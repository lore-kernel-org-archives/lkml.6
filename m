Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-866468-1519070784-2-11265375577536171530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519070784; b=hUbvK4olnfQs2+pVIB5frBBXmf1Kkfehl6oasGzXqU8rOIF
    xW2/hbHTnyiajg6gl766zOUUIvCfWzngCu3mu7rNA76GRtuhqFwdCkRjqAv+CuOc
    9O5jTI7MUthB7PM0zGe4eIYVRNP0z78brpP7yG99Q8eFfgAPBv5q8bEEED/rXaT9
    jO+MDXATkTCku9gCVVT44g4Tr0Nr7xdKvoqy3q3wNOmOFxdz5mrZ+kFjV4DGBSWT
    kvrE4N0Yqol1LR5ze7s55ahjatC7G1Lv1sVaFU0pPHrX1xrUQp9f3NLEJj84F3Bx
    dwbjad3429Q//5Ti0gS4Sa4yDSgd3USmLCl2RLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519070784; bh=AXiRN/ZojQ8ULmzhxuCartAuo0trE7Et/TgeSp
    QdHS0=; b=UcfO/jVAMNklFQXzFau0cqQfD2I1/EhSttMCRiPCg+/6KfCx5fG1GY
    JHiHCBVs54n8fMwOA79Nm9dbgiL/ZejlRd+fRWuCE3VkI8d24gWr4vFvBy43gcgy
    0YzEhUu2WwZRd29dvAQsFE1nHcsNMKG9kOq9j/ggLuxbP4KQGcSzondkGLgfxYBf
    JKbY/2tPJFQPwWlm9KKa1GK8AI90Rx9PkvdzyoGlKere/vrR0Bg1MPchMJqpHJvm
    VuF4Tim7lTkS13J31xnGMLprbUR3blgnoyfaw+WtnPiKxIK4rk3UT1NcZbw9+mfY
    UB+S3iAWjHEBib2rImUjOql0x2NL/Qkw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=j8x04ENk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Rk0xVyWF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=j8x04ENk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Rk0xVyWF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753727AbeBSUGX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 15:06:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38042 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeBSUGW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 15:06:22 -0500
X-Google-Smtp-Source: AH8x224Dz9QP6E9WfOmXIYQHGAQOFmSnmN20mRjq5OZ43c8hkB+z7FtwBS/t6ZpoMHRnWw1+GwKSZJzmdcAbm53/8sc=
MIME-Version: 1.0
In-Reply-To: <1519069941.3422.65.camel@codethink.co.uk>
References: <20180129123847.507563674@linuxfoundation.org> <20180129123850.261403857@linuxfoundation.org>
 <1519069573.3422.63.camel@codethink.co.uk> <1519069941.3422.65.camel@codethink.co.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2018 12:06:19 -0800
Message-ID: <CANn89iL=8vgByOoJ5bbFVF+DJN2-QrMn4ihE6cM42WaSxSwz4Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 60/74] ipv6: fix udpv6 sendmsg crash caused by too
 small MTU
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Mike Maloney <maloney@google.com>, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 11:52 AM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Mon, 2018-02-19 at 20:46 +0100, Ben Hutchings wrote:
>> On Mon, 2018-01-29 at 13:57 +0100, Greg Kroah-Hartman wrote:
>> > 4.4-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Mike Maloney <maloney@google.com>
>> >
>> >
>> > [ Upstream commit 749439bfac6e1a2932c582e2699f91d329658196 ]
>>
>> [...]
>> > --- a/net/ipv6/ip6_output.c
>> > +++ b/net/ipv6/ip6_output.c
>> > @@ -1246,14 +1246,16 @@ static int ip6_setup_cork(struct sock *s
>> >     v6_cork->tclass = tclass;
>> >     if (rt->dst.flags & DST_XFRM_TUNNEL)
>> >             mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
>> > -                 rt->dst.dev->mtu : dst_mtu(&rt->dst);
>> > +                 READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
>> >     else
>> >             mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
>> > -                 rt->dst.dev->mtu : dst_mtu(rt->dst.path);
>> > +                 READ_ONCE(rt->dst.dev->mtu) : dst_mtu(rt->dst.path);
>> >     if (np->frag_size < mtu) {
>> >             if (np->frag_size)
>> >                     mtu = np->frag_size;
>> >     }
>> > +   if (mtu < IPV6_MIN_MTU)
>> > +           return -EINVAL;
>>
>> This error path appears to leak a reference to rt->dst.
>
> Never mind, I see that the callers release it.

Yes, I agree this is quite confusing :/
