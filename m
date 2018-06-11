Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UjAXG/p/HlsGbwAAmS7hNA
	; Mon, 11 Jun 2018 13:59:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E56C1607E4; Mon, 11 Jun 2018 13:59:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=jcline.org header.i=@jcline.org header.b="a93pzTRt";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hlokW6e0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,MAILING_LIST_MULTI autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72FDF60791;
	Mon, 11 Jun 2018 13:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72FDF60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=jcline.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933389AbeFKN7T (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:59:19 -0400
Received: from a8-242.smtp-out.amazonses.com ([54.240.8.242]:57932 "EHLO
        a8-242.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933007AbeFKN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rdybrs3533vx7mghocfwl3vdwgpl2v5u; d=jcline.org; t=1528725555;
        h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Kf+auwKyJHIKbBHfSHJDsUhpVYR8DKsWeZJVEOPKw8k=;
        b=a93pzTRtWq0wYMtj1HbEunUUylQMpoaGWYq5YZ8/pCZk/edoNGuejerRN4qDgUoY
        1/1rIaO9cMqGu49aDG2kXwJMFE3LcMpI7TGgOBp0xJORkqJmUxBtslEnJ+2OLAf5hSw
        jgYKXzfncbdRPMEXvAFSewMfivh+NR4SrJu9JEiA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1528725555;
        h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=Kf+auwKyJHIKbBHfSHJDsUhpVYR8DKsWeZJVEOPKw8k=;
        b=hlokW6e0biqbrLoXUI0+gcebXt+sd50t6nboBiATzredSBbo0gwfkrvrRBZLAMLY
        CUoPYJtx+FX6GSwbuBT+B44pTp8nsX3VZ+T6sQhMuEf/pF0dyJ6BbXdqD+DU4MHGUwt
        i7XT8V9rg4ts3vteh/tL+quzgrVrwlxnUJD1RZ38=
X-Virus-Scanned: amavisd-new at jcline.org
From: Jeremy Cline <jeremy@jcline.org>
Subject: Regression: x86/tsc: Fix mark_tsc_unstable()
Openpgp: preference=signencrypt
Autocrypt: addr=jeremy@jcline.org; prefer-encrypt=mutual; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, len.brown@intel.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        Diego Viola <diego.viola@gmail.com>
Message-ID: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
Date: Mon, 11 Jun 2018 13:59:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.06.11-54.240.8.242
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

A few Fedora users have reported[0] a regression starting in v4.16.8
where the boot will hang ~1/3 of the time with the following RCU stall
warning:

INFO: rcu_sched detected stalls on CPUs/tasks:
o1-...!: (0 ticks this GP) idle=688/0/0 softirq=171/171 fqs=0
o(detected by 0, t=60002 jiffies, g=-142, c=-143, q=9)
Sending NMI from CPU 0 to CPU 1:
NMI backtrace for cpu 1 skipped: idling at
acpi_processor_ffh_cstate_enter+0x65/0xb0
rcu_sched kthread starved for 60002 jiffies! g18446744073709551474
c1844674407370955143 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 -> cpu=1
RCU grace-period kthread stack dump:
rcu_sched       I    0     9      2 0x80000000
Call Trace:
 ? __schedule+0x234/0x850
 schedule+0x28/0x80
 schedule_timeout+0x166/0x380
 ? __next_timer_interrupt+0xc0/0xc0
 rcu_gp_kthread+0x368/0x830
 ? rcu_process_callbacks+0x4f0/0x4f0
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x35/0x40

A user has bisected the problem to the v4.16 commit 1ab4ca7c59d4
("x86/tsc: Fix mark_tsc_unstable()"). According to the reporter,
explicitly setting "tsc=" on the kernel command line causes the boot to
always succeed. All the users have Thinkpad T500s or T400s (Core 2 Duos)

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1579925


Thanks,
Jeremy
