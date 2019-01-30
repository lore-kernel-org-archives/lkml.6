Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82094C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588C52087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1qxyF/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfA3SfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:35:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbfA3SfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:35:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so416596lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQ0dKTYavvdRK2craM+1+cJoElQMefWKTyFdjDSik8w=;
        b=X1qxyF/EyL/kleGQ7Tjtw1XsuimunA+g7IjHYnNk1jOhzaYVvBUM7mgt7jI/8yksWs
         JVKtOIkOam8fvkOTAcT+EXX3nID0pJa4msDaSJfu6FhX51lOFDNEkRoVKyRdpuRXZn2p
         krfsJtBNAN0w5pzx0qDZrkyfQX17HUpefJ+9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQ0dKTYavvdRK2craM+1+cJoElQMefWKTyFdjDSik8w=;
        b=HhproeilB2vtQk/FnYvWLus1ky+QtwqvbB2DRxhNde8P26XAbO3hv0obRuoYt13g68
         J0oEooHONGf9eIjKktJwZ4C/Q3Z4cnA1BLI6ZM/zg8C15xWtgd/ZWqAWZf++Rmf5IlCU
         T3b7rj8KurtkeP/0+dgsTtVt+sAgAvGyec4H/I0atwDHWhQGaJwNSqjF9kkCHU7xhm8/
         IqwTmbxcv6K87EzUfA0vyEaVNjtCW0tw2ZqJhN/DbbQMtPZ1gJ4Ca9zCUa0+Q6cCztIa
         XhUjnYHhDzgkoHWqsqVjmnObnElegDuzicDIwI2c6qrUpDn4B7CcszTFeZCsTbOFgYKw
         GSlQ==
X-Gm-Message-State: AJcUukee0tGU31gaooidDa2Qm0cMCZVEea/w1sbdi5QkFJOYqIZCdna2
        29VLOctELwqbgOdM4BW1lpjIw/uBq2g=
X-Google-Smtp-Source: ALg8bN788JLZ9sSWeFBVIjMLH64thmQwdhQhOjDNUlN7/FmrNiT0jbAi/oUNF2v1UnF+tGdCDuTA8Q==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr21806194lfg.93.1548873304083;
        Wed, 30 Jan 2019 10:35:04 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p67sm418231lfe.14.2019.01.30.10.35.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:35:03 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id u18so374367lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:35:03 -0800 (PST)
X-Received: by 2002:a19:7018:: with SMTP id h24mr24289646lfc.162.1548872894574;
 Wed, 30 Jan 2019 10:28:14 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-3-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-3-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:27:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft61E614+kXLGr7Z1MZOrPAsTAcM2qU8GGqKq61vfSFvOg@mail.gmail.com>
Message-ID: <CAE=gft61E614+kXLGr7Z1MZOrPAsTAcM2qU8GGqKq61vfSFvOg@mail.gmail.com>
Subject: Re: [PATCH v5 02/20] iommu/mediatek: Use a struct as the platform data
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

On Mon, Dec 31, 2018 at 7:56 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Use a struct as the platform special data instead of the enumeration.
> This is a prepare patch for adding mt8183 iommu support.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
