Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55154C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AB9214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbqDgrAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbeLQSqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:46:11 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:38893 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeLQSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:46:11 -0500
Received: by mail-it1-f176.google.com with SMTP id h65so441068ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9U94R06JMJihKEn4ykZFaXUxyjfw6aGK4cSw3eC0y4o=;
        b=NbqDgrATCweKpj7zEAVkWBshpZ48StPBQNujLM0ov1o9AqgriO5eSa4FrtzFsFGIkv
         s04hNC6oqXVKE4oOZUrrLnRXKanhzU4CpaGTCVoKkgXsMdv7IJnWiwJVe4vwkfVavQcj
         RbiGuSZ6YKoFtWGVPsWQhWz/Lw3FiKbs+Y5WRDvXLUQxuxPbX4quuBqYXxFboeGTCuSO
         DDvxnq96I+e7km156KByIr8RKC4WxJIQ9ssB/I9FdMSaRTVZVpcOo0myuXByacYjI8hN
         /sWIdh07rUgTPyfL0EMYfmPl2FXsHOehmxTZubQEJvarJTiVWO5lIKZavc16CtwtCaER
         fnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9U94R06JMJihKEn4ykZFaXUxyjfw6aGK4cSw3eC0y4o=;
        b=NhH5gvfIjPqgZTQr/pXhusN4my+uTHAkNumUkwwZ05pOhhs75hqdpXEcmyAUkgv1OY
         zPWbDzwQHUm0jwmbT9bt6kTd45NghhpAx1YZFzdDUXcemoeUvB/AVwMhqEURgQzXUIbC
         pk6+4PrspdvBMp0KjlU4fkVIvrnYNPd/GLE3XMok/DNA43ZtZUAMCkXJsX4zPntX88Hu
         Eym9Ml6DvyWsir9m4y7Kjb3F+8cF0H8LNQaJ2QSXXXro7+n1npaL7XNfgDjYhtwm8DFK
         IGwCnvIX+8tNo2Ch4jObzpSZ/B1D/H1U5x1cO6MCW46nlvVl71EES6o6/RSeaxykZVaA
         H5rg==
X-Gm-Message-State: AA+aEWYOrQeeqTMTpefRPheJcxFU7hsQLAkmSJjSC7sh/yemF4LA+BgD
        muEZvlBpgONi0pyQVXc0HqQ2rt+rl0OJHtCLCJzSww==
X-Google-Smtp-Source: AFSGD/VzwTIIwGp3SLcgxFaoShLOcanBpQF8Ms4ap0qbrrRPCkxhwGnI7H2fwyFj37xJ6hy79DHK2SFfGCVWEV67V1E=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr243485iti.166.1545072369759;
 Mon, 17 Dec 2018 10:46:09 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
 <20181217112916.GG4170@linux.ibm.com> <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
 <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
 <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com> <20181217162421.6d636ee5@redhat.com>
 <20181217192121.64f34511@redhat.com>
In-Reply-To: <20181217192121.64f34511@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 19:45:58 +0100
Message-ID: <CACT4Y+ZU3F=AyyuNyVia7gT22Z71JKM-K4uap0J-iumF=NjH9A@mail.gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:29 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> Any chance of a bisection?

Better later then never. Bisection also needs testing :)

