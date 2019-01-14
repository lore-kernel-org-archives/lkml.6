Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24DE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhn3wPTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfANNKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:10:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44123 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfANNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:10:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id o8so10424910qkk.11;
        Mon, 14 Jan 2019 05:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEzRm9NgrM0eHoivspEjx4ML/GC91Om340BxWzEq9XI=;
        b=Jhn3wPTf3Qd58FSP0KOS86YVQAILNk9ikP306lngaEQrf4EL8hy37yghriuaoZ0aAB
         VSNHu61+RbJeq8LHrfDV6PGYg0tdXmdoX/9lPho5RH5CBZLVQ+69BJUaybIxkRYJL1/8
         Q51eivQ6SvFh5TEsnxsdLX/DLM71NsjlKc+4kgQMdQbVQ/555cJf6wm4W/I+nBcHRKZV
         rcmNgz9OILTxE1hKbZxx/HntR6ePjPiRsF7tfPwuDGgou5pLl6yPv1Uh80TfqSik0if6
         KrltoCkQUzmk+Nlz1dYapnuxyeoJ9emq2SYl6O4s0/dOEbf9WRE1Pc/OQRjuG+JeRK7s
         jsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEzRm9NgrM0eHoivspEjx4ML/GC91Om340BxWzEq9XI=;
        b=MHymdpsNCO4NNcEPw6NsYqsBLWI42H9sU5BhYwHGPlRfG/7gWRUJzz9M5X5ynE3X8V
         HuXDE/ThbTb+d/ODWPjOYL513smFoizpPhknmIlIATcSCNcctTRx8JK4qFoYhrseeI0I
         30uuKfOsGnzmZVsN+hH29V0j/txSz4jTuO1RbttQBJfFvdsjeyLD5Z6iVE2QCm0UVE7d
         hx8RfENBEqly0q5LZLFxrAlH3iXXjmUrtrcSMiJCTA3nOn604GvZJ2qW+sb7NGIrAB+s
         KkI9AeFQB659u5OfOaBbwJ5MLsWrL5OtV3qhHEh1paxezce8xuFCFXMBsg8e8tGIWbTo
         kOvQ==
X-Gm-Message-State: AJcUukddjgPhS6ylRv/TMmKP7b1C4QIIay3SWda3RJXt2SO9U5hgLSvR
        93Yt1JU4hlIHNU2xnKG8u84=
X-Google-Smtp-Source: ALg8bN45euhwpsEMJIZd3GouojSENUNQSnUyxqqRBhD1pPSmHUlVF2DmstYuXPOukYaxPTq/do86rw==
X-Received: by 2002:a37:5002:: with SMTP id e2mr22944141qkb.169.1547471427907;
        Mon, 14 Jan 2019 05:10:27 -0800 (PST)
Received: from localhost.localdomain ([168.181.49.80])
        by smtp.gmail.com with ESMTPSA id z30sm56644206qtz.26.2019.01.14.05.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 05:10:27 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 1283F180B6A; Mon, 14 Jan 2019 11:10:24 -0200 (-02)
Date:   Mon, 14 Jan 2019 11:10:24 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Neil Horman <nhorman@tuxdriver.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH net] sctp: allocate sctp_sockaddr_entry with kzalloc
Message-ID: <20190114131023.GP23855@localhost.localdomain>
References: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 06:34:02PM +0800, Xin Long wrote:
> The similar issue as fixed in Commit 4a2eb0c37b47 ("sctp: initialize
> sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event") also exists
> in sctp_inetaddr_event, as Alexander noticed.
> 
> To fix it, allocate sctp_sockaddr_entry with kzalloc for both sctp
> ipv4 and ipv6 addresses, as does in sctp_v4/6_copy_addrlist().
> 
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Seems you were faster than syzkaller, but we could still use:
Reported-by: syzbot+ae0c70c0c2d40c51bb92@syzkaller.appspotmail.com

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> ---
>  net/sctp/ipv6.c     | 5 +----
>  net/sctp/protocol.c | 4 +---
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index b9ed271..ed8e006 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -97,11 +97,9 @@ static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
>  
>  	switch (ev) {
>  	case NETDEV_UP:
> -		addr = kmalloc(sizeof(struct sctp_sockaddr_entry), GFP_ATOMIC);
> +		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v6.sin6_family = AF_INET6;
> -			addr->a.v6.sin6_port = 0;
> -			addr->a.v6.sin6_flowinfo = 0;
>  			addr->a.v6.sin6_addr = ifa->addr;
>  			addr->a.v6.sin6_scope_id = ifa->idev->dev->ifindex;
>  			addr->valid = 1;
> @@ -434,7 +432,6 @@ static void sctp_v6_copy_addrlist(struct list_head *addrlist,
>  		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v6.sin6_family = AF_INET6;
> -			addr->a.v6.sin6_port = 0;
>  			addr->a.v6.sin6_addr = ifp->addr;
>  			addr->a.v6.sin6_scope_id = dev->ifindex;
>  			addr->valid = 1;
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index d5878ae..4e0eeb1 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -101,7 +101,6 @@ static void sctp_v4_copy_addrlist(struct list_head *addrlist,
>  		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v4.sin_family = AF_INET;
> -			addr->a.v4.sin_port = 0;
>  			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
>  			addr->valid = 1;
>  			INIT_LIST_HEAD(&addr->list);
> @@ -776,10 +775,9 @@ static int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
>  
>  	switch (ev) {
>  	case NETDEV_UP:
> -		addr = kmalloc(sizeof(struct sctp_sockaddr_entry), GFP_ATOMIC);
> +		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>  		if (addr) {
>  			addr->a.v4.sin_family = AF_INET;
> -			addr->a.v4.sin_port = 0;
>  			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
>  			addr->valid = 1;
>  			spin_lock_bh(&net->sctp.local_addr_lock);
> -- 
> 2.1.0
> 
