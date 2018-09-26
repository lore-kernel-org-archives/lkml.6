Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CD1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8058C21565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2rTsqTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8058C21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0D77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:59:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38418 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0D77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:59:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so416145lfl.5;
        Wed, 26 Sep 2018 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK4u1Vil0+G+ym8hmhP/B2chtzkpNfwFxP5B6qLHGUg=;
        b=O2rTsqTvPc2qinJ+LYZb/E7UF2HWqriwLzX0YdJT9L45gQGMoaoXhi3jhyTyQUC84E
         s6P7ACKHGSnHUi/yokNd77eLcjlqPQL/3JeSDPjT9igOtd2Beq+5D9gkcqMKf6o76UFL
         2LVP1XbMeUcbQ0F7u06bFly4UO/bbZoAmkLbR1S+YUlDBXmlBufwKxM9v67WRVMGEpCg
         LJKwl8Ukp2+wjrKYvsr0koc9XjGtpIMZ+liEjvf5wEgvUmSJojs054E71wXRUcbHsB4F
         lt/xbzSZAmPgxonbDrba7VSRgTN8aBlgotUOBLN5323d/JEfp9tAyv/nuuaO64QhdTI5
         W2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK4u1Vil0+G+ym8hmhP/B2chtzkpNfwFxP5B6qLHGUg=;
        b=Qa1aQ4r5dC9M1Wsn9PHs+sLIkMpL0II/+ZD4Od+PWMUdGe8e0kzDOCySnbN4loJ3Xr
         VMe3a8aL9v97dKqK2BPpzWNucd7Gtb3jZK9P7RJ++t3PCVmD7oiwosUVAmD8jjFG8CGN
         Ran9UAR389koK/nypNCqY35or/6J5OnhbepDHmsd+weGbM6yMG0nKsdkC0ArmMPP0y6s
         C2sU2opUF418RFOjjY+U3LSrLfCgYqOtqP1VVOJ1L7ZPmAgLc+rCxq4ED1yN3Few9aNd
         Uh9o3ckB0Rjx/T0n22DHLWKwF5N1UE4IURCP3Wd/EFGd+ahRLYrBsFKRPJ5TR7Oxy3a7
         nmFg==
X-Gm-Message-State: ABuFfoitBnNGN9fBZNzRkTY0+4fFWtmh5tW8mlCSKM/RtSIFnGaDcfB6
        qG4cWbHWtrFQNqHBGTMTC/JichnvmOvJu3bdK+M=
X-Google-Smtp-Source: ACcGV620isRtpn8uXemTMe7aGQsSf0PdX75twtg6cWLdJfeSanuVsehg6jQ38cPFomYEP9EPvBadhlNXZyeP+BzQVxQ=
X-Received: by 2002:a19:1447:: with SMTP id k68-v6mr5898444lfi.4.1537998299344;
 Wed, 26 Sep 2018 14:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000084e2450576c817cc@google.com>
In-Reply-To: <00000000000084e2450576c817cc@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 26 Sep 2018 14:44:46 -0700
Message-ID: <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
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

On Wed, Sep 26, 2018 at 8:44 AM syzbot
<syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f763fa400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
> dashboard link: https://syzkaller.appspot.com/bug?extid=37b8770e6d5a8220a039
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5614e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a532a400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: use-after-free in tcf_block_find+0x9d1/0xb90
> net/sched/cls_api.c:646
> Read of size 4 at addr ffff8801cc126978 by task syz-executor002/5646
>
> CPU: 1 PID: 5646 Comm: syz-executor002 Not tainted 4.19.0-rc5+ #232
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>   __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>   tcf_block_find+0x9d1/0xb90 net/sched/cls_api.c:646

Hmm. looks like missing a rcu_dereference() here:

                if (!*parent) {
                        *q = dev->qdisc;
                        *parent = (*q)->handle;
