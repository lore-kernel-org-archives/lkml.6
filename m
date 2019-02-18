Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518DC217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myou/Agv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfBRPUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:20:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44246 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:20:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so4182219wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FbBe0DVlJ1/RqhCrzZiZYkVJskeLKNQIpcjVkdyvasU=;
        b=myou/AgvrVso4c3yIsZcvSsoVgixZacDEYb2RDiS93YgJaw99M47B30JN0H8O16pOK
         ikwotFlw/fKdaVrljcArSarTrEbdepntfjE07+ubZw8xEuiEyA5zZfydBoT3dJBCTqmE
         nbOvDQSHSWHXNx6cDjZzHl7/7CvKf/OgsWDB4EbFqwWWGhNkcW7wLRzvOlwTcD9i6J7P
         JawbNW2a7ZtN5Wf/X6KzOSNKrag20bH6B6FYlXx4g53nHPPTCQwuJGhjYkVy3v3moiyH
         OW0/0Z5nvbbXm1r2HVMl7OaF74+OP/5kmccljvp609saTkO8HaM9FP07VACFxcuzEkNI
         nuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FbBe0DVlJ1/RqhCrzZiZYkVJskeLKNQIpcjVkdyvasU=;
        b=Yibe7D+qY0aHZ+DJPmTfGy31EQ+Ict9d5Cvvt2XoYKJBOV0kHfAFSIzVSu2H7sShJe
         zwrcJfuA0GhD2VGVMkbdZU3rh1wUgZq0poiO+6O/i+8g6lRyLdmg3C+gBkYMVit+fLOA
         FQV9ErGv7M+dmrJscHkf9nIA/Z/Zr9TOWILdU1IBhQPVHOOctODDpyvlRUUrx4q/4C+x
         k7FJAlGp5RQudWRl4NX2PIWzK9KbIoQ1YcCwNGf2+gsdy9R/1Qzaxv0aY6GNRddAFkoS
         k6DUOU01fIM8Y+d7Vm4SQSbTHWJWGek+AGWWlckBrGzISva9L513NRkptD22UEzRSUAr
         K0UA==
X-Gm-Message-State: AHQUAuYIEu8F8kL4jv1/YSRct9byIv2KHe3Y4T7kj0GnPubCCr+0KZUX
        Qd/mHgqhU0Nh5F1rpwzhDdmEEg==
X-Google-Smtp-Source: AHgI3IZYT/4yVkh52CCsXwPnIXFqzEQ2IexmLt5ycWW2gwIUIKiySMmCd2xXuGv+4Ws6+3G7yVslAg==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr18586701wrq.178.1550503213342;
        Mon, 18 Feb 2019 07:20:13 -0800 (PST)
Received: from [192.168.0.41] (148.125.92.92.rev.sfr.net. [92.92.125.148])
        by smtp.googlemail.com with ESMTPSA id x6sm12926912wmg.0.2019.02.18.07.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 07:20:11 -0800 (PST)
Subject: Re: [PATCH V4] dt-bindings: timer: gpt: update binding doc
To:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1546076081-23196-1-git-send-email-Anson.Huang@nxp.com>
 <20190111145214.GA15957@bogus>
 <AM6PR0402MB39111964EB06DF1D0447BB1BF5630@AM6PR0402MB3911.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c0e15cd1-0a87-9371-06cc-7d55f06d5c9e@linaro.org>
Date:   Mon, 18 Feb 2019 16:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AM6PR0402MB39111964EB06DF1D0447BB1BF5630@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 16:17, Anson Huang wrote:
> Hi, Rob
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Rob Herring [mailto:robh@kernel.org]
>> Sent: 2019Äê1ÔÂ11ÈÕ 22:52
>> To: Anson Huang <anson.huang@nxp.com>
>> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; mark.rutland@arm.com;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>
>> Subject: Re: [PATCH V4] dt-bindings: timer: gpt: update binding doc
>>
>> On Sat, Dec 29, 2018 at 09:39:34AM +0000, Anson Huang wrote:
>>> The i.MX GPT timer driver binding doc is out of date, update it
>>> according to current GPT timer driver.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>> ChangeLog since V3:
>>> 	be more specific about the backwards compatible of each SoC;
>>> ---
>>>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 39 ++++++++++++++++++--
>> --
>>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>
>> This now seems in line with my 9+ year old memory of the lineage of this
>> block. :)
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> Rob
> 
> Do you know who will pick-up this patch?

I will. Applied for 5.1

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

