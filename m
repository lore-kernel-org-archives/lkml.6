Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668ABC6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4DB205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxLZECHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4DB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJIIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:22:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:22:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so11926984wrd.4;
        Mon, 08 Oct 2018 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5ODFFAehFtVzpa3EBEncia5u6Fqogg8s8zHRCY5WcnY=;
        b=AxLZECHP9dEzPI5Wt/ySWsEWfNr6idUy6iDZy80+zhAycpXwCgusXKw817zBBctxQy
         LWP+j1EwE9KgVeNW8HKr4pHIEpmktMcrIJFdlKHbpLgP3f6CGviyfXOavOtVGz0dt8Aa
         4aM/fDvli+Qq14pMrnDJm9JEqTrJLGLS+kEmtk1fV6nr076GxD068iHWPv3DobWR8Q7U
         bNkEhZFolgWBIGEWlIq75LJoyvYhv3doX9uKbX2fxg5Y7yb70Ud0AA5c2l99+lJvQmI6
         qy7Ghw8Y6hnvhn6He0Hyfg4yTbKh/7i7gmwUtxUkXSFnX1T13DTVcrVvFN1A0mPVFfKI
         PR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5ODFFAehFtVzpa3EBEncia5u6Fqogg8s8zHRCY5WcnY=;
        b=CCFNF0KCJV1pcEzH9MNSb1Lg1EYi7K72zIQusEoSdpgEPF/70XiWPcgGvH8OUU/tM+
         3j3APN7EcJubUTvCGG7JE0nyUDozxnQkd4MnF0nLbNIobQFudVJWk5mIf1Bpnvp+pXWK
         CwavhTAfTIG/x3bOIKK4FRCUTvEdr7Eg/1CT3UIpBgR7OH91Da1kc4uWjV55GcrVz8+3
         QbxQFizeFbhe2Il8cVO720w1Q7FzzBp2aEPxD7BtbBpayPisAjoNGX2hyoc28C9mhtVA
         ICCfHaAmJO8lS53vb2cUlj/aqJBPf6tYoF8KIcvwJoo654GSBud3s1JMui+5s7rVPHzT
         CvnQ==
X-Gm-Message-State: ABuFfoiQHJMsVxEvoToYzyeg8J7iUT84AlYEhpyPs++glBHXdoHXvSN9
        bFhMT8PnSa7ykYIrDeXNL1/xRMO0
X-Google-Smtp-Source: ACcGV61sh1QiXNFtcU7grqf6aJUxJt3KfknBy1W1YNqHuoxYApH4QbVEnx99gPNHPyjbF8dAHnxnHA==
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr17351474wrc.131.1539047272190;
        Mon, 08 Oct 2018 18:07:52 -0700 (PDT)
Received: from [172.30.1.166] (nat-wv.mentorg.com. [192.94.38.34])
        by smtp.gmail.com with ESMTPSA id v76-v6sm18957035wmd.32.2018.10.08.18.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 18:07:51 -0700 (PDT)
Subject: Re: [PATCH v4 10/11] media: imx: Allow interweave with top/bottom
 lines swapped
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
 <20181004185401.15751-11-slongerbeam@gmail.com>
 <1538736221.3545.17.camel@pengutronix.de>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <6c8404fa-88b4-9e07-34d4-bc6652736644@gmail.com>
Date:   Mon, 8 Oct 2018 18:07:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538736221.3545.17.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,


