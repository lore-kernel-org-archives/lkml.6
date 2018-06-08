Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RXaKLulIGluNKAAAmS7hNA
	; Fri, 08 Jun 2018 09:14:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CC856607E4; Fri,  8 Jun 2018 09:14:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63BAF607DC;
	Fri,  8 Jun 2018 09:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63BAF607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeFHJOQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:14:16 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:40876 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750907AbeFHJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:14:13 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id RDT7fnqKztLaARDTAfxwMq; Fri, 08 Jun 2018 11:14:12 +0200
Subject: Re: [PATCH v2 2/2] media: mtk-vcodec: Support VP9 profile in decoder
To: Keiichi Watanabe <keiichiw@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-3-keiichiw@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a631f7f4-3405-5c1a-2932-106e4481ae5a@xs4all.nl>
Date: Fri, 8 Jun 2018 11:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180530071613.125768-3-keiichiw@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHOLjLTPTdDkACnCGVSqds6P9uaMc1ld/DsI9gf68hfwpRsA3+hQd2NVjT/etABBRgkpYXz7OixcAHeyR2RemFrg9eaCFTg/RSSgOPxA46rzhhadMieI
 9N0WvZ3bVs+aR6Yeb/Bqse8+NpQLx0goAVBvshVwxu9aPC3nbftA41VipD8o+ilbxwIH7MCdnV1FzeNF0ZgJDplZCTrEUYOmzJM+hYCWjOaOUWaooaZKOJLJ
 +MhilAXeNjORAI0LaC+tdCk3krFxumqdmsvMHlWm+fjTb/b9IxGi9kkKUtG+Oiodd6pgV5weuhGWVQG0QH8TWDJMM7eeTEl8WgfhZi+k45mNCTb7FaY9nGqa
 /JyzewVbNa3CGAGiglyVsTWKRVUKZ+m8qT9Rv3Twq6k3APqoHMAn6RVTX0pEFG4xQ2alx6crdqNPyaVbnSDy9krk0ikklY3+IHGyGXVXpcTL2DU6/pQ3nMLN
 WNrJkb9ly1YnwqV+ULDrnN8Ayjygezyp/1XrjuBV/rcKo5pG+Q6YKJlk/h8hx0BGNvJI/8CsQzNr/paPQjdUTqdNPEiHdwMsLtZQUvw6ANRYX09B7BWbpAGh
 vs89pSH8gmL761od9VLp0oJkK/TN1ZVIORKEJZQDPREwIR2Buw6kJDOMdD4Uo8QzvE67thoA4M05QdEG7fL6XLrR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
> Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE control in MediaTek decoder's
> driver.
> MediaTek decoder only supports profile 0 for now.
> 
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> index 86f0a7134365..f9393504356d 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> @@ -1400,6 +1400,12 @@ int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
>  				V4L2_CID_MIN_BUFFERS_FOR_CAPTURE,
>  				0, 32, 1, 1);
>  	ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
> +	v4l2_ctrl_new_std_menu(&ctx->ctrl_hdl,
> +				&mtk_vcodec_dec_ctrl_ops,
> +				V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
> +				V4L2_MPEG_VIDEO_VP9_PROFILE_3,

It makes no sense to set max to PROFILE_3 if PROFILE_0 is the only choice.
Just set max to PROFILE_0 as well.

> +				~(1U << V4L2_MPEG_VIDEO_VP9_PROFILE_0),
> +				V4L2_MPEG_VIDEO_VP9_PROFILE_0);
> 
>  	if (ctx->ctrl_hdl.error) {
>  		mtk_v4l2_err("Adding control failed %d",
> --
> 2.17.0.921.gf22659ad46-goog
> 

Regards,

	Hans
