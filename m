Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7FDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7CE2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgITvha8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7CE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbeIFWDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:03:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35365 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIFWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:03:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so5626878pfh.2;
        Thu, 06 Sep 2018 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LPofWpVcjy7TOwslNdix0khWnL3kLOtjr/xoTMpy/lA=;
        b=RgITvha87yN0QIlm5qynsUmi3v3Ed4H9onsIR/w0xVu2WBvyOOPxmW3EU15tLDvRbb
         CRlWp+DlEHMWt4aGCohs5UWbK/WIer/u69FzgeiCSmBBrmLtBk8zce7oRI2QmW4ZYN2q
         xFoIA8jzZ5AJi6Px7qmuenB5ZBa2eTDeK3++1OAjUEt4RxwCc0FdUDkc2NeyRx/gFTui
         8T3sy7FL4J9pwgs8RoMPhkP4CSwuUq24onFAu2pEiGu1fAnP6AOVU/I5wqe+9yNEDFrw
         ggxXGTKDe3A6w/89ulzyD5g9AFC9ouUIaTRJf+h06LOp1wgwFYhZvbDvg7S0OPKIBtM1
         NSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LPofWpVcjy7TOwslNdix0khWnL3kLOtjr/xoTMpy/lA=;
        b=iLTW0W+tEpB3PrbZezkgQApNToZQAoTKRvOnmUoj1FXHMBBpwhM/jY7fPnmF+8qlT/
         52HlPKuOYMdasBNEeuwXxZY8pG90WGHX6s3IkrMzz7O0qBt7uOFErSqT5ybc1UuCnk+A
         gc5ml2kywvi4JDkM9vb6UBXCmMFbPAF2Hj0aBuLTJwF4lV/7SdjCc7RnDar6H5ddc+o0
         UOKb/l+ML+kuA/utRx7YyQyKWmiqfxNc1r3TCBwybX1+ZOYxrtFdN/SnQXlAW7Py/9GH
         9OMQnJKlKQwl1VB4vFYXgloYltOw0jbz2pfoErOtbAmHqz214itIk0wAOZYPCL4oUjnc
         qXrQ==
X-Gm-Message-State: APzg51DbHU3II9pLkbvye/ZsN+VIFGUkIMSgTJqWE1Pe2V21vCNADUcI
        TjVpfPhdNetMiYd/i2sO2b4=
X-Google-Smtp-Source: ANB0VdbKXyUmmTl1rztqOtHgJ49+mcLkkbgL9dYR7Q+JJxqVVLHA+04mcxr2Iz/ax1o4h6MEX43DQw==
X-Received: by 2002:a63:2701:: with SMTP id n1-v6mr3922043pgn.146.1536254840820;
        Thu, 06 Sep 2018 10:27:20 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::5:7a4e])
        by smtp.gmail.com with ESMTPSA id w81-v6sm12300838pfk.92.2018.09.06.10.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 10:27:19 -0700 (PDT)
Date:   Thu, 6 Sep 2018 10:27:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>,
        ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dvyukov@google.com, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6
Message-ID: <20180906172713.cxjoazoo7asqggb3@ast-mbp.dhcp.thefacebook.com>
References: <0000000000002bef6405752b530b@google.com>
 <c8285592-29a7-2827-8c9a-d8cc0cf099e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8285592-29a7-2827-8c9a-d8cc0cf099e8@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:00:26AM -0700, Eric Dumazet wrote:
