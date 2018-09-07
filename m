Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E481620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkMKiCKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E481620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeIHAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:40:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44042 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIHAkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:40:11 -0400
Received: by mail-yb1-f195.google.com with SMTP id l16-v6so5868862ybk.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pEggwKTaQq3xsBZC2zDMBcXR0XKQEFti6lmE8Z5B540=;
        b=FkMKiCKTUj1n2mTF6LyCvt3zehlw0DwRZHu4U+ogYxdKq3Tqd5Ymi55VuKR9mUYEBZ
         5D6UGkxiCNVucqpx1GOenZ7HeInOYGVAzpe9DIQxnfmOaK90IN91I3jXW2SyNl5LEgBN
         PusHB/MTbM8HpvU8TI/W+ar96b8Gaptyq4peqhfBkIPpEcS/wC27XQGhOixmEMDXKJOG
         Gx2U1gv4AfDYkX97G9+cTFJcJYMfo02Arz9P+5SZnQEp66yhn6hrxb5TAaXOUwU+KF1x
         wJANKdD/XGBS/wqiFEZd7NTkaRHxZf2l4ZhX8lyZgGXv6eo4pwKuhvQb5Ocjxkiu5OFs
         NBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pEggwKTaQq3xsBZC2zDMBcXR0XKQEFti6lmE8Z5B540=;
        b=OeGRpyIAt24+MKQTaZoJ7NcXNlAlF+EdZxT1HI8RCn0TlBDWK9wRW8/G9by53Q2/T1
         iuehfU4VXkPD4xOeWXHUz5N54g1hIsJCUkQ/ACGxjCMQZ4sqisFf829bxSE5DqHdT9BQ
         DnzYve96EymzvCS73hvx9aC+BtTzPnOelUEmUOG7VrM0af90v/2h3jcQGuhxklDtfUPT
         HlaqH7yMmFHRvI0tK6qagRGCoydS3k/1Nc14BjbZZHUDcggZytFZpNr8VGQowgLEqLWj
         bJ5FyejKpG+Gt8rB3C/bGZxiCeEQ6B0lrax849B5pmS6xw4j6UmfTbHIQk9prKCUTlND
         WxfA==
X-Gm-Message-State: APzg51CqZuIyo6PmeqP+rw0wx/CihTbQzD4Ecb6VZ3kanoz+7Uk9sgJx
        Z4xVHBCz2+jwY14xOARsRy7a9f0/Msaf6NXQ7eo25Q==
X-Google-Smtp-Source: ANB0VdbwLc96cYGRcw97iZCcjQO6khlJTE8gK3jkBhf4CosPIYd5jJNp/k6iI7AShPK8FwrW0NdL2hd7or/NMtRr9aw=
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr5005559ybd.141.1536350262143;
 Fri, 07 Sep 2018 12:57:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 12:57:41 -0700 (PDT)
In-Reply-To: <14d5bccf-f12d-0fc1-eddc-9fb24dc0cf14@I-love.SAKURA.ne.jp>
References: <000000000000e16cba057549aab6@google.com> <14d5bccf-f12d-0fc1-eddc-9fb24dc0cf14@I-love.SAKURA.ne.jp>
From:   Kees Cook <keescook@google.com>
Date:   Fri, 7 Sep 2018 12:57:41 -0700
Message-ID: <CAGXu5jLLYCGnN66UNeYqcPCPN4EAb=PzGLuQj4-UZr_A0AHp-g@mail.gmail.com>
Subject: Re: BUG: bad usercopy in __check_object_size (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Fri, Sep 7, 2018 at 9:17 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/08 0:29, syzbot wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       bpf
>> console output: https://syzkaller.appspot.com/x/log.txt?x=124e64d1400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=62e9b447c16085cf
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a3c9d2673837ccc0f22b
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f9cd1400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b3e8be400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+a3c9d2673837ccc0f22b@syzkaller.appspotmail.com
>>
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x440479
>> usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 64)!
>
> Kees, is this because check_page_span() is failing to allow on-stack variable
>
>    u8 opcodes[OPCODE_BUFSIZE];
>
> which by chance crossed PAGE_SIZE boundary?

There are a lot of failure conditions for the PAGESPAN check. This
might be one (and one that I'm hoping to solve separately).

-Kees

-- 
Kees Cook
Pixel Security
