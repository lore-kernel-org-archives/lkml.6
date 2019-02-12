Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA91C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500632084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7sJeVtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfBLMuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:50:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45803 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLMuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:50:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so4036739ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDNXOREDNGYW88RlMWXWe1+fpPoFObQlemG/TN+KLuA=;
        b=Y7sJeVtRiglF2RvgFGXMXC12YVEM1qnMuaG5u2CnqMtRCX+TEoY32Diq5FGu/iK21d
         XaxBmvAte7CK3Fx6LdIMz4w9E2yGuvvovTmxS1lkAtTxS4FpnEEiTGJcrHsNf4xZFWWy
         PTF2aeHPgo+9wPqFmiUfjdWO4rlaap2YO7STY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDNXOREDNGYW88RlMWXWe1+fpPoFObQlemG/TN+KLuA=;
        b=W+02x4zYnwx5Qhb/xuRgUF+J6CK325v9S83Z/QTIzspDurHeWwBdm9kRwo3b6dxIbs
         I74BfDwyeqtX4/sWEbs5jsyALACsm2gjdN4SC3Kr7++eVT6Y8CdF5Macq8WSfENtWoWk
         1kIao7XCMdGJyFewFS7noJJH/wDId9/2nFbRAGZlTWnhgD7Dac5rvVWmp9Zy8L2vVkG0
         UDpFwWron45hPptWM0kmkG3xWNCFbnxq/Xe4+eJxjnpkX+oN+IDQLh1xhyKBSJTgpsLM
         wd6YdUaPdETLFEhJD0rzWycI02g8WC9FifsUt+wl0yrGkMojOqLDYmv6pAzTFZAiUMne
         5LCQ==
X-Gm-Message-State: AHQUAuaaQpHPoXrMtzAOdB6oLDoFh+zq4InxZMonUm0jzfjeZCZvCrv5
        JnCYh3suxKVd4rHSk/E2U7QMfMTsGv0=
X-Google-Smtp-Source: AHgI3IZjBho4axnpWqgxA4/TlPZ6IhuWtqFCcz0WPbaC07lp10QdFCYHaIaa81oB8bi20BN9UvfaTg==
X-Received: by 2002:a9d:3426:: with SMTP id v35mr3851265otb.71.1549975831357;
        Tue, 12 Feb 2019 04:50:31 -0800 (PST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id t8sm5225587otp.69.2019.02.12.04.50.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 04:50:30 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id n71so4114702ota.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:50:30 -0800 (PST)
X-Received: by 2002:a9d:6f8e:: with SMTP id h14mr3388599otq.241.1549975829538;
 Tue, 12 Feb 2019 04:50:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 12 Feb 2019 21:50:18 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
Message-ID: <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] media: cedrus: Add H264 decoding support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        jenskuske@gmail.com, Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, Feb 11, 2019 at 11:39 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Here is a new version of the H264 decoding support in the cedrus
> driver.

Thanks for working on this. Please see my comments below.

>
> As you might already know, the cedrus driver relies on the Request
> API, and is a reverse engineered driver for the video decoding engine
> found on the Allwinner SoCs.
>
> This work has been possible thanks to the work done by the people
> behind libvdpau-sunxi found here:
> https://github.com/linux-sunxi/libvdpau-sunxi/
>
> I've tested the various ABI using this gdb script:
> http://code.bulix.org/jl4se4-505620?raw
>
> And this test script:
> http://code.bulix.org/8zle4s-505623?raw
>
> The application compiled is quite trivial:
> http://code.bulix.org/e34zp8-505624?raw
>
> The output is:
> arm:    builds/arm-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> x86:    builds/x86-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> x64:    builds/x64-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> arm64:  builds/arm64-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
>
> Let me know if there's any flaw using that test setup, or if you have
> any comments on the patches.
>
> Maxime
>
> Changes from v2:
>   - Simplified _cedrus_write_ref_list as suggested by Jernej
>   - Set whether the frame is used as reference using nal_ref_idc
>   - Respect chroma_format_idc
>   - Fixes for the scaling list and prediction tables
>   - Wrote the documentation for the flags
>   - Added a bunch of defines to the driver bit fields
>   - Reworded the controls and data format descriptions as suggested
>     by Hans
>   - Reworked the controls' structure field size to avoid padding
>   - Removed the long term reference flag

This and...

>   - Reintroduced the neighbor info buffer
>   - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
>     one in the DPB

these are used in our Rockchip VDEC driver.

Could you elaborate on the reasons why they got removed?

Best regards,
Tomasz
