Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBBOJc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:09:32 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:41687 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751629AbeBBOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:09:24 -0500
Subject: Re: [Patch v8 11/12] [media] s5p-mfc: Add support for HEVC encoder
To: Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kyungmin.park@samsung.com, kamil@wypas.org, jtp.park@samsung.com,
        a.hajda@samsung.com, mchehab@kernel.org, pankaj.dubey@samsung.com,
        krzk@kernel.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
 <CGME20180202125018epcas1p31771ade936e0290e579b8e0805f3f0a1@epcas1p3.samsung.com>
 <1517574348-22111-12-git-send-email-smitha.t@samsung.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <37e3531b-b677-9d3c-e954-25d8f989e774@xs4all.nl>
Date: Fri, 2 Feb 2018 15:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1517574348-22111-12-git-send-email-smitha.t@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPFpiFlV5e0BywljYxMwW69ywieh6IRjOeLDvGxOzC6BeESCe2XgLupB9rmZKsw1O8BP/UcS//YkHPknTGVBGNv+vbWXSj2Iwea5Wj65BK9OtsGrLdwf
 ZQTxrhEbke8qFFeCxNxU6pRUMfCybclhirFUg6TaWxjxBQxGLXYS38WZwc42371t0SLb0q50961tZu6ccwPjpzNIqAVPWTrpt54tD//TjhxrHsETH1KhG7yn
 PJbU+ueEQDsm8/PKvfryANhBAUj7IwWT2IHGv7F0A3bOgmpz/CNsZ1Lgcz4kqQaES4DrySHvJmucotCbVbyzZMbZbZ+F613i7j8jaU+aVVHj24BcYrD8K83C
 pzOQLqCxVV/W60GW2hJMoBCQy/WCwV5a3e88M5317D5HTCJszl9DozlAXE1YdDwbyhgSUNsUbx23+/lU1N20g1mYuMIIGDKHra3f578qD/HKX/R1ylITTVaY
 hdmSs0/HVZ3IpUXW3m4jrLg8kN464lYyOhkwPFdTW53PMeqs3TCt4Yy/lRHBlG/JktIfD7wKFqSjBqWkfyUPSLVRW8HWlj/YN1WWvIioeMOYd7/Vjeolrdex
 R2WvPe23VveCIdnq62yydEDqocNGCLQmUEqTnD06XvSNK8SqtQKlCQq6V4p9vpx69EKPE++SnqreBnCtGNAPhoHo
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/18 13:25, Smitha T Murthy wrote:
> Add HEVC encoder support and necessary registers, V4L2 CIDs,
> and hevc encoder parameters
> 
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Not quite, one last comment:

> ---
>  drivers/media/platform/s5p-mfc/regs-mfc-v10.h   |  28 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc.c        |   1 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  54 ++-
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    | 536 ++++++++++++++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr.h    |   8 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 182 ++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h |   8 +
>  8 files changed, 818 insertions(+), 2 deletions(-)
> 

<snip>

>  static inline int vui_sar_idc(enum v4l2_mpeg_video_h264_vui_sar_idc sar)
>  {
>  	static unsigned int t[V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED + 1] = {
> @@ -1635,6 +2024,153 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
>  		p->codec.vp8.profile = ctrl->val;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:
> +		p->codec.hevc.rc_frame_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_QP:
> +		p->codec.hevc.rc_p_frame_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP:
> +		p->codec.hevc.rc_b_frame_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_FRAME_RATE_RESOLUTION:
> +		p->codec.hevc.rc_framerate = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP:
> +		p->codec.hevc.rc_min_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP:
> +		p->codec.hevc.rc_max_qp = ctrl->val;
> +		break;

When you change this, you should call __v4l2_ctrl_modify_range to modify the
range of the controls that depend on this.

You can make a patch '13/12' for this or post a v9 for this patch. I would like to
see this implemented. It's one of those things that never gets implemented if you
don't address this now.

It shouldn't be difficult to do.

Regards,

	Hans
