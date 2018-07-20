Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCA320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxoxz9Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCA320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeGTPiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:38:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeGTPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:38:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so11557706wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqTubvQD7oLVcS1+64zkm8Axm3ZSq8UguOl6NavgE6E=;
        b=kxoxz9FsfKyeTDDUl0kEgal8WAdsCaGQdjkbSmhTJrPlP4MimcQd/JtR9wjW2PNSWJ
         7ZRIpVUpEekUbkSJAOeNGj59OFNVJPxA8qtLTg8Jlb4tfYZsvlEEwQE3jXZxU6IhWQQF
         K6rVlVw03Yyhx/swTknq4ZsNXe4Wry5weEPLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqTubvQD7oLVcS1+64zkm8Axm3ZSq8UguOl6NavgE6E=;
        b=V2UUpxbSCv5zNIcCUW2SgAllS9qZqMDC6Kie0rAgQhsRowF3t/6xf+PxHhdIAYd9LR
         ej7ywZAClCqwLdX1YH5gJSbMZEyQkJRtqLr10GwvWqiPN6BITtbRWoh3y3ONOg6NJZZU
         KkZhoT4o4SExKswk7PXc7L7NErpFEi9JB/jOh6q4Bfeg5TZIXlrYh3LYfQiqVAvTDrNW
         NVkcKvJtSAzO3CmrLPJbg30IXc6Sf6S/ch8YE72JhXapDQD93dhuAeI2FqePT4sEVNGX
         tRjSH+GlPMhgQ72R0wj3A9GC80J5421FUgVMWzhZtmx+Lto+TflYfrIajrjnFH0T+ham
         fVQA==
X-Gm-Message-State: AOUpUlG+6qwjVCnXtYWb0dmoZsYdsu06AISsxAaZ7jKMrP3OYvCYXUeq
        3uHD6PiLi+rD8KBuCtRqODANkgr2eoc=
X-Google-Smtp-Source: AAOMgpeILLmvZ/a6XJPwQpOJXB2d60lYlLT8AAojHj5SBav0/OXz9fFKy5Mq03GNKXo31e0SSEtDPQ==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr1809449wrw.209.1532098210859;
        Fri, 20 Jul 2018 07:50:10 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm2555914wmd.11.2018.07.20.07.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 07:50:10 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-7-georgi.djakov@linaro.org>
 <CAE=gft4YR27-ZyR5GXVxbiRbGycw=ydHu182LfwaLD=M+a8CNw@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <6bc5a4bc-5b66-7cfa-8820-4cd1053c6f8e@linaro.org>
Date:   Fri, 20 Jul 2018 17:50:08 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft4YR27-ZyR5GXVxbiRbGycw=ydHu182LfwaLD=M+a8CNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/11/2018 01:34 AM, Evan Green wrote:
> On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig        |   5 +
>>  drivers/interconnect/Makefile       |   1 +
>>  drivers/interconnect/qcom/Kconfig   |  10 +
>>  drivers/interconnect/qcom/Makefile  |   2 +
>>  drivers/interconnect/qcom/msm8916.c | 499 ++++++++++++++++++++++++++++
>>  5 files changed, 517 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> index a261c7d41deb..07a8276fa35a 100644
>> --- a/drivers/interconnect/Kconfig
>> +++ b/drivers/interconnect/Kconfig
>> @@ -8,3 +8,8 @@ menuconfig INTERCONNECT
>>
>>           If unsure, say no.
>>
>> +if INTERCONNECT
>> +
>> +source "drivers/interconnect/qcom/Kconfig"
>> +
>> +endif
>> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
>> index 97fca2e09d24..7944cbca0527 100644
>> --- a/drivers/interconnect/Makefile
>> +++ b/drivers/interconnect/Makefile
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_INTERCONNECT)             += core.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index b0c2ff928d88..a87afdef1bf7 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -2,6 +2,8 @@ config INTERCONNECT_QCOM
>>         bool "Qualcomm Network-on-Chip interconnect drivers"
>>         depends on INTERCONNECT
>>         depends on ARCH_QCOM || COMPILE_TEST
>> +       help
>> +         Support for Qualcomm's Network-on-Chip interconnect hardware.
>>
>>  config INTERCONNECT_QCOM_SMD_RPM
>>         tristate "Qualcomm SMD RPM interconnect driver"
>> @@ -9,3 +11,11 @@ config INTERCONNECT_QCOM_SMD_RPM
>>         help
>>           This is a driver for communicating interconnect related configuration
>>           details with a remote processor (RPM) on Qualcomm platforms.
>> +
>> +config INTERCONNECT_QCOM_MSM8916
>> +       tristate "Qualcomm MSM8916 interconnect driver"
>> +       depends on INTERCONNECT_QCOM
>> +       select INTERCONNECT_QCOM_SMD_RPM
> 
> I'm not a kconfig expert, maybe someone else could chime in. I have
> this impression that folks don't like select. Is there a way to do
> this with depends instead? If I'm way off here, ignore me.

It could be done with depends, but i think that it would be easier for
the user to choose only the SoC driver, without having to look into what
dependencies need to be enabled for each. Here we are using select only
locally and if there are any dependencies on other subsystems (like the
QCOM_SMD_RPM), they should be put under the interconnect platform
driver. Of course i am open for other arguments and suggestions.

Thanks,
Georgi
