Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CB4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98F2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUTUhOyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B98F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeGJJv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:51:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52801 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeGJJv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:51:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id w16-v6so23859259wmc.2;
        Tue, 10 Jul 2018 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b/vodOVOuj9BFSNcHe+4ZmrPe7Gxn6XhuXMLpIBFxSI=;
        b=YUTUhOyvPzfbsjsAfVKvHc/3LQ1E2Nujp+pNj15M0DVKrgA2sIUNcGrGkCe49Nc+rs
         En/aw4aMH4OZWe16gFmIGDfQjHX3OolNbsAsdaQ7++yDnRSlMChhAG06h/te3f3UwRvb
         FcU+ggN5tSxmGkf/H6be6YE6PL0f7/lnoJyoGHbzpCh0IsVUcLSjcTz2wbhB3MrseelF
         SnvAEhL3EMkrwPiEXzy9Y7zHEH4N7RIb7ybKvQeU6KSVl758CBbxc7LPY6m/9IU3WyH+
         BFHcGDWTwzAFgsVPWz5/GghSF4aBKwgXGN75wRmEIL86YCSWQYc1g4rHNiMXywCN5YaD
         44Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b/vodOVOuj9BFSNcHe+4ZmrPe7Gxn6XhuXMLpIBFxSI=;
        b=fKSmeNokDLTrPtnSPC7OY9aYJlnDzqNlxAPyT6IBDzCfcWTWna1rJk9y7LKgDVfDd8
         NWLKNXzcIKXP6KsWiZ99slLQrU4k6ffL2qGFlI7t/IUpqAmxpFjFvNlyL5/dB+GGtbsI
         Zksa311bele1LM9vioXkaBevRdvky0W95eCKElvzkAHlrys7DoJyeppttJEazRUTG0ns
         ReDlqi6i/MrHi3b6WNLhhh17vUaX9e1PeqULrZMKrCnqclmagXj6amQ0jK9sapSBeNqo
         DJe0ZwWyBB508osN2tx77pTaiJW2k2ggieobsbXqUYJbVzxSZkH9KVlPq1Unze6kY+lG
         cIxw==
X-Gm-Message-State: APt69E17oJhWy/jiQv8H8jfQwV9dajXgihgwqZAXy6pY7KhdH2ZuwroM
        O0pEQUp85bCgk/cyt/BmCNo=
X-Google-Smtp-Source: AAOMgpfV5BXWgBpMsdtspa5L+HDRSIBDpYz/mbs7UqxQkhPaF5YHCNkP5vPPEOxeGukakTtw5tlecQ==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr15498571wmd.79.1531216284444;
        Tue, 10 Jul 2018 02:51:24 -0700 (PDT)
Received: from sch.bme.hu (ecklm-pi.sch.bme.hu. [152.66.179.182])
        by smtp.gmail.com with ESMTPSA id v1-v6sm582444wrs.28.2018.07.10.02.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:51:23 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:51:22 +0200
From:   =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without
 NF_TABLES_IPV6
Message-ID: <20180710095122.6ee4wxfg4sabhcvw@sch.bme.hu>
References: <20180709213537.2748896-1-arnd@arndb.de>
 <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
 <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
 <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:10:40AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 10, 2018 at 10:05 AM, Máté Eckl <ecklm94@gmail.com> wrote:
> > On Tue, Jul 10, 2018 at 10:02:27AM +0200, Máté Eckl wrote:
> >> On Mon, Jul 09, 2018 at 11:35:09PM +0200, Arnd Bergmann wrote:
> >> > It is now possible to build the nft_socket module as built-in when
> >> > NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=m set manually.
> >> >
> >> > In this case, the NF_SOCKET_IPV6 functionality will be useless according
> >> > to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
> >> > IPv6 select dependencies"), but on top of that it also causes a link
> >> > error:
> >> >
> >> > net/netfilter/nft_socket.o: In function `nft_socket_eval':
> >> > nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_v6'
> >> >
> >> > This changes the compile-time check so we don't attempt to use
> >> > the NF_SOCKET_IPV6 code when it cannot be used, and make it all
> >> > compile again. That may lead to unexpected behavior when a user
> >> > enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
> >> > logical conclusion of the 35bf1ccecaaa change.
> >> >
> >> > Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> I think this should be fixed in the Kconfig rather than inside the module(s).
> 
> Should we revert your patch then, or do you have a better idea?
> 
> >> I did some investigation and it turns out that you missed a circumstance. This
> >> link error occures only if NFT_SOCKET=y && NF_SOCKET_IPV6=m && NF_TABLES_IPV6=y
> >> (cannot be m here if NFT_SOCKET is y).
> 
> No, if NF_TABLES_IPV6=y the problem cannot happen, since NFT_SOCKET then
> selects NF_SOCKET_IPV6=y as well. Before your patch, it would always select
> NF_SOCKET_IPV6 when it could, so it worked in all configurations.

Sorry I wanted to write NF_TABLES_IPV6=n...
So: NFT_SOCKET=y && NF_SOCKET_IPV6=m && NF_TABLES_IPV6=n causes linkage error.
NFT_SOCKET=m && NF_SOCKET_IPV6=m && NF_TABLES_IPV6=n compiles fine.

> >>  And probably the same with
> >> iptables-related modules. Probably this possibility should be eliminated.
> >
> > NF_TPROXY_IPV6 might be in the same situation.
> 
> I tried coming up with a combination that is broken for NF_TPROXY_IPV6=m
> but could not. From what I can see with
> 
> config NETFILTER_XT_TARGET_TPROXY
>        tristate '"TPROXY" target transparent proxying support'
>        depends on IP6_NF_IPTABLES || IP6_NF_IPTABLES=n
>        select NF_TPROXY_IPV6 if IP6_NF_IPTABLES
> 
> and
> 
> #if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
> 
> inside of net/netfilter/xt_TPROXY.c, there is no way we can end up with
> xt_TPROXY calling into the nf_tproxy_ipv6 loadable module from
> a built-in context. This is the same approach I used in my patch,
> just with IP6_NF_IPTABLES instead of NF_SOCKET_IPV6, in both
> the Kconfig dependency and the module.

Right, I see your point. I have an alternative solution which seems more robust
to me, but I might be overthinking this situation.

So
Accepted-by: Máté Eckl <ecklm94@gmail.com>

>       Arnd
