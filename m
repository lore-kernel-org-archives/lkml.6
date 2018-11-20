Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B65C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F6320831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcOmFyrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F6320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeKTPJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:09:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39134 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730861AbeKTPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:09:56 -0500
Received: by mail-io1-f65.google.com with SMTP id j18-v6so436051iog.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 20:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GbzeFJvaInspakWgcHCF6d1TaV5bqa5EwLQWU/L7S84=;
        b=pcOmFyrLZSP6N6gmyZSXesU7StDyD2Mb+OIRgGGTDMMmODjQzHKkpJH2Vg/nmrTL2m
         Xz4VwPopzN52kfKnpTeLyX5TnUFmg7jFbncIFsvz5WrtpBnAEMurPxSaZ/GG5fwGvMbZ
         /LA8LajTAoT/jD0p6fqHbO3bsFi1nLFj6CMBBVfJkl6nZ5ozX+3ICwZDAzozkVKbWDpi
         ggn7TPQckXrxtBnG9Pgi6CK+ezm8k9xQlLPB6Fmq+iMkZRcjQhlLaZYHTfT12L/oN6CB
         sgqBqbs2EVO4xBY9KDk03zA3TmaeQeyP7ooZeNsRBA5jBBEdC7+qSaZxrDldUnS+hKn0
         87ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GbzeFJvaInspakWgcHCF6d1TaV5bqa5EwLQWU/L7S84=;
        b=FlPWA1hZPyNpfZvvj25hDzUqMTBK+CUlOIT1wNoiRnTVGB5KJ1Dzoj20GgFc2r1Wl0
         A3cDmoDDNcy6+JNJRT5otHrXdTzoeGFA+a++GslhyH34LDt1cRojK48k7RoP32YIHyhZ
         dh+NA6UfRGS0h4lCmlPnZJY47FSCWFDub8rWLbTqpHw2n0ixBwdxOaCiB+1d0OT9y2vO
         6B/eT0HtX1GAQ8rsn+hoN9QK0FXfr95PU8hyOy//vTdQeAT6FP9exgnMxInoKDX3imq9
         cwGCp3mstfn83xIG8VvbsRLg6+ttuiS65nq6xrUJQ55ZZGOT86DcuKHShzSF7eAJUZn4
         Q43g==
X-Gm-Message-State: AA+aEWZHegxG5lLxcMFJOVOGv7dkljraFt37LSQavjpMHKyMd8u67VQK
        epIhDQTr9D/ANtEzSaMrSJwh6zArvnpHIl4DFIaSxw==
X-Google-Smtp-Source: AFSGD/XQaaO9qmFU5njoBhBpVARcWZYr9ey2f9GqPCF8BGq80QWvdloL6yrDuYAUefrjKk37igMizA3Wbt8aP32U8n8=
X-Received: by 2002:a6b:620d:: with SMTP id f13-v6mr372944iog.11.1542688967253;
 Mon, 19 Nov 2018 20:42:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 20:42:26
 -0800 (PST)
In-Reply-To: <20181120041041.GA3398@lerouge>
References: <0000000000007829c8057b0b58ed@google.com> <20181120041041.GA3398@lerouge>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 19 Nov 2018 20:42:26 -0800
Message-ID: <CACT4Y+b1Eq1eXcHJR4tVyn1746pBCNqie8yapuqM3+ry3wJX4g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tick_sched_handle (3)
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     syzbot <syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 8:10 PM, Frederic Weisbecker
<frederic@kernel.org> wrote:
> On Mon, Nov 19, 2018 at 01:39:02PM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    bae4e109837b mlxsw: spectrum: Expose discard counters via ..
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11b5e77b400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
>> dashboard link: https://syzkaller.appspot.com/bug?extid=999bca54de2ee169c021
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7d093400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1487a225400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com
>>
>> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
>> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>> 8021q: adding VLAN 0 to HW filter on device team0
>> ==================================================================
>> kasan: CONFIG_KASAN_INLINE enabled
>> BUG: KASAN: use-after-free in tick_sched_handle+0x16c/0x180
>> kernel/time/tick-sched.c:164
>
> So tick_sched_timer() -> tick_sched_handle() is passed regs returned by
> get_irq_regs() that seem to be junk.
>
> Those regs should come from smp_apic_timer_interrupt().
>
> Thoughts?


Looking at the reproducer it looks like some memory corruption in
networking stack. +netdev
