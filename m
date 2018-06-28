Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8671EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35996273B9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PEcKs47h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PEcKs47h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35996273B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbeF1NC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:02:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeF1NC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:02:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8C5360B10; Thu, 28 Jun 2018 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530190946;
        bh=pTt0lPbawbP7S2s69mOi+Dyqdep7LU0FJ8AIZpa+UBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEcKs47hjyPiZQ/QM6x0cj28nIT45yDufzL7U3183anJSponpJgvzT9LjBDQ7lrET
         Nk305rdHV3c3GdPX64np6lB1XQuLIXolydbDeI6Bi0IUMnD8am4W+JshMKNx8dNDzG
         1BGSM22D//xjM3i1TD9Lvm2cRQsbwjeQlSBWEFF0=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D86F60711;
        Thu, 28 Jun 2018 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530190946;
        bh=pTt0lPbawbP7S2s69mOi+Dyqdep7LU0FJ8AIZpa+UBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEcKs47hjyPiZQ/QM6x0cj28nIT45yDufzL7U3183anJSponpJgvzT9LjBDQ7lrET
         Nk305rdHV3c3GdPX64np6lB1XQuLIXolydbDeI6Bi0IUMnD8am4W+JshMKNx8dNDzG
         1BGSM22D//xjM3i1TD9Lvm2cRQsbwjeQlSBWEFF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D86F60711
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Thu, 28 Jun 2018 18:32:05 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH] stop_machine: Remove cpu swap from stop_two_cpus
Message-ID: <20180628130124.GG9208@codeaurora.org>
References: <1530048506-21393-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530048506-21393-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:28:26PM -0700, Isaac J. Manjarres wrote:
> When invoking migrate_swap(), stop_two_cpus() swaps the
> source and destination CPU IDs if the destination CPU
> ID is greater than the source CPU ID. This leads to the
> following race condition:
> 
> The source CPU invokes migrate_swap and sets itself as
> the source CPU, and sets the destination CPU to another
> CPU, such that the CPU ID of the destination CPU is
> greater than that of the source CPU ID, and invokes
> stop_two_cpus(cpu1=destination CPU, cpu2=source CPU,...)
> Now, stop_two_cpus sees that the destination CPU ID is
> greater than the source CPU ID, and performs the swap, so
> that cpu1=source CPU, and cpu2=destination CPU.
> 
> The source CPU calls cpu_stop_queue_two_works(), with cpu1
> as the source CPU, and cpu2 as the destination CPU. When
> adding the stopper threads to the wake queue used in this
> function, the source CPU stopper thread is added first,
> and the destination CPU stopper thread is added last.
> 
> When wake_up_q() is invoked to wake the stopper threads, the
> threads are woken up in the order that they are queued in,
> so the source CPU's stopper thread is woken up first, and
> it preempts the thread running on the source CPU.
> 
> The stopper thread will then execute on the source CPU,
> disable preemption, and begin executing multi_cpu_stop()
> and wait for an ack from the destination CPU's stopper thread,
> with preemption still disabled. Since the worker thread that
> woke up the stopper thread on the source CPU is affine to the
> source CPU, and preemption is disabled on the source CPU, that
> thread will never run to dequeue the destination CPU's stopper
> thread from the wake queue, and thus, the destination CPU's
> stopper thread will never run, causing the source CPU's stopper
> thread to wait forever, and stall.
> 
> Remove CPU ID swapping in stop_two_cpus() so that the
> source CPU's stopper thread is added to the wake queue last,
> so that the source CPU's stopper thread is woken up last,
> ensuring that all other threads that it depends on are woken
> up before it runs.
> 
> Co-developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  kernel/stop_machine.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index f89014a..d10d633 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -307,8 +307,6 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
>  	cpu_stop_init_done(&done, 2);
>  	set_state(&msdata, MULTI_STOP_PREPARE);
>  
> -	if (cpu1 > cpu2)
> -		swap(cpu1, cpu2);
>  	if (cpu_stop_queue_two_works(cpu1, &work1, cpu2, &work2))
>  		return -ENOENT;
>  

Nested spinlocks must be taken in the same order everywhere. If you don't it
can create circular dependency which leads to deadlock. Sebastian already
pointed it out.

For example,

CPU2: stop_two_cpus(CPU0, CPU1)
CPU3: stop_two_cpus(CPU1, CPU0)

CPU2 may acquire CPU0 lock and waiting for CPU1 lock. At the same time, CPU3
which acquired CPU1 lock could be waiting for CPU0 lock. They stuck forever.

Coming to the original problem described in the changelog, it is happening due
to not waking stopper threads atomically in cpu_stop_queue_two_works().

Can you check if the below patch (not tested :-)) helps?

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a..1ff523d 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -270,7 +270,11 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 		goto retry;
 	}
 
-	wake_up_q(&wakeq);
+	if (!err) {
+		preempt_disable();
+		wake_up_q(&wakeq);
+		preempt_enable();
+	}
 
 	return err;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

