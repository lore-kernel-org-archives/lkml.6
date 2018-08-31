Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37162083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGnAettT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37162083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIABnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:43:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33506 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeIABnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:43:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b92-v6so983968plb.0;
        Fri, 31 Aug 2018 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I4qkQiOWVOF2EIQLku8botXY/OPqzaPJWzOGpzzBVS4=;
        b=qGnAettTpmBRabeBRj04UYOmqsMM44v/Hpma542JWcF+fE8Medpn0mMK5JExIyqvKv
         FKGclC4qt8Cz4WtxTW4ZUvzcGuFZpVD9c//F09Mbk9M4EeTvGFoGUeFfWQxMsjQ0S1LT
         Bj3LPFFrBFF5pYwkueiD1RzMBohb8Hu8e6J2lBQflYIGZ+GAmeZ9Vdl5YqJtwN/8iw6W
         IRYH4szEmvwXESUm4pLQpQpkCg5IqlzsUgCY9NozN40o/JeoOETXuKIYWa6CBGxmM2cS
         ATs5l703FAPSwZOwPnOf3p+CkLY9tdSFc1FeArw4oPgXp4J+5Z5LwBjVkp3RNwZppphN
         +OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4qkQiOWVOF2EIQLku8botXY/OPqzaPJWzOGpzzBVS4=;
        b=Q2gmT+ShXxqvu6+TH/nyaVTCqnekspMV3B2ZKfMk/+s/Ud8WRJvocommfJeZ+APqFk
         k/hociFyweVrkkreiDKT7TMPY+PNejhsGwZI9LF04o9ijnwbPuRvmqIlBEhdSoB/cHzB
         HA0ci5IJmLHr8/2PqKesJMEnrPcWv6ThV8FTE4TedAO4QaHBntildCF1Rjsqi+/Hqp1W
         Vb0XDHPMTqDigcRjKNsoGSM0v0iMhgoULprT4fmFVYVBHeV3mqd949sfbPR6JP1L0MQl
         ZizdaD3CbrBxlSkVQSx4SerRH3El370Z30C1cNtaSdV6LAI4k7KLSuYYQmIx+siIpRCY
         0rWw==
X-Gm-Message-State: APzg51C8zPyX64kKpCsVoulJ4G9YHqubQMAXsFBRWtOQ+UsPZx7sf9pT
        e8nOgmbQbOsmcktfbMACDf4=
X-Google-Smtp-Source: ANB0VdYJuFj3oLhgngA8PNGDz2vqJRuMPqMwbFHcWH0zF7lkEkfCzmkwOCVnoIIYts1fJnWHVMQROQ==
X-Received: by 2002:a17:902:7686:: with SMTP id m6-v6mr17329688pll.186.1535751264515;
        Fri, 31 Aug 2018 14:34:24 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id t86-v6sm15649808pfe.109.2018.08.31.14.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:34:24 -0700 (PDT)
Subject: Re: [PATCH v3] rpmsg: qcom_smd: Access APCS through mailbox framework
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20180420011757.22389-1-bjorn.andersson@linaro.org>
 <c6e2e87c-e2fd-c0ea-dbb9-5246b8694272@gmail.com>
 <20180831040701.GR2523@minitux>
 <e7af3589-dce5-2ea8-3ce0-258ced4a2302@gmail.com>
 <20180831205519.GS2523@minitux>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d6bdaad6-05cb-6af8-b1d5-c454949628d3@gmail.com>
Date:   Fri, 31 Aug 2018 14:34:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831205519.GS2523@minitux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/18 13:55, Bjorn Andersson wrote:
> On Fri 31 Aug 13:41 PDT 2018, Frank Rowand wrote:
> 
>> On 08/30/18 21:07, Bjorn Andersson wrote:
>>> On Thu 30 Aug 20:57 PDT 2018, Frank Rowand wrote:
>>>
>>>> Hi Bjorn,
>>>>
>>>>
>>>> On 04/19/18 18:17, Bjorn Andersson wrote:
>>>>> Attempt to acquire the APCS IPC through the mailbox framework and fall
>>>>> back to the old syscon based approach, to allow us to move away from
>>>>> using the syscon.
>>>>>
>>>>> Reviewed-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>> ---
>>>>>
>>>>> Changes since v2:
>>>>> - Added comment about mbox_send_message() return value.
>>>>>
>>>>>  .../devicetree/bindings/soc/qcom/qcom,smd.txt      |  8 ++-
>>>>>  drivers/rpmsg/Kconfig                              |  1 +
>>>>>  drivers/rpmsg/qcom_smd.c                           | 67 ++++++++++++++++------
>>>>>  3 files changed, 56 insertions(+), 20 deletions(-)
>>>>
>>>> This patch in the mainline Linux kernel as commit ab460a2e72dabecfdabd45eb7e3ee2d73fc876d4
>>>> causes a problem with the APQ8074 Dragonboard.  The mmc device is not set up
>>>> with the patch applied, thus I do not have the block device my root file system
>>>> is located on.
>>>>
>>>> Testing on v4.18, if I revert this commit the mmc device is available.
>>>>
>>>> I'll reply to this email with the console messages for 4.18 and for 4.18 with
>>>> this commit reverted.
>>>>
>>>
>>> The mmc device would fail to come up if the regulators didn't come up,
>>> which would be the result of smd not working. But it should fallback to
>>> the old mechanism if no mailbox is specified.
>>>
>>> Can you double check that CONFIG_RPMSG_QCOM_SMD is still set in your
>>> .config after applying and building with this commit included? And if
>>> not, try to enable CONFIG_MAILBOX.
>>
>> Thank you!
>>
>> That is indeed the cause.  ab460a2e72da added a "depends on MAILBOX" to
>> CONFIG_RPMSG_QCOM_SMD, so CONFIG_RPMSG_QCOM_SMD becomes unset since
>> CONFIG_MAILBOX is not enabled in qcom_defconfig and is not otherwise
>> selected for the dragonboard.
>>
> 
> Thanks for verifying this!
> 
>> Is there a config variable that should be selecting MAILBOX for a class
>> of systems that would include the APQ8074 Dragonboard?  For my testing
>> I added the "select MAILBOX" to CONFIG_ARCH_MSM8974, but I do not know
>> what systems that includes, and whether it is appropriate to do the
>> select for all of them.
>>
> 
> We typically don't use the CONFIG_ARCH_* to enable user selectable
> config options, even if they serve a critical role in the system.
> 
> So minimum change would be to add CONFIG_MAILBOX to the qcom_defconfig
> (and multi_v7_defconfig I presume). The fuller solution would be to add
> qcom,msm8974-apcs-kpss-global (.data is 8) to the qcom-apcs-ipc-mailbox
> list of compatibles and replace the syscon currently used, and then
> enable these in the defconfigs.

I would be happy with either solution.  Can I twist your arm to create
the patch?


> 
> Regards,
> Bjorn
> 