On 10/05/2018 03:43 AM, Philipp Zabel wrote:
> Hi Steve,
>
> On Thu, 2018-10-04 at 11:54 -0700, Steve Longerbeam wrote:
>> Allow sequential->interlaced interweaving but with top/bottom
>> lines swapped to the output buffer.
>>
>> This can be accomplished by adding one line length to IDMAC output
>> channel address, with a negative line length for the interlace offset.
>>
>> This is to allow the seq-bt -> interlaced-bt transformation, where
>> bottom lines are still dominant (older in time) but with top lines
>> first in the interweaved output buffer.
>>
>> With this support, the CSI can now allow seq-bt at its source pads,
>> e.g. the following transformations are allowed in CSI from sink to
>> source:
>>
>> seq-tb -> seq-bt
>> seq-bt -> seq-bt
>> alternate -> seq-bt
>>
>> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
>> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
>> ---
>>   drivers/staging/media/imx/imx-ic-prpencvf.c | 17 +++++++-
>>   drivers/staging/media/imx/imx-media-csi.c   | 46 +++++++++++++++++----
>>   2 files changed, 53 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
>> index cf76b0432371..1499b0c62d74 100644
>> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
>> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
>> @@ -106,6 +106,8 @@ struct prp_priv {
>>   	u32 frame_sequence; /* frame sequence counter */
>>   	bool last_eof;  /* waiting for last EOF at stream off */
>>   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
>> +	u32 interweave_offset; /* interweave line offset to swap
>> +				  top/bottom lines */
> We have to store this instead of using vdev->fmt.fmt.bytesperline
> because this potentially is the pre-rotation stride instead?

interweave_offset was used by prp_vb2_buf_done() below, but in fact
that function is passed the non-rotation IDMAC channel (priv->out_ch)
_only_ if rotation is not enabled, so it is actually safe to use
vdev->fmt.fmt.bytesperline for the interweave offset in
prp_vb2_buf_done().

So I've gotten rid of interweave_offset in both imx-ic-prpencvf.c and
imx-media-csi.c, and replaced with a boolean interweave_swap as you
suggested. I agree it is much cleaner.
   

>>
>> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
>> index 679295da5dde..592f7d6edec1 100644
>> --- a/drivers/staging/media/imx/imx-media-csi.c
>> +++ b/drivers/staging/media/imx/imx-media-csi.c
>> @@ -114,6 +114,8 @@ struct csi_priv {
>>   	u32 frame_sequence; /* frame sequence counter */
>>   	bool last_eof;   /* waiting for last EOF at stream off */
>>   	bool nfb4eof;    /* NFB4EOF encountered during streaming */
>> +	u32 interweave_offset; /* interweave line offset to swap
>> +				  top/bottom lines */
> This doesn't seem necessary. Since there is no rotation here, the offset
> is just vdev->fmt.fmt.pix.bytesperline if interweave_swap is enabled.
> Maybe turn this into a bool interweave_swap?

Agreed.

>
>>   	struct completion last_eof_comp;
>>   };
>>   
>> @@ -286,7 +288,8 @@ static void csi_vb2_buf_done(struct csi_priv *priv)
>>   	if (ipu_idmac_buffer_is_ready(priv->idmac_ch, priv->ipu_buf_num))
>>   		ipu_idmac_clear_buffer(priv->idmac_ch, priv->ipu_buf_num);
>>   
>> -	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num, phys);
>> +	ipu_cpmem_set_buffer(priv->idmac_ch, priv->ipu_buf_num,
>> +			     phys + priv->interweave_offset);
>>   }
>>   
>>   static irqreturn_t csi_idmac_eof_interrupt(int irq, void *dev_id)
>> @@ -396,10 +399,10 @@ static void csi_idmac_unsetup_vb2_buf(struct csi_priv *priv,
>>   static int csi_idmac_setup_channel(struct csi_priv *priv)
>>   {
>>   	struct imx_media_video_dev *vdev = priv->vdev;
>> +	bool passthrough, interweave, interweave_swap;
>>   	const struct imx_media_pixfmt *incc;
>>   	struct v4l2_mbus_framefmt *infmt;
>>   	struct v4l2_mbus_framefmt *outfmt;
>> -	bool passthrough, interweave;
>>   	struct ipu_image image;
>>   	u32 passthrough_bits;
>>   	u32 passthrough_cycles;
>> @@ -433,6 +436,8 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
>>   	 */
>>   	interweave = V4L2_FIELD_IS_INTERLACED(image.pix.field) &&
>>   		V4L2_FIELD_IS_SEQUENTIAL(outfmt->field);
>> +	interweave_swap = interweave &&
>> +		image.pix.field == V4L2_FIELD_INTERLACED_BT;
> Although this could just as well be recalculated in csi_vb2_buf_done.

In the future yes, when we add support for alternate mode (I assume
that's what you are getting at?).


> Apart from that,
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks.

Steve

