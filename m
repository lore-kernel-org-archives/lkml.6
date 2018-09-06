Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DAFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9320659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLNgPSUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeIFXyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:54:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37643 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbeIFXyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:54:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so5421402plt.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ZwtTUWbok8bObhQWxHYOOoWBQMVIy0B8s4ZxkGbJb4=;
        b=DLNgPSUPNiau8nUaOxGY1wSQmPtm/9iwGqRBBZLCIjQFeMe6tEyMMo0tO3+W4tM/gB
         9SH0lTi1U8vQRk4XSgJdd57H0GfYDYJOd8N2Acn+3h679aRuqiFjNc25zWmpxRvi1ut9
         m0fJNMx9J7G7bCt3Xy5MBUAw+FvO00gpb+D+rWDZOJsDDv4y1TWN+/LoovmtZ8cTg/yc
         3WuTEzTypcQY9m5FBY5HjUWf5nSG5wRUd3ECwrPOyhpy9IFNF10FJXSHUHJmSGa1liiy
         yMAlTcvQHK4I/p6g6Ds5Q282otUhdrmzHLruF30EfC1s7X74TioGUDmMfyADxKMlSOdG
         +P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ZwtTUWbok8bObhQWxHYOOoWBQMVIy0B8s4ZxkGbJb4=;
        b=HCE2R8VX93vs/COMoGJBOA2BdWcdpa91IXtul0MIAKvE3wGMs6lU1iQzqF92JbscUb
         GGB0AVpX80n30Cc0KnJdgui8x8tvTd1neJIbuDJ25g7B7481a+95zy5gRBk5Fkrq9dGU
         IG4bFRPo4IDjOcxjd6xuoV63zxX4RlnsUpLoUSjSpq2M3kiALovxpmwVslRSe9Mnm0CF
         00V7E/W+kwTT0o+bJB6rNM85Sa0QEv/slVscFy+IgLMxmwsqhR9UJDu2lzuPk+5zPjh6
         QbZL/Kwc+CZ/T6ZH/3i1PiUjFrTrovDItHLTB86WOiuOGp9slA3S+HLe7gHIOj960Z49
         ay0g==
X-Gm-Message-State: APzg51A9fBAlq70muQ/XFVE1ew/u4npD3kp1vzxtkEUbSWfTzYt3VSiK
        fkI6i4DT6dXJIl/mHO/EEz634xIWTj/4Of/5UbINuw==
X-Google-Smtp-Source: ANB0VdZ1depWeK7nVFtHchKB9FxV73ZXq5u0/dR3m2hg/jN43uaPqFhT/FhM0CJihDc5sjJivuuDt4uoW+R1Uh2Wfkc=
X-Received: by 2002:a17:902:934a:: with SMTP id g10-v6mr4187933plp.121.1536261463114;
 Thu, 06 Sep 2018 12:17:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 6 Sep 2018 12:17:22
 -0700 (PDT)
In-Reply-To: <20180906172713.cxjoazoo7asqggb3@ast-mbp.dhcp.thefacebook.com>
References: <0000000000002bef6405752b530b@google.com> <c8285592-29a7-2827-8c9a-d8cc0cf099e8@gmail.com>
 <20180906172713.cxjoazoo7asqggb3@ast-mbp.dhcp.thefacebook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Sep 2018 21:17:22 +0200
Message-ID: <CACT4Y+ZaPPpYyCkU8iJ_EFpCPGqQ60Z-7f6RQrDzY+01tdJBeA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 7:27 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Sep 06, 2018 at 12:00:26AM -0700, Eric Dumazet wrote:
>>
>>
>> On 09/05/2018 08:17 PM, syzbot wrote:
>> > syzbot has found a reproducer for the following crash on:
>> >
>> > HEAD commit:=C3=A1=C3=A1=C3=A1 b36fdc6853a3 Merge tag 'gpio-v4.19-2' o=
f git://git.kernel...
>> > git tree:=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1 upstream
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D164938d140=
0000
>> > kernel config:=C3=A1 https://syzkaller.appspot.com/x/.config?x=3D4c7e8=
3258d6e0156
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dacffccec848d=
c13fe459
>> > compiler:=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1 gcc (GCC) 8.0.1 20180413=
 (experimental)
