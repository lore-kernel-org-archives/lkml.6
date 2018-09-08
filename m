Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0641C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CDC2086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0eRBcJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CDC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeIHUBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 16:01:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45072 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 16:01:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so7843019pll.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xNnKeX8f4L8LXFMMf6fbKC8tV2kOss2XzDq+uAEAtrQ=;
        b=f0eRBcJGkYAaOik4lbxyFgA0liYjNpf46BGiDn+6LHIbQ3KTQC+3bGn6nA5AWtoA34
         YNxQPIzQv1nbSOkQXWSv10RobecyzbawYKC4BXalrYj9cdMJQmSkSrzF6K5EHbvM7OD4
         AGrCccr5EV0yW6iNJ+WzkzcJFwDwNnLts1yrFXEGpC747+QbuVHmkkyETlks0kK7/UNi
         cNDfeeCvc6ZeUI28dYbDP36kCEdoZcjZEO6RcFn51yQeUJ/kP9nRBUFLf+rxJqWJ9n9E
         s8cCTGPiJ7i50Ze5R4aF2jxTTkTHX7hjY/AXVW4x2q8MdMjY26/7jh8lci08O+DtaB7d
         pLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xNnKeX8f4L8LXFMMf6fbKC8tV2kOss2XzDq+uAEAtrQ=;
        b=dRfp248AYSLgtr21OAM7S8fE5Bf6/m0WArLUrToZdYWEZb3KJQKId3S44hJpGAU/7o
         vZyzGvulo547ovWMHN+JH1LlwCyZywmsePQEMRt9dLxMqJ9LlZrGRdIht8HAzQBpr2bF
         CAJVEFvpuFWqEsnp0QAjj/knWKdmSvEIIOKEtPRulwiLrct3HScWx1l53A8SsKBUUAQf
         XqdHgKv0zGIOKQEjS+wMer/xVDRx1Sp34e1KLV0RRKKoHri4D7he8thcSKbfSgLfxwB6
         dinUOcpRe0QM00+XVERlSOdhUGAcfgFN6xhJxNd9KMq6Yhl/I6SCRYHvIEYc7wQenE0/
         QuGQ==
X-Gm-Message-State: APzg51BwvM0eluDunlNXb0bW3P8yVxEVS00y1cejncoGfYJrZt/I9Etc
        qm80JWZIm5ge8VIYay4OJx2CL+0miuU2SAsrfJtrNA==
X-Google-Smtp-Source: ANB0VdbZ7gl3at25YMba+dhVdeM3n096ncS/zQ217LxkTLYaUhHljJfitAqffQtC+qHt6MYQyKyM1CMFmYlbtJ005tw=
X-Received: by 2002:a17:902:bf46:: with SMTP id u6-v6mr13247937pls.85.1536419724874;
 Sat, 08 Sep 2018 08:15:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Sat, 8 Sep 2018 08:15:03
 -0700 (PDT)
In-Reply-To: <CAGXu5jLLYCGnN66UNeYqcPCPN4EAb=PzGLuQj4-UZr_A0AHp-g@mail.gmail.com>
References: <000000000000e16cba057549aab6@google.com> <14d5bccf-f12d-0fc1-eddc-9fb24dc0cf14@I-love.SAKURA.ne.jp>
 <CAGXu5jLLYCGnN66UNeYqcPCPN4EAb=PzGLuQj4-UZr_A0AHp-g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 8 Sep 2018 17:15:03 +0200
Message-ID: <CACT4Y+Y5J_i1CpV3d5MFH0jZCqKyOTzaP8uDQ0CH3HD33m+UZA@mail.gmail.com>
Subject: Re: BUG: bad usercopy in __check_object_size (2)
To:     Kees Cook <keescook@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 9:57 PM, Kees Cook <keescook@google.com> wrote:
> On Fri, Sep 7, 2018 at 9:17 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2018/09/08 0:29, syzbot wrote:
>>> syzbot has found a reproducer for the following crash on:
>>>
>>> HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
>>> git tree:       bpf
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=124e64d1400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a3c9d2673837ccc0f22b
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f9cd1400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b3e8be400000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com
>>>
>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> RIP: 0033:0x440479
>>> usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 64)!
>>
>> Kees, is this because check_page_span() is failing to allow on-stack variable
>>
>>    u8 opcodes[OPCODE_BUFSIZE];
>>
>> which by chance crossed PAGE_SIZE boundary?
>
> There are a lot of failure conditions for the PAGESPAN check. This
> might be one (and one that I'm hoping to solve separately).

Disabled CONFIG_HARDENED_USERCOPY_PAGESPAN on syzbot:
https://github.com/google/syzkaller/commit/be20da425029ecd45b18e99fa5f09691ba0658ea

#syz invalid
