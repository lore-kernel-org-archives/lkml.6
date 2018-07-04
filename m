Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EFEC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A721532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGRYgK4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A721532
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeGDP17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:27:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42543 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753052AbeGDP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:27:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id v9-v6so2856205pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ejbVkJ/1rZ2S2UUZxGu+Xlkric8KFSKKvOUBosO7JOA=;
        b=mGRYgK4y6IZ5SvxbIid6IUEdZJetSlQQL2LCacd01L64lCu9dwSvSjmJFzBNy8XkX2
         HdZtue24p2byM+Kixrd20PHx6HFgtr9lelhwvgXJD81L2OpV1klABHKS57pRk9uk8ASP
         3UsyB6TCtTM74Wk7jthKXqcCzPR+SRr7eQWq28p93gI+DoPh9go6cjH3AdXYGhYnB4rz
         keZtizosGqOo59P0jJHz/uA7kbeS9pCYh5W12vGdpY3trWzEEyu2i2z4iUcJp7xNB2Hk
         r4T2Xdl9qOklQ9+6Yir3cwf1vwBT2g7MBfwUmTJGc6qkbLZoD+kceC4n+QicdrTUcJ1z
         7lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ejbVkJ/1rZ2S2UUZxGu+Xlkric8KFSKKvOUBosO7JOA=;
        b=clt3n7EXfZ6fFTxTcmWTkEPIYnFRh1qDUcE8LmoIZZ7JMHGvZ1jmyGPYl+44A243fr
         TgU8vsb+4+uf6T5oSgkmwVq8YQtHtqymziRO9ecQeTiaUjpZriXBF+2qyCqBsAPhdTQa
         afW994AcPtk4jpFdS4TZcZ0tTR4fDnf2Df8ZYUdcKE5xRG75xH1kspAOho1PFXy5PJYu
         PzXylYElMWDwa3wvkEYupW5rz8MeigLQexvfJYedtY9SYTQtGRx6EoKkBfJF/tOUQSOt
         VULSOvjplclA03AE39rZJ0xY7yDZrJhqyXXOXHlvTI20xH4eiT4dGm7ujX4Uob5i9EKM
         sKiA==
X-Gm-Message-State: APt69E03TQaf73i59dX8zbQZ9zHzqvJ1IHpZkTtnLmyic+/kr0VAxDCc
        67JhYkI5X65h8rnsGxSWykgZh/36GIW0Fxs5Sbzs5Q==
X-Google-Smtp-Source: AAOMgpckqwEtCM9dZI7EoYHgltgPDT5tfwjrhY1AccLS51O+q33THR1Pc1ok7VPSNcz5Uzubmx/hETVqzUpp3YeNULU=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr2686549pfe.114.1530718076775;
 Wed, 04 Jul 2018 08:27:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Wed, 4 Jul 2018 08:27:36
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1807041718070.1752@nanos.tec.linutronix.de>
References: <000000000000ebc8e405702ddd18@google.com> <alpine.DEB.2.21.1807041718070.1752@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Jul 2018 17:27:36 +0200
Message-ID: <CACT4Y+aOvjaHHmKiKZzZAMqv3NRsXEXcfN3+v7LzrKqWyM1e4Q@mail.gmail.com>
Subject: Re: KASAN: use-after-scope Read in __hrtimer_run_queues
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 5:20 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 4 Jul 2018, syzbot wrote:
>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14339f42400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7f73a81393d3b3777fb0
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: use-after-scope in lookup_object lib/debugobjects.c:157 [inline]
>> BUG: KASAN: use-after-scope in debug_object_deactivate+0x425/0x450
>> lib/debugobjects.c:540
>> Read of size 8 at addr ffff88019d1a5ec0 by task syz-executor3/13445
>
> I don't see how lib/debugobjects.c:157 would be a valid use after scope
> issue. The one in line 540 makes no sense either.

Hi Thomas,

They all don't make sense:
https://groups.google.com/d/msg/syzkaller-bugs/A-S5Rfn5bwQ/dFvmNcmyAAAJ

One of them says "stack overflow", so there seems to be a serious
system corruption that now leads to assorted nonsensical crashes. And
this seems to be a very recent change.
