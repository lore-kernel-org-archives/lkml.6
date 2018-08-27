Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5644A208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qN1rxIq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5644A208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeH0SMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:12:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41284 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0SMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:12:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so6946406pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=77Hg5SAXBbLnn128ZLaXgNQPCrX2iC248IWI1ACyDPs=;
        b=qN1rxIq6J6Nm8d5Qesm/pygLyjJuIK6fwDJ/LPQ33LuNMGQSX/x0F4huNPNUmeyyDK
         H3AGplC49LBHyc1MLiRG0hZoBLQ3em7GdBUFvi0Zkx7XtHFr1dnluZowTPQY34jo9diE
         i/pEvy9MRKFWuYk/dhHGUNrv/V/VXSjw7P2m3x79EhXB0WLHKXiVv5hemOQDEjO80j7w
         ++aqUKHFQ+tnsXTH1AFbqAi7h4EDa5vX7tLUQws8aEzpKjc3V1PT17sCraGlP86Tv09K
         +3aNSXyEDIpxw0sMahyMAwTPQWsmznHBwBBAoCoJNaClbV9diQOlf+GRGuhbsNtPdLMF
         Q8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=77Hg5SAXBbLnn128ZLaXgNQPCrX2iC248IWI1ACyDPs=;
        b=ssRXu5sPIOWNX037MNC08EqnvW+XTUs0vMYrewfuBZ3VOEwoE7SKvHVd47siIPcNyc
         a4yDFUJCaVnoCLqIgJbOmPLFBmafQ6d9L3tUNBQmmljQEDqyCNyfunLsfU61EZWssjZH
         MBWzqYxpg9bUnwxFIUFz6FDHv5K3nZ/2RGIxbP2uD9+GlM8XXThszZDBAm2pcm7bDrN4
         QuyOKyqWPxKY/5x8I3M9mWhK/+IVDWHVv5ayinwqCG+C28Iux1PHYW0wDY/dBvDhmq66
         JdqlX/Lf68Ms1mdn+XJGpl5JN4W7k9Kynu6QuRkV75D5US4C+/xDpBpCs+DMxxNkG5Tw
         Mfqg==
X-Gm-Message-State: APzg51Bsi8iw7gEp+sTcAVbDSJJBZHGSyZpJxS4hBhr4C2VJ+NlmoH0T
        V77om8YB9ub53AaTk2EHYP7FyYJbHNqQ0zIldBlWPQ==
X-Google-Smtp-Source: ANB0VdY75ZVBjkdmplkcyy9nKGhOOLC6dXwVSTk+SG6+52QJVPwI+YqO8N/SthQYfpoSvC0JAUaE3vFFCyGsmnngoLk=
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr14872271pfi.147.1535379938595;
 Mon, 27 Aug 2018 07:25:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 27 Aug 2018 07:25:18
 -0700 (PDT)
In-Reply-To: <20180827052412.GA26294@nautica>
References: <000000000000af648b057456e234@google.com> <20180827052412.GA26294@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Aug 2018 07:25:18 -0700
Message-ID: <CACT4Y+b1B5_Eg+j91GxaVbPk5sb8+SVOU_z5k9HYb4R716X9kQ@mail.gmail.com>
Subject: Re: KASAN: invalid-free in p9stat_free
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzbot <syzbot+d4252148d198410b864f@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 10:24 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> syzbot wrote on Sun, Aug 26, 2018:
>> HEAD commit:    e27bc174c9c6 Add linux-next specific files for 20180824
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15dc19a6400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=28446088176757ea
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d4252148d198410b864f
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f8efba400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1178256a400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> ==================================================================
>> BUG: KASAN: double-free or invalid-free in p9stat_free+0x35/0x100
>> net/9p/protocol.c:48
>
> That looks straight-forward enough, p9pdu_vreadf does p9stat_free on
> error then v9fs_dir_readdir does the same ; there is nothing else that
> could return an error without going through the first free so we could
> just remove the later one...
>
> There are a couple other users of the 'S' pdu read (that reads the stat
> struct and frees it on error), so it's probably best to keep the current
> behaviour as far as this is concerned, what we could do though is make
> the free function idempotent (write NULLs in the freed fields), but I do
> not see this being done often, do you know what the policy is about
> this kind of pattern nowadays?


Hi Dominique,

kfree and then null pointer is pretty common, try to run:

find -name "*.c" -exec grep -A 1 "kfree(" {} \; | grep -B 1 " = NULL;"

Leaving dangling pointers behind is not the best idea.
And from what I remember a bunch of similar double frees were fixed by
nulling the pointer after the first kfree.


> The struct is cleanly zeroed before being read so there is no risk of
> double-frees between iterations so zeroing pointers is not strictly
> required, but it does make things safer in general.
