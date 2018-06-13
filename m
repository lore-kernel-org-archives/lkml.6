Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7CF1DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EBA208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBmX6Qkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EBA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeFMJZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:25:03 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41058 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933657AbeFMJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:25:01 -0400
Received: by mail-io0-f194.google.com with SMTP id t5-v6so2713963ioa.8;
        Wed, 13 Jun 2018 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/FHTPthfzToImDrKkQrr2+frxdic6sqcxIYOJRA0RA4=;
        b=RBmX6QkbUSofC/z34Xp7xsS4NFAMDwInza3gTtIbRgRWJs7RVdVkUrp7hFDZzoh2Ag
         FV3j1SkVeBzQzKLtDiFXpn8prhlCWiqxzY/P8fgsy6jr/sFveGpW5DXRJNA2KFIEY3Ep
         dZrsAUrwkjdaiiPg7VVz9ntNSDw1od9ZaanVBVhq4RCmAjtmS7ixFurGSk7YHMx3jmAi
         SqhUr5Yo1G/q+LJ4kFca5pN62LZThD0umFLoTwvUg90bVQrferMZOTZUn5NQkOLkCm6r
         U0pPcrncM73j6vEbAGEJtie8d5IH7qNr/pSVKApJLBd0OS9K7JKlpzwydCzTrWRddfQn
         /yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/FHTPthfzToImDrKkQrr2+frxdic6sqcxIYOJRA0RA4=;
        b=tnDEJhsyhAZh+5vHZ3TF6AHkRT4ERYmL/qeuS+or96JxtxDQlIoUJOmWyqDxe7knVg
         28unlaowmCBfdkENdzqExWbagiti2jhWS+7c4MCYMqs4BbgIHtgL8khRSsGZ0LaSpVVw
         z6iWggcYIUQ53o1I66m5gO1piPZW/TpX3fRkwwVwOl0aZpO6N3Fw/FoE5rkqdGO2k9aU
         +dTGnAWKRqFDCKn05MAhHVNgOBjdq89Yo9a8Wab+8SJnCdfq8fKGGsKuivmVibi+AyGR
         aIuy1hd6hN79pjN8cq6o2aVaZYIp6tWmONZThzDTKKzl1sGvAKcNivSbNuN+ks+tsUmm
         euBw==
X-Gm-Message-State: APt69E0XuFnhOW6GAh9X/vO3eZMRRlRLZB40AQK9xoA108ie1c3dMnZd
        lT037g8WOGMRr26bdz6QNM4Pk4ocmkXl3Ue6ooc=
X-Google-Smtp-Source: ADUXVKKyRWcXScFDd8uaNzpQQWEz7dZf96sJfqXcN0bEcw4GRhRvqurH8Gr1NcZ+uDm4Xmg7Z2CGArAhCDqi9cBObNU=
X-Received: by 2002:a6b:1e91:: with SMTP id e139-v6mr613553ioe.36.1528881900767;
 Wed, 13 Jun 2018 02:25:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9912:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 02:25:00
 -0700 (PDT)
In-Reply-To: <20180613043620.GA22578@ziepe.ca>
References: <1525769416-14596-1-git-send-email-lidongchen@tencent.com> <20180613043620.GA22578@ziepe.ca>
From:   858585 jemmy <jemmy858585@gmail.com>
Date:   Wed, 13 Jun 2018 17:25:00 +0800
Message-ID: <CAOGPPbe8V45B0TVMUiezKDcm0_d5dJhrubpbu5ARhi-y6MXkUg@mail.gmail.com>
Subject: Re: [PATCH v2] IB/umem: ib_ucontext already have tgid, remove pid
 from ib_umem structure
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, akpm@linux-foundation.org,
        qing.huang@oracle.com, Leon Romanovsky <leon@kernel.org>,
        artemyko@mellanox.com, dan.j.williams@intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adi Dotan <adido@mellanox.com>,
        Gal Shachaf <galsha@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Lidong Chen <lidongchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:36 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, May 08, 2018 at 04:50:16PM +0800, Lidong Chen wrote:
>> The userspace may invoke ibv_reg_mr and ibv_dereg_mr by different threads.
>> If when ibv_dereg_mr invoke and the thread which invoked ibv_reg_mr has
>> exited, get_pid_task will return NULL, ib_umem_release does not decrease
>> mm->pinned_vm. This patch fixes it by use tgid in ib_ucontext struct.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  [v2]
>>  - use ib_ucontext tgid instread of tgid in ib_umem structure
>
> I'm looking at this again, and it doesn't seem quite right..
>
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index 9a4e899..2b6c9b5 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -119,7 +119,6 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>>       umem->length     = size;
>>       umem->address    = addr;
>>       umem->page_shift = PAGE_SHIFT;
>> -     umem->pid        = get_task_pid(current, PIDTYPE_PID);
>>       /*
>>        * We ask for writable memory if any of the following
>>        * access flags are set.  "Local write" and "remote write"
>> @@ -132,7 +131,6 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>>                IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND));
>>
>>       if (access & IB_ACCESS_ON_DEMAND) {
>> -             put_pid(umem->pid);
>>               ret = ib_umem_odp_get(context, umem, access);
>>               if (ret) {
>>                       kfree(umem);
>> @@ -148,7 +146,6 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>>
>>       page_list = (struct page **) __get_free_page(GFP_KERNEL);
>>       if (!page_list) {
>> -             put_pid(umem->pid);
>>               kfree(umem);
>>               return ERR_PTR(-ENOMEM);
>>       }
>
> in ib_umem_get we are doing this:
>
>         down_write(&current->mm->mmap_sem);
>         locked     = npages + current->mm->pinned_vm;
>
> And then in release we now do:
>
>         task = get_pid_task(umem->context->tgid, PIDTYPE_PID);
>         if (!task)
>                 goto out;
>         mm = get_task_mm(task);
>         mm->pinned_vm -= diff;
>
> But there is no guarantee that context->tgid and 'current' are the
> same thing during ib_umem_get..

context->tgid and current maybe different. but different threads in one
process should point to one mm structure. so it should works for multithread.

>
> So in the dysfunctional case where someone forks and keeps the context
> FD open on both sides of the fork they can cause the pinned_vm
> counter to become wrong in the processes. Sounds bad..

I am not sure about fork support, I will check this problem.

>
> Thus, I think we need to go back to storing the tgid in the ib_umem
> and just fix it to store the group leader not the thread PID?
>
> And then even more we need the ib_get_mr_mm() helper to make sense of
> this, because all the drivers are doing the wrong thing by using the
> context->tgid too.
>
> Is that all right?
>
> Jason
