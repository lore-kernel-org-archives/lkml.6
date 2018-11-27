Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E783120873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aC4c3gBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E783120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeK0TVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:21:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44610 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbeK0TVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:21:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so17359012wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ik8Olk2vN6kLe6zSI0+hBnOrSwZKDk4ik8r18iyrE9k=;
        b=aC4c3gBGSKlBohq5VaP3xx8DfSt0OkJF8MD0cKE74M8u7zgIvQkJ9r5C4QJAbQ3ApQ
         /f6sZBRcrzPvuvAFUaFHBynhxut5FUN8l7ENICt+CZDBMAIaJI8MBqL5QhU7JPdEotMF
         llhO+hv8FshW/OEPbEGoureveaY5QT6BPPDhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ik8Olk2vN6kLe6zSI0+hBnOrSwZKDk4ik8r18iyrE9k=;
        b=MNy5HGdu0YeXmpYqBdqT5mOzF4+rxI7VGjyDhcStvXY/WJXDz+jWQznXRqaa/volOH
         Wz2v1WrEPJfX0SKmzxGC0Bamhc9zPoNuptXrSEciYemsSMX55knwzb4S1Crpb/Debo0n
         IJVl55bZtbjtUUXlVHwheBrn1rrwmrCF1eVjgcCsdkN+vnHXYCGyX7QRqhHz0LNlLQn3
         OHn0igZoiEIs5b5yjUNQyxOdeo/59+uo67SGJnVmC4KOv7CKMQQVGfDQC0C4/KqpxU1Y
         tE88TmBrk1SZ6b8svSZ3d143KixXEXboGjX/FeX+EHVUAs5iFeLrWnXqokfhh2cqNlOW
         EDqQ==
X-Gm-Message-State: AA+aEWYFVIhQAhv5HVHGQlV0RvWnhZnqjsWufBeEgZVn0noT02p2LZD2
        iIQrimtQRIv5Tv4gIwUed9HMaA==
X-Google-Smtp-Source: AFSGD/XkVf2UW6ws81ol/Uh93l0DsYfCyunyTEzlPL123aI4xbHVeEa5jBbY2KpbtKFOORDODMsCAg==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr29010333wrn.185.1543307048931;
        Tue, 27 Nov 2018 00:24:08 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id q9sm6014684wrp.0.2018.11.27.00.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 00:24:08 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: sdm845: add video nodes
To:     Alexandre Courbot <acourbot@chromium.org>, mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <1542708506-12680-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MVzmxfRstUrTOtkJdCDaZEZO=UeP_u3btGKrsKasBijRg@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <7e306c60-8603-a8c4-cbb3-526f8a63ee39@linaro.org>
Date:   Tue, 27 Nov 2018 10:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVzmxfRstUrTOtkJdCDaZEZO=UeP_u3btGKrsKasBijRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 11/27/18 9:31 AM, Alexandre Courbot wrote:
> On Tue, Nov 20, 2018 at 7:08 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>>
>> This adds video nodes to sdm845 based on the examples
>> in the bindings.
>>
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 0c9a2aa..d82487d 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -84,6 +84,10 @@
>>                         reg = <0 0x86200000 0 0x2d00000>;
>>                         no-map;
>>                 };
>> +               venus_region: venus@95800000 {
>> +                       reg = <0x0 0x95800000 0x0 0x500000>;
> 
> Note that the driver expects a size of 0x600000 here and will fail to
> probe if this is smaller.
> 

I have to send a patch to fix that size mismatch as we discussed that it
the other mail thread.

-- 
regards,
Stan
