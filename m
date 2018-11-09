Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BAF20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kC+iunRM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V8VesBUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BAF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKITA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:00:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeKITAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:00:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EE826029D; Fri,  9 Nov 2018 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541755244;
        bh=OksxZfYdCjBVLgwLtiec01Wupm7MciV95e+HQ93GTRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kC+iunRMJ6TNendmvcpujFB7TcgKr+XCDRBYntD4bIWy4VBpvCC1qNKAXFgiwHz5C
         I3gz4T5owtoyT4LfJ+3XIolpD8zRhZH603GYHMlMiM6GNVeyGwx4f0udKU7pTV9PT/
         6II6PCKrorQNEM7O002ns97OG2akqPlWmA5lX8Js=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B69E76038E;
        Fri,  9 Nov 2018 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541755243;
        bh=OksxZfYdCjBVLgwLtiec01Wupm7MciV95e+HQ93GTRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V8VesBUGyxWHMXyKmAU1SLTuZc4VEkcZ7SxLZ5pb5hmBaJcJIF/VAGHIvDo7EuEtw
         5M7ISK+dTtt/CsJwtpe//Pi/q8GEraspAQj+hxObTjEgJqltbO7z/rOGHk0aSGTVlE
         2FFOkxfabqkCh8px37XZqr+Dsyy+za2ExCzgxnXM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Nov 2018 09:20:43 +0000
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
Subject: Re: [PATCH v2] media: venus: add support for selection rectangles
In-Reply-To: <CAAFQd5CwhPTmh4kF6O23Os2tihaWEez1SM=Th6BGkf_wo_LYDA@mail.gmail.com>
References: <1541749141-6989-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5CwhPTmh4kF6O23Os2tihaWEez1SM=Th6BGkf_wo_LYDA@mail.gmail.com>
Message-ID: <be2906d9d9c3f4618d21d4adef662d75@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-09 07:56, Tomasz Figa wrote:
> Hi Malathi,
> 
> On Fri, Nov 9, 2018 at 4:39 PM Malathi Gottam <mgottam@codeaurora.org> 
> wrote:
>> 
>> Handles target type crop by setting the new active rectangle
>> to hardware. The new rectangle should be within YUV size.
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc.c | 26 
>> ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/venc.c 
>> b/drivers/media/platform/qcom/venus/venc.c
>> index ce85962..d26c129 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -478,16 +478,34 @@ static int venc_g_fmt(struct file *file, void 
>> *fh, struct v4l2_format *f)
>>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection 
>> *s)
>>  {
>>         struct venus_inst *inst = to_inst(file);
>> +       int ret;
>> +       u32 buftype;
>> 
>>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>>                 return -EINVAL;
>> 
>>         switch (s->target) {
>>         case V4L2_SEL_TGT_CROP:
>> -               if (s->r.width != inst->out_width ||
>> -                   s->r.height != inst->out_height ||
>> -                   s->r.top != 0 || s->r.left != 0)
>> -                       return -EINVAL;
>> +               if (s->r.left != 0) {
>> +                       s->r.width += s->r.left;
>> +                       s->r.left = 0;
>> +               }
>> +
>> +               if (s->r.top != 0) {
>> +                       s->r.height += s->r.top;
>> +                       s->r.top = 0;
>> +               }
>> +
>> +               if (s->r.width > inst->width)
>> +                       s->r.width = inst->width;
>> +               else
>> +                       inst->width = s->r.width;
>> +
>> +               if (s->r.height > inst->height)
>> +                       s->r.height = inst->height;
>> +               else
>> +                       inst->height = s->r.height;
>> +
> 
> From semantic point of view, it looks fine, but where is the rectangle
> actually set to the hardware?
> 
> Best regards,
> Tomasz

As this set selection call occurs before the hfi session initialization,
for now we are holding these values in driver.

As this call is followed by VIDIOC_REQBUFS(), as a part of this
we have venc_init_session

static int venc_init_session(struct venus_inst *inst)
{
	int ret;

	ret = hfi_session_init(inst, inst->fmt_cap->pixfmt);
	if (ret)
		return ret;

	ret = venus_helper_set_input_resolution(inst, inst->width,
						inst->height);
	if (ret)
		goto deinit;

	ret = venus_helper_set_output_resolution(inst, inst->width,
						 inst->height,
						 HFI_BUFFER_OUTPUT);
	if (ret)
		goto deinit;

	ret = venus_helper_set_color_format(inst, inst->fmt_out->pixfmt);
	if (ret)
		goto deinit;

	ret = venc_set_properties(inst);


 From here we set these values to hardware.
