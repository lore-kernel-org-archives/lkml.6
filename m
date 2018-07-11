Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A368C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0520C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C0520C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbeGKNrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:47:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36118 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388041AbeGKNrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:47:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28F2D15AD;
        Wed, 11 Jul 2018 06:42:41 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1203F3F266;
        Wed, 11 Jul 2018 06:42:38 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask
 to cpu_possible_mask
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
 <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <229f0ac1-16b5-3fcf-3d0d-60ad59ea40f8@arm.com>
Date:   Wed, 11 Jul 2018 14:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2009eeb1-e925-fe5c-ac4a-9f3e41945127@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 11/07/18 12:36, Daniel Lezcano wrote:
> On 11/07/2018 13:24, Sudeep Holla wrote:
>> Currently, quite a few clockevent devices have cpumask set to
>> cpu_all_mask which should be fine. However, cpu_possible_mask is more
>> accurate and if there are any other clockevent devices in the system
>> which have cpumask set to cpu_possible_mask, then having cpu_all_mask
>> may result in issues (mostly boot hang with forever loops in
>> clockevents_notify_released).
>>
>> So, lets replace all the clockevent device cpu_all_mask to
>> cpu_possible_mask in order to prevent above mentioned possible issue.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
> 
> Applied, thanks for the fix.
> 

Thomas was planning to take this, see [1]
-- 
Regards,
Sudeep

[1]
https://lore.kernel.org/lkml/alpine.DEB.2.21.1807102220320.1588@nanos.tec.linutronix.de/

