Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D5BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48162156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMBPDU5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48162156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeI0OYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:24:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35393 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0OYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:24:04 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so1317178iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=btzRT687kjJvDLX0iNSz9daC/2A68USvFXsJfs4dxko=;
        b=ZMBPDU5q0wsMQFDUX2Ka8V74sdx83Y3O8+XyLgIAkL8xKl4DuZRqqU+9jrz5FYov+S
         +6ycWt3O06CWUyctB3n1fEQqR+uKWR1cXturW5yiYJoaE9gonuxwN7gtBgLyBwzLlvge
         Udr/DofmGaXJOK6+1VYe7hf+PVTq93mqp/wxwIEplbrRFoKnT6HVhD6bN3+94u1YpHpZ
         xiMxGgWqb+kH02c+d4Gfu/ZHhXxwYoppCSXaWdXu3KkUD2lyonMwwueTg6opKmt/jnY3
         t/S1tQlrMhheuW5P3fALdFQM/T0CHkrJY15sejSb4Sqs5FZQDYpj6av1+CXnvnZ3H28q
         UenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=btzRT687kjJvDLX0iNSz9daC/2A68USvFXsJfs4dxko=;
        b=ZFMzMMsOM8Tycf2kEIek/UMuQ66oBu1sM++AGXQGmBnBHYxpGZm6qIJTLSjhQJNoPa
         NhiABOneHEJvRWYJTow+Eq0HKOflDuYT5wFCHTn1g0HUGNOPPM+w0107pgIDqsoVDq34
         3V/Rl1RGESQ8tFYJBj+2D9BR4b7GYtszWrZDkI9F1IvZ/TGcxnHE/VgNuBl+JMk8Em4l
         2y8N8+47FwLIOVHGFa6DafID3ZyLd/fnJMF1v45VA9hMvDbtyw4nQAOli9TQfDWEBZf7
         HVpA4a7vz9qzGXhQF3KqJ7JRpsGul5gKdRS6U+1Aneet/b0By6OBVBokJnynwEw/2++I
         yoeA==
X-Gm-Message-State: ABuFfojHO1eRE+X0xicmqqcXTejK+kJTmvCN64oW+QInZMzcRfA+s77f
        ngiQAHe7WGUK/c+Lq/HnOJglaVsxb5q875uRQcY17Q==
X-Google-Smtp-Source: ACcGV605YYLLDyOyI6MvUGijyyI2sY6q0XchubyAbX53XwyC5eFUOEe7Ydbzm2tNu+xYjJciq9glObwhYtLzuoljeoA=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr7382529ioe.282.1538035624842;
 Thu, 27 Sep 2018 01:07:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 01:06:44
 -0700 (PDT)
In-Reply-To: <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com> <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 10:06:44 +0200
Message-ID: <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:55 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>> >> Hello,
>> >>
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
>> >> git tree:       net-next
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16f763fa400000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=37b8770e6d5a8220a039
>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5614e400000
>> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a532a400000
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
>> >>
>> >> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>> >> 8021q: adding VLAN 0 to HW filter on device team0
>> >> ==================================================================
>> >> BUG: KASAN: use-after-free in tcf_block_find+0x9d1/0xb90
>> >> net/sched/cls_api.c:646
>> >> Read of size 4 at addr ffff8801cc126978 by task syz-executor002/5646
>> >>
>> >> CPU: 1 PID: 5646 Comm: syz-executor002 Not tainted 4.19.0-rc5+ #232
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> >> Google 01/01/2011
>> >> Call Trace:
>> >>   __dump_stack lib/dump_stack.c:77 [inline]
>> >>   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>> >>   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>> >>   kasan_report_error mm/kasan/report.c:354 [inline]
>> >>   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>> >>   __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>> >>   tcf_block_find+0x9d1/0xb90 net/sched/cls_api.c:646
>> >
>> > Hmm. looks like missing a rcu_dereference() here:
>> >
>> >                 if (!*parent) {
>> >                         *q = dev->qdisc;
>> >                         *parent = (*q)->handle;
>> >
>>
>> We hold RTNL here.
>>
>> Have we already done the changes allowing dev->qdisc being changed
>> without RTNL being required ?
>
> That transition is not completed yet, but holding RTNL doesn't help
> any more after we now free qdisc in rcu callback.
>
> More interestingly, rcu read lock is already held in this context,
> so it seems we still have to use rcu_deference() to read dev->qdisc
> and of course mark it with __rcu too.

On hardware level rcu_deference() only affects Alpha. On software
level, it can affect all archs due to e.g. a re-read of the variable.
Do we see the potential for compilation that would lead to the UAF
here? A missed rcu_deference() would not be the first thing that I
would suspect for UAF on x86. It's more likely some bolder bug.
