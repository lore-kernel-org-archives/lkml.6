Return-Path: <hverkuil@xs4all.nl>
X-Google-Smtp-Source: AB8JxZqdo7bf2FcycOoupHTApR5QUjVDWERWeE3YW15q3SZkpWhyXLKJ9d6CK5PHvJOaBouFSdi2
ARC-Seal: i=1; a=rsa-sha256; t=1525700990; cv=none;
        d=google.com; s=arc-20160816;
        b=BX/gZM3F9T8USddqlhF8hK3jDilGDfuk//K9icZUmfnunSftP5d6qvH9mdFUHKSpOh
         VMGdQXLDRKVathcTUmAHDoOYwStGMXUjjqtnpfjFTaRznQqFK1V49+QLbJSTNTGGADza
         de8/fapu09sAu4G9/CGxcJrRi+YVi1wmkgSa3LqAdYfWHc1tgh6Kxtayq57w005vEsUD
         AkSTtohHheFZ09cjINgOhz9nq8K7/nfTmurf7MWbtryuQ3Fjid4xkVcCvvpUVlUG+7/R
         v6mZSUKX1E6bloAl6LNkAoGpotHJL9YobB2jxZa03BBnG1dsFDYKcySMRvNnIHgwebmx
         XiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=q9AZCnNr31yWGKc3TSJnxZjnHH6CwlBxBMhN/tVK0vw=;
        b=YQ80CNRKcIgU1gvTaTDVXk7VvEUpHCibdCBMMDAazkPPecaSecwXqVHJPJpuegaESp
         xteD09Y/Bb465JpSE8+yUoERrmHBLTAkMhPypiaqa91VgMLN3wVfqDZJ89tRgy0/r2nF
         tRDmMgtVTjC4E3P5DV/3szXW4ca+RedRgkJNsSvRNA4NVieUCVn6z1GHhdYRAD5SeWXR
         EdfKoBTC1ASspyIrosBIR8MqmI4aDQNhUZkqP/2Y5ZG1aR/6nEwBHPc6cp2rGgr9bU4Q
         NeATbDuUj5W+3zQL/fGmcxfBdfT9A0s0ROAhrcMCf+U+Q2JT60SUsJoCTHoDbe/BalyX
         yCWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.26 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.26 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Subject: Re: [PATCH v3 08/14] media: v4l: Add definitions for MPEG2 frame
 format and header metadata
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@st.com>, Thomas Gleixner
 <tglx@linutronix.de>, Hugues Fruchet <hugues.fruchet@st.com>,
 Alexandre Courbot <gnurou@gmail.com>,
 Florent Revest <florent.revest@free-electrons.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
 Smitha T Murthy <smitha.t@samsung.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Randy Li <ayaka@soulik.info>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
 <20180507124500.20434-9-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <1bd7af5a-c8d5-220c-8471-545eb1835882@xs4all.nl>
