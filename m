Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520494446-2-8991108935508101685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520494445; b=ENqHRCdziB/KRfNHVq9BJ0Ur9Jp/ydiE0TgDEdy4o8slKWO
    WCPmp8nQZFJGRWwgvIaUyrwP9I7oJmuzYc8dutEgsq0eBa80DDQflq4NsEZoxKAP
    ltlDx68cQahpFrCUzSsMm6dMKOvYFZttylTdhI1Utr5vH6Pc3RbxIXIRg33aqZP2
    WcWGfRIhvsTzuYIEQJ8Yfyz0bB72q704egY5vM3wEXptCJRYLYE0y0eIunmXD2iz
    lUskr9+3xTovUZV6NG+vZfZRBjDJlloF/AJ72jZoIQc5MQ27BJmjv4p8fe69zYOM
    YeXS6Az8Fh9BG7ic0t6T+2RYxpp4POjLgHj0Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520494445; bh=FZYsThoLs7/IS3X6YD9m8MgsDQ
    8MmNg8Gd98FSrBSGo=; b=EUTPWoDT3GbgauC6QQ7OLyvqyv+DDLptyWcfPPIotc
    rJfqhEeZgMsfzG2yx9eExG/xJ+TFZsp5J/GebSfYU+ywxyv2TRNWqqpM7yKojeqa
    pJ5G7/KAw9syB/JYAigIpZul+3X8rMC7mUmM+Ytk2w76aLpjFCyUmlFXSxj6V9ua
    tDd+Oz2yccv/pev90uB/pHDVcyGrqjUWIDkxCWhu4WsKYBhntD8YmLXMnl1bZO0G
    UcpqzumSEUhBlO2A4QfhyDcokKXcF2uwdLFLnWYkKy+F5znvK4F2R6ZUhmzEG+WH
    keT4tPGRcxJaKGzYna7ywanDyQFHmp0hlAnPYzXyJpvA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeCHHdq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:33:46 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:46978 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeCHHdp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 02:33:45 -0500
Date: Thu, 8 Mar 2018 15:33:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg Hackmann <ghackmann@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
Message-ID: <20180308073328.GA8111@gondor.apana.org.au>
References: <20180307192416.233202-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307192416.233202-1-ghackmann@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 11:24:16AM -0800, Greg Hackmann wrote:
> f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added a
> __this_cpu_read() call inside ipcomp_alloc_tfms().  Since this call was
> introduced, the rules around per-cpu accessors have been tightened and
> __this_cpu_read() cannot be used in a preemptible context.
> 
> syzkaller reported this leading to the following kernel BUG while
> fuzzing sendmsg:

How about reverting f7c83bcbfaf5 instead?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
