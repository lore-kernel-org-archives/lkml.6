Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7EBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4492320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4492320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeILSre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:47:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59814 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeILSre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:47:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20FD080D;
        Wed, 12 Sep 2018 06:42:59 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9519C3F703;
        Wed, 12 Sep 2018 06:42:57 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Keerthy <j-keerthy@ti.com>,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
To:     Tony Lindgren <tony@atomide.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
 <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
 <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
 <20180912133228.GI5662@atomide.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <19ae9d20-46aa-25d7-87aa-ea4270f0162b@arm.com>
Date:   Wed, 12 Sep 2018 14:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912133228.GI5662@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 14:32, Tony Lindgren wrote:
> * Sudeep Holla <sudeep.holla@arm.com> [180912 11:41]:
>> On 12/09/18 12:19, Keerthy wrote:
>>> suspend to mem and suspend to disk are pretty generic states and i agree
>>> implementation is platform dependent so why not have properties that
>>> convey if they are supported?
>>>
>>
>> We already have power domains and idle states for that. If you need to
>> restrict few states on some platform for whatever reasons, just disable
>> those states. I don't see the need to add any more bindings for the same.
> 
> Oh do you mean the "domain-idle-states" property as mentioned in the
> Documentation/devicetree/bindings/power/power_domain.txt?
> 

Yes, exactly that.

> Yeah that should do and the DOMAIN_PWR_DN and DOMAIN_RET can be SoC
> specific and then the board can select which ones to use depending on
> how things are wired for GPIOs, memory, PMIC and so on.
>

All the idle-states are platform specific. DOMAIN_RET and DOMAIN_PWR_DN
are just examples used in the bindings.

> Hmm I don't see any users for this binding though?
> 

It was added specifically to deal with such SoC idles states or
hierarchical CPU power domains states, no users in upstream yet. But IMO
it fits what $subject is trying to address.

-- 
Regards,
Sudeep
