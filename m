Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-827994-1519069974-2-14200725569417111704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519069973; b=PoZUGfiLggAab/hECPt73qoZ8B+EleGWqozaYJclBnbCyoH
    tbWoy2/0wtKNxRyBvo5yy5MWkGKUM5O8tzg2qlTdKdjN/9VSOPJMBcIB2pdP1EPk
    QSLFgWVcEJevC85quHe1ntRThsD7GyGqQdE8SuI7GisW/MyyjGmRkLau4qPiCXQm
    xCLZmndAYTHKowkPXvGYXXnGuhCAwbnaguLzWI2//hCiNx/KMrxYCxZp9MAAZ1yw
    KEK9ZjMCHopXPmQ9mJrDAU7XtkDxU5WDlVe1Jph8J+BKZvPNI0Mran0rnIng+okU
    E3oe1Wxagm4KwHjsJRfEa5L6eirGU7nE/k2eOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519069973; bh=O6Jkx/u7CtPrbYlwcJuQK4KEH1ubVC9I7nw4mY5NSUQ=; b=H
    Auu+hZXWZcqBfCo0XkkYCbBdy4WWdYZ7F3sxvLdSvosBMaqxPuxd+C79+f3VLbGx
    JU17/oXvlS88daIIRMTmmQWGTEmIzHB+UYST3pwFgH3CTYT9DKqIJ3qfnEag8rlM
    VH/8dmUgF2wVn1KVuSKvpbdmEdrdEd4VZo8WOC1/e6gWPQ2EMNfV4lCWl67Ldzpz
    tfvn5FcsDl5jhb1tJYlmiEy+2A0OK+uNWvfDM7riBJvU8Zrou7u2Buheta/qGrjB
    zI0/fDCIMpNbHAmLsKShCTZYHctAq4kCj0xdkmAm8kHkXkrDs9WpmXBJvjeQ7nkT
    XB1PfygFLW3MZNLmh/Y7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeBSTw3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 14:52:29 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:50375 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeBSTw0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 14:52:26 -0500
Message-ID: <1519069941.3422.65.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 60/74] ipv6: fix udpv6 sendmsg crash caused by too
 small MTU
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Mike Maloney <maloney@google.com>,
        Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 19 Feb 2018 20:52:21 +0100
In-Reply-To: <1519069573.3422.63.camel@codethink.co.uk>
References: <20180129123847.507563674@linuxfoundation.org>
         <20180129123850.261403857@linuxfoundation.org>
         <1519069573.3422.63.camel@codethink.co.uk>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-19 at 20:46 +0100, Ben Hutchings wrote:
> On Mon, 2018-01-29 at 13:57 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Mike Maloney <maloney@google.com>
> > 
> > 
> > [ Upstream commit 749439bfac6e1a2932c582e2699f91d329658196 ]
> 
> [...]
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -1246,14 +1246,16 @@ static int ip6_setup_cork(struct sock *s
> >  	v6_cork->tclass = tclass;
> >  	if (rt->dst.flags & DST_XFRM_TUNNEL)
> >  		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
> > -		      rt->dst.dev->mtu : dst_mtu(&rt->dst);
> > +		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
> >  	else
> >  		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
> > -		      rt->dst.dev->mtu : dst_mtu(rt->dst.path);
> > +		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(rt->dst.path);
> >  	if (np->frag_size < mtu) {
> >  		if (np->frag_size)
> >  			mtu = np->frag_size;
> >  	}
> > +	if (mtu < IPV6_MIN_MTU)
> > +		return -EINVAL;
> 
> This error path appears to leak a reference to rt->dst.

Never mind, I see that the callers release it.

Ben.

> Ben.
> 
> > > >  	cork->base.fragsize = mtu;
> > > >  	if (dst_allfrag(rt->dst.path))
> > > >  		cork->base.flags |= IPCORK_ALLFRAG;
> > 
> > 
> > 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
