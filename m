Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ED82241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcGbVuRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ED82241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeKLWN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:13:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39307 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbeKLWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:13:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so7933672wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+q0sGtV6LYlVRfRRIFqKNF1KCgIaxkkEm5+nnapho7E=;
        b=KcGbVuRt6o92z/acf3WHuKJ56R9Qxd18GbSf/UHbJ2Reguu9biP9mOe5Th7LJ8pJVd
         skO13JCYQQDEhJNXKtecq1MPDfiPjolCgSs5SofYhR9FbHmkMjdxIIsM5rrfX0f/Zk1V
         qiEPqaoxS5FOm20oyxMuYE3fJ0IAQx8/10dcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+q0sGtV6LYlVRfRRIFqKNF1KCgIaxkkEm5+nnapho7E=;
        b=DVAfeuEmNVvtIFHza0el5a/tHOV0arXEHWl5ZQPEjHDJifLwpCpi3SKS/rBlrqhZ3S
         Yf0av8WW+JBSh8dtw0bkp91gYpVZSaS06pDvUr/CC8XxvyVpwjMiW5MleGJ+rxEgiB8d
         h7XIrDRCUXQJ2se8e3lJ82FUo9B/Q89SIWPKnWuTPY2ffJGl2uX+fIYUnIdHGM81HsKm
         vWfFokTosdTPjlfiUdfnPqZeLFesSgoU8eDMuHzzESMsDEBdT8HdJpyt1uT25+QcU+t7
         XO+rxx5TiSlZFeMtGJh3HkHr6rUBpRubncc7zRcZRJQCsa8qs5L4OuLU8WEfYcSmIPIJ
         VfyQ==
X-Gm-Message-State: AGRZ1gIeUdia/wDTNjchXMAageITgSK5+GREFNkMoin4EDhVsux0xH9h
        hZHEitRf33kzoCXpnYLxK4d/axe6JYY=
X-Google-Smtp-Source: AJdET5cyWsc0fOKb+lnedm65huKXUORY+Rmkkhc66oCUAiY8GeNqvJsCMJOn7LDMypBZRoFjJ2DTAA==
X-Received: by 2002:a1c:d0c6:: with SMTP id h189-v6mr7552479wmg.43.1542025252802;
        Mon, 12 Nov 2018 04:20:52 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id x2-v6sm10197797wrw.42.2018.11.12.04.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 04:20:51 -0800 (PST)
Subject: Re: [PATCH v1 5/5] media: venus: update number of bytes used field
 properly for EOS frames
To:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     sgorle@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <1538222432-25894-1-git-send-email-sgorle@codeaurora.org>
 <1538222432-25894-6-git-send-email-sgorle@codeaurora.org>
 <a331a717-199d-6d6c-c88d-54f911b942d4@linaro.org>
 <CAPBb6MVio_kYK-P+eASFMzdxbvBMWwQC7-ZjPxP3aaqpMsnEdA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <3097b9b9-e065-e42f-5b19-849313df38c2@linaro.org>
Date:   Mon, 12 Nov 2018 14:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVio_kYK-P+eASFMzdxbvBMWwQC7-ZjPxP3aaqpMsnEdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 11/12/18 10:12 AM, Alexandre Courbot wrote:
> Hi Stan,
> 
> On Thu, Nov 8, 2018 at 7:16 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi,
>>
>> On 9/29/18 3:00 PM, Srinu Gorle wrote:
>>> - In video decoder session, update number of bytes used for
>>>   yuv buffers appropriately for EOS buffers.
>>>
>>> Signed-off-by: Srinu Gorle <sgorle@codeaurora.org>
>>> ---
>>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> NACK, that was already discussed see:
>>
>> https://patchwork.kernel.org/patch/10630411/
> 
> I believe you are referring to this discussion?
> 
> https://lkml.org/lkml/2018/10/2/302
> 
> In this case, with https://patchwork.kernel.org/patch/10630411/
> applied, I am seeing the troublesome case of having the last (empty)
> buffer being returned with a payload of obs_sz, which I believe is
> incorrect. The present patch seems to restore the correct behavior.

Sorry, I thought that this solution was suggested (and tested on Venus
v4) by you, right?

> 
> An alternative would be to set the payload as follows:
> 
> vb2_set_plane_payload(vb, 0, bytesused);
> 
> This works for SDM845, but IIRC we weren't sure that this would
> display the correct behavior with all firmware versions?

OK if you are still seeing issues I think we can switch to
vb2_set_plane_payload(vb, 0, bytesused); for all buffers? I.e. not only
for buffers with flag V4L2_BUF_FLAG_LAST set.

> 
>>
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>>> index 311f209..a48eed1 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -978,7 +978,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>>>
>>>               if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
>>>                       const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
>>> -
>>> +                     vb->planes[0].bytesused = bytesused;

Is 'bytesused' != 0 in case of EoS ever?

i.e. shouldn't this be vb->planes[0].bytesused = 0 ?

>>>                       v4l2_event_queue_fh(&inst->fh, &ev);
>>>               }
>>>       } else {
>>>
>>
>> --
>> regards,
>> Stan

-- 
regards,
Stan
