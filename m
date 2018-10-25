Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB9FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FA3205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jrWg2tn+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jrWg2tn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FA3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJYPzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:55:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:55:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB04D60C48; Thu, 25 Oct 2018 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540452217;
        bh=P5qrV/27JOt4/3qTEupaSGD5er/xGC2QBt9aJo3H+CA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrWg2tn+UJ2utpDxGCrn0I2nU0JQ9aEM80YQ+riLw2n0NpdvbVZamv0rYGBd1MXm4
         wXR9tE2m0WYUgY82iKPZ4cK1t0BC0tRhg0rODel9XjLfK0HhQjRtqFx2zlB3IcEiwV
         8kzsJXltswtqtPS42Cc0ySIKRYHYbCw5uaZ6aGnU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0D8C160316;
        Thu, 25 Oct 2018 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540452217;
        bh=P5qrV/27JOt4/3qTEupaSGD5er/xGC2QBt9aJo3H+CA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrWg2tn+UJ2utpDxGCrn0I2nU0JQ9aEM80YQ+riLw2n0NpdvbVZamv0rYGBd1MXm4
         wXR9tE2m0WYUgY82iKPZ4cK1t0BC0tRhg0rODel9XjLfK0HhQjRtqFx2zlB3IcEiwV
         8kzsJXltswtqtPS42Cc0ySIKRYHYbCw5uaZ6aGnU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 12:53:37 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v2] media: venus: add support for key frame
In-Reply-To: <CAAFQd5CaYH-kxj+9cquObTHiRyA1VoEYHQmiQAGjdZm6J1ACfg@mail.gmail.com>
References: <1540389162-30358-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5CaYH-kxj+9cquObTHiRyA1VoEYHQmiQAGjdZm6J1ACfg@mail.gmail.com>
Message-ID: <86344762e1eeab8fe8a940a1bfffa2c1@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-24 20:02, Tomasz Figa wrote:
> On Wed, Oct 24, 2018 at 10:52 PM Malathi Gottam 
> <mgottam@codeaurora.org> wrote:
>> 
>> When client requests for a keyframe, set the property
>> to hardware to generate the sync frame.
>> 
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c 
>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> index 45910172..6c2655d 100644
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
>> @@ -173,6 +175,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>> 
>>                 ctr->num_b_frames = bframes;
>>                 break;
>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>> +               if (inst->streamon_out && inst->streamon_cap) {
>> +                       ptype = 
>> HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
>> +                       ret = hfi_session_set_property(inst, ptype, 
>> &en);
>> +
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +               break;
> 
> This is still not the right way to handle this.
> 
> Please see the documentation of this control [1]:
> 
> "V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME (button)
> Force a key frame for the next queued buffer. Applicable to encoders.
> This is a general, codec-agnostic keyframe control."
> 
> Even if the driver is not streaming, it must remember that the
> keyframe was requested for next buffer. The next time userspace QBUFs
> an OUTPUT buffer, it should ask the hardware to encode that OUTPUT
> buffer into a keyframe.

That's correct. Driver can cache the client request and set it when the 
hardware
is capable of accepting the property.
Still the issue having the requested OUTPUT buffer to be encoded as sync 
frame will
be there. If there are few frames queued before streamon, driver will 
only keep a
note that it has to set the request for keyframe, but not the exact one 
which was
requested.

> [1]
> https://www.kernel.org/doc/html/latest/media/uapi/v4l/extended-controls.html?highlight=v4l2_cid_mpeg_video_force_key_frame
> 
> But generally, the proper modern way for the userspace to request a
> keyframe is to set the V4L2_BUF_FLAG_KEYFRAME flag in the
> vb2_buffer_flag when queuing an OUTPUT buffer. It's the only
> guaranteed way to ensure that the keyframe will be encoded exactly for
> the selected frame. (The V4L2 control API doesn't guarantee any
> synchronization between controls and buffers itself.)

This is a better way to handle it to ensure exact buffer gets encoded as 
sync frame.

> Best regards,
> Tomasz
