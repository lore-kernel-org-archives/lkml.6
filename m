Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8164C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36B420881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmyxaNgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36B420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeGJLPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:15:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933222AbeGJLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:15:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so14184479wro.3;
        Tue, 10 Jul 2018 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7uK/qUqCs5PlZwEmGyAxMTcfzH/r9TktAJTFyB2r4aM=;
        b=ZmyxaNgH4VRvWPyDtC9aByrkEW/6qGLL0JQIKmZDPUaFrNOyX/IuPmb3vet0ReakST
         /pkWiDv4UJpHt8HV4RRBqTLNvO2nLe0YIFUOD53UWmVv521t4OsCL6Yqp11OXejQ62ix
         baGd3on/nki2bXwUhHAdkZyarveEYo+ClgWMieYQ50EK8YqCNjSdsEfDhmFYpgAWrt9G
         IWyerGVKxWyOlChoPI2aLlROQ0Umu7ecpeN+1jx28OsuJ1xY3AxeVoTpYDAtBx2HKqkZ
         4H0W/Sb3YDYEmkR1XO3qWVZ6J8u5t1K3ydOwLHbwASP4YJVFQQP2DiUf97InPpRrEpc4
         YC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7uK/qUqCs5PlZwEmGyAxMTcfzH/r9TktAJTFyB2r4aM=;
        b=cyPsAded0AbOimU5OZHR3lrchVZ3gm1kFHgnqMDxTqHm6m2uZ+x6Pzt90raxxTy7YR
         uo4Iduq2G7DOsN2pOwNAVY/O8u600M9S6yejVQticlOrCC4cmsuHA7Y3XBxx0I0G41xT
         b4y/vDFvCgw7sYs2qvZKALfojgieZJYPWGRIBs6uM8dbX2ECQahT/vdKkZMXwcp9gDbj
         1mMnn4HoAGaKTRCsIgC11lqn1ooYknFpQ/yjTqRW5i86cavBhEzD9nYxl08MOPbzcUqb
         nq3EsWFtUHVMRd2h+Tc4l5ihIadBp9zK0yOZFEeI3eqX119seDfBaQuk91eaLUJpPX/P
         YrYw==
X-Gm-Message-State: APt69E2IMGjCyBg9192yoL8uP6fiJ2ZMupGrV8VptiFj/f2uo445o9eA
        m8faQki6ozNyoUJMdcNFeYA=
X-Google-Smtp-Source: AAOMgpcjyjTJGX+Cz0QvdeUOwvQMwECBfnhnmURGcqJFjBXSu2Hr+yi+DSuTbELxR8JSMu0YYZjdGQ==
X-Received: by 2002:a5d:6981:: with SMTP id g1-v6mr16463237wru.77.1531221339216;
        Tue, 10 Jul 2018 04:15:39 -0700 (PDT)
Received: from sch.bme.hu (ecklm-pi.sch.bme.hu. [152.66.179.182])
        by smtp.gmail.com with ESMTPSA id t184-v6sm12775720wmf.18.2018.07.10.04.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 04:15:37 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:15:36 +0200
From:   =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without
 NF_TABLES_IPV6
Message-ID: <20180710111536.hio2xalz7pyxucc6@sch.bme.hu>
References: <20180709213537.2748896-1-arnd@arndb.de>
 <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
 <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
 <CAK8P3a0zYmdoMdWdFDcWprZY_4w2hbMYq4--iZB=JE4x2UiscA@mail.gmail.com>
 <20180710105605.evgtmjiq5z46zld6@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710105605.evgtmjiq5z46zld6@salvia>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:56:05PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Jul 10, 2018 at 11:10:40AM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 10, 2018 at 10:05 AM, Máté Eckl <ecklm94@gmail.com> wrote:
> > > On Tue, Jul 10, 2018 at 10:02:27AM +0200, Máté Eckl wrote:
> > >> On Mon, Jul 09, 2018 at 11:35:09PM +0200, Arnd Bergmann wrote:
> > >> > It is now possible to build the nft_socket module as built-in when
> > >> > NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=m set manually.
> > >> >
> > >> > In this case, the NF_SOCKET_IPV6 functionality will be useless according
> > >> > to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
> > >> > IPv6 select dependencies"), but on top of that it also causes a link
> > >> > error:
> > >> >
> > >> > net/netfilter/nft_socket.o: In function `nft_socket_eval':
> > >> > nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_v6'
> > >> >
> > >> > This changes the compile-time check so we don't attempt to use
> > >> > the NF_SOCKET_IPV6 code when it cannot be used, and make it all
> > >> > compile again. That may lead to unexpected behavior when a user
> > >> > enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
> > >> > logical conclusion of the 35bf1ccecaaa change.
> > >> >
> > >> > Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
> > >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >>
> > >> I think this should be fixed in the Kconfig rather than inside the module(s).
> > 
> > Should we revert your patch then, or do you have a better idea?
> 
> Máté, would you resubmit a new patch that addresses all the problems
> that Arnd is reporting in one go?

This patch only solves the nf_socket and nft_socket modules problem so I can
only submit a v2 for 'netfilter: Kconfig: Change IPv6 select dependencies' but
you already applied it so it would meen a force push. Should I do this?

I think Arnd's patch solves these problems in case we don't want to force-push
or rebase.

> I think it's better if we toss your original patch in the tree and
> rebase, ie. take the new one that fixes all issues that Arnd is
> reporting. It would be good if we can sort out this before I send the
> next pull request for net-next stuff.
> 
> I was afraid of fallout like this when I saw your original patch,
> kbuild is always tricky.

This patch is not related to the nft_tproxy module (it seems that you refer to
that) as Arnd didn't have that in the tree when doing this. I'll send a v4 fot
the tproxy module, but that cannot be related to this one as it is not in tree
yet.

> Please Cc Arnd, Florian and me for review.
> 
> Thanks!
