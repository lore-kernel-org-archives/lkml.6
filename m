Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59CDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7051E21531
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vH4n1X8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7051E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeHUI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:58:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45878 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:58:35 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so8220216pll.12;
        Mon, 20 Aug 2018 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erlyi2KuJUO56qvCTogeENzrWEOTc2BNc9CeXLWlDwE=;
        b=vH4n1X8Hz6jJoAXJRNSkJgQ86hsNoWRpJ0BiXDgcaDQcJkAMQ4dnSFdzjtCuQ9oOuR
         kgVzWAMm/Bo+MIW4lIPFui489HyMx3SkSAGBm17qd3BXmGkb2n94lJCT3dfz5TzpMdgA
         lPlIPCxvxdGMvRZS6fRO280m1ACsVPfN0xYlxMVxtIQf8+WDCKtYasIp3EthOyvHW9iA
         Q6nJB/gCnN6/VgGnxtxYCH+4lMsCrgKr6ukJmuHKkHSg9RPpkY4jhulXykiHhTopcugz
         Rk1CXkt5B7xtko33GovrINoC2Xa6hkcrh1kDzSkVY9zGQxpbIPxzDMIwfThia3bsq0EX
         hNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erlyi2KuJUO56qvCTogeENzrWEOTc2BNc9CeXLWlDwE=;
        b=kQteCDw0TDCHGt/dFDlbBGyMerkAomamaB2cC2zqwNHb4CtIPuOoTJv8dL3nVIkI/F
         2lyS7TjlbONA0tcVZdABvyEmMRbBr5gHDQz0umrfRyPSt8hNGdQFImpkHGjVqnGtVaRC
         HbOwT2blVHKX95uF+BAutTBljfbh3FiW8Hx+uAKZIO8eSv/UvglbrrmzggiLfut9PzfU
         tZDoM6EAm+A0fnzpbh1jR5VvpSOIl71Xe70ZnQ+uhbD22BgwH1pJXJEBhhWAI0NzIEyI
         1QDYmKNbLhLkOWPa+QyxeT5tB/Z2LS9Wu52zXrJ35IeSWJu6Z6XF91Wh/pNnw8Sj9vHA
         m4Gg==
X-Gm-Message-State: AOUpUlHUn2mYJq/0MCpqXHjxsV5tVfe7QFDwTIFEllqN9Ny3Dc327N24
        Sjb1DtI8xIQLARzXeLPRBHm2/jE1lCO7AKWRjG0=
X-Google-Smtp-Source: AA+uWPy0xz3ahZKW8gye1n5cuzt8gPP6UO6dD7HmyfKG4RFdNSSxx8F95jyBViwLSDD2lzoD2CUVr4UUoc6ZMk9tlK0=
X-Received: by 2002:a17:902:2904:: with SMTP id g4-v6mr2767018plb.70.1534829997433;
 Mon, 20 Aug 2018 22:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d22100573d66078@google.com> <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
In-Reply-To: <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 20 Aug 2018 22:40:43 -0700
Message-ID: <CAM_iQpVM4wHkW4RKMuDj_Jjof3XbJmAsN0SdSRfneaf94CL0cw@mail.gmail.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     Julian Anastasov <ja@ssi.bg>
Cc:     syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com,
        ddstreet@ieee.org, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 6:00 AM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,
>
> On Sun, 19 Aug 2018, syzbot wrote:
>
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    d7857ae43dcc Add linux-next specific files for 20180817
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13c72fce400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4b10cd1ea76bb092
> > dashboard link: https://syzkaller.appspot.com/bug?extid=30209ea299c09d8785c9
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15df679a400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15242741400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com
> >
> > IPVS: stopping master sync thread 4657 ...
> > IPVS: stopping master sync thread 4663 ...
> > IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0, id
> > IPVS: = 0
> > IPVS: sync thread started: state = MASTER, mcast_ifn = syz_tun, syncid = 0, id
> > IPVS: = 0
> > IPVS: stopping master sync thread 4664 ...
> > unregister_netdevice: waiting for lo to become free. Usage count = 1
>
>         Well, only IPVS and tun in the game? But IPVS does not
> take any dev references for sync threads. Can it be a problem
> in tun? For example, a side effects from dst_cache_reset?
> May be dst_release is called too late? Here is what should happen
> on unregistration:

There are multiple similar bugs grouped together under this, perhaps
they are different, perhaps they are a same bug, too early to say.

For the one I look into, dst_cache doesn't matter, because the xmit
path doesn't even use tunnel dst_cache at all, and it is ip6tnl0 FB
device, unlike this one which is tun device.


>
> - NETDEV_UNREGISTER event: rt_flush_dev changes dst->dev with lo
> but dst is not released
>
> - ndo_uninit/ip_tunnel_uninit: dst_cache_reset is called which
> does nothing!?! May be dst_release call is needed here.


I think this makes sense, at least prior to the general dst_cache
introduction, dst refcnt was released in ndo_uninit() too, so it
is reasonable to move the dst_cache_destroy() to ndo_uninit().



>
> - no more references are expected here ...
>
> - netdev_run_todo -> netdev_wait_allrefs: loop here due to refcnt!=0
>
> - dev->priv_destructor (ip_tunnel_dev_free) calls dst_cache_destroy
> where dst_release is used but it is not reached because we loop in
> netdev_wait_allrefs above
>
> - dst_cache_destroy: really call dst_release
>
>         In fact, after calling rt_flush_dev and replacing the
> dst->dev we should reach dev->priv_destructor (ip_tunnel_dev_free)
> for tun device where dst_release for lo should be called. But may be
> something prevents it, exit batching?

I can't see anything in netnns exit batch is any special here.

For the one I look into, it seems some fib6_info is not released for
some reason. It seems to be the one created by addrconf_prefix_route(),
which is supposed to be released by fib6_clean_tree() I think, but it
never happens.

Thanks.
