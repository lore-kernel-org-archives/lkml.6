Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeEGNp7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:45:59 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:53458 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750881AbeEGNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:45:55 -0400
Subject: Re: [PATCH v9 07/15] v4l: mark unordered formats
To: Ezequiel Garcia <ezequiel@collabora.com>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180504200612.8763-1-ezequiel@collabora.com>
 <20180504200612.8763-8-ezequiel@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <967f1373-c1e2-674c-bd94-3243c20e986b@xs4all.nl>
Date: Mon, 7 May 2018 15:45:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504200612.8763-8-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHtHlEWcex/coD33S3D3++OXSrERT56+ZQlruNHgQBF1dVBU06wwBgN6Y1FWF6HPSZ3QdLvQVaj4J6hJTS2nlkexRt0TypaQ9edB27oT/Cn2NKN2iIIz
 HpX0pjbT9Dy/SEZmuyVww95jQ2BtP4Ml9C2hMfYzm9LxMgpEBy4y78Xj8oI0/FQ2Zk30wT7Fs9Qc/JiNufKCIhbe2eQmxVfeVQQGBegdcZBA3fFR8k0gujId
 WOQn90ZLdt2GOkPTjfIhsx+WNsHBhbsyihYoLvYCLC/W1oeD6o4HpuFl4D9/mItGDMGVBlt6Dwvj3edm2HdBVF7IVWYX/yYySXyGiO+WQnik7LKpBSWdnc+9
 lf/vzB6oxm8IgfkFssjepSbjLMBtcD2hiisv2ecIlczZSpTEYjJO68PauzXjhVqxBW04GIpM/lNvRic2QWyeDJ2qRJKHLy+txw+YJ77WT5N010AyaW+HRXmA
 qh1FvBPehRRsUmWkWcS0/GillVVt4HkpoZdu6YMiQyGVDum9GFdk7ne3G471QAqsc5uqU5keVbr6BXXHydkORtXPPL3ErMCVTFR6Cp2yEH3EVFfIteTG4lv8
 zBZ9nAnlvqXbCofRR1dNe63H
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 22:06, Ezequiel Garcia wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> Now that we've introduced the V4L2_FMT_FLAG_UNORDERED flag,
> mark the appropriate formats.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 55 ++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index f48c505550e0..f75ad954a6f2 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1260,20 +1260,6 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_MJPEG:	descr = "Motion-JPEG"; break;
>  		case V4L2_PIX_FMT_JPEG:		descr = "JFIF JPEG"; break;
>  		case V4L2_PIX_FMT_DV:		descr = "1394"; break;
> -		case V4L2_PIX_FMT_MPEG:		descr = "MPEG-1/2/4"; break;
> -		case V4L2_PIX_FMT_H264:		descr = "H.264"; break;
> -		case V4L2_PIX_FMT_H264_NO_SC:	descr = "H.264 (No Start Codes)"; break;
> -		case V4L2_PIX_FMT_H264_MVC:	descr = "H.264 MVC"; break;
> -		case V4L2_PIX_FMT_H263:		descr = "H.263"; break;
> -		case V4L2_PIX_FMT_MPEG1:	descr = "MPEG-1 ES"; break;
> -		case V4L2_PIX_FMT_MPEG2:	descr = "MPEG-2 ES"; break;
> -		case V4L2_PIX_FMT_MPEG4:	descr = "MPEG-4 part 2 ES"; break;
> -		case V4L2_PIX_FMT_XVID:		descr = "Xvid"; break;
> -		case V4L2_PIX_FMT_VC1_ANNEX_G:	descr = "VC-1 (SMPTE 412M Annex G)"; break;
> -		case V4L2_PIX_FMT_VC1_ANNEX_L:	descr = "VC-1 (SMPTE 412M Annex L)"; break;
> -		case V4L2_PIX_FMT_VP8:		descr = "VP8"; break;
> -		case V4L2_PIX_FMT_VP9:		descr = "VP9"; break;
> -		case V4L2_PIX_FMT_HEVC:		descr = "HEVC"; break; /* aka H.265 */
>  		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
>  		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
>  		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
> @@ -1294,17 +1280,36 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		default:
> -			WARN(1, "Unknown pixelformat 0x%08x\n", fmt->pixelformat);
> -			if (fmt->description[0])
> -				return;
> -			flags = 0;
> -			snprintf(fmt->description, sz, "%c%c%c%c%s",
> -					(char)(fmt->pixelformat & 0x7f),
> -					(char)((fmt->pixelformat >> 8) & 0x7f),
> -					(char)((fmt->pixelformat >> 16) & 0x7f),
> -					(char)((fmt->pixelformat >> 24) & 0x7f),
> -					(fmt->pixelformat & (1 << 31)) ? "-BE" : "");
> -			break;
> +			/* Unordered formats */
> +			flags = V4L2_FMT_FLAG_UNORDERED;

I realized that this is a problem since this function is called *after*
the driver. So the driver has no chance to clear this flag if it knows
that the queue is always ordered.

I think this needs to be split: first set the UNORDERED flag for the selected
formats, then call the driver, then fill in the rest.

Note that this function sets fmt->flags, this should become |=. Otherwise
the UNORDERED flag would be overwritten.

It's a bit messy, but I don't see a better approach. Except by setting the
UNORDERED flag in the drivers, but I prefer this more defensive approach
(i.e. presumed unordered, unless stated otherwise).

Regards,

	Hans

> +			switch (fmt->pixelformat) {
> +			case V4L2_PIX_FMT_MPEG:		descr = "MPEG-1/2/4"; break;
> +			case V4L2_PIX_FMT_H264:		descr = "H.264"; break;
> +			case V4L2_PIX_FMT_H264_NO_SC:	descr = "H.264 (No Start Codes)"; break;
> +			case V4L2_PIX_FMT_H264_MVC:	descr = "H.264 MVC"; break;
> +			case V4L2_PIX_FMT_H263:		descr = "H.263"; break;
> +			case V4L2_PIX_FMT_MPEG1:	descr = "MPEG-1 ES"; break;
> +			case V4L2_PIX_FMT_MPEG2:	descr = "MPEG-2 ES"; break;
> +			case V4L2_PIX_FMT_MPEG4:	descr = "MPEG-4 part 2 ES"; break;
> +			case V4L2_PIX_FMT_XVID:		descr = "Xvid"; break;
> +			case V4L2_PIX_FMT_VC1_ANNEX_G:	descr = "VC-1 (SMPTE 412M Annex G)"; break;
> +			case V4L2_PIX_FMT_VC1_ANNEX_L:	descr = "VC-1 (SMPTE 412M Annex L)"; break;
> +			case V4L2_PIX_FMT_VP8:		descr = "VP8"; break;
> +			case V4L2_PIX_FMT_VP9:		descr = "VP9"; break;
> +			case V4L2_PIX_FMT_HEVC:		descr = "HEVC"; break; /* aka H.265 */
> +			default:
> +				WARN(1, "Unknown pixelformat 0x%08x\n", fmt->pixelformat);
> +				if (fmt->description[0])
> +					return;
> +				flags = 0;
> +				snprintf(fmt->description, sz, "%c%c%c%c%s",
> +						(char)(fmt->pixelformat & 0x7f),
> +						(char)((fmt->pixelformat >> 8) & 0x7f),
> +						(char)((fmt->pixelformat >> 16) & 0x7f),
> +						(char)((fmt->pixelformat >> 24) & 0x7f),
> +						(fmt->pixelformat & (1 << 31)) ? "-BE" : "");
> +				break;
> +			}
>  		}
>  	}
>  
> 
