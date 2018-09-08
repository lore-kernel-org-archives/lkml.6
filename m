Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F891C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A6C20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A6C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeIHPI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:08:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39508 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeIHPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:08:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so13188184edi.6;
        Sat, 08 Sep 2018 03:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7jbFWcKp3kpSFtmSsiFzcZJWHU4EDKwkNrCIi6ZnKI=;
        b=SkDB+0HrjrSX710uN5Hy40PWN/hTVqhyV1hevbOWyJkBjdbRUr11ff6RWEd1gytXqV
         x9WvWJSf03FAUsGpf/w4eUHscCodKI/6U0XIQkpMlhGBGPblBaRj+1Z2K2NA8X+EwGF5
         h7EawAaNSQoLCytVf+B8Bgf81ENCU1XStOEwdICpNBARx9GGontMQpu9bs1FRn0lmznJ
         OSz+2OdXff6XvWxeT50PtvfgdeNdnhYDtBHIkAH0Pfn91bA1sN9F9x5p7As/t2g9NiCN
         x2KZSKEJQpl6zBNFVnh+mdjLSqdzdQ8vUYYc3AVUBHY0IirX+3SScrOCsrjPr84kSmop
         XYbg==
X-Gm-Message-State: APzg51DVJInQOzgAaPk7vYreaT8KrMpq5BWGwinyDzhzZSoRAwn7zrqf
        lrj9OIQuGz6dYLYUKqVRT2sBY7SL
X-Google-Smtp-Source: ANB0Vdak6w4fZsxg7fLsgj+VjCEbS+6JCs2RJuA56o9sVH2iaHl2W4hAjYjvPRhwFDIPw4Yux40aYQ==
X-Received: by 2002:a50:d512:: with SMTP id u18-v6mr13545301edi.291.1536402191808;
        Sat, 08 Sep 2018 03:23:11 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id g38-v6sm5701557edc.40.2018.09.08.03.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 03:23:09 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id g33-v6so17224691wrd.1;
        Sat, 08 Sep 2018 03:23:09 -0700 (PDT)
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr8322365wrl.26.1536402189495;
 Sat, 08 Sep 2018 03:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180907163347.32312-1-contact@paulk.fr> <11104c03-97ac-8b36-7d75-dfecb8fcce10@xs4all.nl>
In-Reply-To: <11104c03-97ac-8b36-7d75-dfecb8fcce10@xs4all.nl>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 8 Sep 2018 18:22:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v67F2a-kYFRb_f+CyhzkHf5+Y+h01=SE-rxJ=-Oj-ma1BA@mail.gmail.com>
Message-ID: <CAGb2v67F2a-kYFRb_f+CyhzkHf5+Y+h01=SE-rxJ=-Oj-ma1BA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Follow-up patches for Cedrus v9
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Randy Li <ayaka@soulik.info>, ezequiel@collabora.com,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 6:06 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 09/07/2018 06:33 PM, Paul Kocialkowski wrote:
> > This brings the requested modifications on top of version 9 of the
> > Cedrus VPU driver, that implements stateless video decoding using the
> > Request API.
> >
> > Paul Kocialkowski (2):
> >   media: cedrus: Fix error reporting in request validation
> >   media: cedrus: Add TODO file with tasks to complete before unstaging
> >
> >  drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
> >  drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
> >  2 files changed, 19 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/staging/media/sunxi/cedrus/TODO
> >
>
> So close...
>
> When compiling under e.g. intel I get errors since it doesn't know about
> the sunxi_sram_claim/release function and the PHYS_PFN_OFFSET define.
>
> Is it possible to add stub functions to linux/soc/sunxi/sunxi_sram.h
> if CONFIG_SUNXI_SRAM is not defined? That would be the best fix for that.
>
> The use of PHYS_PFN_OFFSET is weird: are you sure this is the right
> way? I see that drivers/of/device.c also sets dev->dma_pfn_offset, which
> makes me wonder if this information shouldn't come from the device tree.
>
> You are the only driver that uses this define directly, which makes me
> suspicious.

On Allwinner platforms, some devices do DMA directly on the memory BUS
with the DRAM controller. In such cases, the DRAM has no offset. In all
other cases where the DMA goes through the common system bus and the DRAM
offset is either 0x40000000 or 0x20000000, depending on the SoC. Since the
former case is not described in the device tree (this is being worked on
by Maxime BTW), the dma_pfn_offset is not the value it should be. AFAIK
only the display and media subsystems (VPU, camera, TS) are wired this
way.

In drivers/gpu/drm/sun4i/sun4i_backend.c (the display driver) we use
PHYS_OFFSET, which is pretty much the same thing.

Regards
ChenYu
