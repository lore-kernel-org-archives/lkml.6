Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BF022ACD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmV3SzD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BF022ACD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeGFWRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:17:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37249 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeGFWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:17:28 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so12129244ioh.4;
        Fri, 06 Jul 2018 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOQe9DXRTnG0hKO0ggSqTmEiRWFipgxhUz1KENcPgds=;
        b=kmV3SzD7BtqmEUX8SoLeFevlq0BpD4xfW1QVRpCeofinm7l7HaQolq2+w9u5zMxgTI
         HXE6GXb4WsQr0UAe27hins7JIdwcdzJKepY9M1xEtWOMIY/ESUNkpHla9UCKQ7MwNKVF
         wXeRfMZirah+cFksg3cQKgEdtdvDiDtRaEfjqxta8v9dzwRfKmpVILyhgcVbNdfmXQ6s
         efLy3YM3q9R0wX95VQgivZjALNIC9Y+7fGf5LUROxpihM4jrqD9cBSjN7VtrqMgsSTTC
         JtIgIeUYyTxLEBoFFMcSOhLMAuBPSpq59VuZ0VXaSth65ttpnkHZQFEOO/mSxVcw6GmL
         +KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOQe9DXRTnG0hKO0ggSqTmEiRWFipgxhUz1KENcPgds=;
        b=LER0TMJbBRaz/DQcc5H0X6duYYnhAGLrT6gkmBih24mr0chYyvgk71xE4I8kkymw72
         reTSPXBUa7a9uK83EUCOFwwc6J5but0MPh9yI4FOUGxUdE0RhdYN0yxyTO1JQFhXMH+4
         AgfZb8DO4Rjv3a1DEOZGjveJDBbG4tcM0IcrbPgD1iOgf1SpIzF5D1/CEPrXXz7aq72g
         aH+wanb0UMJwR7slywFZDevCXMTq4G5W7kNdVUThvlWtz1OBTtgb414SKylExQyH2WnE
         vFsZaWQ69c92t3Sw0rFAS51VQoBINNW95XX/ACa0iN0r9qdOS6KiQFmCNTNqRze0WW4Y
         zb0A==
X-Gm-Message-State: AOUpUlHz3cOAzgXA77x6sNVnvCp1TMvBrymEb4wkdrtpnDWlAVVO1A6j
        NgTlPJ2r/AFDtSb3MxNDcOB9Gtze60Q/eN1N/Sg=
X-Google-Smtp-Source: AAOMgpedx0brQQ3NUdtpVnIA5cwfPtNXcjc/KTwZSVzPDECXmf22MwoEGOXHiFvnKjcDlOaA+Io/wtsgP7EqzFk7MCs=
X-Received: by 2002:a6b:a504:: with SMTP id o4-v6mr9381914ioe.95.1530915447940;
 Fri, 06 Jul 2018 15:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b0ee7a056eea93a7@google.com> <00000000000033f8440570585207@google.com>
In-Reply-To: <00000000000033f8440570585207@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 6 Jul 2018 18:16:52 -0400
Message-ID: <CAF=yD-JgBPy+D2Jm7SN=-bzAfAf__pxE92qAqNWs=9EqfyLmAA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ipv6_gso_pull_exthdrs
To:     syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 1:55 PM syzbot
<syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    70ba5b6db96f ipv4: Return EINVAL when ping_group_range sys..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cd2970400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> dashboard link: https://syzkaller.appspot.com/bug?extid=7b9ed9872dab8c32305d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15dfb748400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1050c400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: use-after-free in ipv6_gso_pull_exthdrs+0x57a/0x5f0
> net/ipv6/ip6_offload.c:45
> Read of size 1 at addr ffff8801ce17f3a9 by task syz-executor655/4567

This is an 8 byte packet with a virtio_net_hdr describing it as
VIRTIO_NET_HDR_GSO_TCPV4, but with protocol ETH_P_NSH. That
matches the occurrence of nsh_gso_segment in the stack trace.

This pulls the struct nshhdr of 8B, passing a packet with skb->len 0
to skb_mac_gso_segment. That is the only GRO function that
unconditionally calls _skb_pull without first checking pskb_may_pull.
Adding that check does catch this:

+       if (unlikely(!pskb_may_pull(skb, vlan_depth)))
+               return ERR_PTR(-EINVAL);
