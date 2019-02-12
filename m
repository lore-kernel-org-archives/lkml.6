Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD725C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD61B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfBLNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:52:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:12100 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfBLNwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:52:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 05:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="125849112"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 05:51:58 -0800
Subject: Re: [PATCH v10 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
References: <20190212044914.15490-1-aubrey.li@linux.intel.com>
 <20190212044914.15490-2-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1902121358050.3710@nanos.tec.linutronix.de>
 <61791002-0928-fa79-8cba-9625eb0418dd@linux.intel.com>
 <alpine.DEB.2.21.1902121422180.3710@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <4e4b9f97-b7f5-f353-4abe-d9e3af076d74@linux.intel.com>
Date:   Tue, 12 Feb 2019 21:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902121422180.3710@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/12 21:24, Thomas Gleixner wrote:
> On Tue, 12 Feb 2019, Li, Aubrey wrote:
> 
>> On 2019/2/12 21:03, Thomas Gleixner wrote:
>> I didn't include the first patch, because I saw it's already in tip
>> tree. Did you use tip tree?
> 
> Yes, that's my bad, forgot to switch branches. That still does not solve:
> 
>>> arch/x86/kernel/fpu/xstate.c: At top level:
>>> arch/x86/kernel/fpu/xstate.c:1279:6: warning: no previous prototype for ¡arch_proc_pid_status¢ [-Wmissing-prototypes]
>>>  void arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
>>>       ^~~~~~~~~~~~~~~~~~~~
>> Sorry for this, May I know how to replicate it on my side?
> 
> make W=1 ....

This works, thanks!

> 
> And please take your time and do not shoot out half baken patch series
> every 5 minutes.
> 
Sorry for the trouble, just want to solve the problem before your eyes move
away from this thread.

Thanks,
-Aubrey