Date: Mon, 7 May 2018 15:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507124500.20434-9-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLTW6p1YRWGA4IVwpnmgDZCCkAZ+x1VQdmmNdMiaOHUWt4evBtDFIITBfw0y5LBZZkYjqhvCX4ttFh83mcKsV2WVSruGYBNgURx5AvlWNDAlQ80YeNxn
 90Of6IqFTDhtNRLq2O0YyIqYa9vGoVS75xKyO5dc02BG0vX0QywYs2xSPr687ec0ra8N3AAs/2iAzced/AUYYPV6R93xagPF1WfPwyhotB3s9RyorfhyuDsk
 NpbmsDEn8WkSBNLKFnsYtesO+uhQOMWa7E6cIp7FXVzWW8KKkATdQcz1QOAZysaSGv6PBAf6wTazrMbFpP7gsCbk038/N06j/ESFAvyk0+B0pcCXS7R7XRh6
 HNNMcXtbPhZqTTak/SnRms0ti57WW9KZvOaYEcMW5LBG+kaxtPer0X9Vmc6PSHa+ZsH23vnCZ1XWBgPvIAfLxWBnXD1WGqFrBTztKulkP5apokMPN4bIXBPe
 tMYdMHhrccPMG/K2GaYutg788wedENm1CX61VPkPfNn/RXNual8CqxoiJ2Wqa8FV4VQGZ6WFIhhIAlkJABA1KjPoxrbsuy4dzmFk1SXq7OkqTG4Q7fgozBHr
 b3Av98Dur+tWoH5yVEJ8lhg5+yIbvwQVOSX+eT4OQWwvfESNH3RJYjtg/HEn+bqaq6gGBjFbH8KUjy9vyKEelk0mArcQ4NP1NwdwiLqI4cDjNa6xbrVsxjdC
 K3tO0S9C+WCki5PQJvCRAr0Ui3EDxlFjoyuU+UACnT+/sgvSjUFKaiLxHCMQAh73OmsGWsBzbUBXNaJbeL5fsDh5uRQqRxssLaIXmhEQCkj8GPBf61VAmZkk
 ps2ZJo9KokGi3vAESGsQHo9hU0ODlFEg1iobJVTAqN7tYMPSF5DxDa6VJ7YIzdfYF8vKTlpRH2qdDyrpRw8V7MBohy+PAapeu4uzoAAeU/yZ5BMxS/530Lc4
 3wVEL14biUDjQQUmhft1pwL5Nij8dhzq6oO0+PtLespi56Ov3QpS8teIe24usnrfAUS7aG5kgW4bXfwqdMCOKFNYHHoR6kGEfK9OPr17MI+J5sQO7sH1Lyrf
 i3fjwkmCWvWgKxvLM8rXjJwhjAae88IYv4UYKUkLyvoBfPBknRV7bjXUlwhWLG39T9dOuP1C3hh5+G7SgcFnbjYiu23h+PvtXsMjVOw8HrjtU1joTBd973Xa
 pOCgSTUD+WYGGtT82iJRxbP4hqpW362AReIlRsUG1FhYnjBotFd93XL7M/B90StlJ1U3cvz2BoV66CEV30yeecT52enS6ew/sKNqFa4Q36hPQjxfT2Tl6EG/
 +4OB/V4G+g+4wuCk0FjkYtT53jYTegM5DlqaJmabikcLy94o30V9e2krPxEV63V/t7yWcPlTpxs++uxWuxQGDUdTCkgeBLV4w05Q1x2zL3/5twUbjePrsBGV
 y6iea9EXvJiysqOxBvi3g82Y7S2OAUFN1FircZQZNh3umDlOoi4y2H9PYhx1/+wbgTIxrxtCW3DcGV6iRV8zlnWBbUzYg+M10aSH4QFt1oCpByk6Nyq54Hzg
 8Z2Ef+1z+XB6mmth3OuTse3I7/evTDDw9CBon6344Kmo6QUT/f86z3DnYVZgPRXf1gU5lsbwlXv416McYO0Vljz6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809525009240133?=
X-GMAIL-MSGID: =?utf-8?q?1599813441622518965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07/05/18 14:44, Paul Kocialkowski wrote:
> From: Florent Revest <florent.revest@free-electrons.com>
> 
> Stateless video decoding engines require both the MPEG slices and
> associated metadata from the video stream in order to decode frames.
> 
> This introduces definitions for a new pixel format, describing buffers
> with MPEG2 slice data, as well as a control structure for passing the
> frame header (metadata) to drivers.
> 
> Signed-off-by: Florent Revest <florent.revest@free-electrons.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 10 ++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c |  1 +
>  include/uapi/linux/v4l2-controls.h   | 26 ++++++++++++++++++++++++++
>  include/uapi/linux/videodev2.h       |  3 +++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index df58a23eb731..cdf860c8e3d8 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -826,6 +826,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE:		return "Vertical MV Search Range";
>  	case V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER:		return "Repeat Sequence Header";
>  	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:		return "Force Key Frame";
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_FRAME_HDR:		return "MPEG2 Frame Header";

This compound control needs to be documented in the V4l2 spec.

>  
>  	/* VPX controls */
>  	case V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS:		return "VPX Number of Partitions";
> @@ -1271,6 +1272,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_RDS_TX_ALT_FREQS:
>  		*type = V4L2_CTRL_TYPE_U32;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_FRAME_HDR:
> +		*type = V4L2_CTRL_TYPE_MPEG2_FRAME_HDR;
> +		break;
>  	default:
>  		*type = V4L2_CTRL_TYPE_INTEGER;
>  		break;
> @@ -1591,6 +1595,9 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
>  			return -ERANGE;
>  		return 0;
>  
> +	case V4L2_CTRL_TYPE_MPEG2_FRAME_HDR:
> +		return 0;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -2165,6 +2172,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
>  	case V4L2_CTRL_TYPE_U32:
>  		elem_size = sizeof(u32);
>  		break;
> +	case V4L2_CTRL_TYPE_MPEG2_FRAME_HDR:
> +		elem_size = sizeof(struct v4l2_ctrl_mpeg2_frame_hdr);
> +		break;
>  	default:
>  		if (type < V4L2_CTRL_COMPOUND_TYPES)
>  			elem_size = sizeof(s32);
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 561a1fe3160b..38d318c47c55 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1274,6 +1274,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_VP8:		descr = "VP8"; break;
>  		case V4L2_PIX_FMT_VP9:		descr = "VP9"; break;
>  		case V4L2_PIX_FMT_HEVC:		descr = "HEVC"; break; /* aka H.265 */
> +		case V4L2_PIX_FMT_MPEG2_FRAME:	descr = "MPEG2 Frame"; break;

