Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ECE208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/y2m/6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ECE208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933452AbeGJICf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:02:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42178 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932949AbeGJICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:02:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1-v6so13531071wrs.9;
        Tue, 10 Jul 2018 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJDIWMcHtjcafklLuasi/g6glssiDYW4BXgGXO5UIs0=;
        b=e/y2m/6qUYU3TdVK63Wc3yC6h1rRIs5TMTnlTpKdkp7l1/F/FaH2Vb7oIBoGFINNBk
         /gtsIle7UVkO0pOqhKnkYs79bMoWpSXkW9aLUEOgsJZrfD7bOScSEjsw5b5ub3kF/gDy
         bgbwIJCUkj7955aIWbx4sfgu2pGvZ/czTBgfnxtzUUKwMkoHi2rLLNdkdZk4n/JOJumR
         XQQ8/IyxThAvl+hlnhsOtwyqcfwU9stcZF1sa1Z6HWozuU9gzVeKrEgDwMK0cYPTtueX
         yyHrlh0/eNTcb4xkd/cR0NMS/vwvuirw3F2E/CxLW3V105jvcXCEvV5mDRs1uRipWna1
         lVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJDIWMcHtjcafklLuasi/g6glssiDYW4BXgGXO5UIs0=;
        b=npd+t30KQ6Ly+GmhmPxYEV/XZljil9A+ASAOp8MgSwG4iqUytu6oXaaK/Su4pUdudj
         Z60Rgy0sCBEfOd2SyhCdaw04omEqN1jdtOPwmweQ5YUCRptQwjD835o1n6FWDH8U4FZR
         RtrPk2a2YlWmrIbgkB2x1kOaRsHCqczJaeBSXccqNXvFC8hxpqezx0VJhQjya5guzehS
         aQXb9dN068eVHfwZWDtfGcUN4tniy6x1MN8fhI5nN++eIS93ir9qDLBccy+oGYZtp9j/
         /FXN3xF1/NdbPL+8L2fXanscFi1u08x56D/ManBOJaUPR/0wCZih5jXT3xB0U+reUU7A
         O3Ag==
X-Gm-Message-State: APt69E19kk5i8OMcrNdpN96jLjvnbRwIWbLMDV+dbxEN+/qpWdh7saNj
        0nNdyEgY14e5xVC3ikctP/rDI50H
X-Google-Smtp-Source: AAOMgpcdqxSO+j1hJabV2jXWYEapgD9x8jJqlHk0BPczASeU3wJ2zdoKBTQQKli27jxjOiLaJqgDyA==
X-Received: by 2002:adf:9465:: with SMTP id 92-v6mr18772615wrq.283.1531209749267;
        Tue, 10 Jul 2018 01:02:29 -0700 (PDT)
Received: from sch.bme.hu (ecklm-pi.sch.bme.hu. [152.66.179.182])
        by smtp.gmail.com with ESMTPSA id 72-v6sm15748374wmh.0.2018.07.10.01.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 01:02:28 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:02:27 +0200
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
Message-ID: <20180710080227.qwh53ahq26j6phhd@sch.bme.hu>
References: <20180709213537.2748896-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709213537.2748896-1-arnd@arndb.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:35:09PM +0200, Arnd Bergmann wrote:
> It is now possible to build the nft_socket module as built-in when
> NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=m set manually.
> 
> In this case, the NF_SOCKET_IPV6 functionality will be useless according
> to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
> IPv6 select dependencies"), but on top of that it also causes a link
> error:
> 
> net/netfilter/nft_socket.o: In function `nft_socket_eval':
> nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_v6'
> 
> This changes the compile-time check so we don't attempt to use
> the NF_SOCKET_IPV6 code when it cannot be used, and make it all
> compile again. That may lead to unexpected behavior when a user
> enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
> logical conclusion of the 35bf1ccecaaa change.
> 
> Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think this should be fixed in the Kconfig rather than inside the module(s).

I did some investigation and it turns out that you missed a circumstance. This
link error occures only if NFT_SOCKET=y && NF_SOCKET_IPV6=m && NF_TABLES_IPV6=y
(cannot be m here if NFT_SOCKET is y). And probably the same with
iptables-related modules. Probably this possibility should be eliminated.
