Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA9CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F862087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+nPMG1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfA3S2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:28:33 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39156 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbfA3S2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:28:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so386695lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8Po7PAew1Si7r0kpsvoOXR+vsOhQ/wQS/c90BOpM+o=;
        b=i+nPMG1r3BI/2v4XPoi3Qxk/kyH3G1OXuf0sHhgCbPAbYcXLYROQd0o7vHLB8tIMVG
         0wHlqSAI/zcWD35MQr0mMRtLSOoWn49YJoMDi8M/DkYsRnrA3ldMNB66BLD0mS2BTcUs
         +NLvcXdtfk1Kb419xwb8cwo3+bS9vjDC5MH6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8Po7PAew1Si7r0kpsvoOXR+vsOhQ/wQS/c90BOpM+o=;
        b=EBRRg1xHvA1Qq2tXbt4kSthayT05zXM0j8nbNASaVYZMH1VKNRSXRwXZ2deFhzZMIS
         kfHib9Ea7yMbRLS5QYC7lNkJTFFYmoPnMT7QZ1RkqIhJmNqaL/Y8x3VurctHtkv4Spun
         dW1TL9jjj1JMtZu6dHDMPGIJ2UpWEZXRZTAl1u4q2Oz25CqvZceAMkB8bHd/ZrGA2sz8
         hLULWm9sE87NG+tWje1A9k1Kpe8q376HVgwvU0V0KKN6YcwGMO7cMaWXGV9vYEtAT63t
         GjyM3bNAP0qDvOsaHsrZBv0WKnu6ayjcrxUpA0zxo6686pYVg8UiqsYYhTL6/CsVsSCR
         09oA==
X-Gm-Message-State: AJcUukcdLu8PU0cdMMzwY/M07wed947IdXcqC6sUwQW9FWCgGSVJBpun
        BlIDjMin2Y8Vmr06DygL1LnMIFXaJE8=
X-Google-Smtp-Source: ALg8bN7qetJBwcOrOY0hKDANiZgrWV735w3Sy2g2g6qnBarUkpoXKiFMGiG+Zwtx9Yd5syQBugmD/w==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr24889856lfe.63.1548872910985;
        Wed, 30 Jan 2019 10:28:30 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 10sm410529lff.62.2019.01.30.10.28.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:28:30 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id u18so359503lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:28:29 -0800 (PST)
X-Received: by 2002:a19:7352:: with SMTP id o79mr25471998lfc.104.1548872909383;
 Wed, 30 Jan 2019 10:28:29 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:27:52 -0800
X-Gmail-Original-Message-ID: <CAE=gft6AouN2DDzgF6d4f52n+mqiOyeeKg1=Og+=YxQsMoBnLw@mail.gmail.com>
Message-ID: <CAE=gft6AouN2DDzgF6d4f52n+mqiOyeeKg1=Og+=YxQsMoBnLw@mail.gmail.com>
Subject: Re: [PATCH v5 03/20] memory: mtk-smi: Use a general config_port interface
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
> The config_port of mt2712 and mt8183 are the same. Use a general
> config_port interface instead.
>
> In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
> are not the normal larb, their register space are different from the
> normal one. thus, we can not call the general config_port. In mt8183,
> IPU0/1 and CCU connect with smi-common directly, they also are not
> the normal larb. Hence, we add a "larb_direct_to_common_mask" for these
> larbs which connect to smi-commmon directly.
>
> This is also a preparing patch for adding mt8183 SMI support.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
