Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52FB20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52FB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbeGINPt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:15:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:57949 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754183AbeGINPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:15:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 06:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="55467868"
Received: from aperigno-mobl1.ger.corp.intel.com (HELO [10.252.52.195]) ([10.252.52.195])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2018 06:15:45 -0700
Subject: Re: [PATCH 1/4] drm/arm/malidp: Add modifier definitions for
 describing Arm Framebuffer Compression (AFBC).
To:     Ayan Kumar Halder <ayan.halder@arm.com>, gustavo@padovan.org,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Rosen Zhelev <rosen.zhelev@arm.com>
References: <1530807905-18248-1-git-send-email-ayan.halder@arm.com>
 <1530868585-11068-1-git-send-email-ayan.halder@arm.com>
 <1530868585-11068-2-git-send-email-ayan.halder@arm.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <36fdd04b-5717-2cb9-d70c-d24e7113117b@linux.intel.com>
Date:   Mon, 9 Jul 2018 15:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530868585-11068-2-git-send-email-ayan.halder@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 06-07-18 om 11:16 schreef Ayan Kumar Halder:
> AFBC is a proprietary lossless image compression protocol and format.
> It provides fine-grained random access and minimizes the amount of data
> transferred between IP blocks.
> AFBC has several features which may be supported and/or used, which are
> represented using bits in the modifier. Not all combinations are valid,
> and different devices or use-cases may support different combinations.
>
> Signed-off-by: Rosen Zhelev <rosen.zhelev@arm.com>
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: James (Qian) Wang <james.qian.wang@arm.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 83 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index e04613d..af7e9ab 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -183,6 +183,7 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
>  #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
>  #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
> +#define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>  /* add more to the end as needed */
>  
>  #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
> @@ -405,6 +406,88 @@ extern "C" {
>   */
>  #define DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED fourcc_mod_code(BROADCOM, 1)
Seems drm-misc-next now has a DRM_FORMAT_MOD_BROADCOM_UIF format extra, but that's just noise when applying. :)
> +/*
> + * Arm Framebuffer Compression (AFBC) modifiers
> + *
> + * AFBC is a proprietary lossless image compression protocol and format.
> + * It provides fine-grained random access and minimizes the amount of data
> + * transferred between IP blocks.
> + *
> + * AFBC has several features which may be supported and/or used, which are
> + * represented using bits in the modifier. Not all combinations are valid,
> + * and different devices or use-cases may support different combinations.
> + */
> +#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
> +
> +/*
> + * AFBC superblock size
> + *
> + * Indicates the superblock size(s) used for the AFBC buffer. The buffer
> + * size (in pixels) must be aligned to a multiple of the superblock size.
> + * Four lowest significant bits(LSBs) are reserved for block size.
> + */
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
> +
> +/*
> + * AFBC lossless colorspace transform
> + *
> + * Indicates that the buffer makes use of the AFBC lossless colorspace
> + * transform.
> + */
> +#define AFBC_FORMAT_MOD_YTR     (1ULL <<  4)
> +
> +/*
> + * AFBC block-split
> + *
> + * Indicates that the payload of each superblock is split. The second
> + * half of the payload is positioned at a predefined offset from the start
> + * of the superblock payload.
> + */
> +#define AFBC_FORMAT_MOD_SPLIT   (1ULL <<  5)
> +
> +/*
> + * AFBC sparse layout
> + *
> + * This flag indicates that the payload of each superblock must be stored at a
> + * predefined position relative to the other superblocks in the same AFBC
> + * buffer. This order is the same order used by the header buffer. In this mode
> + * each superblock is given the same amount of space as an uncompressed
> + * superblock of the particular format would require, rounding up to the next
> + * multiple of 128 bytes in size.
> + */
> +#define AFBC_FORMAT_MOD_SPARSE  (1ULL <<  6)
> +
> +/*
> + * AFBC copy-block restrict
> + *
> + * Buffers with this flag must obey the copy-block restriction. The restriction
> + * is such that there are no copy-blocks referring across the border of 8x8
> + * blocks. For the subsampled data the 8x8 limitation is also subsampled.
> + */
> +#define AFBC_FORMAT_MOD_CBR     (1ULL <<  7)
> +
> +/*
> + * AFBC tiled layout
> + *
> + * The tiled layout groups superblocks in 8x8 or 4x4 tiles, where all
> + * superblocks inside a tile are stored together in memory. 8x8 tiles are used
> + * for pixel formats up to and including 32 bpp while 4x4 tiles are used for
> + * larger bpp formats. The order between the tiles is scan line.
> + * When the tiled layout is used, the buffer size (in pixels) must be aligned
> + * to the tile size.
> + */
> +#define AFBC_FORMAT_MOD_TILED   (1ULL <<  8)
> +
> +/*
> + * AFBC solid color blocks
> + *
> + * Indicates that the buffer makes use of solid-color blocks, whereby bandwidth
> + * can be reduced if a whole superblock is a single color.
> + */
> +#define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
> +
>  #if defined(__cplusplus)
>  }
>  #endif

Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

But I would put patch 2 last, since that enables the feature without hw support otherwise.

