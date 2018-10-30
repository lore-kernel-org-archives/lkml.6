Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2292081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2292081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJaG3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:29:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:2367 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:29:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 14:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="104625428"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.144]) ([10.54.74.144])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2018 14:34:44 -0700
Subject: Re: [Patch v4 16/18] x86/speculation: Enable STIBP to protect
 security sensitive tasks
To:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
 <26ec186930a8fb33033743997bd56e5ce44050ec.1540923609.git.tim.c.chen@linux.intel.com>
 <99FC4B6EFCEFD44486C35F4C281DC6732148DC8C@ORSMSX110.amr.corp.intel.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5793bddc-cd09-eebb-bc0c-51c9b3aca0c1@linux.intel.com>
Date:   Tue, 30 Oct 2018 14:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732148DC8C@ORSMSX110.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 02:07 PM, Schaufler, Casey wrote:
>> -----Original Message-----
>> From: Tim Chen [mailto:tim.c.chen@linux.intel.com]
>> Sent: Tuesday, October 30, 2018 11:49 AM
>> To: Jiri Kosina <jikos@kernel.org>; Thomas Gleixner <tglx@linutronix.de>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>; Tom Lendacky
>> <thomas.lendacky@amd.com>; Ingo Molnar <mingo@redhat.com>; Peter
>> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@redhat.com>;
>> Andrea Arcangeli <aarcange@redhat.com>; David Woodhouse
>> <dwmw@amazon.co.uk>; Andi Kleen <ak@linux.intel.com>; Hansen, Dave
>> <dave.hansen@intel.com>; Schaufler, Casey <casey.schaufler@intel.com>;
>> Mallick, Asit K <asit.k.mallick@intel.com>; Arjan van de Ven
>> <arjan@linux.intel.com>; Jon Masters <jcm@redhat.com>; Waiman Long
>> <longman9394@gmail.com>; linux-kernel@vger.kernel.org; x86@kernel.org
>> Subject: [Patch v4 16/18] x86/speculation: Enable STIBP to protect security
>> sensitive tasks
>>
>> Enable STIBP defense on high security tasks.
>>
>> For normal tasks, STIBP is unused so they are not impacted by overhead
>> from STIBP in lite protection mode.
>>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>  arch/x86/kernel/cpu/bugs.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 54f4675..b402b96 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -14,6 +14,8 @@
>>  #include <linux/module.h>
>>  #include <linux/nospec.h>
>>  #include <linux/prctl.h>
>> +#include <linux/sched/coredump.h>
>> +#include <linux/security.h>
>>
>>  #include <asm/spec-ctrl.h>
>>  #include <asm/cmdline.h>
>> @@ -770,6 +772,37 @@ static int ssb_prctl_set(struct task_struct *task,
>> unsigned long ctrl)
>>  	return 0;
>>  }
>>
>> +static void set_task_stibp(struct task_struct *tsk, bool stibp_on)
>> +{
>> +	bool update = false;
>> +
>> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
>> +		return;
>> +
>> +	if (stibp_on)
>> +		update = !test_and_set_tsk_thread_flag(tsk, TIF_STIBP);
>> +	else
>> +		update = test_and_clear_tsk_thread_flag(tsk, TIF_STIBP);
>> +
>> +	if (!update)
>> +		return;
>> +
>> +	if (tsk == current)
>> +		speculation_ctrl_update_current();
>> +}
>> +
>> +void arch_set_security(struct task_struct *tsk, unsigned int value)
> 
> In this context "security" isn't descriptive. arch_set_stibp_defenses()
> would be better.

A more generic name decoupled from STIBP will be preferable.  There
can other kind of security defenses to be erected in
the future.

Perhaps arch_set_mitigation?

Thanks.

Tim

> 
> Since "value" should only ever have one of two values, and those
> map directly to "true" or "false" this should be a bool, making the
> code trivial:
> 
> void arch_set_stibp_defenses(struct task_struct *task, bool stibp)
> {
> 	set_task_stibp(task, stibp);
> }
> 
> Or perhaps arch_set_security() should go away, and the calling
> code would call set_task_stibp() directly. Unless there is some compelling
> reason for the abstractions.
> 
>> +{
>> +	if (value > SECURITY_HIGH)
>> +		return;
>> +
>> +	/* Update STIBP defenses */
>> +	if (value == SECURITY_HIGH)
>> +		set_task_stibp(tsk, true);
>> +	else
>> +		set_task_stibp(tsk, false);
>> +}
>> +
>>  int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>>  			     unsigned long ctrl)
>>  {
>> --
>> 2.9.4
> 

