Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D142C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6CD2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad2X4J5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6CD2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIFLeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:34:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51708 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIFLea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:34:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so10253310wma.1;
        Thu, 06 Sep 2018 00:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hMxqRjStJPTRfnQD1LwBKfgyzUCbW6ok17AN+2ymoCY=;
        b=Ad2X4J5I/u0pGJbuIlFEo9quqwC6aHZ/dP00/lPN+iAHKzlO9cIZ9qDtjU5iE1Iy3W
         zVNJrD2r4EooeZIPYa7jgIPv6vC7LGpgOApx++uBIj7e/DugNK1Jy23HSaAJMKPzQymh
         2C9Y+fB1oPhmcb3AS2adlXXVwn3oN5xhE04w9kKpqC56qYo7cOJbq35GewI/mWSG3XX5
         jRNuaY4niKTHdCYcKezJHuhEZFqWshU1W2ARaDOR93hiUpXwrh9AJOe1BuPE0CP05E/e
         mWD+Q+y9xwA9Jb0gAmO+FlQoyL+2VupTYJ093a+IqVXB3DV/dKLRDtR8U65qiV9jJs4d
         wfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMxqRjStJPTRfnQD1LwBKfgyzUCbW6ok17AN+2ymoCY=;
        b=Hc3H82tFOaKl9FLh8NRkBJPIEsT/jEpkLyWloFfQ6CdNUIyCSAMnPL5zkwJ0OjZzQ9
         98OJP8IXBTnKS7c7jPjyFqo745CKXFYL7V/YSTkLqPpZ4UEhLkiK8xs2CReTZfriomPd
         JgCZi+sf4IxL1mt1u2Q8fWTWXEb1eZdpb3fksIfcUsauQxCvUsxv9rxbnwDBbWS/fCLr
         GTwS7vJZk19Bub24sogy4Yg3g02jhFRjNrN+04fktldTJWN/hl/tH90bXZI/UpLHRriv
         2lcqOrIsAWIdM2ng8Qgj0/YP+mG4bPPvXBvPvR2IszbCC1175UH1NlvFjbPvHD7Cw0g3
         BWKg==
X-Gm-Message-State: APzg51BV+GMgVw8PPD4TJmJ3oqzf+RDfOkzwD156dL8mkEzb9An4OmO4
        WEmgNljlOdhondpXXOD85Oo=
X-Google-Smtp-Source: ANB0VdZGiL/RieQFTpzEFYpoONUwYIoJ/RzTbaIGB7X6mBhUomoFUl1wqznLD36D95qxQkVqn7EbmA==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr1095924wma.4.1536217229300;
        Thu, 06 Sep 2018 00:00:29 -0700 (PDT)
Received: from [192.168.8.147] (177.87.136.77.rev.sfr.net. [77.136.87.177])
        by smtp.gmail.com with ESMTPSA id n17-v6sm2822123wmc.13.2018.09.06.00.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 00:00:28 -0700 (PDT)
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6
To:     syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>,
        ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dvyukov@google.com, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
References: <0000000000002bef6405752b530b@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c8285592-29a7-2827-8c9a-d8cc0cf099e8@gmail.com>
Date:   Thu, 6 Sep 2018 00:00:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0000000000002bef6405752b530b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2018 08:17 PM, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164938d1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
> dashboard link: https://syzkaller.appspot.com/bug?extid=acffccec848dc13fe459
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f172e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16399be1400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
> Read of size 1 at addr ffff8801d4a67f07 by task syz-executor092/4673
> 
> CPU: 1 PID: 4673 Comm: syz-executor092 Not tainted 4.19.0-rc2+ #223
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>  _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
>  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
>  xfrm_decode_session include/net/xfrm.h:1232 [inline]
>  vti6_tnl_xmit+0x3fc/0x1bb1 net/ipv6/ip6_vti.c:542
>  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
>  xmit_one net/core/dev.c:3216 [inline]
>  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3232
>  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3802
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
>  __bpf_tx_skb net/core/filter.c:2012 [inline]
>  __bpf_redirect_common net/core/filter.c:2050 [inline]
>  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
>  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
>  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
>  bpf_prog_c39d1ba309a769f7+0xe9e/0x1000
> 
> Allocated by task 4673:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc_node mm/slab.c:3682 [inline]
>  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
>  __kmalloc_reserve.isra.41+0x3a/0xe0 net/core/skbuff.c:137
>  pskb_expand_head+0x230/0x10e0 net/core/skbuff.c:1463
>  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5129
>  __bpf_try_make_writable net/core/filter.c:1633 [inline]
>  bpf_try_make_writable net/core/filter.c:1639 [inline]
>  bpf_try_make_head_writable net/core/filter.c:1647 [inline]
>  ____bpf_clone_redirect net/core/filter.c:2084 [inline]
>  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
>  bpf_prog_c39d1ba309a769f7+0xe9e/0x1000
> 
> Freed by task 3286:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x210 mm/slab.c:3813
>  load_elf_binary+0x2569/0x5610 fs/binfmt_elf.c:1118
>  search_binary_handler+0x17d/0x570 fs/exec.c:1653
>  exec_binprm fs/exec.c:1695 [inline]
>  __do_execve_file.isra.35+0x15ff/0x2460 fs/exec.c:1819
>  do_execveat_common fs/exec.c:1866 [inline]
>  do_execve fs/exec.c:1883 [inline]
>  __do_sys_execve fs/exec.c:1964 [inline]
>  __se_sys_execve fs/exec.c:1959 [inline]
>  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801d4a67d00
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 7 bytes to the right of
>  512-byte region [ffff8801d4a67d00, ffff8801d4a67f00)
> The buggy address belongs to the page:
> page:ffffea00075299c0 count:1 mapcount:0 mapping:ffff8801dac00940 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0007529988 ffffea0007529a48 ffff8801dac00940
> raw: 0000000000000000 ffff8801d4a67080 0000000100000006 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801d4a67e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801d4a67e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff8801d4a67f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff8801d4a67f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801d4a68000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 


What about :

diff --git a/net/core/filter.c b/net/core/filter.c
index aecdeba052d3f0ff3d4f0a33ec36891f9738052c..a662f59786bd0677850c1c60a2c92faa6fb6c5bb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2081,7 +2081,7 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
         * here, we need to free the just generated clone to unclone once
         * again.
         */
-       ret = bpf_try_make_head_writable(skb);
+       ret = bpf_try_make_head_writable(clone);
        if (unlikely(ret)) {
                kfree_skb(clone);
                return -ENOMEM;
