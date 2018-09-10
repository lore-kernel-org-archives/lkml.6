Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E36C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8172087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8172087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeIJUaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:30:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbeIJUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:30:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F2018A;
        Mon, 10 Sep 2018 08:35:26 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.Emea.Arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330B23F557;
        Mon, 10 Sep 2018 08:35:21 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        John Horley <john.horley@arm.com>, Al Grant <al.grant@arm.com>
Subject: Re: [PATCH v3 0/9] coresight: Update device tree bindings
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <20180730200232.GA31755@xps15>
 <CANLsYkzBfCydwDO-KyDub4X=GTy_dtv-478RyMReBEH6VybSAg@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <9e935bd9-1cd1-0fda-3d73-fe2487759a1c@arm.com>
Date:   Mon, 10 Sep 2018 16:35:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkzBfCydwDO-KyDub4X=GTy_dtv-478RyMReBEH6VybSAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 31/07/18 16:06, Mathieu Poirier wrote:
> [...]
> 
>>>
>>> Suzuki K Poulose (9):
>>>   coresight: Document error handling in coresight_register
>>>   coresight: platform: Refactor graph endpoint parsing
>>>   coresight: platform: Fix refcounting for graph nodes
>>>   coresight: platform: Fix leaking device reference
>>>   coresight: Fix remote endpoint parsing
>>>   coresight: Add helper to check if the endpoint is input
>>>   coresight: platform: Cleanup coresight connection handling
>>>   coresight: Cleanup coresight DT bindings
>>>   dts: juno: Update coresight bindings
>>>
>>>  .../devicetree/bindings/arm/coresight.txt          |  95 +++++---
>>>  arch/arm64/boot/dts/arm/juno-base.dtsi             | 161 ++++++------
>>>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  52 ++--
>>>  arch/arm64/boot/dts/arm/juno.dts                   |  13 +-
>>>  drivers/hwtracing/coresight/coresight.c            |  35 +--
>>>  drivers/hwtracing/coresight/of_coresight.c         | 269 ++++++++++++++-------
>>>  include/linux/coresight.h                          |   9 +-
>>>  7 files changed, 359 insertions(+), 275 deletions(-)
>>>
>>
>> Good day,
>>
>> I have applied patches 1 to 7.  I will wait for Rob's ACK before doing the same
>> with 8 and 9.
> 
> I just applied patch 8 and 9.
> 
Sorry for the delay, but ARM SoC expects all the DTS changes to go via
their tree. Please drop patch 9, I will route via ARM-SoC.

-- 
Regards,
Sudeep
