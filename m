Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E391FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E771205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbxBFZoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E771205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeJPVxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:53:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39975 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:53:06 -0400
Received: by mail-it1-f194.google.com with SMTP id i191-v6so32262983iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=B9hUoXb5NAdeS2MHaluwFs/4hP6TzggZyqRVVOpGx48=;
        b=mbxBFZoZI0I8R7EENg/8Npu/JfjhQADERl/bBdeA3EhcUpEvpc0nQUehOBbd6yiYaj
         ySH9VHQRztkFslbNpt57OjH9jAtUvwQHsd+E6WhryGLmulM82j2GURZlZ1Sl07MUNfpC
         1vAsni9HgpqXO5d3eUJ1R5RwhcrhFCm+UlZ/zD4ZbjaabZEzA1+n48F0/zp16XxOatHg
         /EgQmKLIlhnZfPicyTosSPN3idQTe32WVFUcS1Q2Zql8DIj+iaCj8a+VhNAxr8h90z2y
         f3fikgnMHiA0CQDGRSJS4uUDdtAoUCRD2y0kjHZWd42xFluW3mgDWuKxnGKG0JJseWQO
         hDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=B9hUoXb5NAdeS2MHaluwFs/4hP6TzggZyqRVVOpGx48=;
        b=Sta2CBkzrNLSFB8HpB6TuPTqIhQ0L/cO6Qxl0HqVzH/RmnKbd60ahHpQRrgLMqMCzm
         P9Sy6vGDgEQCN9q7rfE6vjS3B81c4ahZdldMo99eP/9tvpRcteIKB32+jGvxyOPs8SYN
         d7Yw0VL1/CWk60mQ8z2CH9DmnHit9idzO0RB4ZG5yMbLuQsK3pLjpnmzsSgH0BUfTWlC
         Uyj4lQy361uz43lD/rkF/DseIq0A/U3vZkueNmxrNwKm7DlvxX0J2u0coXZTrnHhMpwD
         pV/QUb12cAevhBxWrh+8KN+RsrH9+RHm+iO4U0L3qcPUB86XTBQB8wMKai7c9SHSNkp2
         UKpA==
X-Gm-Message-State: ABuFfogtC8N1LJ98GmABR6OhSRxMOmj8k6+GX12WWlUGoMVxe4jRd/Fv
        RQdarNjJllb+IaKpAa6t92UNR9vlqamPyxEOILOUlA==
X-Google-Smtp-Source: ACcGV607IIAL6CbnXWiSnF4AIY5cVqUesHXPRgiPMXwPX+Kb9VgRGc+1Dt0AtIsW2zd1dHR8gWIo15oFi8RXLQwxv/M=
X-Received: by 2002:a24:24c9:: with SMTP id f192-v6mr13972113ita.144.1539698548495;
 Tue, 16 Oct 2018 07:02:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 07:02:07
 -0700 (PDT)
In-Reply-To: <20181015180821.GE8983@thunk.org>
References: <0000000000002753c60577b9f707@google.com> <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
 <20181009013425.GB3369@thunk.org> <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
 <20181015180821.GE8983@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Oct 2018 16:02:07 +0200
Message-ID: <CACT4Y+bs72L4GKF7K6zHHqDGfURymzUke7UT6CKtakLWu+f94g@mail.gmail.com>
Subject: Re: WARNING in ext4_invalidatepage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:08 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Oct 15, 2018 at 03:22:42PM +0200, Dmitry Vyukov wrote:
>> Now that you mention EXT4_IOC_SWAP_BOOT, I think I looked at the wrong
>> program, there is a subsequent one that does ioctl(0x6611) where
>> 0x6611 is in fact EXT4_IOC_SWAP_BOOT. So I think it's this one:
>>
>> 05:23:28 executing program 5:
>> r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
>> socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000380)={0xffffffffffffffff,
>> <r1=>0xffffffffffffffff})
>> write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000240)={0x0, 0x18,
>> 0xfa00, {0x0, &(0x7f0000000200)}}, 0x20)
>> ioctl$PERF_EVENT_IOC_ENABLE(r1, 0x8912, 0x400200)
>> ioctl$EXT4_IOC_SETFLAGS(r0, 0x6611, &(0x7f0000000000)=0x4000)
>
> Ah, so is it a bug in Syzkaller that it is printing
> ioctl$EXT4_IOC_SETFLAGS when 0x6611 is in fact EXT4_IOC_SWAP_BOOT,
> right?

I am not sure how exactly this should be classified. To significant
degree these "$FOO" discriminations are informational and only really
affect the data format passed in. For ioctl/write it's not really
possible to know what exactly it will do if you just open a file
(which can be a link to into an overlay mount pointing to some special
file). Sometimes we also want to specifically spoof exact fd type (or
other resource type) for a syscall. Sometimes we discover other ioctl
command constants while running an ioctl, and then we just change the
command constant but leave the data as is.


>> I've tried to manually reply this program and the whole log too, but
>> it does not reproduce. This may be related to the fact that filesystem
>> accumulates too much global state, so probably first relevant part
>> happened long time ago, and then second relevant part happened later
>> and triggered the warning. But just re-doing the second part does not
>> reproduce the bug.
>
> It was probably some other process racing with EXT4_IOC_SWAP_BOOT.
> The patch I referenced in my previous e-mail protects against
> additional scenarios where someone might be trying to punch a whole
> into a file that is being swapped into the bootloader ioctl.  This
> particular ioctl isn't yet being used by anyone, so it had some other
> issues as well, such as not interacting well with inline_data-enabled
> file systems --- not that any bootloader would be small enough that it
> would fit in an inline_data inode, but we're basically proofing the
> code against a malicious (or buggy) root-privileged program... such as
> syzbot.  :-)

... or paving the way to opening all of this to non-root users. Why
not if not bugs? ;)


Back to this bug, I think we should wait to see if it happens more in
future and if syzkaller can come up with a repro. If it won't happen
more (perhaps fixed by your patch), then we will close it as obsolete.
