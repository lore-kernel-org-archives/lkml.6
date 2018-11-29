Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDCDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BED2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VbSrIVfG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DZdQmYDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BED2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeK2WPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:15:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeK2WPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:15:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0EC2B6130B; Thu, 29 Nov 2018 11:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543489841;
        bh=t45rxi35F0hkWa+QTei+RUEf69X09ASWRlL+LGfFHBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VbSrIVfGsFxnmw2YR9aVC9cc8f723VL7ELoFUzMYeS4+MQEZ1VRAwaAtYlHE1VyC3
         AeyMf6evLSGI4aAYXmbXlQhTgoZmc2s33QmFA8KzjDT5aum77+ly4AyUFOTSkGw4Uv
         0ETDGN9tlXTOpMtt99ZGMTyIb4TKlzHNUC/7cWlE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DAD9E6143E;
        Thu, 29 Nov 2018 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543489837;
        bh=t45rxi35F0hkWa+QTei+RUEf69X09ASWRlL+LGfFHBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DZdQmYDsPAGBGrkoFczi9C3PCpDl04EtdJZ5v8Rvo93LXdzCwwZQ/Ssj84qaQRJeQ
         XnU40JFeOWMsll3qDGum7AJAiRJt8CEdvjwEZwc8W7IUznp5UrzL9EbrVPNsyq1WQj
         hcRbT3ccHJD2gAxsPqv4uVqOT2Jh4h7jfibK+PAs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Nov 2018 16:40:36 +0530
From:   mgottam@codeaurora.org
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Subject: Re: [PATCH v3] media: venus: add support for key frame
In-Reply-To: <4767b56f-420b-dc0c-0ae9-44dbf6dcd0b1@linaro.org>
References: <1541163476-23249-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
 <4767b56f-420b-dc0c-0ae9-44dbf6dcd0b1@linaro.org>
Message-ID: <6d765e0d7d6b873e087a3db823cb1b29@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stan,

On 2018-11-29 16:01, Stanimir Varbanov wrote:
> Hi Tomasz,
> 
> On 11/3/18 5:01 AM, Tomasz Figa wrote:
>> Hi Malathi,
>> 
>> On Fri, Nov 2, 2018 at 9:58 PM Malathi Gottam <mgottam@codeaurora.org> 
>> wrote:
>>> 
>>> When client requests for a keyframe, set the property
>>> to hardware to generate the sync frame.
>>> 
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 20 
>>> +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c 
>>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>> index 45910172..59fe7fc 100644
>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>> @@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>  {
>>>         struct venus_inst *inst = ctrl_to_inst(ctrl);
>>>         struct venc_controls *ctr = &inst->controls.enc;
>>> +       struct hfi_enable en = { .enable = 1 };
>>>         u32 bframes;
>>>         int ret;
>>> +       u32 ptype;
>>> 
>>>         switch (ctrl->id) {
>>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
>>> @@ -173,6 +175,19 @@ static int venc_op_s_ctrl(struct v4l2_ctrl 
>>> *ctrl)
>>> 
>>>                 ctr->num_b_frames = bframes;
>>>                 break;
>>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>>> +               mutex_lock(&inst->lock);
>>> +               if (inst->streamon_out && inst->streamon_cap) {
>> 
>> We had a discussion on this in v2. I don't remember seeing any 
>> conclusion.
>> 
>> Obviously the hardware should generate a keyframe naturally when the
>> CAPTURE streaming starts, which is where the encoding starts, but the
>> state of the OUTPUT queue should not affect this.
>> 
>> The application is free to stop and start streaming on the OUTPUT
>> queue as it goes and it shouldn't imply any side effects in the
>> encoded bitstream (e.g. a keyframe inserted). So:
>> - a sequence of STREAMOFF(OUTPUT),
>> S_CTRL(V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME), STREAMON(OUTPUT) should
>> explicitly generate a keyframe,
> 
> I agree with you, but presently we don't follow strictly the stateful
> encoder spec. In this spirit I think proposed patch is applicable to 
> the
> current state of the encoder driver, and your comment should be
> addressed in the follow-up patches where we have to re-factor a bit
> start/stop_streaming according to the encoder documentation.
> 
> But until then we have to get that patch.

So I can see that this patch is good implementation of forcing sync 
frame
under current encoder state.

Can you please ack the same.

Thanks,
Malathi.

> 
>> - a sequence of STREAMOFF(OUTPUT), STREAMON(OUTPUT) should _not_
>> explicitly generate a keyframe (the hardware may generate one, if the
>> periodic keyframe counter is active or a scene detection algorithm
>> decides so).
>> 
>> Please refer to the specification (v2 is the latest for the time being
>> -> https://lore.kernel.org/patchwork/patch/1002476/) for further
>> details and feel free to leave any comment for it.
>> 
>> Best regards,
>> Tomasz
>> 
