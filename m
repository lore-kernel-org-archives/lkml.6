Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3525E20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esIya/48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3525E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIFPmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:42:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53478 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeIFPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:42:50 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so14160281itp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 04:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6pUL03UWwpP1L/tnwoe48VBijcEjvJrJc3cYjSNcu4=;
        b=esIya/48OXNqVRjwuXCfh9WH8HaJn0hWztUErKEbE0jf4YumR/l4bNsghjlMCZDJwU
         i5hSniZWkLqR+mWUHsyZCpYABXRuzPBIbAM/JcjxCnWFB+vd2BKIFQ2smGQsKlDhrpMc
         TRLyQdN5AxqiThHWtEI89/TwosSrJUzZ8nNKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6pUL03UWwpP1L/tnwoe48VBijcEjvJrJc3cYjSNcu4=;
        b=ZwJvvQlxwDidrd7Nnyd0eqPMXF3tqjT6VHNJkyey8NkuL4y2fvD+nEloGRyqZRAtuf
         4PM7CdHzxWE8lR8ftRVnlqXvXkUZMH/O+0/YgtXJLPntOvcKTD7Ot2Duq/PxQdZKO4K2
         w/cbKFdoPQc99D3hUR/+8UNv0ZM8tx3r/hbtzol6xJGSnO98HyQw+rFroMxrym3PyLkg
         El8yrxfJxSKQw1rJwE/p4hJl1TmUAdDcMeDomxVIeQBoROUhyWFklICFkqPRsF1RdJtb
         yDhfkYlc1c02+ZHfpWNr8gLiAXHKdgDVL78aesXI4273nevWk3Rjk2wfEiOpqRNEJ0qy
         C0jw==
X-Gm-Message-State: APzg51B1YnWAbIAapVeDpBuK/E00mSajvVOTNdEYZ6jCrE1hXtkHPnHn
        Ht5jN9KXQZXBDdJDS+nkXpd/j4xxLoMaD+SBE9ITtQ==
X-Google-Smtp-Source: ANB0VdZA6/y+7z6aaXM7voHXj74+GP1MC6lQ+ggCqIpRh2kEgIpsVuv4NIIYfFVq+BqYZO91y5PKUQeFqLnlLsbnxfU=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr1951657itk.62.1536232073979;
 Thu, 06 Sep 2018 04:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180905052113.21262-1-stefan@agner.ch> <4035252.QuWadVx7pr@avalon>
 <1569297.pdEFdpi3HS@avalon> <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
In-Reply-To: <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Sep 2018 13:07:41 +0200
Message-ID: <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
To:     Stefan Agner <stefan@agner.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@linux.ie>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
> On 05.09.2018 00:44, Laurent Pinchart wrote:

> Good point! I actually really don't like that we use the same flags here
> but from a different perspective. Especially since the flags defines
> document things differently:
>
> /* drive data on pos. edge */
> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> /* drive data on neg. edge */
> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)

Maybe a stupid comment from my side, but can't we just change the
documentation to match the usecases?

/* Trigger pixel data latch on positive edge */
#define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)

> Using the opposite perspective would also need translation in crtc
> drivers... So far no driver uses sampling_edge.
>
> I would prefer if we always use the meaning as documented by the flags.
>
> I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
> DRM_BUS_FLAG_PIXDATA_NEGEDGE.
>
> Linus Walleij, you added sampling edge, any thoughts?

I just thought it was generally useful to have triggering edge encoded
into the bridge as it makes it clear that this edge is something
that is a delayed version of the driving edge which is subject to
clock skew caused by the speed of electrons in silicon and
copper and slew rate caused by parasitic capacitance.

Yours,
Linus Walleij