Needs to be documented in the spec.

>  		case V4L2_PIX_FMT_CPIA1:	descr = "GSPCA CPiA YUV"; break;
>  		case V4L2_PIX_FMT_WNVA:		descr = "WNVA"; break;
>  		case V4L2_PIX_FMT_SN9C10X:	descr = "GSPCA SN9C10X"; break;
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 8d473c979b61..23da8bfa7e6f 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -557,6 +557,8 @@ enum v4l2_mpeg_video_mpeg4_profile {
>  };
>  #define V4L2_CID_MPEG_VIDEO_MPEG4_QPEL		(V4L2_CID_MPEG_BASE+407)
>  
> +#define V4L2_CID_MPEG_VIDEO_MPEG2_FRAME_HDR     (V4L2_CID_MPEG_BASE+450)
> +
>  /*  Control IDs for VP8 streams
>   *  Although VP8 is not part of MPEG we add these controls to the MPEG class
>   *  as that class is already handling other video compression standards
> @@ -1076,4 +1078,28 @@ enum v4l2_detect_md_mode {
>  #define V4L2_CID_DETECT_MD_THRESHOLD_GRID	(V4L2_CID_DETECT_CLASS_BASE + 3)
>  #define V4L2_CID_DETECT_MD_REGION_GRID		(V4L2_CID_DETECT_CLASS_BASE + 4)
>  
> +struct v4l2_ctrl_mpeg2_frame_hdr {
> +	__u32 slice_len;
> +	__u32 slice_pos;
> +	enum { MPEG1, MPEG2 } type;

Still an enum?

> +
> +	__u16 width;
> +	__u16 height;
> +
> +	enum { PCT_I = 1, PCT_P, PCT_B, PCT_D } picture_coding_type;
> +	__u8 f_code[2][2];
> +
> +	__u8 intra_dc_precision;
> +	__u8 picture_structure;
> +	__u8 top_field_first;
> +	__u8 frame_pred_frame_dct;
> +	__u8 concealment_motion_vectors;
> +	__u8 q_scale_type;
> +	__u8 intra_vlc_format;
> +	__u8 alternate_scan;
> +
> +	__u8 backward_ref_index;
> +	__u8 forward_ref_index;
> +};
> +
>  #endif
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 1f6c4b52baae..d8f9b59d90d7 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -636,6 +636,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_VP8      v4l2_fourcc('V', 'P', '8', '0') /* VP8 */
>  #define V4L2_PIX_FMT_VP9      v4l2_fourcc('V', 'P', '9', '0') /* VP9 */
>  #define V4L2_PIX_FMT_HEVC     v4l2_fourcc('H', 'E', 'V', 'C') /* HEVC aka H.265 */
> +#define V4L2_PIX_FMT_MPEG2_FRAME v4l2_fourcc('M', 'G', '2', 'F') /* MPEG2 frame */
>  
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> @@ -1587,6 +1588,7 @@ struct v4l2_ext_control {
>  		__u8 __user *p_u8;
>  		__u16 __user *p_u16;
>  		__u32 __user *p_u32;
> +		struct v4l2_ctrl_mpeg2_frame_hdr __user *p_mpeg2_frame_hdr;
>  		void __user *ptr;
>  	};
>  } __attribute__ ((packed));
> @@ -1632,6 +1634,7 @@ enum v4l2_ctrl_type {
>  	V4L2_CTRL_TYPE_U8	     = 0x0100,
>  	V4L2_CTRL_TYPE_U16	     = 0x0101,
>  	V4L2_CTRL_TYPE_U32	     = 0x0102,
> +	V4L2_CTRL_TYPE_MPEG2_FRAME_HDR = 0x0109,
>  };
>  
>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
> 

Regards,

	Hans