>> > syz repro:=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1 https://syzkaller.appspot.com=
/x/repro.syz?x=3D115f172e400000
>> > C reproducer:=C3=A1=C3=A1 https://syzkaller.appspot.com/x/repro.c?x=3D=
16399be1400000
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:
>> > Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com
>> >
>> > IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
>> > IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
>> > IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>> > 8021q: adding VLAN 0 to HW filter on device team0
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0 net/i=
pv6/xfrm6_policy.c:161
>> > Read of size 1 at addr ffff8801d4a67f07 by task syz-executor092/4673
>> >
>> > CPU: 1 PID: 4673 Comm: syz-executor092 Not tainted 4.19.0-rc2+ #223
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 01/01/2011
>> > Call Trace:
>> > =C3=A1__dump_stack lib/dump_stack.c:77 [inline]
>> > =C3=A1dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>> > =C3=A1print_address_description+0x6c/0x20b mm/kasan/report.c:256
>> > =C3=A1kasan_report_error mm/kasan/report.c:354 [inline]
>> > =C3=A1kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>> > =C3=A1__asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>> > =C3=A1_decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
>> > =C3=A1__xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
>> > =C3=A1xfrm_decode_session include/net/xfrm.h:1232 [inline]
>> > =C3=A1vti6_tnl_xmit+0x3fc/0x1bb1 net/ipv6/ip6_vti.c:542
>> > =C3=A1__netdev_start_xmit include/linux/netdevice.h:4287 [inline]
>> > =C3=A1netdev_start_xmit include/linux/netdevice.h:4296 [inline]
>> > =C3=A1xmit_one net/core/dev.c:3216 [inline]
>> > =C3=A1dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3232
>> > =C3=A1__dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3802
>> > =C3=A1dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
>> > =C3=A1__bpf_tx_skb net/core/filter.c:2012 [inline]
>> > =C3=A1__bpf_redirect_common net/core/filter.c:2050 [inline]
>> > =C3=A1__bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
>> > =C3=A1____bpf_clone_redirect net/core/filter.c:2090 [inline]
>> > =C3=A1bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
>> > =C3=A1bpf_prog_c39d1ba309a769f7+0xe9e/0x1000
>> >
>> > Allocated by task 4673:
>> > =C3=A1save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>> > =C3=A1set_track mm/kasan/kasan.c:460 [inline]
>> > =C3=A1kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>> > =C3=A1__do_kmalloc_node mm/slab.c:3682 [inline]
>> > =C3=A1__kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
>> > =C3=A1__kmalloc_reserve.isra.41+0x3a/0xe0 net/core/skbuff.c:137
>> > =C3=A1pskb_expand_head+0x230/0x10e0 net/core/skbuff.c:1463
>> > =C3=A1skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5129
>> > =C3=A1__bpf_try_make_writable net/core/filter.c:1633 [inline]
>> > =C3=A1bpf_try_make_writable net/core/filter.c:1639 [inline]
>> > =C3=A1bpf_try_make_head_writable net/core/filter.c:1647 [inline]
>> > =C3=A1____bpf_clone_redirect net/core/filter.c:2084 [inline]
>> > =C3=A1bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
>> > =C3=A1bpf_prog_c39d1ba309a769f7+0xe9e/0x1000
>> >
>> > Freed by task 3286:
>> > =C3=A1save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>> > =C3=A1set_track mm/kasan/kasan.c:460 [inline]
>> > =C3=A1__kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>> > =C3=A1kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>> > =C3=A1__cache_free mm/slab.c:3498 [inline]
>> > =C3=A1kfree+0xd9/0x210 mm/slab.c:3813
>> > =C3=A1load_elf_binary+0x2569/0x5610 fs/binfmt_elf.c:1118
>> > =C3=A1search_binary_handler+0x17d/0x570 fs/exec.c:1653
>> > =C3=A1exec_binprm fs/exec.c:1695 [inline]
>> > =C3=A1__do_execve_file.isra.35+0x15ff/0x2460 fs/exec.c:1819
>> > =C3=A1do_execveat_common fs/exec.c:1866 [inline]
>> > =C3=A1do_execve fs/exec.c:1883 [inline]
>> > =C3=A1__do_sys_execve fs/exec.c:1964 [inline]
>> > =C3=A1__se_sys_execve fs/exec.c:1959 [inline]
>> > =C3=A1__x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
>> > =C3=A1do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>> > =C3=A1entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> >
>> > The buggy address belongs to the object at ffff8801d4a67d00
>> > =C3=A1which belongs to the cache kmalloc-512 of size 512
>> > The buggy address is located 7 bytes to the right of
>> > =C3=A1512-byte region [ffff8801d4a67d00, ffff8801d4a67f00)
>> > The buggy address belongs to the page:
>> > page:ffffea00075299c0 count:1 mapcount:0 mapping:ffff8801dac00940 inde=
x:0x0
>> > flags: 0x2fffc0000000100(slab)
>> > raw: 02fffc0000000100 ffffea0007529988 ffffea0007529a48 ffff8801dac009=
40
>> > raw: 0000000000000000 ffff8801d4a67080 0000000100000006 00000000000000=
00
>> > page dumped because: kasan: bad access detected
>> >
>> > Memory state around the buggy address:
>> > =C3=A1ffff8801d4a67e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> > =C3=A1ffff8801d4a67e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>> >> ffff8801d4a67f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> > =C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=
=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1=C3=A1 ^
>> > =C3=A1ffff8801d4a67f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc f=
c
>> > =C3=A1ffff8801d4a68000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>>
>>
>> What about :
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index aecdeba052d3f0ff3d4f0a33ec36891f9738052c..a662f59786bd0677850c1c60=
a2c92faa6fb6c5bb 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -2081,7 +2081,7 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, s=
kb, u32, ifindex, u64, flags)
>>          * here, we need to free the just generated clone to unclone onc=
e
>>          * again.
>>          */
>> -       ret =3D bpf_try_make_head_writable(skb);
>> +       ret =3D bpf_try_make_head_writable(clone);
>
> This part is fine. I think the bug is in _decode_session6,

