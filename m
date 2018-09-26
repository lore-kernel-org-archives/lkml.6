Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC34EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3BC214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAJsPmEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3BC214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeI0EKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:10:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37805 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:10:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id a82-v6so441888lfa.4;
        Wed, 26 Sep 2018 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MiH1De9n30DVbZQwsRuRTwEL6Q0ILnQDij6ZU5UsSA=;
        b=FAJsPmEyKlHSRyoBUJmpTt9W6YNdswqnIHpjgLZz+i3vgGRIBXZNt91+T1qrnVXule
         Ai3AgHYs4HyQ6qRqOoExFYBA+c5+lJToqzHzcaYQIm+4RMprxp1WKyiEhky+WIuRA+wG
         14U/4mmokTpikai1dje+CdiZGBYiPFQFEnCCG87eIdQZa/rvTENV769ST01E7qs/xG9w
         nAYnOANgwNrWCJoiwDin4dMQl+vqXJX0ZgjXolwCgng2ftaJ9rEOleJXdoTldp/j4MSc
         NxXQuGLhNVUw1BLH5whjoInluM6hRDc9OHbzOoMW3/Bh+CdSHarkKWsX/1LsRZUWps+D
         eMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MiH1De9n30DVbZQwsRuRTwEL6Q0ILnQDij6ZU5UsSA=;
        b=rP7dkRr25fNG95NBIqOFOe6KIlHvwYYsvZr0XLdLfGgCoPz8H8hHbcBWoSu1zi+3WQ
         a89u6hLde634bIz4T2fdg6vCB8YwsiNPUHNT9cedJPPhrOJc/TSIxy6JVfAndCly0M1V
         UhKcSiUrRCaIgHpMCX5JYRK/PpeGnThCkxMEMMRKhYi01vJUdQmiO9hK0XwQKZJKYaZn
         rs+KjXjTvMv+agdmp5pI9kl0o6m1+qlyid7cIFCV0+cfaoa44xyT35EQv9D/pHl2yhqt
         ys14wkgTmhIxtwGdZnGu2xV2PLOvfgBOkpJjh3clMST++hb9ffW8g84DryVz99nXBb+e
         8WrA==
X-Gm-Message-State: ABuFfohOmj9RI+l3aAgYfM/Kd3HYxDzIq0BFLc3R6VqEOSPxxK8p4q6H
        PTQVdULcWIIO1W30xVM3rM5LbAB70diW527X4lY=
X-Google-Smtp-Source: ACcGV62a7oWrloKHSz/LZoGiVkUTDwXYKz09xAj5mjhI0KC6d2ys9A4Na7n4EG8SczLIHbxdaBrIO8c23W0UlRS+TT8=
X-Received: by 2002:a19:9d8d:: with SMTP id g135-v6mr5185146lfe.3.1537998936518;
 Wed, 26 Sep 2018 14:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000084e2450576c817cc@google.com> <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
 <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com>
In-Reply-To: <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 26 Sep 2018 14:55:24 -0700
Message-ID: <CAM_iQpX4sKSPFXgEjU-be=he=91+=3Bm9KvP3CMciA9zi2b-6g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:50 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 09/26/2018 02:44 PM, Cong Wang wrote:
> > On Wed, Sep 26, 2018 at 8:44 AM syzbot
> > <syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16f763fa400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=37b8770e6d5a8220a039
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5614e400000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a532a400000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
> >>
> >> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> >> 8021q: adding VLAN 0 to HW filter on device team0
> >> ==================================================================
> >> BUG: KASAN: use-after-free in tcf_block_find+0x9d1/0xb90
> >> net/sched/cls_api.c:646
> >> Read of size 4 at addr ffff8801cc126978 by task syz-executor002/5646
> >>
> >> CPU: 1 PID: 5646 Comm: syz-executor002 Not tainted 4.19.0-rc5+ #232
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Call Trace:
> >>   __dump_stack lib/dump_stack.c:77 [inline]
> >>   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> >>   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> >>   kasan_report_error mm/kasan/report.c:354 [inline]
> >>   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> >>   __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
> >>   tcf_block_find+0x9d1/0xb90 net/sched/cls_api.c:646
> >
> > Hmm. looks like missing a rcu_dereference() here:
> >
> >                 if (!*parent) {
> >                         *q = dev->qdisc;
> >                         *parent = (*q)->handle;
> >
>
> We hold RTNL here.
>
> Have we already done the changes allowing dev->qdisc being changed
> without RTNL being required ?

That transition is not completed yet, but holding RTNL doesn't help
any more after we now free qdisc in rcu callback.

More interestingly, rcu read lock is already held in this context,
so it seems we still have to use rcu_deference() to read dev->qdisc
and of course mark it with __rcu too.
