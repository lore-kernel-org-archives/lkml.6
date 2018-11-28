Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE4BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFAA2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AOoQJB24";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kGI1gqyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFAA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeK1XlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:41:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbeK1XlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:41:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F0EC612F2; Wed, 28 Nov 2018 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543408786;
        bh=t7u7siOugJyyWH4ebX/o1gjwWZ/zTEJYur2rWm9fEcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AOoQJB24q/zfhTzDEmo+daZ1Sl0yRg98RFoX2/irKNNI73p/PF4nujX9Ak49dUI1T
         BQJkY/0B9lyZ7vgPcNkQ65+0jfIw6bDVc4RUXoc1P9ihprOapD5KawtrOAs5VBsI72
         c2hy6OTZtit4m7tzXLUGUmzxvM9vBAe7Mur9oHdM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 42C1C60C5F;
        Wed, 28 Nov 2018 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543408785;
        bh=t7u7siOugJyyWH4ebX/o1gjwWZ/zTEJYur2rWm9fEcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGI1gqyu+KIE/Ryt74nK0P7cVjLU02wcLC0v/813aCA4oxknsEVZMZEVYLYYJWs/6
         rHBf+Dr3JD/WQQd17xE3OpJ+EJE2L8lu5nZN6JUXggItoQqKEssfE7yLtY4XgY5r1i
         QDIaZID7wsIvfLlnR+s1qpUPqzvjZ5ceoFgHJNp0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Nov 2018 18:09:45 +0530
From:   mgottam@codeaurora.org
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Subject: Re: [PATCH v3] media: venus: add support for key frame
In-Reply-To: <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
References: <1541163476-23249-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
Message-ID: <702e222691accc7d92263a7265391b5f@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-03 08:31, Tomasz Figa wrote:
> Hi Malathi,
> 
> On Fri, Nov 2, 2018 at 9:58 PM Malathi Gottam <mgottam@codeaurora.org> 
> wrote:
>> 
>> When client requests for a keyframe, set the property
>> to hardware to generate the sync frame.
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 20 
>> +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c 
>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> index 45910172..59fe7fc 100644
>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> @@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>         struct venus_inst *inst = ctrl_to_inst(ctrl);
>>         struct venc_controls *ctr = &inst->controls.enc;
>> +       struct hfi_enable en = { .enable = 1 };
>>         u32 bframes;
>>         int ret;
>> +       u32 ptype;
>> 
>>         switch (ctrl->id) {
>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
>> @@ -173,6 +175,19 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>> 
>>                 ctr->num_b_frames = bframes;
>>                 break;
>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>> +               mutex_lock(&inst->lock);
>> +               if (inst->streamon_out && inst->streamon_cap) {
> 
> We had a discussion on this in v2. I don't remember seeing any 
> conclusion.
> 
> Obviously the hardware should generate a keyframe naturally when the
> CAPTURE streaming starts, which is where the encoding starts, but the
> state of the OUTPUT queue should not affect this.
> 
> The application is free to stop and start streaming on the OUTPUT
> queue as it goes and it shouldn't imply any side effects in the
> encoded bitstream (e.g. a keyframe inserted). So:
> - a sequence of STREAMOFF(OUTPUT),
> S_CTRL(V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME), STREAMON(OUTPUT) should
> explicitly generate a keyframe,
> - a sequence of STREAMOFF(OUTPUT), STREAMON(OUTPUT) should _not_
> explicitly generate a keyframe (the hardware may generate one, if the
> periodic keyframe counter is active or a scene detection algorithm
> decides so).
> 
> Please refer to the specification (v2 is the latest for the time being
> -> https://lore.kernel.org/patchwork/patch/1002476/) for further
> details and feel free to leave any comment for it.
> 
> Best regards,
> Tomasz

Gentle reminder!!

Stan, please provide your view on this.

Thanks,
Malathi.
