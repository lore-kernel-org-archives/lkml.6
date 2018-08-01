Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E66620855
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9tPJeCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E66620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeHBBqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:46:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45328 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHBBqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:46:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so277613wrv.12;
        Wed, 01 Aug 2018 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9pTo8/yU8Ifv0eJAO0IS9oSsbjCCWOeE39Vo7CrV1Cg=;
        b=J9tPJeCuu2LRcrxuZqnxRDm/3jF+DkLAxwGgWhYpJBjAGneUl7PJVkdGsGP3N/cK69
         /UnsrIQRw761kNG+OGORaSBQZuEsyBhHQ8QI0GyQ7etKn8xgUjd0/gc/HHMzHyFt4ju9
         o0T7QIh4RshkJvauoJG6pGn5RvQ9qAU546OOL75WeGUk4riN8EtWXGVsf8sBbNNXeIdV
         cJw5QD3IMrkojJtHPKqvO2qne9QJXOlsRnQsqVYVYowm97ICMb9iqCqvvGaLQWjSzKlI
         ES8trUBR/VmxZTG+7itBckwR5P8ECSBU42QWxdvRMKJ/W5JB9AHE3GPnA13ItCHyYj8n
         Fo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9pTo8/yU8Ifv0eJAO0IS9oSsbjCCWOeE39Vo7CrV1Cg=;
        b=fJChFu7+0lIpmOD+q094CZFvHx4WHlulQa01AF4PgNxs9yBoTIt6eu/FQGjvaBmdQv
         BstfGbhlmA/BPoRtKfWi1Khd5EvEa9GsZ12FnzFDOp2nVmvEp1CxgpsJAYpFr7m+JgSO
         T0Vd5NEwf2NW/HgiAOvnwIsKwa+f15/S9YwF94vxQx4fG4zbNnsEXPLATuYd/sMoIr5F
         35YhUBarUHsU/7tZXw3JTt0pHghlG4kN7X0M8CqEcUty/4Z0DFgb1e7r0POohHVWCAKu
         zcFVdi1s8jaFKuGF6fabAtIGvoswn8Q8cGr4uhOjQbD91diFx5opkQkvQuQHLcM7fZhX
         Hslg==
X-Gm-Message-State: AOUpUlFsfOVDvoX+pch3crnkL2n7i3Q4cKrhzykEDLU3mTlGAIFTlC6j
        RaQr0bvlcL2aSaNNRL33ptA8oY5G0dFUtiKC5Ys=
X-Google-Smtp-Source: AAOMgpcMpQiKluDVLSN/eA3FyaD/PldngSH/a4mVc0Gqe5rGHT5NsLJEYhyB7ZNt59EmlIT7jtTRCrdIRAtVsVZNUsk=
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr255321wre.5.1533167878521;
 Wed, 01 Aug 2018 16:57:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 16:57:57 -0700 (PDT)
In-Reply-To: <20180801234727.GA3762@roeck-us.net>
References: <20180801175852.36549130@canb.auug.org.au> <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com> <20180801234727.GA3762@roeck-us.net>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 2 Aug 2018 07:57:57 +0800
Message-ID: <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 7:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Aug 01, 2018 at 03:52:45PM -0700, James Bottomley wrote:
>> On Wed, 2018-08-01 at 15:48 -0700, Guenter Roeck wrote:
>> > On Wed, Aug 01, 2018 at 05:58:52PM +1000, Stephen Rothwell wrote:
>> > > Hi all,
>> > >
>> > > Changes since 20180731:
>> > >
>> > > The pci tree gained a conflict against the pci-current tree.
>> > >
>> > > The net-next tree gained a conflict against the bpf tree.
>> > >
>> > > The block tree lost its build failure.
>> > >
>> > > The staging tree still had its build failure due to an interaction
>> > > with
>> > > the vfs tree for which I disabled CONFIG_EROFS_FS.
>> > >
>> > > The kspp tree lost its build failure.
>> > >
>> > > Non-merge commits (relative to Linus' tree): 10070
>> > >  9137 files changed, 417605 insertions(+), 179996 deletions(-)
>> > >
>> > > -----------------------------------------------------------------
>> > > -----------
>> > >
>> >
>> > The widespread kernel hang issues are still seen. I managed
>> > to bisect it after working around the transient build failures.
>> > Bisect log is attached below. Unfortunately, it doesn't help much.
>> > The culprit is reported as:
>> >
>> > 2d542828c5e9 Merge remote-tracking branch 'scsi/for-next'
>> >
>> > The preceding merge,
>> >
>> > 453f1d821165 Merge remote-tracking branch 'cgroup/for-next'
>> >
>> > checks out fine, as does the tip of scsi-next (commit 103c7b7e0184,
>> > "Merge branch 'misc' into for-next"). No idea how to proceed.
>>
>> This sounds like you may have a problem with this patch:
>>
>>     commit d5038a13eca72fb216c07eb717169092e92284f1
>>      Author: Johannes Thumshirn <jthumshirn@suse.de>
>>      Date:   Wed Jul 4 10:53:56 2018 +0200
>>
>>          scsi: core: switch to scsi-mq by default
>>
>> To verify, boot with the additional kernel parameter
>>
>> scsi_mod.use_blk_mq=0
>>
>> Which will reverse the effect of the above patch.
>>
> Yes, that fixes the problem.

That may not the root cause, given this issue is only started to
see from next-20180731, but d5038a13eca7 (scsi: core: switch to
scsi-mq by default)
has been in -next for quite a while.

Seems something new causes this issue.

Thanks,
Ming Lei
