Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D16ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhlE06JY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B7A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:07:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37811 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:07:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so1887947eds.4;
        Tue, 17 Jul 2018 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kZnsFSKyy62tixi+alSRUAS2tH0NGxOiK1XPu0Z9gY=;
        b=JhlE06JYvogXXsE9AB2eIlICUBaw/OlHDabfM9zz//sj6j/jPi6yg1zDvG9BT5EF3r
         ZaYIS0fYMX6Djh6QfzRiXzlqrsyPMTbZVVq9OZAst5gxuoI16Ax5zMNEgZpM6Qgi+JiC
         fMb2sZ7u+wiMkLTP4Z+vUcwtz8Y7TNnCs+bEi6O4H9jK+z7LhgsglTGzeHEso6TREmCY
         yM9ylqlFExYeENxknNwAqlJnZIy6iect6IP2hzqS4TXltLOWVsYj46m+US67NvQLQlJh
         Z/Zp4gy5ENgwlhOogyJOUSOrOGRi3RO+MXkG77/MTCdIHL6x6V9HqsoD2AcyT5Rce946
         CwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kZnsFSKyy62tixi+alSRUAS2tH0NGxOiK1XPu0Z9gY=;
        b=bGZMqgDX83JNSpwDXURz9OsC0pJNzUhhjPVBpzzYOzqgrRPwZMuWyRz6kSLkQfNfIk
         fZjEAZbCn9Bd2otSTAhhLgvK+4bzDoGtnmTB1onfyX55hQCR0Pk5BtcihWN85futMtZx
         7x0Y6CUFnSWOn+b+HlyrjDqPZuB6hR7Yg57fN83+ilupZybytNeG4L8DNlri/ZsE8iqn
         72pPsmk4OP32jvL9v0CnVttLir3ELGIDTJjobN+bBii3C+tfsyroSs9EVePP2DCz1dWZ
         Il70ar4kCl8iW5cC/OdmL/tCnN0Mh1NLhHxKb3oY9sYuBqofAsck+RrVtuxOSLRAetCh
         jKww==
X-Gm-Message-State: AOUpUlGLuqob/XHq6C1VGBeiBGhRJIyYSI93X/zIZgLqOhPycuj1Lm2E
        B/jQIS9VduHpoWkYbet64KYeBS5nz3QOlvE3NT0=
X-Google-Smtp-Source: AAOMgpf6KAMov7ApJc0gH7CupP7uuj6L4Q0Alb3/v8RTMmlh69KlIihddIuiN3KrPRSy0xTHAMe2JdQLnSKs7C+cJtk=
X-Received: by 2002:a50:d7cb:: with SMTP id m11-v6mr3519434edj.19.1531848810716;
 Tue, 17 Jul 2018 10:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000076e6dc057131d87c@google.com>
In-Reply-To: <00000000000076e6dc057131d87c@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 17 Jul 2018 10:32:53 -0700
Message-ID: <CAF=yD-L0G2VC2-sCgsUmX=qmj5ukq6HS7Td1LDWitJkEUYdkHA@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in put_cmsg
To:     syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:25 AM syzbot
<syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kmsa..
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=166dafa0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9adb4b567003cac781f0
> compiler:       clang version 7.0.0 (trunk 334104)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=164e4ab0400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a41e40400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9adb4b567003cac781f0@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KMSAN: kernel-infoleak in copy_to_user include/linux/uaccess.h:184
> [inline]
> BUG: KMSAN: kernel-infoleak in put_cmsg+0x5ef/0x860 net/core/scm.c:242
> CPU: 0 PID: 4501 Comm: syz-executor128 Not tainted 4.17.0+ #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>   kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
>   kmsan_internal_check_memory+0x138/0x1f0 mm/kmsan/kmsan.c:1219
>   kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1261
>   copy_to_user include/linux/uaccess.h:184 [inline]
>   put_cmsg+0x5ef/0x860 net/core/scm.c:242
>   ip6_datagram_recv_specific_ctl+0x1cf3/0x1eb0 net/ipv6/datagram.c:719

> Bytes 2-3 of 24 are uninitialized
> Memory access starts at ffff8801bde1f8a8

This socket requests IPV6_ORIGDSTADDR.

According to

  > Uninit was stored to memory at:
  >   ip6_datagram_recv_specific_ctl+0x1c3e/0x1eb0 net/ipv6/datagram.c:713
  >   ip6_datagram_recv_ctl+0x41c/0x450 net/ipv6/datagram.c:733

It is reading two uninitialized bytes at line

                        sin6.sin6_port = ports[1];

But this access is after the check

                __be16 *ports = (__be16 *) skb_transport_header(skb);

                if (skb_transport_offset(skb) + 4 <= (int)skb->len) {

and the sent packet is 725B.

The socket was opened with SOCK_RAW and protocol NEXTHDR_DEST.

  r0 = socket$inet6(0xa, 0x3, 0x3c)

so this is not a normal packet. Need to take a look at the contents.
