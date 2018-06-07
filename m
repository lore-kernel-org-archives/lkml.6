Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uJacMybtGFs1dgAAmS7hNA
	; Thu, 07 Jun 2018 08:31:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54F79607F7; Thu,  7 Jun 2018 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528360265;
	bh=bOSHevP5ncy1vhwJfLUegQPLcIP0BM7QNGD9iCfkztM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=M7jMrdf95SV9CkK1bbQXAGexyFpX262mPJa9zeD+BsS+VPdsfddZYCi5OyxHS4URf
	 TrBDOcWzd9x5am6YWD+3eFZOc12jN+1G1wgZ9Rv5OBfPhyxRGwgKyXn13Thw8RKZ3B
	 5Ez6misBn9XIPnPLwSHDaLQCgwHJO5LVU39zSY5E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C900860115;
	Thu,  7 Jun 2018 08:31:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ANdqjvYO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ANdqjvYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C900860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeFGIbB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:31:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbeFGIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:30:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D69D6608C8; Thu,  7 Jun 2018 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528360258;
        bh=bOSHevP5ncy1vhwJfLUegQPLcIP0BM7QNGD9iCfkztM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ANdqjvYO8BZ8A+FXtRIjccp0GDRnqPSIg/UhEp8fzaL6XULqW623k84SsPveGq5L6
         GPUq73pAefLWpvWZKRReJlyqJW7K7lrFi0sonQow+RgfJkSrUmfUHw+tsPIrGcBtfq
         LyOtN+vzzYC53Cob4OL+PZt4y4LnhJE4ma8yEIJg=
Received: from [10.204.78.68] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79B7B60115;
        Thu,  7 Jun 2018 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528360258;
        bh=bOSHevP5ncy1vhwJfLUegQPLcIP0BM7QNGD9iCfkztM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ANdqjvYO8BZ8A+FXtRIjccp0GDRnqPSIg/UhEp8fzaL6XULqW623k84SsPveGq5L6
         GPUq73pAefLWpvWZKRReJlyqJW7K7lrFi0sonQow+RgfJkSrUmfUHw+tsPIrGcBtfq
         LyOtN+vzzYC53Cob4OL+PZt4y4LnhJE4ma8yEIJg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79B7B60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
To: Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
References: <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
 <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
 <ba12bc49-33c0-b4ee-05cf-f84124bd66cc@codeaurora.org>
 <20180605150841.GA24053@redhat.com>
 <20180605152212.GY12180@hirez.programming.kicks-ass.net>
 <20180605154053.GB12235@hirez.programming.kicks-ass.net>
 <20180605163515.GB24053@redhat.com>
 <20180605201316.GZ12198@hirez.programming.kicks-ass.net>
 <20180606135115.GA4609@redhat.com>
 <20180606185920.GI12198@hirez.programming.kicks-ass.net>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <1ebda1e3-dae3-9e86-ad92-e1acdead23be@codeaurora.org>
Date: Thu, 7 Jun 2018 14:00:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606185920.GI12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI ,

In the latest patch mentioned, k should be their instead of p:

-WARN_ON_ONCE(!wait_task_inactive(p, TASK_PARKED))
+WARN_ON_ONCE(!wait_task_inactive(k, TASK_PARKED))

Regards
Gaurav

On 6/7/2018 12:29 AM, Peter Zijlstra wrote:
> On Wed, Jun 06, 2018 at 03:51:16PM +0200, Oleg Nesterov wrote:
>> IIUC, this will only affect smpboot_update_cpumask_percpu_thread() which can hit
>> an already parked thread, but it doesn't need to wait.
>>
>> And it seems that smpboot_update_cpumask_percpu_thread() in turn needs some cleanups.
>> Hmm. and its single user: kernel/watchdog.c.
>>
>> And speaking of watchdog.c, can't we simply kill the "watchdog/%u" threads? This is
>> off-topic, but can't watchdog_timer_fn() use stop_one_cpu_nowait(watchdog) ?
>>
>> And I really think we should unexport kthread_park/unpark(), only smpboot_thread_fn()
>> should use them. kthread() should not play with __kthread_parkme(). And even
>> KTHREAD_SHOULD_PARK must die, I mean it should live in struct smp_hotplug_thread,
>> not in struct kthread.
>>
>> OK, this is off-topic too.
> 
>> And, let me repeat, can't we avoid complete_all() ?
> 
> Yes, or at least if that watchdog crap is the only user.
> 
> I have most of the patch reworking watchdog.c to use stop_one_cpu*(),
> and that cleans up lots -- of course, I've not tested it yet, so it
> could also be breaking lots :-)
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
