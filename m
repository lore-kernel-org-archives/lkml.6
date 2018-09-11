Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422ABC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CE52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CE52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeIKOBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:01:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:58700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbeIKOBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:01:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0257EAF87;
        Tue, 11 Sep 2018 09:03:26 +0000 (UTC)
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20180907130550.11885-1-mhocko@kernel.org>
 <f7ed71c1-d599-5257-fd8f-041eb24d9f29@profihost.ag>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <186d4fd2-546b-d193-448f-52662931a0b9@suse.cz>
Date:   Tue, 11 Sep 2018 11:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f7ed71c1-d599-5257-fd8f-041eb24d9f29@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 08:52 PM, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> whlie using this path i got another stall - which i never saw under
> kernel 4.4. Here is the trace:
> [305111.932698] INFO: task ksmtuned:1399 blocked for more than 120 seconds.
> [305111.933612]       Tainted: G                   4.12.0+105-ph #1
> [305111.934456] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [305111.935323] ksmtuned        D    0  1399      1 0x00080000
> [305111.936207] Call Trace:
> [305111.937118]  ? __schedule+0x3bc/0x830
> [305111.937991]  schedule+0x32/0x80
> [305111.938837]  schedule_preempt_disabled+0xa/0x10
> [305111.939687]  __mutex_lock.isra.4+0x287/0x4c0

Hmm so is this waiting on mutex_lock(&ksm_thread_mutex)? Who's holding it?

Looking at your original report [1] I see more tasks waiting on a semaphore:

[245654.463746] INFO: task pvestatd:3175 blocked for more than 120 seconds.
[245654.464730] Tainted: G W 4.12.0+98-ph <a
href="/view.php?id=1" title="[geschlossen] Integration Ramdisk"
class="resolved">0000001</a>
[245654.465666] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[245654.466591] pvestatd D 0 3175 1 0x00080000
[245654.467495] Call Trace:
[245654.468413] ? __schedule+0x3bc/0x830
[245654.469283] schedule+0x32/0x80
[245654.470108] rwsem_down_read_failed+0x121/0x170
[245654.470918] ? call_rwsem_down_read_failed+0x14/0x30
[245654.471729] ? alloc_pages_current+0x91/0x140
[245654.472530] call_rwsem_down_read_failed+0x14/0x30
[245654.473316] down_read+0x13/0x30
[245654.474064] proc_pid_cmdline_read+0xae/0x3f0

- probably down_read(&mm->mmap_sem);

[245654.485537] INFO: task service:86643 blocked for more than 120 seconds.
[245654.486015] Tainted: G W 4.12.0+98-ph <a
href="/view.php?id=1" title="[geschlossen] Integration Ramdisk"
class="resolved">0000001</a>
[245654.486502] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[245654.486960] service D 0 86643 1 0x00080000
[245654.487423] Call Trace:
[245654.487865] ? __schedule+0x3bc/0x830
[245654.488286] schedule+0x32/0x80
[245654.488763] rwsem_down_read_failed+0x121/0x170
[245654.489200] ? __handle_mm_fault+0xd67/0x1060
[245654.489668] ? call_rwsem_down_read_failed+0x14/0x30
[245654.490088] call_rwsem_down_read_failed+0x14/0x30
[245654.490538] down_read+0x13/0x30
[245654.490964] __do_page_fault+0x32b/0x430
[245654.491389] ? get_vtime_delta+0x13/0xb0
[245654.491835] do_page_fault+0x2a/0x70
[245654.492253] ? page_fault+0x65/0x80
[245654.492703] page_fault+0x7b/0x80

- page fault, so another mmap_sem for read

[245654.496050] INFO: task safe_timer:86651 blocked for more than 120
seconds.
[245654.496466] Tainted: G W 4.12.0+98-ph <a
href="/view.php?id=1" title="[geschlossen] Integration Ramdisk"
class="resolved">0000001</a>
[245654.496916] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[245654.497336] safe_timer D 0 86651 1 0x00080000
[245654.497790] Call Trace:
[245654.498211] ? __schedule+0x3bc/0x830
[245654.498646] schedule+0x32/0x80
[245654.499074] rwsem_down_read_failed+0x121/0x170
[245654.499501] ? call_rwsem_down_read_failed+0x14/0x30
[245654.499959] call_rwsem_down_read_failed+0x14/0x30
[245654.500381] down_read+0x13/0x30
[245654.500851] __do_page_fault+0x32b/0x430
[245654.501285] ? get_vtime_delta+0x13/0xb0
[245654.501722] do_page_fault+0x2a/0x70
[245654.502163] ? page_fault+0x65/0x80
[245654.502600] page_fault+0x7b/0x80

- ditto

But those are different tasks that the one that was stalling allocation
while holding mmap_sem for write.

So I'm not sure what's going on, but maybe the reclaim is also stalled
due to waiting on some locks, and is thus victim of something else?

[1] https://lists.opensuse.org/opensuse-kernel/2018-08/msg00012.html
