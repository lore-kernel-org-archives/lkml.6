Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCCBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6179020820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thh7kSIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6179020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeKBAFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:05:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55570 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeKBAFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:05:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so1665599wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KyjWIjUr8TonEep6jXfXUf5MzlaEcdINDlgDYqQC/4Q=;
        b=Thh7kSIErjFcjocjSzqU4zOVq7RYR4u57/XyywpKGqPiluRc5IdcU9rILaMG3aLFYq
         MHr4Wae2CGwtocljL6iNEDq1p0lzsfAIOYgu3UaizHJKhm4+XTQ6Jn/i7ZiuuLKUfErL
         2z34IsbkttY3IVrEmYlbAPmhMFN2PaDt1MDhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KyjWIjUr8TonEep6jXfXUf5MzlaEcdINDlgDYqQC/4Q=;
        b=t6i5jNmyk63iIbRxycoNORcp/T3U8hMzLTgEgDx2llzxGH1BQNbqttjgVHu2phbwTa
         8Xdf1FCs0SrdX7KHvbHYiXlOIY3rp+F8F5XTNkWCaSmLju3JEoxGMfwb8Tp06KL7vojX
         AJmYR72A2s7mnSB2ASyf8I1fhPsn4JOVmNcERTzFlk/420MVCfMe6VlHGOnu8eQ6Jnpo
         Z6Eim4dotgmAtslGPEPTXpRDLXU5XMvDxJyMpYwa8tvbzu3j3kqeF4RmhIrH8977fOGj
         SDj5MtaoIggxJjBu/nEgHExMHGHGhaqOIWe/dVqELvrSs04LNdEaFnhCvUP7uPbjZTr+
         UACg==
X-Gm-Message-State: AGRZ1gJf6XIvQwV4xQCptj8S1QWLACW5SKkVIjkv62mbsuF0BbboAPc6
        6/hcbFjQgpTZz3D3mM5IRHE5EQ==
X-Google-Smtp-Source: AJdET5fYxauIJ35h76bsExy1vNqZVBrRrKDpYh79yeTWVRwxa5i/wzkJj7mhWQ6xn1CKbMnoFKVjiA==
X-Received: by 2002:a1c:3c82:: with SMTP id j124-v6mr5813229wma.62.1541084530101;
        Thu, 01 Nov 2018 08:02:10 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l140-v6sm43445696wmb.24.2018.11.01.08.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:02:09 -0700 (PDT)
Subject: Re: [PATCH] media: venus: add support for selection rectangles
To:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071603-1588-1-git-send-email-mgottam@codeaurora.org>
 <0e0f689e-f6e3-73a6-e145-deb2ef7cafc8@linaro.org>
 <5037ca4b0dd0de80750e35ca889d4225@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <4ccc50dc-c819-ca49-11d2-415053c02c0a@linaro.org>
Date:   Thu, 1 Nov 2018 17:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5037ca4b0dd0de80750e35ca889d4225@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On 11/1/18 3:10 PM, mgottam@codeaurora.org wrote:
> On 2018-10-16 15:11, Stanimir Varbanov wrote:
>> Hi Malathi,
>>
>> On 10/09/2018 10:53 AM, Malathi Gottam wrote:
>>> Handles target type crop by setting the new active rectangle
>>> to hardware. The new rectangle should be within YUV size.
>>>
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/venc.c | 19 +++++++++++++++++--
>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/venc.c
>>> b/drivers/media/platform/qcom/venus/venc.c
>>> index 3f50cd0..754c19a 100644
>>> --- a/drivers/media/platform/qcom/venus/venc.c
>>> +++ b/drivers/media/platform/qcom/venus/venc.c
>>> @@ -478,16 +478,31 @@ static int venc_g_fmt(struct file *file, void
>>> *fh, struct v4l2_format *f)
>>>  venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>>>  {
>>>      struct venus_inst *inst = to_inst(file);
>>> +    int ret;
>>> +    u32 buftype;
>>>
>>>      if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>>>          return -EINVAL;
>>>
>>>      switch (s->target) {
>>>      case V4L2_SEL_TGT_CROP:
>>> -        if (s->r.width != inst->out_width ||
>>> -            s->r.height != inst->out_height ||
>>> +        if (s->r.width > inst->out_width ||
>>> +            s->r.height > inst->out_height ||
>>>              s->r.top != 0 || s->r.left != 0)
>>>              return -EINVAL;
>>> +        if (s->r.width != inst->width ||
>>> +            s->r.height != inst->height) {
>>> +            buftype = HFI_BUFFER_OUTPUT;
>>> +            ret = venus_helper_set_output_resolution(inst,
>>> +                                 s->r.width,
>>> +                                 s->r.height,
>>> +                                 buftype);
>>
>> I'm afraid that set_output_resolution cannot be called at any time. Do
>> you think we can set it after start_session?
> 
> Yes Stan, we can set output_resolution after the session has been
> initialization.
> As per the spec, this call s_selection is an optional step under
> Initialization
> procedure of encoder even before we request buffers.

What spec you are referring to? The spec for the encoders [1] or
something else.

> 
> So I think setting output resolution in this api shouldn't cause any
> issue once
> we are confident on the instance state.

OK, but I want to test that on v1 and v3 as well (usually the behavior
differs between versions).

-- 
regards,
Stan

[1] https://patchwork.linuxtv.org/patch/52624/
