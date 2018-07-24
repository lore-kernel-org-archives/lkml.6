Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B9EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A5A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A5A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeGXN7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:46252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeGXN7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 05:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="scan'208";a="69811406"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2018 05:52:44 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 317FB203B0; Tue, 24 Jul 2018 15:52:44 +0300 (EEST)
Date:   Tue, 24 Jul 2018 15:52:44 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/35] media: v4l2-ioctl: Add format descriptions for
 packed Bayer raw14 pixel formats
Message-ID: <20180724125243.jigwhde5rmifctyd@paasikivi.fi.intel.com>
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <1532343772-27382-36-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532343772-27382-36-git-send-email-todor.tomov@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

On Mon, Jul 23, 2018 at 02:02:52PM +0300, Todor Tomov wrote:
> This removes warning "Unknown pixelformat" for the following formats:
>         V4L2_PIX_FMT_SBGGR14P
>         V4L2_PIX_FMT_SGBRG14P
>         V4L2_PIX_FMT_SGRBG14P
>         V4L2_PIX_FMT_SRGGB14P
> 
> CC: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 2e3b1f0..e8f7c89 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1260,6 +1260,10 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_PIX_FMT_SGBRG12P:	descr = "12-bit Bayer GBGB/RGRG Packed"; break;
>  	case V4L2_PIX_FMT_SGRBG12P:	descr = "12-bit Bayer GRGR/BGBG Packed"; break;
>  	case V4L2_PIX_FMT_SRGGB12P:	descr = "12-bit Bayer RGRG/GBGB Packed"; break;
> +	case V4L2_PIX_FMT_SBGGR14P:	descr = "14-bit Bayer BGBG/GRGR Packed"; break;
> +	case V4L2_PIX_FMT_SGBRG14P:	descr = "14-bit Bayer GBGB/RGRG Packed"; break;
> +	case V4L2_PIX_FMT_SGRBG14P:	descr = "14-bit Bayer GRGR/BGBG Packed"; break;
> +	case V4L2_PIX_FMT_SRGGB14P:	descr = "14-bit Bayer RGRG/GBGB Packed"; break;
>  	case V4L2_PIX_FMT_SBGGR16:	descr = "16-bit Bayer BGBG/GRGR"; break;
>  	case V4L2_PIX_FMT_SGBRG16:	descr = "16-bit Bayer GBGB/RGRG"; break;
>  	case V4L2_PIX_FMT_SGRBG16:	descr = "16-bit Bayer GRGR/BGBG"; break;

You could merge this to the patch that adds the format definitions. Or:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

And preferrably move it to earlier in the patchset where new formats are
added.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
