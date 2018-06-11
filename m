Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ykpIKw73HVtRIQAAmS7hNA
	; Mon, 11 Jun 2018 04:14:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 89B1F607A4; Mon, 11 Jun 2018 04:14:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B570C60541;
	Mon, 11 Jun 2018 04:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B570C60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbeFKEOC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:14:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751358AbeFKEOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:14:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5B48vLt048508
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:14:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jhhp8rdnu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:14:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 11 Jun 2018 05:13:55 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 05:13:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5B4Dnqs27394180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 04:13:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E29CA404D;
        Mon, 11 Jun 2018 05:04:44 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50AEEA4040;
        Mon, 11 Jun 2018 05:04:41 +0100 (BST)
Received: from [9.124.31.215] (unknown [9.124.31.215])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 05:04:41 +0100 (BST)
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
To: Oleg Nesterov <oleg@redhat.com>
Cc: srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
 <20180608163600.GA9030@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Mon, 11 Jun 2018 09:43:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608163600.GA9030@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18061104-0028-0000-0000-000002CF5AA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061104-0029-0000-0000-000023866E59
Message-Id: <456ae8b8-8c5b-022c-0d53-c59627bda753@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 06/08/2018 10:06 PM, Oleg Nesterov wrote:
> Hello,
> 
> I am travelling till the end of the next week, can't read this version
> until I return. Just one question,
> 
> On 06/06, Ravi Bangoria wrote:
>>
>>  1. One of the major reason was the deadlock between uprobe_lock and
>>  mm->mmap inside trace_uprobe_mmap(). That deadlock was not easy to fix
> 
> Could you remind what exactly was wrong?
> 
> I can't find your previous email about this problem, but iirc you didn't
> explain the deadlock in details, just copied some traces from lockdep...

The deadlock is between mm->mmap_sem and uprobe_lock.

Some existing code path is taking these locks in following order:
	uprobe_lock
	  event_mutex
	    uprobe->register_rwsem
	      dup_mmap_sem
		mm->mmap_sem

I've introduced new function trace_uprobe_mmap() which gets called
from mmap_region() / vma_adjust() with mm->mmap_sem already acquired.
And it has to take uprobe_lock to loop over all trace_uprobes. i.e.
the sequence is:
	mm->mmap_sem
	  uprobe_lock

Why it's difficult to resolve is because trace_uprobe_mmap() does
not have control over mm->mmap_sem.

Detailed trace from lockdep:

