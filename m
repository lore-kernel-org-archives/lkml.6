Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A2C20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A2C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeILQlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:41:25 -0400
Received: from foss.arm.com ([217.140.101.70]:57938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeILQlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:41:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E34E67A9;
        Wed, 12 Sep 2018 04:37:16 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C63F3F614;
        Wed, 12 Sep 2018 04:37:15 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        t-kristo@ti.com, tony@atomide.com
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
To:     Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
 <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
Date:   Wed, 12 Sep 2018 12:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 12:19, Keerthy wrote:
> 
> 
> On Wednesday 12 September 2018 04:32 PM, Sudeep Holla wrote:
>>
>>
>> On 12/09/18 05:09, Keerthy wrote:
>>> Introuduce linux generic suspend states supported properties.
>>> It is convenient for the generic suspend path to have
>>> the knowledge of the suspend states supported based on the
>>> device tree properties based on which it can either be suspended
>>> or safely bailed out of suspend if none of the suspend states
>>> are supported.
>>>
>>
>> NACK for any bindings that are linux specific. The suspend feature is so
>> platform dependent that I see no need for generic Linux bindings for the
>> same.
> 
> suspend to mem and suspend to disk are pretty generic states and i agree
> implementation is platform dependent so why not have properties that
> convey if they are supported?
> 

We already have power domains and idle states for that. If you need to
restrict few states on some platform for whatever reasons, just disable
those states. I don't see the need to add any more bindings for the same.

> Is the disagreement over making the properties being linux specific?
> 

Yes.

-- 
Regards,
Sudeep
