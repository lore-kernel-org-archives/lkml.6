Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208EC2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 01:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208EC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJIqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:46:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33668 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeJJIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:46:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 22023260A95
Subject: Re: [PATCH] media: vivid: Improve timestamping
To:     Gabriel Francisco Mandaji <gfmandaji@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
References: <20181010004921.GA6532@gfm-note>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <06d3f4d3-f864-6cca-9c3a-45909f7188da@collabora.com>
Date:   Tue, 9 Oct 2018 22:26:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010004921.GA6532@gfm-note>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

Thanks for your patch.

On 10/9/18 9:49 PM, Gabriel Francisco Mandaji wrote:
> Simulate a more precise timestamp by calculating it based on the
> current framerate.
> 
> Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
> ---
>  drivers/media/platform/vivid/vivid-core.h        |  1 +
>  drivers/media/platform/vivid/vivid-kthread-cap.c | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/vivid/vivid-core.h b/drivers/media/platform/vivid/vivid-core.h
> index cd4c823..cbdadd8 100644
> --- a/drivers/media/platform/vivid/vivid-core.h
> +++ b/drivers/media/platform/vivid/vivid-core.h
> @@ -384,6 +384,7 @@ struct vivid_dev {
>  	/* thread for generating video capture stream */
>  	struct task_struct		*kthread_vid_cap;
>  	unsigned long			jiffies_vid_cap;
> +	u64				cap_stream_start;
>  	u32				cap_seq_offset;
>  	u32				cap_seq_count;
>  	bool				cap_seq_resync;
> diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
> index f06003b..0793b15 100644
> --- a/drivers/media/platform/vivid/vivid-kthread-cap.c
> +++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
> @@ -416,6 +416,7 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
>  	char str[100];
>  	s32 gain;
>  	bool is_loop = false;
> +	u64 soe_time = 0;
>  
>  	if (dev->loop_video && dev->can_loop_video &&
>  		((vivid_is_svid_cap(dev) &&
> @@ -426,11 +427,11 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
>  
>  	buf->vb.sequence = dev->vid_cap_seq_count;
>  	/*
> -	 * Take the timestamp now if the timestamp source is set to
> -	 * "Start of Exposure".
> +	 * Store the current time to calculate the delta if source is set to
> +	 * "End of Frame".
>  	 */
> -	if (dev->tstamp_src_is_soe)
> -		buf->vb.vb2_buf.timestamp = ktime_get_ns();
> +	if (!dev->tstamp_src_is_soe)
> +		soe_time = ktime_get_ns();
>  	if (dev->field_cap == V4L2_FIELD_ALTERNATE) {
>  		/*
>  		 * 60 Hz standards start with the bottom field, 50 Hz standards
> @@ -556,12 +557,18 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
>  	}
>  
>  	/*
> -	 * If "End of Frame" is specified at the timestamp source, then take
> -	 * the timestamp now.
> +	 * If "End of Frame", then calculate the "exposition time" and add
> +	 * it to the timestamp.
>  	 */
>  	if (!dev->tstamp_src_is_soe)
> -		buf->vb.vb2_buf.timestamp = ktime_get_ns();
> -	buf->vb.vb2_buf.timestamp += dev->time_wrap_offset;
> +		soe_time = ktime_get_ns() - soe_time;

If I understand correctly, soe_time here is the elapsed time (the delta
between the beginning of the frame and the end of it), so I thing naming
it etime or frame_time or delta_time would be clearer, because soe
stands for "start of exposure" and doesn't seem to be the right meaning.

> +	buf->vb.vb2_buf.timestamp = dev->timeperframe_vid_cap.numerator *
> +				    1000000000 /
> +				    dev->timeperframe_vid_cap.denominator *
> +				    dev->vid_cap_seq_count +
> +				    dev->cap_stream_start +
> +				    soe_time +
> +				    dev->time_wrap_offset;

Could you move the dev->vid_cap_seq_count to the top? I got confused if
it was multiplying only the denominator, I think moving to the top makes
it clearer (or add parenthesis).

>  }
>  
>  /*
> @@ -759,6 +766,7 @@ static int vivid_thread_vid_cap(void *data)
>  	dev->cap_seq_count = 0;
>  	dev->cap_seq_resync = false;
>  	dev->jiffies_vid_cap = jiffies;
> +	dev->cap_stream_start = ktime_get_ns();
>  
>  	for (;;) {
>  		try_to_freeze();
> 

Thanks
Helen
