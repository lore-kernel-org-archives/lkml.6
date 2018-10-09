Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB2ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C554B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C554B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJJBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:14:24 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42850 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:14:24 -0400
Received: by mail-vk1-f196.google.com with SMTP id t202-v6so601720vke.9;
        Tue, 09 Oct 2018 10:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKYDVDly7w6GpzneiT0QsJb4GfJbEUwaHnAgZopgbVE=;
        b=nl3OT8pVRqOmC3PzZPN3HGAH28oS/bW1zE46A6jeFP8ZlULG5EimNoL0eM4CbKvX2k
         iyKK1TjRNAi5tJo2+DgI3f0NlELGl/t/OnzuCEfRSXstv5glV9L2vu+TPbnKmDYlZWiK
         zDwuJsPI6g0YtVqDe4mKbr9Uqa9VExHyYgGiHUIVP3NaHuEDTO+PUKzA+FTb8U4gu7mx
         QAELfxgOd8GZGGnTHQsVNb3ifCoEunFyJZ81Jw1BF45xesSrsvIIdumOMcxLfha8dVdD
         M78THbC1frX8COn4hUbKogx+R2dp616x2iwr1j8D5blJiI43wMcQFvegRo89g8GXZmgw
         umLQ==
X-Gm-Message-State: ABuFfoj5zccU9kEzVCvPjXDY2jAEbWAWSvbmUAarcMceqA1fGdPZFL5K
        cZtN40Qmh7eAe/MfpVWXl/zTAQkKuSiM0kPRi0w=
X-Google-Smtp-Source: ACcGV60FNLPMo5I93qg7Alkf4ZHmIBcwd/wegKJwRN1gd2NM92eQhX2JM0tb0vOU7UfpfWaXB28oFGSZ/n8ecMQXDA0=
X-Received: by 2002:a1f:d484:: with SMTP id l126-v6mr5372633vkg.7.1539107774945;
 Tue, 09 Oct 2018 10:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-16-jernej.skrabec@siol.net> <3616158.EzHeIcd69b@avalon>
In-Reply-To: <3616158.EzHeIcd69b@avalon>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 9 Oct 2018 13:56:04 -0400
Message-ID: <CAKb7Uvgmv4-t0g=b-Xsimn9AiRL1L4sQ51vu5xMTFKNdDC9bLw@mail.gmail.com>
Subject: Re: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround
 for v2.12a
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jernej.skrabec@siol.net, maxime.ripard@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        sboyd@kernel.org, David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:40 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jernej,
>
> Thank you for the patch.
>
> On Sunday, 7 October 2018 12:38:51 EEST Jernej Skrabec wrote:
> > It turns out that even new DW HDMI controllers exhibits same magenta
> > line issues as older versions.
> >
> > Enable workaround for v2.12a.
>
> This doesn't affect the platforms I maintain, so I can't really test this, but
> I'm wondering whether there could be other platforms using a v2.12a DW HDMI
> that wouldn't need the workaround.
>
> My platforms use a previous version, namely v2.01a. The workaround for that
> version has been enabled by
>
> commit 9c305eb442f3b371fc722ade827bbf673514123e
> Author: Neil Armstrong <narmstrong@baylibre.com>
> Date:   Fri Feb 23 12:44:37 2018 +0100
>
>     drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
>
> I haven't paid too much attention to the patch back then, and have now double-
> checked the HDMI output on R-Car Gen3. Enabling the workaround doesn't cause
> any regression, and reverting the commit doesn't cause any issue either. I
> thus wonder whether we shouldn't enable the workaround with count = 1 in the
> default case instead of adding new IP core versions to the list. It would be
> nice if someone from Synopsys could comment on this.

I hope this comment isn't *incredibly* off-topic, but we encountered a
similar issue with NVIDIA (and I believe AMD) hardware a while back,
related to HDMI. This was due to infoframes not being sent, but
(perhaps) HDMI Audio being enabled.

This was a single vertical(!) line. It was described as "purple", but
not sure that's distinguishable from "magenta" by most people. [ Fixed
by a522946174 on nouveau, sample bug report
https://bugs.freedesktop.org/show_bug.cgi?id=79912 ]

Cheers,

  -ilia
