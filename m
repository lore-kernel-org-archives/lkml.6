Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A2C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3078B208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4J2nIKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3078B208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbeGHW6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 18:58:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34731 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754360AbeGHW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 18:58:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id d3-v6so12462464edi.1;
        Sun, 08 Jul 2018 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+eweRtR4UU8Uphd+HWv9UQXO+sy22luHq/IvJnoT2o=;
        b=b4J2nIKhgYFVWKZ7fO+PVAb3XSXHhv+NCsSM5lW9v9EEOyyJHvgCXRyzqC4OvglWYr
         hNEK8P4JhbGV2ekTbBuO8y+7Uojl7hUEpoJwRZz/zFSdeDeEFVGPCbs0DZlgmKX7UERA
         f6GaG+JZPNM2u2Qp4shpz5VzHN0VdV5J93XCFVCaNzg7zopYK8zaiVi+77BZrfMyTHHx
         y34HUSBEzIQzHcsLlfv1XwKXFmumhBFne7dwULEyRAOKg29gZITijmqADgTLe9jcBhuK
         zeQ+ucRdGYfMEbFHAEU3ifVIAYMK50/SEyZNx5rszCI+3Jglmvcb+ZHW9wW4V/HsiC2d
         A9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+eweRtR4UU8Uphd+HWv9UQXO+sy22luHq/IvJnoT2o=;
        b=d36ssur+PltnpBtYYvP5JXBsuuFN5eZUwTjZoNyoFvOJNpBszDzBwJHIHwShxcR8Bh
         luLDNqPbhPG0zzpbqr12cYSWS4SgdbIdDN8rK/IWOzqsWUs60SQWwZv09f/Gmd9WYLZ3
         +9GZ/wpoKMSx3/zv2G0+1PQLBO3Y5DF6ZnUyrJ6khnty96I8MEFzQ4ndhWQmp4kH0XSz
         kTTtAvFVVa5crcCSuTZovhs85NyBvSvvvMkHvcQbxrBU0vj4yBaJwYFJjgxfMKM9bYDX
         siWOcNaz8pTDczaQUJ2Y+MDFiXzuARwFc8IBTCjTgQ4nzqjlZKVUusYC+w/wkQm6IkMG
         WKow==
X-Gm-Message-State: APt69E1dh2Ea5i6ssreR/GdIL2oZluMmYyGWYxW3z5IpfgbBHp0QJMUv
        8vnwptf1YA3Kdyn70Hu5gwfowRUWsPkRBScDwdU=
X-Google-Smtp-Source: AAOMgpf3vEcx/e7YAJv24s3o9LosaiwPGOHHMyKSlqPCIOzL3ECCKOc64qGiaFMnJphxJqOJxdiyaulS468xZkpEH1U=
X-Received: by 2002:a50:b5a5:: with SMTP id a34-v6mr19307032ede.88.1531090730821;
 Sun, 08 Jul 2018 15:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b0ee7a056eea93a7@google.com> <00000000000033f8440570585207@google.com>
 <CAF=yD-JgBPy+D2Jm7SN=-bzAfAf__pxE92qAqNWs=9EqfyLmAA@mail.gmail.com>
In-Reply-To: <CAF=yD-JgBPy+D2Jm7SN=-bzAfAf__pxE92qAqNWs=9EqfyLmAA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 8 Jul 2018 18:58:14 -0400
Message-ID: <CAF=yD-LcXtF94=5Xt5zeD=AmqHxNHGP+NURazJERigA8ysBuAQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in ipv6_gso_pull_exthdrs
To:     syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 6:16 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Jul 6, 2018 at 1:55 PM syzbot
> <syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    70ba5b6db96f ipv4: Return EINVAL when ping_group_range sys..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13cd2970400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7b9ed9872dab8c32305d
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15dfb748400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1050c400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com
> >
> > IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
> > 8021q: adding VLAN 0 to HW filter on device team0
> > ==================================================================
> > BUG: KASAN: use-after-free in ipv6_gso_pull_exthdrs+0x57a/0x5f0
> > net/ipv6/ip6_offload.c:45
> > Read of size 1 at addr ffff8801ce17f3a9 by task syz-executor655/4567
>
> This is an 8 byte packet with a virtio_net_hdr describing it as
> VIRTIO_NET_HDR_GSO_TCPV4, but with protocol ETH_P_NSH. That
> matches the occurrence of nsh_gso_segment in the stack trace.
>
> This pulls the struct nshhdr of 8B, passing a packet with skb->len 0
> to skb_mac_gso_segment. That is the only GRO function that
> unconditionally calls _skb_pull without first checking pskb_may_pull.
> Adding that check does catch this:
>
> +       if (unlikely(!pskb_may_pull(skb, vlan_depth)))
> +               return ERR_PTR(-EINVAL);

vlan_depth is 65528 when entering skb_mac_gso_segment due to
overflow of skb->mac_len in nsh_gso_segment. For this packet, the
outer mac len is zero, so skb->data == skb_mac_header(skb). Then

    skb_reset_network_header(skb);
    [...]
    __skb_pull(skb, nsh_len);
    skb_reset_mac_header(skb);    // now mac hdr starts nsh_len == 8B
after net hdr
    skb_reset_mac_len(skb);          // mac len = net hdr - mac hdr ==
(u16) -8 == 65528
    [..]
    skb_mac_gso_segment(skb, ..)

Setting skb->mac_len to 0, similar to mpls_gs_segment,
is sufficient if the encapsulated packet is not ETH_P_TEB.

If the packet is encapsulated at L2, __skb_pull(skb, vlan_depth)
has to pull the inner mac header before passing to l3 handlers like
inet_gso_segment.

If that header includes VLAN tags, skb_network_protocol will
parse then and update the mac length in vlan_depth. So
hardcoding to ETH_HLEN should be fine:

@@ -104,7 +95,7 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
        __skb_pull(skb, nsh_len);

        skb_reset_mac_header(skb);
-       skb_reset_mac_len(skb);
+       skb->mac_len = proto == ETH_P_TEB ? ETH_HLEN : 0;
        skb->protocol = proto;

        features &= NETIF_F_SG;
