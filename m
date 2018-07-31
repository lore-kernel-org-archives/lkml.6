Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC41C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223C220862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePcBT6Ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223C220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeGaSzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:55:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40392 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeGaSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:55:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id e13-v6so6423176pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gdwXNdekDSnl/NO1/p7grdZi5izDDgEPpxy8npla8uo=;
        b=ePcBT6WwpEIrg13QBl1RG0QwwSpryN131KukCK8ix+nJEHYGSNlJ3oqWiIEVGG+mkN
         Rb/81as6geWRtq/QRpXy6uj/mk//csuJsXH+hWJGWulJ7X7WLOPHXO4Yyij9U78C5wwT
         l7qqgJ3Y6CPvcigS/clDYs9njmrk7GE/57sKQzgmpRzpCsuCFDvlgswucgB3gzJgkj/4
         sy/KHdvJB6c1CCsbDrkB0g9JeEUcHANZSpfma5ktThvO9wn4QVu6DUx9z4tQCy3PXei1
         VdOtjbYJ3rgS0TsXq9WrL0UW5UOaAVv4Aox4NQwMbuHNxJPNpBPcjvxppoPP24qMINMF
         OYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gdwXNdekDSnl/NO1/p7grdZi5izDDgEPpxy8npla8uo=;
        b=k9Ad80/rhf6MFODydypl6ekXYIWd3sdGLDKPRmrrlaByhl13DXNKnwdAhjUJM9WiQh
         vAA9c7mxgN5VlT/o2CigM3EcUaj+CT/1YorUpGI7Ej0VCIdW515Rb1969iP+XRzC0Zcd
         FtSJyamXs7LWZ179MsbjJCKkpuayIRS4+9rvHQa3ErQ7YK/VaFkboxFZR3ExekWf6d81
         XfH+CtptjwxhTFMNngGvJ4yJRNPAywTZ7/pB67Be/lxGhRS+ATakfEqvcDPsXu0vRYW9
         MyXlmmaR99/CulU5QDzmPm5F/QBFr/QQXGAIxlOitgpU7GfzrR+VjzQaUAVUBsCjbhj2
         kEEQ==
X-Gm-Message-State: AOUpUlF9F3j/6w7UWgvb0+95wlEUanuVXF3h+gWkrJWdCnNUN1BSN95y
        3SJ60HxPkqOvYbiQpK4rKslcGA==
X-Google-Smtp-Source: AAOMgpfKbxHWizpzD6o0PwLbU6MPhCDCoKzitf8BwMYxwYp4X0YL4h1CqurTgHnH7+r0k0hD92VZlA==
X-Received: by 2002:a63:4f1a:: with SMTP id d26-v6mr21758578pgb.121.1533057239540;
        Tue, 31 Jul 2018 10:13:59 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id s3-v6sm42726399pfg.2.2018.07.31.10.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:13:58 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
        <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com>
        <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
        <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com>
Date:   Tue, 31 Jul 2018 10:13:56 -0700
In-Reply-To: <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com> (Xunlei
        Pang's message of "Tue, 31 Jul 2018 22:58:49 +0800")
Message-ID: <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> On 7/31/18 1:55 AM, Cong Wang wrote:
>> On Sun, Jul 29, 2018 at 10:29 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>>
>>> Hi Cong,
>>>
>>> On 7/28/18 8:24 AM, Cong Wang wrote:
>>>> Each time we sync cfs_rq->runtime_expires with cfs_b->runtime_expires,
>>>> we should sync its ->expires_seq too. However it is missing
>>>> for distribute_cfs_runtime(), especially the slack timer call path.
>>>
>>> I don't think it's a problem, as expires_seq will get synced in
>>> assign_cfs_rq_runtime().
>> 
>> Sure, but there is a small window during which they are not synced.
>> Why do you want to wait until the next assign_cfs_rq_runtime() when
>> you already know runtime_expires is synced?
>> 
>> Also, expire_cfs_rq_runtime() is called before assign_cfs_rq_runtime()
>> inside __account_cfs_rq_runtime(), which means the check of
>> cfs_rq->expires_seq is not accurate for unthrottling case if the clock
>> drift happens soon enough?
>> 
>
> expire_cfs_rq_runtime():
>     if (cfs_rq->expires_seq == cfs_b->expires_seq) {
>         /* extend local deadline, drift is bounded above by 2 ticks */
>         cfs_rq->runtime_expires += TICK_NSEC;
>     } else {
>         /* global deadline is ahead, expiration has passed */
>         cfs_rq->runtime_remaining = 0;
>     }
>
> So if clock drift happens soon, then expires_seq decides the correct
> thing we should do: if cfs_b->expires_seq advanced, then clear the stale
> cfs_rq->runtime_remaining from the slack timer of the past period, then
> assign_cfs_rq_runtime() will refresh them afterwards, otherwise it is a
> real clock drift. I am still not getting where the race is?

Nothing /important/ goes wrong because distribute_cfs_runtime only fills
runtime_remaining up to 1, not a real amount.
