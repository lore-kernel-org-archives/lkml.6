Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8DCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739E3208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739E3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbeHAO4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:56:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33910 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389258AbeHAO4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:56:21 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fkqtZ-0005GU-P4; Wed, 01 Aug 2018 15:10:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie,
        Ajit Linux <ajitn.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
Date:   Wed, 01 Aug 2018 15:10:29 +0200
Message-ID: <1843623.lUM99VBV1x@phil>
In-Reply-To: <CAFqt6zZfLXuMUT75a3dWKeiCCmKZOfi=FdTeFRjcdFDZdfcRVQ@mail.gmail.com>
References: <20180731203430.GA30136@jordon-HP-15-Notebook-PC> <16141309.kTfAWOe8rM@phil> <CAFqt6zZfLXuMUT75a3dWKeiCCmKZOfi=FdTeFRjcdFDZdfcRVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. August 2018, 14:43:47 CEST schrieb Souptick Joarder:
> On Wed, Aug 1, 2018 at 6:03 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Hi Souptick,
> >
> > Am Dienstag, 31. Juli 2018, 22:34:30 CEST schrieb Souptick Joarder:
> >> convert drm_atomic_helper_suspend/resume() to use
> >> drm_mode_config_helper_suspend/resume().
> >>
> >> With this conversion, rockchip_drm_fb_resume() and
> >> rockchip_drm_fb_suspend() will not be used anymore.
> >> Both of these functions can be removed.
> >>
> >> Also, in struct rockchip_drm_private state will not be
> >> used anymore. So this can be removed forever.
> >>
> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> >
> > the patch itself looks great, just a simple bookkeeping question.
> >
> > What role did Ajit play in creating the patch? If I remember correctly
> > it is meant to be
> > - 1st Signed-off: Patch-Author
> > - 2nd Signed-off: E-Mail sender + patch possibly patch changes
> > (optional of course if the same)
> >
> > So was this meant to be a Reviewed-by from Ajit?
> 
> We both are working together for these patches to
> convert drm_atomic_helper_suspend/resume().
> That's the reason to add his name in 2nd Signed-off
> in all similar patches.
> 
> Is it a incorrect way to put 2nd Signed-off here ?

Thanks for the clarification and the interesting question :-)

I've just read through Documentation/process/submitting-patches.rst
and it seems there is an "official" way to show that relationship, via a
tag named "Co-Developed-by:" described under number 12.

So I guess we could just adapt the patch accordingly, if that is ok with
both of you (i.e. I can change this when applying, so no need to resend).


Heiko


