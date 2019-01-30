Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0372087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJvwOn6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfA3S3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:29:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44085 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733036AbfA3S3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:29:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so355509lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcw5vt9zbl++2RXOENtvs4XQX4dr/6bQWVR0Pe9YBiI=;
        b=TJvwOn6QwSVGUiDeb09oklzogw6mAA0r+OL2c9ehh3L//6bdR3mD03hcoKP1ausY9r
         46Iu8d4YSJIzjEPla7bDxNqxFGy+/Matc4dXOkm/riEjy0+6VPYb5AfyN95joo/dNZ1n
         Lu4gCpPgrKOiE1Zb7SSLvEjp3sEHx25BMSDKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcw5vt9zbl++2RXOENtvs4XQX4dr/6bQWVR0Pe9YBiI=;
        b=esU5BqKND1OZclWDqo7xZOzBpaGfCFmYLfX7d/5O7JG7doA+fDq09J0QRw/cB5L7kQ
         G1NYrb91q0y07rx/GdrAWWgUqfUHRPY6VXat14L2Da0bQam8CYq6hXFXIIRmp0HMqQlx
         Fwmj7QnCbW9DC1tZBcph3UJr/8T4fApgDpM7/unyz+YkrLIjuqCwbd3XJMSEEWNPoS38
         VwcmvFExr6VxFols02bvE8X5pmCN9PWaI4C4SlHyVBT9g0EXIVp+Gzg6lPFhed1vD0TH
         VZBRoZB6khQlsV2mI3AfX0KbvxT7kX5zpZMRIifs5kFjgmsaxC9Mx3V+JMvFnmoGW7W6
         Kj7A==
X-Gm-Message-State: AJcUukfxrIcy7P5EKfPa415h6QKo8EVTx/T7eKz6VM0Ox8UvrcqJEEmO
        0Oas8mzGBYYNmpwnMigowRzEASMJzpg=
X-Google-Smtp-Source: ALg8bN5U6aLSEtAmPzYdnguWcBRj+5kzZuYv7jiivISVEmANoZDtqwAw8Pm9AYN7jizXusS8emd/rg==
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr24410163lfg.117.1548872948602;
        Wed, 30 Jan 2019 10:29:08 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s17sm461187lfk.9.2019.01.30.10.29.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:29:07 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id s5-v6so389042ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:29:07 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr26439768ljc.97.1548872946625;
 Wed, 30 Jan 2019 10:29:06 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-6-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-6-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:28:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft6KiXmP2Dm8ksnATUcy8Mhnfo8wL=SVpwGZrC0M1CoxpA@mail.gmail.com>
Message-ID: <CAE=gft6KiXmP2Dm8ksnATUcy8Mhnfo8wL=SVpwGZrC0M1CoxpA@mail.gmail.com>
Subject: Re: [PATCH v5 05/20] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and
 iopte_to_paddr helpers
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Add two helper functions: paddr_to_iopte and iopte_to_paddr.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
