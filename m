Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416D82064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsQOOd2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416D82064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:17:16 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37395 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeJJPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:17:15 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so6678915ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yLpp7IxaaGQA301sTQJX9PWLhiBJD8NnJclg3s8a/fQ=;
        b=YsQOOd2Xd/WhOly4R8weECmi3YkVIx8ETmu/kbNTtYFZGSZyP+wuDN8MO6M4CHhHFz
         kf1Am1Qb0K64qw3ecNuWIGE8eXu6jC0u1dpjEdRl32lbAyk3uGH5T3npb7tVoI2qu+jn
         PmDOTu6deeslaKH0DapBeE6DC50Xe9b6xJPsqzFrkH1FpyzkqFjYOxfuWnHnQ3hOm+e9
         cQrBuxvrj8rZnW3KP7E8eRUUs3kZr712QJWq613khrviX8QFuLqAV194tZcs62vkv+wv
         8yjts2rGLRk6HK1PAhcOIqMoaNprpp1ZD2Cp/P8zFNDIRzvtXGqQyDjT89GbKdou0S5V
         p20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yLpp7IxaaGQA301sTQJX9PWLhiBJD8NnJclg3s8a/fQ=;
        b=cqJ3hmd5Do/DWopkrmTNQJNCquN0MAiFPul8dlVOok0OuHTYV5SHU6ITBcymKri2up
         K6COAwfhn9XQk3e6Rc9S157W4u4wn7aX9f04MqU3bd5iTfs062P6tuguprGC4hrpqjtp
         SPtua7Htc9zimOnGq1P8MchSiUAY27cIARIoa78Cf4vmYpBZh3boDu9INqsQ6gOscz/L
         CsL9SjQECLPe4XHuUf6WU5hV9HACeR0qcuCdWLYyayqxOznulCVMkhMXtPMNmCV2dqaV
         LkVWqqFmkUhIydleC0dDF1eCyrLKMuIfAAUzFPmvYNRmBlv9T0uUvexalAWttNqXu8eT
         GkHA==
X-Gm-Message-State: ABuFfoiRGysG6JYLBSvsBc+czJgEm9MUXpYlFO3j04jBkq2nXnpA/0YT
        fg4xW2MY6FUzViYK8sVsDIAPaiGUTNA+BtcoGVghjQ==
X-Google-Smtp-Source: ACcGV60uiPaW6n9iy95vZo3IMnVNL7bL/qsOoM25Jfm/bZ14hsdaNzWE9t2i3w2GHhd3bvldHhM6ttPbaf5L0zuzv/I=
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr3865189ita.144.1539158177786;
 Wed, 10 Oct 2018 00:56:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 00:55:57
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
References: <000000000000dc48d40577d4a587@google.com> <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1810092106190.83503@chino.kir.corp.google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 09:55:57 +0200
Message-ID: <CACT4Y+bmYbNpu3mQR+X52KX+yPD1N2dnZOtd=iu-oETkevQ9RA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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

On Wed, Oct 10, 2018 at 6:11 AM, 'David Rientjes' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
> On Wed, 10 Oct 2018, Tetsuo Handa wrote:
>
>> syzbot is hitting RCU stall due to memcg-OOM event.
>> https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64
>>
>> What should we do if memcg-OOM found no killable task because the allocating task
>> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires
>> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
>> OOM header when no eligible victim left") because syzbot was terminating the test
>> upon WARN(1) removed by that commit) is not a good behavior.


You want to say that most of the recent hangs and stalls are actually
caused by our attempt to sandbox test processes with memory cgroup?
The process with oom_score_adj == -1000 is not supposed to consume any
significant memory; we have another (test) process with oom_score_adj
== 0 that's actually consuming memory.
But should we refrain from using -1000? Perhaps it would be better to
use -500/500 for control/test process, or -999/1000?


> Not printing anything would be the obvious solution but the ideal solution
> would probably involve
>
>  - adding feedback to the memcg oom killer that there are no killable
>    processes,
>
>  - adding complete coverage for memcg_oom_recover() in all uncharge paths
>    where the oom memcg's page_counter is decremented, and
>
>  - having all processes stall until memcg_oom_recover() is called so
>    looping back into try_charge() has a reasonable expectation to succeed.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/alpine.DEB.2.21.1810092106190.83503%40chino.kir.corp.google.com.
> For more options, visit https://groups.google.com/d/optout.
