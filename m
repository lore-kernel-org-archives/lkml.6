Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F153C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C8E21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C8E21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeHBOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:54:57 -0400
Received: from foss.arm.com ([217.140.101.70]:57840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbeHBOy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:54:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E99E3ED1;
        Thu,  2 Aug 2018 06:03:50 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C9B3F2EA;
        Thu,  2 Aug 2018 06:03:49 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [tip:timers/core] clocksource/drivers/arm_arch_timer: Fix bogus
 cpu_all_mask usage
To:     daniel.lezcano@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org
References: <tip-6777996d27dd4f0a569ed9593e78db68c6b659cd@git.kernel.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3fc750c9-fd3d-3a0c-ee86-b893de9ecc77@arm.com>
Date:   Thu, 2 Aug 2018 14:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <tip-6777996d27dd4f0a569ed9593e78db68c6b659cd@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/18 13:57, tip-bot for Thomas Gleixner wrote:
> Commit-ID:  6777996d27dd4f0a569ed9593e78db68c6b659cd
> Gitweb:     https://git.kernel.org/tip/6777996d27dd4f0a569ed9593e78db68c6b659cd
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Thu, 2 Aug 2018 14:53:10 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Thu, 2 Aug 2018 14:55:52 +0200
> 
> clocksource/drivers/arm_arch_timer: Fix bogus cpu_all_mask usage
> 
> Using cpu_all_mask as target mask for clockevents is wrong as it never can
> actually target not possible CPUs. Use cpu_possible_mask instead
> 

I think this was already merged for v4.18 as:
Commit 5e18e412973d ("clocksource: arm_arch_timer: Set arch_mem_timer
cpumask to cpu_possible_mask")

I assume you have earlier -rc as base for tip tree and you might have
missed it.

-- 
Regards,
Sudeep
