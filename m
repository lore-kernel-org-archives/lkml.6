Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA17C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104D520867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104D520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIETp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:45:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbeIETp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:45:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BB14ADFE;
        Wed,  5 Sep 2018 15:14:49 +0000 (UTC)
Subject: Re: [PATCH v1] xen: avoid crash in disable_hotplug_cpu
To:     Olaf Hering <olaf@aepfle.de>
Cc:     xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180905104039.13512-1-olaf@aepfle.de>
 <7630aac8-8588-6e42-0807-f98b66ce37b5@suse.com>
 <20180905164719.52e02256.olaf@aepfle.de>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <237d1597-6085-dffb-fb12-1965db0ee68b@suse.com>
Date:   Wed, 5 Sep 2018 17:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905164719.52e02256.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/18 16:47, Olaf Hering wrote:
> Am Wed, 5 Sep 2018 12:55:58 +0200
> schrieb Juergen Gross <jgross@suse.com>:
> 
>> Instead of trying to fight the symptoms, I think avoiding to offline
>> the last cpu would make more sense.
> 
> Well, apparently the fix is to leave cpu#0 online because of a backtrace like that:

I'd go with testing whether cpu_is_hotpluggable(cpu) returns true.
Per default this will return false for cpu 0.

Additionally I'd really like a test for num_online_cpus() > 1

BTW: I'm not sure this WARN triggers because it is cpu#0. Are you sure
the tested cpu in that WARN was 0? After all the test is just running
on cpu#0 and I don't think it can be offline already.


Juergen

> 
> WARNING: CPU: 0 PID: 83 at kernel/sched/cpudeadline.c:159 cpudl_clear+0xa5/0xb0
> Workqueue: events cpuset_hotplug_workfn
> RIP: e030:cpudl_clear+0xa5/0xb0
> Code: 8b 43 48 c7 44 28 0c ff ff ff ff e8 d5 fd ff ff 48 8d 43 08 f0 4c 0f ab 20 4c 89 ee 48 89 df 5b 5d 41 5c 41 5d e9 0b 3b 79 00 <0f> 0b e9 76 ff ff ff 0f 1f 40 00 66 66 66 66 90 41 56 49 89 d6 41
> RSP: e02b:ffffc900411cbc40 EFLAGS: 00010086
> RAX: ffffffff810d09a0 RBX: ffff880106f1a100 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880106f1a100
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8801068989b0
> R10: ffff8801068989d0 R11: 0000000000000008 R12: 0000000000000000
> R13: ffff8801f3800200 R14: 0000000000000001 R15: ffff8801f3823240
> FS:  00007fd40d7f08c0(0000) GS:ffff8801f3800000(0000) knlGS:0000000000000000
> CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055eff60fe098 CR3: 00000001edf24000 CR4: 0000000000002660
> Call Trace:
>  rq_offline_dl+0x36/0x80
>  set_rq_offline+0x31/0x60
>  rq_attach_root+0x98/0xc0
>  cpu_attach_domain+0x107/0x320
>  partition_sched_domains+0x117/0x347
>  ? cpus_read_lock+0x2d/0x50
>  rebuild_sched_domains_locked+0xe4/0x4e0
>  ? __switch_to_asm+0x40/0x70
>  ? xen_mc_flush+0x102/0x210
>  rebuild_sched_domains+0x16/0x30
>  cpuset_hotplug_workfn+0x45e/0xef0
>  ? _raw_spin_unlock_irq+0x22/0x40
>  ? finish_task_switch+0x75/0x250
>  process_one_work+0x1fd/0x3e0
>  worker_thread+0x2d/0x3d0
>  ? rescuer_thread+0x340/0x340
>  kthread+0x112/0x130
>  ? kthread_create_worker_on_cpu+0x40/0x40
>  ret_from_fork+0x3a/0x50
> 
> Initially I did not spot it because the kernel was booted with 'quiet'.
> 
> Olaf
> 

