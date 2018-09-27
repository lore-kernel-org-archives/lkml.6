Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93024C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB342157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNZJ0i9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB342157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeI0O2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:28:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53891 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeI0O2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:28:06 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so6777866itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D7kwNcenCSZhT5ZWHIEghlJsqdfrreH5mIlMNeDqPGg=;
        b=nNZJ0i9MFIGW7Ynhtqy1z4fLDGyNC7GDJV6+PQYNx3PVtqKh0UWluQc6OVBfDFLvh0
         /vyTw1KSBqkZs7udjXHgHWxUM2AgW4xP61J9AuX6G7qFTa6o6nAiR6SBV9Cz4NiwKtaf
         lPPxOz78K8x65WpCGMRN+7SgiZfC25Cpr6W6QDIS1oHjQCxbrhSF72P+M0h+jrq2Ld6C
         pXxXFnqeiXwQySrzqv8kyo8paSYsu4cEWz9E0J7j7yUerhyQ0GUqspxRJpAtqPesB0+A
         vrFJL0ee/tOIC/gLUpv51Em1NkxV4SCPQkQBOvEWDG7iNfuSZS3eg8DmRi18eXtcANRd
         ArSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D7kwNcenCSZhT5ZWHIEghlJsqdfrreH5mIlMNeDqPGg=;
        b=j/UYdGt0sJXj1Xo3B3F7iEPWqlHJ2oqHRVo3qxEinWMB5eLK+LcJ7K85oGrY6U3nrq
         pRjSGWmO69CoglNYXYWIBFNF3Or4tN56bWOknXtfRP/Pu7JejkjJOgaHQzugAYe6zJ7p
         chWKyPyaiezrkuivVu1ylSBb+SxaqQU0CY9V9wkhN9/VrB0VOHar9vY5mB3XZ4qI4u1E
         WJW34c9lzFMa/XtpMJLx7spNt8TQK2fjDKgHxcfj1dNF+52zsM4JX6betjtTLb4E7mf1
         50udLrTCXjwp2h07zgb8oLDV90TAUzjLUYHyiuTmKfgOmvlZ+3RwU8SmCzaeqjcsSg0m
         QqxA==
X-Gm-Message-State: ABuFfoj+ENZQejGZRJLPv/TA6C3Od2owLzRDBOH/08+kqPD9X6EEtG3B
        Gvpqf5sStvnx8QITX48eLcjEj6eEmjVvrSA+lxn3kw==
X-Google-Smtp-Source: ACcGV60gL0CUXb0+Vo/uK9cmQQNOxHEO2q3mU0bQvA3ft4YQ0T4cioppXOId61uSfq3B31mBhLrYYletkg1ziXcyeMM=
X-Received: by 2002:a02:c04e:: with SMTP id u14-v6mr4250095jam.110.1538035865774;
 Thu, 27 Sep 2018 01:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 01:10:45
 -0700 (PDT)
In-Reply-To: <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com> <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
 <CACT4Y+YbfOYDHJjeK-88wQDg2oSF3fqsaWBhkDwnDr+KUsLnDA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 10:10:45 +0200
Message-ID: <CACT4Y+YbQbZ7XTPK1HLvPiR9rmSm7Cz0H2LJAFfYfAta1Y3CiQ@mail.gmail.com>
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

On Thu, Sep 27, 2018 at 10:06 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Sep 26, 2018 at 11:55 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>> >> Hello,
>>> >>
>>> >> syzbot found the following crash on:
>>> >>
>>> >> HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
>>> >> git tree:       net-next
>>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16f763fa400000
>>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
>>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=37b8770e6d5a8220a039
>>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5614e400000
>>> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a532a400000
>>> >>
>>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> >> Reported-by: syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
>>> >>
>>> >> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>>> >> 8021q: adding VLAN 0 to HW filter on device team0
>>> >> ==================================================================
>>> >> BUG: KASAN: use-after-free in tcf_block_find+0x9d1/0xb90
>>> >> net/sched/cls_api.c:646
>>> >> Read of size 4 at addr ffff8801cc126978 by task syz-executor002/5646
>>> >>
>>> >> CPU: 1 PID: 5646 Comm: syz-executor002 Not tainted 4.19.0-rc5+ #232
>>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> >> Google 01/01/2011
>>> >> Call Trace:
>>> >>   __dump_stack lib/dump_stack.c:77 [inline]
>>> >>   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>> >>   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>>> >>   kasan_report_error mm/kasan/report.c:354 [inline]
>>> >>   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>> >>   __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>>> >>   tcf_block_find+0x9d1/0xb90 net/sched/cls_api.c:646
>>> >
>>> > Hmm. looks like missing a rcu_dereference() here:
>>> >
>>> >                 if (!*parent) {
>>> >                         *q = dev->qdisc;
>>> >                         *parent = (*q)->handle;
>>> >
>>>
>>> We hold RTNL here.
>>>
>>> Have we already done the changes allowing dev->qdisc being changed
>>> without RTNL being required ?
>>
>> That transition is not completed yet, but holding RTNL doesn't help
>> any more after we now free qdisc in rcu callback.
>>
>> More interestingly, rcu read lock is already held in this context,
>> so it seems we still have to use rcu_deference() to read dev->qdisc
>> and of course mark it with __rcu too.
>
> On hardware level rcu_deference() only affects Alpha. On software
> level, it can affect all archs due to e.g. a re-read of the variable.
> Do we see the potential for compilation that would lead to the UAF
> here? A missed rcu_deference() would not be the first thing that I
> would suspect for UAF on x86. It's more likely some bolder bug.


Would a stack trace for call_rcu be helpful here? I have this idea for
a long time, but never get around to implementing it:
https://bugzilla.kernel.org/show_bug.cgi?id=198437

Also FWIW I recently used the following hack for another net bug. It
made that other bug involving call_rcu way more likely to fire. Maybe
it will be helpful here too.

diff --git a/net/core/dst.c b/net/core/dst.c
index 81ccf20e28265..591a8d0aca545 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -187,8 +187,16 @@ void dst_release(struct dst_entry *dst)
                if (unlikely(newrefcnt < 0))
                        net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
                                             __func__, dst, newrefcnt);
-               if (!newrefcnt)
-                       call_rcu(&dst->rcu_head, dst_destroy_rcu);
+               if (!newrefcnt) {
+                       if (lock_is_held(&rcu_bh_lock_map) ||
+                               lock_is_held(&rcu_lock_map) ||
+                               lock_is_held(&rcu_sched_lock_map)) {
+                               call_rcu(&dst->rcu_head, dst_destroy_rcu);
+                       } else {
+                               synchronize_rcu();
+                               dst_destroy_rcu(&dst->rcu_head);
+                       }
+               }
        }
 }