[  499.258006] ======================================================
[  499.258205] WARNING: possible circular locking dependency detected
[  499.258409] 4.17.0-rc3+ #76 Not tainted
[  499.258528] ------------------------------------------------------
[  499.258731] perf/6744 is trying to acquire lock:
[  499.258895] 00000000e4895f49 (uprobe_lock){+.+.}, at: trace_uprobe_mmap+0x78/0x130
[  499.259147]
[  499.259147] but task is already holding lock:
[  499.259349] 000000009ec93a76 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xe0/0x160
[  499.259597]
[  499.259597] which lock already depends on the new lock.
[  499.259597]
[  499.259848]
[  499.259848] the existing dependency chain (in reverse order) is:
[  499.260086]
[  499.260086] -> #4 (&mm->mmap_sem){++++}:
[  499.260277]        __lock_acquire+0x53c/0x910
[  499.260442]        lock_acquire+0xf4/0x2f0
[  499.260595]        down_write_killable+0x6c/0x150
[  499.260764]        copy_process.isra.34.part.35+0x1594/0x1be0
[  499.260967]        _do_fork+0xf8/0x910
[  499.261090]        ppc_clone+0x8/0xc
[  499.261209]
[  499.261209] -> #3 (&dup_mmap_sem){++++}:
[  499.261378]        __lock_acquire+0x53c/0x910
[  499.261540]        lock_acquire+0xf4/0x2f0
[  499.261669]        down_write+0x6c/0x110
[  499.261793]        percpu_down_write+0x48/0x140
[  499.261954]        register_for_each_vma+0x6c/0x2a0
[  499.262116]        uprobe_register+0x230/0x320
[  499.262277]        probe_event_enable+0x1cc/0x540
[  499.262435]        perf_trace_event_init+0x1e0/0x350
[  499.262587]        perf_trace_init+0xb0/0x110
[  499.262750]        perf_tp_event_init+0x38/0x90
[  499.262910]        perf_try_init_event+0x10c/0x150
[  499.263075]        perf_event_alloc+0xbb0/0xf10
[  499.263235]        sys_perf_event_open+0x2a8/0xdd0
[  499.263396]        system_call+0x58/0x6c
[  499.263516]
[  499.263516] -> #2 (&uprobe->register_rwsem){++++}:
[  499.263723]        __lock_acquire+0x53c/0x910
[  499.263884]        lock_acquire+0xf4/0x2f0
[  499.264002]        down_write+0x6c/0x110
[  499.264118]        uprobe_register+0x1ec/0x320
[  499.264283]        probe_event_enable+0x1cc/0x540
[  499.264442]        perf_trace_event_init+0x1e0/0x350
[  499.264603]        perf_trace_init+0xb0/0x110
[  499.264766]        perf_tp_event_init+0x38/0x90
[  499.264930]        perf_try_init_event+0x10c/0x150
[  499.265092]        perf_event_alloc+0xbb0/0xf10
[  499.265261]        sys_perf_event_open+0x2a8/0xdd0
[  499.265424]        system_call+0x58/0x6c
[  499.265542]
[  499.265542] -> #1 (event_mutex){+.+.}:
[  499.265738]        __lock_acquire+0x53c/0x910
[  499.265896]        lock_acquire+0xf4/0x2f0
[  499.266019]        __mutex_lock+0xa0/0xab0
[  499.266142]        trace_add_event_call+0x44/0x100
[  499.266310]        create_trace_uprobe+0x4a0/0x8b0
[  499.266474]        trace_run_command+0xa4/0xc0
[  499.266631]        trace_parse_run_command+0xe4/0x200
[  499.266799]        probes_write+0x20/0x40
[  499.266922]        __vfs_write+0x6c/0x240
[  499.267041]        vfs_write+0xd0/0x240
[  499.267166]        ksys_write+0x6c/0x110
[  499.267295]        system_call+0x58/0x6c
[  499.267413]
[  499.267413] -> #0 (uprobe_lock){+.+.}:
[  499.267591]        validate_chain.isra.34+0xbd0/0x1000
[  499.267747]        __lock_acquire+0x53c/0x910
[  499.267917]        lock_acquire+0xf4/0x2f0
[  499.268048]        __mutex_lock+0xa0/0xab0
[  499.268170]        trace_uprobe_mmap+0x78/0x130
[  499.268335]        uprobe_mmap+0x80/0x3b0
[  499.268464]        mmap_region+0x290/0x660
[  499.268590]        do_mmap+0x40c/0x500
[  499.268718]        vm_mmap_pgoff+0x114/0x160
[  499.268870]        ksys_mmap_pgoff+0xe8/0x2e0
[  499.269034]        sys_mmap+0x84/0xf0
[  499.269161]        system_call+0x58/0x6c
[  499.269279]
[  499.269279] other info that might help us debug this:
[  499.269279]
[  499.269524] Chain exists of:
[  499.269524]   uprobe_lock --> &dup_mmap_sem --> &mm->mmap_sem
[  499.269524]
[  499.269856]  Possible unsafe locking scenario:
[  499.269856]
[  499.270058]        CPU0                    CPU1
[  499.270223]        ----                    ----
[  499.270384]   lock(&mm->mmap_sem);
[  499.270514]                                lock(&dup_mmap_sem);
[  499.270711]                                lock(&mm->mmap_sem);
[  499.270923]   lock(uprobe_lock);
[  499.271046]
[  499.271046]  *** DEADLOCK ***
[  499.271046]
[  499.271256] 1 lock held by perf/6744:
[  499.271377]  #0: 000000009ec93a76 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xe0/0x160
[  499.271628]
[  499.271628] stack backtrace:
[  499.271797] CPU: 25 PID: 6744 Comm: perf Not tainted 4.17.0-rc3+ #76
[  499.272003] Call Trace:
[  499.272094] [c0000000e32d74a0] [c000000000b00174] dump_stack+0xe8/0x164 (unreliable)
[  499.272349] [c0000000e32d74f0] [c0000000001a905c] print_circular_bug.isra.30+0x354/0x388
[  499.272590] [c0000000e32d7590] [c0000000001a3050] check_prev_add.constprop.38+0x8f0/0x910
[  499.272828] [c0000000e32d7690] [c0000000001a3c40] validate_chain.isra.34+0xbd0/0x1000
[  499.273070] [c0000000e32d7780] [c0000000001a57cc] __lock_acquire+0x53c/0x910
[  499.273311] [c0000000e32d7860] [c0000000001a65b4] lock_acquire+0xf4/0x2f0
[  499.273510] [c0000000e32d7930] [c000000000b1d1f0] __mutex_lock+0xa0/0xab0
[  499.273717] [c0000000e32d7a40] [c0000000002b01b8] trace_uprobe_mmap+0x78/0x130
[  499.273952] [c0000000e32d7a90] [c0000000002d7070] uprobe_mmap+0x80/0x3b0
[  499.274153] [c0000000e32d7b20] [c0000000003550a0] mmap_region+0x290/0x660
[  499.274353] [c0000000e32d7c00] [c00000000035587c] do_mmap+0x40c/0x500
[  499.274560] [c0000000e32d7c80] [c00000000031ebc4] vm_mmap_pgoff+0x114/0x160
[  499.274763] [c0000000e32d7d60] [c000000000352818] ksys_mmap_pgoff+0xe8/0x2e0
[  499.275013] [c0000000e32d7de0] [c000000000016864] sys_mmap+0x84/0xf0
[  499.275207] [c0000000e32d7e30] [c00000000000b404] system_call+0x58/0x6c


( Reference: https://lkml.org/lkml/2018/5/25/111 )
