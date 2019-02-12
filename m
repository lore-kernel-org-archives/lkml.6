Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5AF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfBLNUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:20:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:11578 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfBLNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:20:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 05:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="125843179"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 05:20:37 -0800
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
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <61791002-0928-fa79-8cba-9625eb0418dd@linux.intel.com>
Date:   Tue, 12 Feb 2019 21:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902121358050.3710@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/12 21:03, Thomas Gleixner wrote:
> On Tue, 12 Feb 2019, Aubrey Li wrote:
> 
> arch/x86/kernel/fpu/xstate.c:1252:6: warning: no previous prototype for ¡avx512_status¢ [-Wmissing-prototypes]
>  void avx512_status(struct seq_file *m, struct task_struct *task)
>       ^~~~~~~~~~~~~
Sorry for this warning, I didn't see it on my side. May I know how to open this knob?

> arch/x86/kernel/fpu/xstate.c: In function ¡avx512_status¢:
> arch/x86/kernel/fpu/xstate.c:1254:44: error: ¡struct fpu¢ has no member named ¡avx512_timestamp¢
>   unsigned long timestamp = task->thread.fpu.avx512_timestamp;

I didn't include the first patch, because I saw it's already in tip tree. Did you use tip tree?

>                                             ^
> arch/x86/kernel/fpu/xstate.c: At top level:
> arch/x86/kernel/fpu/xstate.c:1279:6: warning: no previous prototype for ¡arch_proc_pid_status¢ [-Wmissing-prototypes]
>  void arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
>       ^~~~~~~~~~~~~~~~~~~~
Sorry for this, May I know how to replicate it on my side?

Thanks,
-Aubrey