> 
> 
> On 09/05/2018 08:17 PM, syzbot wrote:
> > syzbot has found a reproducer for the following crash on:
> > 
> > HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=164938d1400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
> > dashboard link: https://syzkaller.appspot.com/bug?extid=acffccec848dc13fe459
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f172e400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16399be1400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com
> > 
> > IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> > 8021q: adding VLAN 0 to HW filter on device team0
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
> > Read of size 1 at addr ffff8801d4a67f07 by task syz-executor092/4673
> > 
> > CPU: 1 PID: 4673 Comm: syz-executor092 Not tainted 4.19.0-rc2+ #223
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> >  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
> >  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
> >  _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
> >  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
> >  xfrm_decode_session include/net/xfrm.h:1232 [inline]
> >  vti6_tnl_xmit+0x3fc/0x1bb1 net/ipv6/ip6_vti.c:542
> >  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
> >  xmit_one net/core/dev.c:3216 [inline]
> >  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3232
> >  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3802
> >  dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
> >  __bpf_tx_skb net/core/filter.c:2012 [inline]
> >  __bpf_redirect_common net/core/filter.c:2050 [inline]
> >  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
> >  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
> >  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
> >  bpf_prog_c39d1ba309a769f7+0xe9e/0x1000
> > 
> > Allocated by task 4673:
> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >  set_track mm/kasan/kasan.c:460 [inline]
> >  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
> >  __do_kmalloc_node mm/slab.c:3682 [inline]
> >  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
> >  __kmalloc_reserve.isra.41+0x3a/0xe0 net/core/skbuff.c:137
> >  pskb_expand_head+0x230/0x10e0 net/core/skbuff.c:1463
> >  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5129
> >  __bpf_try_make_writable net/core/filter.c:1633 [inline]
> >  bpf_try_make_writable net/core/filter.c:1639 [inline]
> >  bpf_try_make_head_writable net/core/filter.c:1647 [inline]
> >  ____bpf_clone_redirect net/core/filter.c:2084 [inline]
> >  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
> >  bpf_prog_c39d1ba309a769f7+0xe9e/0x1000
> > 
> > Freed by task 3286:
> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >  set_track mm/kasan/kasan.c:460 [inline]
> >  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
> >  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> >  __cache_free mm/slab.c:3498 [inline]
> >  kfree+0xd9/0x210 mm/slab.c:3813
> >  load_elf_binary+0x2569/0x5610 fs/binfmt_elf.c:1118
> >  search_binary_handler+0x17d/0x570 fs/exec.c:1653
> >  exec_binprm fs/exec.c:1695 [inline]
> >  __do_execve_file.isra.35+0x15ff/0x2460 fs/exec.c:1819
> >  do_execveat_common fs/exec.c:1866 [inline]
> >  do_execve fs/exec.c:1883 [inline]
> >  __do_sys_execve fs/exec.c:1964 [inline]
> >  __se_sys_execve fs/exec.c:1959 [inline]
> >  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > The buggy address belongs to the object at ffff8801d4a67d00
> >  which belongs to the cache kmalloc-512 of size 512
> > The buggy address is located 7 bytes to the right of
> >  512-byte region [ffff8801d4a67d00, ffff8801d4a67f00)
> > The buggy address belongs to the page:
> > page:ffffea00075299c0 count:1 mapcount:0 mapping:ffff8801dac00940 index:0x0
> > flags: 0x2fffc0000000100(slab)
> > raw: 02fffc0000000100 ffffea0007529988 ffffea0007529a48 ffff8801dac00940
> > raw: 0000000000000000 ffff8801d4a67080 0000000100000006 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >  ffff8801d4a67e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff8801d4a67e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >> ffff8801d4a67f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >                    ^
> >  ffff8801d4a67f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff8801d4a68000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> > 
> 
> 
> What about :
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index aecdeba052d3f0ff3d4f0a33ec36891f9738052c..a662f59786bd0677850c1c60a2c92faa6fb6c5bb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2081,7 +2081,7 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
>          * here, we need to free the just generated clone to unclone once
>          * again.
>          */
> -       ret = bpf_try_make_head_writable(skb);
> +       ret = bpf_try_make_head_writable(clone);

This part is fine. I think the bug is in _decode_session6,
but I have a hard time reproducing the issue, so will appreciate
if somebody can test the following patch:

From 291f80f212461670d1e0140d06eee3071cf3e1ee Mon Sep 17 00:00:00 2001
From: Alexei Starovoitov <ast@kernel.org>
Date: Thu, 6 Sep 2018 10:23:29 -0700
Subject: [PATCH] net/xfrm: fix out-of-bounds packet access

BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0
net/ipv6/xfrm6_policy.c:161
Read of size 1 at addr ffff8801d882eec7 by task syz-executor1/6667
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
  xfrm_decode_session include/net/xfrm.h:1232 [inline]
  vti6_tnl_xmit+0x3c3/0x1bc1 net/ipv6/ip6_vti.c:542
  __netdev_start_xmit include/linux/netdevice.h:4313 [inline]
  netdev_start_xmit include/linux/netdevice.h:4322 [inline]
  xmit_one net/core/dev.c:3217 [inline]
  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3233
  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3803
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3836

Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv6/xfrm6_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index ef3defaf43b9..d35bcf92969c 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -146,8 +146,8 @@ _decode_session6(struct sk_buff *skb, struct flowi *fl, int reverse)
 	fl6->daddr = reverse ? hdr->saddr : hdr->daddr;
 	fl6->saddr = reverse ? hdr->daddr : hdr->saddr;
 
-	while (nh + offset + 1 < skb->data ||
-	       pskb_may_pull(skb, nh + offset + 1 - skb->data)) {
+	while (nh + offset + sizeof(*exthdr) < skb->data ||
+	       pskb_may_pull(skb, nh + offset + sizeof(*exthdr) - skb->data)) {
 		nh = skb_network_header(skb);
 		exthdr = (struct ipv6_opt_hdr *)(nh + offset);
 
-- 
2.17.1