Eric, you arrived to roughly the same conclusion, right?

> but I have a hard time reproducing the issue, so will appreciate
> if somebody can test the following patch:

syzbot can:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patc=
hes


> From 291f80f212461670d1e0140d06eee3071cf3e1ee Mon Sep 17 00:00:00 2001
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Thu, 6 Sep 2018 10:23:29 -0700
> Subject: [PATCH] net/xfrm: fix out-of-bounds packet access
>
> BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0
> net/ipv6/xfrm6_policy.c:161
> Read of size 1 at addr ffff8801d882eec7 by task syz-executor1/6667
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_address_description+0x6c/0x20b mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>   __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>   _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
>   __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
>   xfrm_decode_session include/net/xfrm.h:1232 [inline]
>   vti6_tnl_xmit+0x3c3/0x1bc1 net/ipv6/ip6_vti.c:542
>   __netdev_start_xmit include/linux/netdevice.h:4313 [inline]
>   netdev_start_xmit include/linux/netdevice.h:4322 [inline]
>   xmit_one net/core/dev.c:3217 [inline]
>   dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3233
>   __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3803
>   dev_queue_xmit+0x17/0x20 net/core/dev.c:3836
>
> Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  net/ipv6/xfrm6_policy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index ef3defaf43b9..d35bcf92969c 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -146,8 +146,8 @@ _decode_session6(struct sk_buff *skb, struct flowi *f=
l, int reverse)
>         fl6->daddr =3D reverse ? hdr->saddr : hdr->daddr;
>         fl6->saddr =3D reverse ? hdr->daddr : hdr->saddr;
>
> -       while (nh + offset + 1 < skb->data ||
> -              pskb_may_pull(skb, nh + offset + 1 - skb->data)) {
> +       while (nh + offset + sizeof(*exthdr) < skb->data ||
> +              pskb_may_pull(skb, nh + offset + sizeof(*exthdr) - skb->da=
ta)) {
>                 nh =3D skb_network_header(skb);
>                 exthdr =3D (struct ipv6_opt_hdr *)(nh + offset);
>
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20180906172713.cxjoazoo7asqggb3%40ast-mbp.dhcp.thefacebook=
.com.
> For more options, visit https://groups.google.com/d/optout.
