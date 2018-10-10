Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F7FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46652214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4/b3HRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46652214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJJQyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:54:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56093 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJJQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:54:54 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so7010723itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qoRJmTum/IGEAF2duW2LywlMjqVpnuxGW1XEm9gtffY=;
        b=c4/b3HRJjBsv19wUSYGgyqVOyuwAiFa0iec+UX5K6otCY8HSFWbH2fo+N0Cshp8+sF
         AjJtBN+oQMP0Or6UHU9ZJChruC1S1TosHZmcL9kNgThAuO8JjPtl32GDS+4oH83NvUWa
         rc23m+Tgai7FLLL7OPN+4QzjQyMUjSsoId5PJMAWiaq9ClXLNURTP2KQT3JKSyAxDSHO
         LwTkfLcURJAciO1DxnuOgFTOglEA8s+TfOD+P+lvjLt9/SW+NrVn4jtdQiXYzs+Z5Ahs
         2W7n0DxK8uG4UYX+7lMUrnRPGOQUwkPui0v5axOLAW22LqOqkUNW6I1cZBeRHpLmpSyA
         DReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qoRJmTum/IGEAF2duW2LywlMjqVpnuxGW1XEm9gtffY=;
        b=pUlsYwuIKjq+Y7hbE6vt7XZEnDdfCU+5EYTYT83MqdF39zQN1GeLr9r9F+ZAnseR5k
         kPNnWSb/GCpx9ztMkWA/ZbKyM8LvHe4VRqy9SBULph9rTxAkJKLvDTBCtgPVxyI7sAdb
         ywK4z655YvVfL9nrWXR7mYj6BrVU1U4chf6DwTKZIB6aVPFNCSgf+RnA7WHwVKJ5P2kk
         k0kaE27UntOAZht+TjMbAbQ/xa9YpOz74bwH/K+o4MFH2zUOVCZJG0G3e/ZAEH67jHih
         jt3gHiCpBpX/CbXGMPO6Ue9Ym+RMd6k2AnqWcpXq0GFUAHoJk+C/6PfqZzfsySZXepTX
         666g==
X-Gm-Message-State: ABuFfohs/m04kEFyppF1zSiULY8GPnSDt/09O61+e8hxy9802GKBk7SM
        wD/LqSavJ7Wx4WaOtU1ZnisALImey3+CvG1tj58+Dw==
X-Google-Smtp-Source: ACcGV61ZLBk9AM3eqtzCYRiyxm693Dnln2DiaNUrtg5KltEBY0aPucoKeok91uHs51GOgouqgDBljUe0rrVWA/t9NLo=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr140351ite.12.1539164014817;
 Wed, 10 Oct 2018 02:33:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 02:33:14
 -0700 (PDT)
In-Reply-To: <20181010091309.GE5873@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com> <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
 <CACT4Y+bmYbNpu3mQR+X52KX+yPD1N2dnZOtd=iu-oETkevQ9RA@mail.gmail.com> <20181010091309.GE5873@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 11:33:14 +0200
Message-ID: <CACT4Y+Y1AAw3M7_weNDZ5eb5ON_bj-sYFHNJmQa0i4uKEy4W5Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yang Shi <yang.s@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:13 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 10-10-18 09:55:57, Dmitry Vyukov wrote:
>> On Wed, Oct 10, 2018 at 6:11 AM, 'David Rientjes' via syzkaller-bugs
>> <syzkaller-bugs@googlegroups.com> wrote:
>> > On Wed, 10 Oct 2018, Tetsuo Handa wrote:
>> >
>> >> syzbot is hitting RCU stall due to memcg-OOM event.
>> >> https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64
>> >>
>> >> What should we do if memcg-OOM found no killable task because the allocating task
>> >> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires
>> >> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
>> >> OOM header when no eligible victim left") because syzbot was terminating the test
>> >> upon WARN(1) removed by that commit) is not a good behavior.
>>
>>
>> You want to say that most of the recent hangs and stalls are actually
>> caused by our attempt to sandbox test processes with memory cgroup?
>> The process with oom_score_adj == -1000 is not supposed to consume any
>> significant memory; we have another (test) process with oom_score_adj
>> == 0 that's actually consuming memory.
>> But should we refrain from using -1000? Perhaps it would be better to
>> use -500/500 for control/test process, or -999/1000?
>
> oom disable on a task (especially when this is the only task in the
> memcg) is tricky. Look at the memcg report
> [  935.562389] Memory limit reached of cgroup /syz0
> [  935.567398] memory: usage 204808kB, limit 204800kB, failcnt 6081
> [  935.573768] memory+swap: usage 0kB, limit 9007199254740988kB, failcnt 0
> [  935.580650] kmem: usage 0kB, limit 9007199254740988kB, failcnt 0
> [  935.586923] Memory cgroup stats for /syz0: cache:152KB rss:176336KB rss_huge:163840KB shmem:344KB mapped_file:264KB dirty:0KB writeback:0KB swap:0KB inactive_anon:260KB active_anon:176448KB inactive_file:4KB active_file:0KB
>
> There is still somebody holding anonymous (THP) memory. If there is no
> other eligible oom victim then it must be some of the oom disabled ones.
> You have suppressed the task list information so we do not know who that
> might be though.
>
> So it looks like there is some misconfiguration or a bug in the oom
> victim selection.


I afraid KASAN can interfere with memory accounting/OMM killing too.
KASAN quarantines up to 1/32-th of physical memory (in our case
7.5GB/32 = 230MB) that is already freed by the task, but as far as I
understand is still accounted against memcg. So maybe making cgroup
limit >> quarantine size will help to resolve this too.

But of course there can be a plain memory leak too.
