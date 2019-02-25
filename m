Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88205C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50438217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNb+nyER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfBZAAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:00:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40572 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBZAAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:00:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id w6so9098269ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4diYRZiwd25fbEdVyDO2DH/OYOgPzTAHtOFBF1MM6EM=;
        b=hNb+nyERabulX656yx8s65MX5UbbJzEe/H7wPy1UjLoKYV911/npz2gZrN9i6HQ8Cz
         HYFIPX0+s2kOXIfdgP66S3aH6m84Z56cuv5USYYtxALgZqfJMtHybUPk2b1wnfuhtg9V
         V8VMGlvLrSVK6iT0jWV+Fombr9DQggmH3BMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4diYRZiwd25fbEdVyDO2DH/OYOgPzTAHtOFBF1MM6EM=;
        b=HAt4EvreW2TpddVykGLYAz8HaG9xeg2BZG8q1P5AbsO1qvPxVHhZysGmtXpJjjD27A
         nEVN4nj++kWJleO0P8FXnA+wpWtKw19UuZ96SxetXrcN16fSmC1yZhqK49FDtgRsWKIW
         c2XfhYbgRXB43+XbiO/PpryjDHid4WYoTkCIbC7XEbVOfp5108X0jlbnby8NHmdL9Exp
         HC/e0cZK5KjEybI1ce+gf4rlcawVpkKANXSGElNhDTPyv4ayzBgFvy/Jt/lUPi2VXJ+f
         /r2al+cOcwCG0V8A+/DWvXFGSoaJqzY/fh/24TYYZ9VkQ5k5IsP6YCeTs2JUVsmiIOnG
         Gtcg==
X-Gm-Message-State: AHQUAuZzzol9e+zhFmWT4ryYukkCJesUi818jx9QzqXnhi2pFbEq8qwE
        xGceP+CLpK5/VuQ/ztI3CbWRQm+nlTQ=
X-Google-Smtp-Source: AHgI3IbL9GDNgwXG73tAeolqW2OnGhuEJg31C/HaF9Dtao7+nZ84JUaQ1rc2nQJfFYs+V1cdCa6hHQ==
X-Received: by 2002:a2e:20b:: with SMTP id 11mr11530016ljc.41.1551139236217;
        Mon, 25 Feb 2019 16:00:36 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j7sm50929ljb.1.2019.02.25.16.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:00:36 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id e27so8261628lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:00:36 -0800 (PST)
X-Received: by 2002:a19:f607:: with SMTP id x7mr11740319lfe.47.1551138876234;
 Mon, 25 Feb 2019 15:54:36 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com> <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 25 Feb 2019 15:54:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
Message-ID: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
Subject: Re: [PATCH 03/13] iommu/mediatek: Add probe_defer for smi-larb
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The iommu consumer should use device_link to connect with the
> smi-larb(supplier). then the smi-larb should run before the iommu
> consumer. Here we delay the iommu driver until the smi driver is
> ready, then all the iommu consumer always is after the smi driver.
>
> When there is no this patch, if some consumer drivers run before
> smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> device_link_add, then device_links_driver_bound will use WARN_ON
> to complain that the link_status of supplier is not right.
>

I don't quite have enough knowledge of device links to figure out if
this is a) the right fix, b) a deficiency in the device_links code, or
c) neither.

Perhaps someone else could chime in on this one.
-Evan
