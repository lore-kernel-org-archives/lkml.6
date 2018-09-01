Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E7C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E6020841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV9TD7k7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E6020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIAEPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:15:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36090 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeIAEPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:15:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id e11-v6so6141991plb.3;
        Fri, 31 Aug 2018 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQKwZnemIOyJD5gMC9rF1K16eEHc6KF5w57aXS3A7CU=;
        b=ZV9TD7k7ofQqlLMpoMCN7r6dlrXivK3Fsv/HayZwjW6SNg3g9I3Z3SjhCApzB5diLY
         oVI6PjgRCJ8GUxvR7LGTkM4iu1KNnsoWBm91thzofIhwdq67PrbXCgRnOjVLheDaDVVY
         oQdtpwEAzltnVx7hlM1cW4DO6t7sAOv/TPx3YCjdnV9pBGgr3xKUcQkK0wETfq7gBBHJ
         cLpDoxOfuehjt6YrtcoVZgoQlb17Ay/9tPsyFPMINadmSWvDEEMMw3D5U7/aDUjZmEnr
         4oTD86vVkWk5iLBakbhsgJpDm00MTT7gRAJbns6fYBIW8xfHZI2zMW6pHEOAJMFXGvk0
         kffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQKwZnemIOyJD5gMC9rF1K16eEHc6KF5w57aXS3A7CU=;
        b=dV/zai9rQhoNNAbkjV8b4CClJiWHe/0fDlLVrW7O5MZlIMiNRPXGa0jf1ax92MLP4v
         YkanLw17lHLYi1EPWwoquxsMQ6bIVsdA4iXHS3XR8kbMfbPsjf7FSr6AaIiqP0VkBiib
         UFhABFWaS8TECLiOtbOb8DXoCZzYMMPgPrU0JJ1eFexeR6LOU7jvv+ru6jPDUOK/Vk6E
         10I8XLx93ki5iurOJVQna/og/iWnkwJyxRQmCr2QPO+zQeiMq0022bvJHEk22hjDDC4P
         U/q/K2RLdMFjmESLKTDLoCoXn8OHr7FcyMc0HoA2STaML65Jy0S3xtSZ3H1BRxBexblX
         LzjA==
X-Gm-Message-State: APzg51D6fkeTEReyBbprGzyyLPB5dCOanh6ykpv4CaADbcoF30vib6hG
        BPojqF2hyymqAIRIuxg25M4=
X-Google-Smtp-Source: ANB0VdZ+PLG+KsVzOlZ7TIQ34Z86T7M3mXi8D/01x2XXmdIJB+yS+e0BMHvcCUYhAe0l1eLqflTm2Q==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr17931818plk.133.1535760313601;
        Fri, 31 Aug 2018 17:05:13 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n29-v6sm22455461pgl.30.2018.08.31.17.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:05:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] ARM: dts: qcom: Add SPMI PMIC Arbiter nodes for
 APQ8084 and MSM8974
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
 <1422965880-11047-2-git-send-email-iivanov@mm-sol.com>
 <550311ad-8f93-3e80-9706-1321482b8c19@gmail.com>
 <20180831230125.GU2523@minitux>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9ff8c04f-80b7-88fa-956a-d0f61809d639@gmail.com>
Date:   Fri, 31 Aug 2018 17:05:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831230125.GU2523@minitux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/18 16:01, Bjorn Andersson wrote:
> On Fri 31 Aug 15:46 PDT 2018, Frank Rowand wrote:
>>> +		spmi_bus: spmi@fc4cf000 {
>>> +			compatible = "qcom,spmi-pmic-arb";
>>> +			reg-names = "core", "intr", "cnfg";
>>> +			reg = <0xfc4cf000 0x1000>,
>>> +			      <0xfc4cb000 0x1000>,
>>> +			      <0xfc4ca000 0x1000>;
>>> +			interrupt-names = "periph_irq";
>>
>>> +			interrupts = <0 190 0>;
>>
>> The final value in this interrupts property means IRQ_TYPE_NONE.
>>
>> A WARN_ON() was added early this year to complain about use of
>> IRQ_TYPE_NONE: 83a86fbb5b56 "irqchip/gic: Loudly complain about
>> the use of IRQ_TYPE_NONE", resulting in many warnings spewing
>> forth when I boot an APQ8074 Dragonboard.  I am trying to
>> determine whether the warning is overly aggressive, or whether
>> the IRQ TYPE is incorrectly specified for the spmi node.
>>
>> The interrupt-parent for the spmi node is intc: interrupt-controller@f9000000,
>> which has compatible = "qcom,msm-qgic2".  I do not know the architecture
>> or implementation of this interrupt controller.  Is an IRQ_TYPE_NONE
>> valid in this case, or should a specific type be provided?
>>
> 
> No, IRQ_TYPE_NONE isn't valid and the WARN_ON() is reasonable.
> 
> Please change it to IRQ_TYPE_LEVEL_HIGH. And while you're at it, replace
> the first 0 with GIC_SPI.
> 
> 
> If you have more of these warnings you can most likely look at e.g.
> msm8916 (arm64) to find the right flags.

Thanks, I'll create a patch.