syz-bisect -config bisect.cfg -crash dda626cdbd87eafe9a755acbbe102e2b6096b256
searching for guilty commit starting from 2aa55dccf83d
building syzkaller on 7624ddd6
testing commit 2aa55dccf83d7ca9f1da59ae005426c44fbeb890 with gcc (GCC) 8.1.0
run #0: crashed: KASAN: slab-out-of-bounds in tick_sched_handle
run #1: crashed: KASAN: slab-out-of-bounds in tick_sched_handle
run #2: crashed: BUG: Bad page map
run #3: crashed: BUG: Bad page map
run #4: crashed: PANIC: double fault in __udp4_lib_err
run #5: crashed: general protection fault in __bfs
run #6: crashed: KASAN: stack-out-of-bounds Read in __handle_mm_fault
run #7: crashed: no output from test machine
testing release v4.19
testing commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d with gcc (GCC) 8.1.0
all runs: OK
# git bisect start 2aa55dccf83d v4.19
Bisecting: 7955 revisions left to test after this (roughly 13 steps)
[f8cab69be0a8a756a7409f6d2bd1e6e96ce46482] Merge tag
'linux-kselftest-4.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
testing commit f8cab69be0a8a756a7409f6d2bd1e6e96ce46482 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good f8cab69be0a8a756a7409f6d2bd1e6e96ce46482
Bisecting: 3957 revisions left to test after this (roughly 12 steps)
[b3491d8430dd25f0a4e00c33d60da22a9bd9d052] Merge tag 'media/v4.20-2'
of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
testing commit b3491d8430dd25f0a4e00c33d60da22a9bd9d052 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good b3491d8430dd25f0a4e00c33d60da22a9bd9d052
Bisecting: 1978 revisions left to test after this (roughly 11 steps)
[40df309e4166c69600968c93846aa0b1821e83f0] octeontx2-af: Support to
enable/disable default MCAM entries
testing commit 40df309e4166c69600968c93846aa0b1821e83f0 with gcc (GCC) 8.1.0
run #0: crashed: general protection fault in __bfs
run #1: crashed: KASAN: stack-out-of-bounds Read in copy_page_range
run #2: crashed: general protection fault in __bfs
run #3: crashed: KASAN: slab-out-of-bounds Read in vma_compute_subtree_gap
run #4: crashed: general protection fault in corrupted
run #5: crashed: general protection fault in corrupted
run #6: crashed: BUG: unable to handle kernel paging request in corrupted
run #7: crashed: KASAN: stack-out-of-bounds Read in inet6_fill_ifla6_attrs
# git bisect bad 40df309e4166c69600968c93846aa0b1821e83f0
Bisecting: 989 revisions left to test after this (roughly 10 steps)
[a13511dfa836c8305a737436eed3ba9a8e74a826] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
testing commit a13511dfa836c8305a737436eed3ba9a8e74a826 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good a13511dfa836c8305a737436eed3ba9a8e74a826
Bisecting: 521 revisions left to test after this (roughly 9 steps)
[9ff01193a20d391e8dbce4403dd5ef87c7eaaca6] Linux 4.20-rc3
testing commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6
Bisecting: 260 revisions left to test after this (roughly 8 steps)
[47e3e53ceadc568c038e457661d836f2259ed774] ice: Destroy scheduler tree
in reset path
testing commit 47e3e53ceadc568c038e457661d836f2259ed774 with gcc (GCC) 8.1.0
run #0: crashed: KASAN: slab-out-of-bounds Read in tick_sched_handle
run #1: crashed: KASAN: stack-out-of-bounds in __fget_light
run #2: crashed: BUG: unable to handle kernel paging request in corrupted
run #3: crashed: KASAN: stack-out-of-bounds in anon_vma_interval_tree_remove
run #4: crashed: general protection fault in __udp4_lib_err
run #5: crashed: KASAN: stack-out-of-bounds Read in free_pgd_range
run #6: crashed: general protection fault in change_protection
run #7: crashed: INFO: trying to register non-static key in corrupted
# git bisect bad 47e3e53ceadc568c038e457661d836f2259ed774
Bisecting: 129 revisions left to test after this (roughly 7 steps)
[52358cb5a310990ea5069f986bdab3620e01181f] Merge branch 's390-qeth-next'
testing commit 52358cb5a310990ea5069f986bdab3620e01181f with gcc (GCC) 8.1.0
run #0: crashed: BUG: unable to handle kernel paging request in corrupted
run #1: crashed: general protection fault in vma_interval_tree_insert
run #2: crashed: KASAN: stack-out-of-bounds Read in __call_rcu
run #3: crashed: BUG: unable to handle kernel paging request in corrupted
run #4: crashed: general protection fault in __bfs
run #5: crashed: BUG: unable to handle kernel paging request in
__cgroup_account_cputime_field
run #6: crashed: WARNING in anon_vma_interval_tree_verify
run #7: crashed: general protection fault in rb_first
# git bisect bad 52358cb5a310990ea5069f986bdab3620e01181f
Bisecting: 65 revisions left to test after this (roughly 6 steps)
[2e7ad56aa54778de863998579fc6b5ff52838571] net/wan/fsl_ucc_hdlc: add BQL support
testing commit 2e7ad56aa54778de863998579fc6b5ff52838571 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good 2e7ad56aa54778de863998579fc6b5ff52838571
Bisecting: 32 revisions left to test after this (roughly 5 steps)
[b592843c6723a850be70bf9618578082f3b73851] net: sched: add an offload
dump helper
testing commit b592843c6723a850be70bf9618578082f3b73851 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good b592843c6723a850be70bf9618578082f3b73851
Bisecting: 16 revisions left to test after this (roughly 4 steps)
[a07966447f39fe43e37d05c9bfc92b1493267a59] geneve: ICMP error lookup handler
testing commit a07966447f39fe43e37d05c9bfc92b1493267a59 with gcc (GCC) 8.1.0
all runs: OK
# git bisect good a07966447f39fe43e37d05c9bfc92b1493267a59
Bisecting: 8 revisions left to test after this (roughly 3 steps)
[04087d9a89bef97998c71c21e3ecfca0cc7c52f3] openvswitch: remove BUG_ON
from get_dpdev
testing commit 04087d9a89bef97998c71c21e3ecfca0cc7c52f3 with gcc (GCC) 8.1.0
run #0: crashed: WARNING: kernel stack regs has bad 'bp' value
run #1: crashed: BUG: unable to handle kernel paging request in corrupted
run #2: crashed: general protection fault in corrupted
run #3: crashed: general protection fault in __bfs
run #4: crashed: general protection fault in corrupted
run #5: crashed: general protection fault in rb_insert_color
run #6: crashed: BUG: corrupted list in __pagevec_lru_add_fn
run #7: crashed: general protection fault in validate_mm
# git bisect bad 04087d9a89bef97998c71c21e3ecfca0cc7c52f3
Bisecting: 3 revisions left to test after this (roughly 2 steps)
[e7cc082455cb49ea937a3ec4ab3d001b0b5f137b] udp: Support for error
handlers of tunnels with arbitrary destination port
testing commit e7cc082455cb49ea937a3ec4ab3d001b0b5f137b with gcc (GCC) 8.1.0
all runs: OK
# git bisect good e7cc082455cb49ea937a3ec4ab3d001b0b5f137b
Bisecting: 1 revision left to test after this (roughly 1 step)
[56fd865f46b894681dd7e7f83761243add7a71a3] selftests: pmtu: Introduce
FoU and GUE PMTU exceptions tests
testing commit 56fd865f46b894681dd7e7f83761243add7a71a3 with gcc (GCC) 8.1.0
run #0: crashed: WARNING in unlink_anon_vmas
run #1: crashed: BUG: unable to handle kernel NULL pointer dereference
in corrupted
run #2: crashed: BUG: unable to handle kernel NULL pointer dereference
in corrupted
run #3: crashed: KASAN: stack-out-of-bounds Read in update_min_vruntime
run #4: crashed: BUG: unable to handle kernel paging request in corrupted
run #5: crashed: PANIC: double fault in corrupted
run #6: crashed: WARNING in unlink_anon_vmas
run #7: crashed: WARNING in unlink_anon_vmas
# git bisect bad 56fd865f46b894681dd7e7f83761243add7a71a3
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e] fou, fou6: ICMP error
handlers for FoU and GUE
testing commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e with gcc (GCC) 8.1.0
run #0: crashed: kernel BUG at include/linux/swapops.h:LINE!
run #1: crashed: general protection fault in __bfs
run #2: crashed: INFO: trying to register non-static key in corrupted
run #3: crashed: lost connection to test machine
run #4: crashed: BUG: unable to handle kernel NULL pointer dereference
in corrupted
run #5: crashed: kernel BUG at include/linux/swapops.h:LINE!
run #6: crashed: no output from test machine
run #7: crashed: lost connection to test machine
# git bisect bad b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e is the first bad commit
commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Nov 8 12:19:23 2018 +0100

    fou, fou6: ICMP error handlers for FoU and GUE

    As the destination port in FoU and GUE receiving sockets doesn't
    necessarily match the remote destination port, we can't associate errors
    to the encapsulating tunnels with a socket lookup -- we need to blindly
    try them instead. This means we don't even know if we are handling errors
    for FoU or GUE without digging into the packets.

    Hence, implement a single handler for both, one for IPv4 and one for IPv6,
    that will check whether the packet that generated the ICMP error used a
    direct IP encapsulation or if it had a GUE header, and send the error to
    the matching protocol handler, if any.

    Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
    Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 cabdcb7779c24a357486aae139cb31cdd625bc53
6bc9db712d9698330234b7c8c934dcfc71cfb657 M net
revisions tested: 16, total time: 3h25m25.893971693s (build:
1h23m29.053198068s, test: 1h59m23.409063298s)
first bad commit: b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e fou, fou6:
ICMP error handlers for FoU and GUE
cc: ["sbrivio@redhat.com" "sd@queasysnail.net"]
