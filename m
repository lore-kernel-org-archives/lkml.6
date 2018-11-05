Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F5DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B8B2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B8B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbeKEWnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:43:06 -0500
Received: from hermes.aosc.io ([199.195.250.187]:58542 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbeKEWnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:43:06 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F05B967013;
        Mon,  5 Nov 2018 13:23:17 +0000 (UTC)
Message-ID: <f140c083f59eabf6ea323d15d655473e8a77d813.camel@aosc.io>
Subject: Re: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 05 Nov 2018 21:23:08 +0800
In-Reply-To: <20181008092111.qcufr4o7cy3nnj4b@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
         <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
         <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
         <20181008092111.qcufr4o7cy3nnj4b@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-10-08一的 11:21 +0200，Maxime Ripard写道：
> On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> > If tcon->panel pointer is NULL, trying to dereference from it
> > (i.e. tcon->panel->connector) will cause a null pointer
> > dereference.
> > 
> > Add tcon->panel null pointer check before calling
> > sun4i_tcon0_mode_set_dithering().
> > 
> > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
> >                       RGB565/RGB666 LCD panels")
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Applied both, thanks!

Please bring them to 4.20.

Currently in 4.20-rc1, bridge support of sun4i-drm is broken because of
this problem.

> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

