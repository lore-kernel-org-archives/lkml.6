Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2415C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFEB21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1w4tJhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFEB21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJLPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:41:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33289 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJLPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:41:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so17470250wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EFDAKpNV+oqfG/NL5WDbSgkRbVkdTGAFpxa1DpT+db4=;
        b=M1w4tJhRpwY3qi42sM3ab0lm7fVMDkWKsyXBxDZAOQcfjRvdmfUiCfQ2E2Dq1Xell+
         QV0JcWjayfl7FWBuPA8wZYCr2UE6C/eS1B+l0iyjI9VrOqHnTcTAhbGo/accUPaBTEwT
         B4lR+igI+hCp2Ui0japTuP9y44NPud/eL7Cc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFDAKpNV+oqfG/NL5WDbSgkRbVkdTGAFpxa1DpT+db4=;
        b=rE/ShUruKdUM+OUsIoVRfTqW9fSEZ+gWCzN/ziMiw26iVcIk++hcK5rnCD1Demvcbx
         v/ylPcDSdrHIcscxhpa9lqVWq/6nzumrUiCrXax+3UAI2XnYC0Iguc9Yyi9w3DevK9Zy
         wY1jtNAF2d4ibfI7Q2UwOzCVHFRZ3v6D3N0zKW7/P8SELpFm0CMpNME+e53+J3yH4rPC
         DN9AK0xZCah7Bigick/ZLcg2TrA/ssbl/VHj8wEOaFSI90xBW/VYiToDqqxG3yaL2Nms
         vgKb8X9y6V8hU9g8Bzkcih5XxPQ74x0WvTnWjH0XpnH5DbkOv0DtCrhjQWBMdTYIAIRG
         j38A==
X-Gm-Message-State: ABuFfogK2BD9GI/gbJA/KzydptEmb+k2vDtcQhzVHLZoEcMNy1x1YovH
        15rCJ8JxhVU0CnGsoOW7tNhdww==
X-Google-Smtp-Source: ACcGV61C6iYBQNqoSeyzpDKbUxcG1xxIG+03M2ytfssJ3kZeRoJtGb7yO4zNvXjPBkdhS3Ma3EgTtw==
X-Received: by 2002:a1c:c4f:: with SMTP id 76-v6mr4316850wmm.6.1539331804642;
        Fri, 12 Oct 2018 01:10:04 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id h78-v6sm697651wmd.4.2018.10.12.01.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 01:10:03 -0700 (PDT)
Subject: Re: [PATCH] media: venus: add support for key frame
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     mgottam@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
 <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org>
 <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <40d15ea4-48e2-b2c7-1d70-68dcc1b08990@linaro.org>
Date:   Fri, 12 Oct 2018 11:10:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXxaGMCY43fXwWYZmYmiVwDA6kdJRwWZGqUHhWOGXSz7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 11:06 AM, Alexandre Courbot wrote:
> On Fri, Oct 12, 2018 at 4:37 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Alex,
>>
>> On 10/12/2018 08:26 AM, Alexandre Courbot wrote:
>>> On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>>>>
>>>> When client requests for a keyframe, set the property
>>>> to hardware to generate the sync frame.
>>>>
>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>>> ---
>>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>> index 45910172..f332c8e 100644
>>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>         struct venc_controls *ctr = &inst->controls.enc;
>>>>         u32 bframes;
>>>>         int ret;
>>>> +       void *ptr;
>>>> +       u32 ptype;
>>>>
>>>>         switch (ctrl->id) {
>>>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
>>>> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>
>>>>                 ctr->num_b_frames = bframes;
>>>>                 break;
>>>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>>>> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
>>>> +               ret = hfi_session_set_property(inst, ptype, ptr);
>>>
>>> The test bot already said it, but ptr is passed to
>>> hfi_session_set_property() uninitialized. And as can be expected the
>>> call returns -EINVAL on my board.
>>>
>>> Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
>>> see that the packet sent to the firmware does not have room for an
>>> argument, so I tried to pass NULL but got the same result.
>>
>> yes, because pdata cannot be NULL. I'd suggest to make a pointer to
>> struct hfi_enable and pass it to the set_property function.
> 
> FWIW I also tried doing this and got the same error, strange...
> 

OK, when you calling the v4l control? It makes sense when you calling
it, because set_property checks does the session is on START state (i.e.
streamon on both queues).

-- 
regards,
Stan
