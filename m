Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D008D20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fm49D9LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391838AbfAPJoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:44:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45642 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbfAPJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:44:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so6071827wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i4COrJ3f04YVkKKA3jV+p3HM78S7a3zx0+u6D2A+RF0=;
        b=fm49D9LIzzrUZ+tHAk2GkcaMLfVnw+cpNEYmIfcqntyU7PeIGmepc6/ASwcsrZbIX6
         olT84NYGG+A3JweN1tKW+/oSjNrRozBPUHVuJZ0xYRJ+tVdI0cafh9zwZIJHoJu7/DjQ
         1L1DWjijS5ALJdUTbtzwtzFFkPBD2FAQPPelw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i4COrJ3f04YVkKKA3jV+p3HM78S7a3zx0+u6D2A+RF0=;
        b=aSjE3jp6hmXejw4jPuy5GROhYPTFsnacaHCD290psUbXoVgSggx97Ybpn85+cwnuj/
         CC931pKbmC3DqllCBo874AkiBOzLCpFEiRp703p5voE0CiR/YIBJVIPsT5Mu8+PwCkTc
         fsECVj9Ou8bKhAqtUPTz+7YqpB6bzFgw77m7xlLiw/aFjTnMp4Y6W+aXtqJaCNvdBvUy
         UICA3pDWZbtdf0gj3T1EmmeXgL+upINc+r3vgDQNgYBFnBGeJX0JdpbRvPPMueRmumV8
         Nc14189OcKQt3fp4dfCC1Wo9GbtDYqrWIYIanUcCn4pmWvwnX2ZHdk+eqMyIZMmf9ctT
         OTFw==
X-Gm-Message-State: AJcUukf1g+Wqw0CdnXwwXgUkYNuZF1jVvIIQoq4/ObZsqb5Eg+okv/HP
        K6awNonxEJrkcuVI6i8Lt9c3jw==
X-Google-Smtp-Source: ALg8bN4nUIvHd+3hrTmx3bjmF4W2SNJYPM2iMyH8wyuB4jjJALZPuuXMgz7FR5pMa1sZBeGKJrJeOg==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr6658214wru.222.1547631849800;
        Wed, 16 Jan 2019 01:44:09 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id y8sm32185921wmg.13.2019.01.16.01.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 01:44:08 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: sdm845: add video nodes
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        mgottam@codeaurora.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <1542708506-12680-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MVzmxfRstUrTOtkJdCDaZEZO=UeP_u3btGKrsKasBijRg@mail.gmail.com>
 <7e306c60-8603-a8c4-cbb3-526f8a63ee39@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <238eaf7a-4785-76ca-b146-c4eb8abcfef7@linaro.org>
Date:   Wed, 16 Jan 2019 11:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7e306c60-8603-a8c4-cbb3-526f8a63ee39@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 11/27/18 10:24 AM, Stanimir Varbanov wrote:
> Hi Alex,
> 
> On 11/27/18 9:31 AM, Alexandre Courbot wrote:
>> On Tue, Nov 20, 2018 at 7:08 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>>>
>>> This adds video nodes to sdm845 based on the examples
>>> in the bindings.
>>>
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 34 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index 0c9a2aa..d82487d 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -84,6 +84,10 @@
>>>                         reg = <0 0x86200000 0 0x2d00000>;
>>>                         no-map;
>>>                 };
>>> +               venus_region: venus@95800000 {
>>> +                       reg = <0x0 0x95800000 0x0 0x500000>;
>>
>> Note that the driver expects a size of 0x600000 here and will fail to
>> probe if this is smaller.
>>
> 
> I have to send a patch to fix that size mismatch as we discussed that it
> the other mail thread.
>

I sent the size mismatch patch here:

https://patchwork.kernel.org/patch/10753645/


-- 
regards,
Stan
