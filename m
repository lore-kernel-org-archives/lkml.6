Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F19C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E26223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E26223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbeKPBnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:43:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40625 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbeKPBnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:43:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so16501323edx.7;
        Thu, 15 Nov 2018 07:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ys9wbimF4fFsc4ELVTR2ELquBF8V612gE5akwCofxW4=;
        b=bv9Xk5el0PTm1uU6jYbDuVRoNWyOcOx+EJcqud1Fl7TSMKviZ8oUzkofHUnXNm6XEh
         1duYirhlrqGFXrc6V+mpx+CBZug0RsGpKyjddg/grmG20nO9D+NPty7XyOtLkPbTUruH
         rDL3Kh9KwyLUSBwQmXfuWwWj78II7AmSGFNsyMfOt4lBGLG16rxDKPFULRaHEtgoBxj5
         gRAHvts2e98xsRt62kzbw1lKd9VMXtlS4Gj1MESg3c+rLkgS6PWlkbJNOnUtXnBfsjco
         z8xAa+/a/+ewfyYP1e+iWYEmnI/AV/OOCeB1MHlzdELFOS3cz4QDVkKtbK/CkMHGJmCJ
         4qIA==
X-Gm-Message-State: AGRZ1gJKehQrRFerhGIEiAQlFgqJ3oCXqd75woGHA9A5Rtgnkdf3cVqE
        F/cYfk39YWIToxaqhjGdp5XAvBW/014=
X-Google-Smtp-Source: AJdET5cXFJitVvHTtQjv4fQm/S5paeRivrKO5ZTxo8zKPtiOys6V48okhIzckWzPUhMZWe9QMA5BpA==
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr6340140edg.121.1542296125123;
        Thu, 15 Nov 2018 07:35:25 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id y4-v6sm1228337ejc.10.2018.11.15.07.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 07:35:24 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id v18-v6so21675623wrt.8;
        Thu, 15 Nov 2018 07:35:24 -0800 (PST)
X-Received: by 2002:adf:b608:: with SMTP id f8mr5935849wre.120.1542296123988;
 Thu, 15 Nov 2018 07:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com> <20181115145013.3378-15-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181115145013.3378-15-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 23:35:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64pVKG4mSAF48xR54yj00rQ6iTvgYQB9Bf-XWmH2FhVqQ@mail.gmail.com>
Message-ID: <CAGb2v64pVKG4mSAF48xR54yj00rQ6iTvgYQB9Bf-XWmH2FhVqQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 14/15] arm64: dts: allwinner: h5: Add Video
 Engine and reserved memory node
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:51 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This adds nodes for the Video Engine and the associated reserved memory
> for the H5. Up to 96 MiB of memory are dedicated to the CMA pool.
>
> The pool is located at the end of the first 256 MiB of RAM so that the
> VPU can access it. It is unclear whether this is still a hard
> requirement for this platform, but it seems safer that way.

I think we can actually test this. You could move the reserved memory
pool beyond 256 MiB, and have cedrus decode stuff, and try to display
the results. If it's gibberish, or the system crashes, it's likely the
memory access wrapped around at 256 MiB.

What do you think?

ChenYu
