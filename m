Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6E8208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDAYuZYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6E8208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeHXXwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:52:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44345 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:52:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so1534819plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6LY4jP0scCgtmW4O8dE2JkIJA9FCsl7elaq5U0ky/mM=;
        b=EDAYuZYzNlb9Hp58TOsEzJ/Z+IxwdxdE6EqXuOwMrvQ4z7BfCiS1+tdxJ2w+qLCf54
         8Ce3BYkLN8JYctiuylSA0ds4AdlkifJjAvqT3/SZ11RviuRfCg2YmpfjQfqTZkfe+42h
         bAbGlw3HS8Oh21aTSXkIN+FsIp7L1dO8RykxJ1zsLdM/G8OZLooekFME4VLztf0vKdMC
         Ue0TKb2p4EwiPAZzQbKbaPXYM4bk1OBCnrFqhoSXQ+KbB7qr71kkRfN91B7cZrYTTwc8
         vS40iuzDqFdir5zDSvN+BrY2uvgboGLBOAcSWEJejbEM6zxbVdoWVnn9bIGraJ+9zoQB
         iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6LY4jP0scCgtmW4O8dE2JkIJA9FCsl7elaq5U0ky/mM=;
        b=LCmruHvDUSjmFcCObQrHclDsj3ywFi0ujqmBRcQ6st+G34TEr8ekNx5Wqbxs1b1VZW
         tFjEAWzzR5KNVY8kg+CEKFHdoj5LCFB26y9jdLwK97jPfQpfbXdi7pnT8nkVGqp4396R
         fzlqFhmyITJwUv/Ji/i7gTn+WaDb5xQr/2pLvNZ21gQZAOYjysfQHFHCcUr1u364CLQq
         KtDPTnJe83a2YSstqCW4sjGwyuvABNfjtg7hUqQj5wRr+grCZBr2XOu86RLtdbVCIAQK
         sjPBkB3MLBM8kvGUx6xfvmTfK0Ad6qEcDWTIWV3ctHRf9B3NBhHvZIZ3swikjf5NTXdT
         qiEA==
X-Gm-Message-State: APzg51D9P+XBbn8pyMj09tar5rf2srlptwA8C4JQULEZHsCAK1/I2hYI
        Tp8ZjqEkMySu5Xc0V+f2iQOEdqNglxPRYdP5lcUxEQ==
X-Google-Smtp-Source: ANB0VdY/Vd4tLmsUsjHGLe3O/krL4bpnHuC/jiaepo8JJ2/RPbdOgagR8A3VPfkaQbfamg9GkKtdmqDv8cOlU33553o=
X-Received: by 2002:a17:902:f:: with SMTP id 15-v6mr2930576pla.195.1535141788558;
 Fri, 24 Aug 2018 13:16:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Fri, 24 Aug 2018 13:16:08
 -0700 (PDT)
In-Reply-To: <20180822090823.GT24124@hirez.programming.kicks-ass.net>
References: <00000000000035c2ed057315bf85@google.com> <0000000000006e87360573f8b328@google.com>
 <20180822090823.GT24124@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Aug 2018 13:16:08 -0700
Message-ID: <CACT4Y+ZKkUGzfgL5K-aLz8+VcFcFF1bWHR3LDRvCO-DtXhD8Ww@mail.gmail.com>
Subject: Re: general protection fault in finish_task_switch (2)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+1f56df64bfb3c29dde6f@syzkaller.appspotmail.com>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 2:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Aug 21, 2018 at 02:28:02PM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    778a33959a8a Merge tag 'please-pull-noboot' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14a5385a400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=214e4990bd49329f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1f56df64bfb3c29dde6f
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> userspace arch: i386
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13ffa561400000
>
> FWIW the lack of whitespace between "repro:" and the URL makes it hard
> to copy paste.

Fixed by:
https://github.com/google/syzkaller/commit/307deaee5e23e4585d4b408ebcf329b9dc8ebdb4
Thanks

>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10023961400000
>
>
>> RIP: 0010:__fire_sched_in_preempt_notifiers kernel/sched/core.c:2481
>
> That repro thing does something dodgy with KVM, which then corrupts the
> premption notifier thing. I'm sufficiently KVM clueless to not really
> know where to start looking though..
