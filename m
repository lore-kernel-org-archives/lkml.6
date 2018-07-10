Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC6220878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMfK8KOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC6220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeGJIFo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:05:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56253 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeGJIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:05:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id v128-v6so6053063wme.5;
        Tue, 10 Jul 2018 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AEMtbuUhv/qRM3s7RRCVxxLavMk2dUJQTwmx2LJebgs=;
        b=eMfK8KOLCQ81Qhxyaf4lB5w8cw/HqZB7cwi5Bvj4m+D9z/khXxADaI0PERkUnY2Dyz
         LlzGTjPYnXmEXGIisTyV7w6KsNko/Um6xToI87A88xwUzB1EGxZRMgbMOkrB8pB00t9r
         DTcakFHOcSbV26vPwoNIGz83gQ/uOSSVitT5DcktsUV0v50WmQPOzxM195MytM2a+YOw
         0osiUhGwqu5hLNw8XlESoDaEXlsSFbPd6w0QtpCsz1x+CC6kCrnyy7nSUI+45CAJAjLU
         aRSZ0f6ZhPv2rYSfgxWcMRCzPKsxwL8F7xbLgfl4U72uPc73b5cvdPv0janVWwUF2EEc
         ddhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AEMtbuUhv/qRM3s7RRCVxxLavMk2dUJQTwmx2LJebgs=;
        b=sNHcdQ/jfOQAiVE3S+QlbqXqRjChgKk7QLz4BdCL1eFaZHr74ZaYFsyLSMMnOwumRw
         WsLggWbInM2acVud4Qq8IJiBp0E8UUmIj7PmAeVUmCU2MSv2FgAtWruzYPWmpOGA8odh
         PNqvPE0GjHjaUkoMHWDWsbMwFUbCx3GN5iox8REH/TB0BbBdoPblCftzSObdFLKViR5i
         f7cAjpOKEcuO8jc+/+p2sOYV7gkZ+llE8+5Htog6tlKRolYKfJNo1T/Xq7jvgRlV7L4Y
         mjMDJMsC93uhxIxTwtM5CGxZR5X1OU8tE2oMgkJgYr8hwqM1otl+u1iXy8l9LwRqv84x
         D+nA==
X-Gm-Message-State: APt69E1ZMFuQ4Y87PfmWUSZo9nV7BH9TweBqFE2qpM5I9+rkDxOI87zx
        fW/j56ZTzXAmhwMbisPFfJo=
X-Google-Smtp-Source: AAOMgpc1MzK643hSMah5QL5y+iA1LAlw7FImrEgRfKG2bVWRJqemGxRqURyzzV1DSI/jwDMXocttiQ==
X-Received: by 2002:a1c:bd5:: with SMTP id 204-v6mr15240129wml.160.1531209940021;
        Tue, 10 Jul 2018 01:05:40 -0700 (PDT)
Received: from sch.bme.hu (ecklm-pi.sch.bme.hu. [152.66.179.182])
        by smtp.gmail.com with ESMTPSA id c13-v6sm3689260wrt.24.2018.07.10.01.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 01:05:39 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:05:38 +0200
From:   =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without
 NF_TABLES_IPV6
Message-ID: <20180710080538.d7xqpjdvpksfrx6o@sch.bme.hu>
References: <20180709213537.2748896-1-arnd@arndb.de>
 <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:02:27AM +0200, Máté Eckl wrote:
> On Mon, Jul 09, 2018 at 11:35:09PM +0200, Arnd Bergmann wrote:
> > It is now possible to build the nft_socket module as built-in when
> > NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=m set manually.
> > 
> > In this case, the NF_SOCKET_IPV6 functionality will be useless according
> > to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
> > IPv6 select dependencies"), but on top of that it also causes a link
> > error:
> > 
> > net/netfilter/nft_socket.o: In function `nft_socket_eval':
> > nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_v6'
> > 
> > This changes the compile-time check so we don't attempt to use
> > the NF_SOCKET_IPV6 code when it cannot be used, and make it all
> > compile again. That may lead to unexpected behavior when a user
> > enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
> > logical conclusion of the 35bf1ccecaaa change.
> > 
> > Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I think this should be fixed in the Kconfig rather than inside the module(s).
> 
> I did some investigation and it turns out that you missed a circumstance. This
> link error occures only if NFT_SOCKET=y && NF_SOCKET_IPV6=m && NF_TABLES_IPV6=y
> (cannot be m here if NFT_SOCKET is y). And probably the same with
> iptables-related modules. Probably this possibility should be eliminated.

NF_TPROXY_IPV6 might be in the same situation.
