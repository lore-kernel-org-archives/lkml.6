Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4FCFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352CC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LA2Er57f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352CC20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeINOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:49:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:32782 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeINOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:49:10 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A74ADCE;
        Fri, 14 Sep 2018 11:35:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536917729;
        bh=wemHiVaGWFzjZH7vjHn0SfTsxfBTmMtpqvmiPEPOcxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LA2Er57f/dN3TvEpo2+MzmgPI4+S4k3bTaycyDUXxwXz57jK6NEKNZBmnlTWn9jsp
         XIMT4xMh6jZZWpOPksAIqPcEPxHbtGfs1fctgVd84IbpkmDFNF9IcbpWprlqY+C7Lj
         VeNcWfJ7GnvfXKQKEqyBEn12UoUVMu7Tt2ycm/6s=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Agner <stefan@agner.ch>, Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        max.krummenacher@toradex.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] drm/bridge: add bus flag support
Date:   Fri, 14 Sep 2018 12:35:42 +0300
Message-ID: <4703489.BS6gAglWfc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CACRpkdZdxLMkECq8BBJHDqKszHPMt2uUPFbwbPVNKXyxu-SWGQ@mail.gmail.com>
References: <20180912183222.25414-1-stefan@agner.ch> <CACRpkdZdxLMkECq8BBJHDqKszHPMt2uUPFbwbPVNKXyxu-SWGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday, 14 September 2018 12:07:03 EEST Linus Walleij wrote:
> On Wed, Sep 12, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
> > @Linus Walleij, Laurent Pinchart: Since you have been involved in
> > the initial bus timings discussion, I would like to have your Ack
> > on at least patch 2/3... If we want to keep the setup/hold timings,
> > the patchset should also work without those two patches.
> 
> AFAICT this ends up with the PL111 code identical to what I
> proposed in my first patch set to support the latching properly,
> so I am pretty much happy as long as my hardware does not
> flicker. (Rough consensus and running code.) I'm not very invested
> in either idea to represent these timings, so
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I've just replied to patch 3/8 with an explanation of why we have added this 
particular API, and why we need to keep it.

-- 
Regards,

Laurent Pinchart



