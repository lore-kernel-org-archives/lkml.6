Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2767DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEC22150C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEC22150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbeHBOak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:30:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732130AbeHBOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:30:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 603247A9;
        Thu,  2 Aug 2018 05:39:40 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E0ED3F2EA;
        Thu,  2 Aug 2018 05:39:39 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] clockevents: warn if cpu_all_mask is used for cpumask
 while registering new device
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
 <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <988e86c6-92bb-b73d-068b-04dfbc0fffda@arm.com>
Date:   Thu, 2 Aug 2018 13:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 11/07/18 12:24, Sudeep Holla wrote:
> Using cpu_all_mask in clockevents cpumask may result in issues while
> comparing multiple clockevent devices to choose the preferred one.
> On one of the platforms with 2 system(i.e. non per-CPU) timers with
> different ratings, having cpu_all_mask for one of the device resulted
> in boot hang with forever loop in clockevents_notify_released as both
> were being selected as preferred.
> 
> In order to prevent such issues in future, let's warn if any clockevent
> drivers sets cpu_all_mask as it's cpumask and just override it to use
> cpu_possible_mask. All the existing occurrences of cpu_all_mask are
> already replaced with cpu_possible_mask.
> 

Daniel has picked up patch 1/3, do you want me to resend this patch 2
and 3 again or you happy to pick them ?

-- 
Regards,
Sudeep
