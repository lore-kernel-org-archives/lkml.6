Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3161771-1520947489-2-9214352702559500535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520947488; b=PZw/a+N5bp18EtKmYEWJO/0LacJBR06QmJPxu8apoeemkvY
    tBnyq0itmbbg/u31f0VUz7eyB3Os7ci6VwXBux3VQ1qB02NaViKrYqQsJ4m+EgNk
    +2Q+Uq9fdzhklAZ+emssuHEvY4PRl5aU9IMzU3WrloF/vE70KrVp9cHTdAvq0Sy5
    5PpejuBS3zVITRRyUNZXRI959hWspN/FxrOiR57wcc2hOpsdkHZZ2NaLYJiHj+JD
    OQuxcFIv68FTyC8hOAHnj+diUjPnn737v5UB1zz+8d64sd0dVzxwK3+QrSIQDBpA
    bBpWChwWUFvRc64EdnNp0PG+6CRE0jnq9qiO+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520947488; bh=raFkgcF1baIVEpiwhxCfDAmpceIkk13D9ElazFEOfX4=; b=X
    rBMg8goL1HSDbjGkwFmyNIqGmivmrwvRZPvm3OsWhBEYo+hszMjc4ClBIEu6dRBG
    YYtHbBHftSWkfGv6cALQvnPcA+vqQy1O6HtU3CexkkFLqJS0YbtblBbJ8tdCywFb
    5Tw+9LLy1eTtZzyFMtwyq7Pr3gnauwQ7zpIfG+pGFJq2e+TmswstfXCNejhtOpkH
    lof0aaJp3U2lzixX38xCArPJKi9l5T0Qr8htDsVo9RDIxtMsjMjrdofb59nrWArl
    h43tCDWmnuYF/+cKpqYibv3h7idYbDkLCmKUWXZkBiZFME+JcHIAWlc/ANQi1nWe
    5ceHLfHU8RELl8rLNTHYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeCMNYp convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 13 Mar 2018 09:24:45 -0400
Received: from ozlabs.org ([103.22.144.67]:49065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeCMNYp (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Mar 2018 09:24:45 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap copy
In-Reply-To: <20180310194742.GA12279@kroah.com>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr> <20180310001043.GD13963@kroah.com> <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr> <20180310145258.GA6874@kroah.com> <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr> <20180310194742.GA12279@kroah.com>
Date: Wed, 14 Mar 2018 00:24:41 +1100
Message-ID: <87r2oof6qu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Sat, Mar 10, 2018 at 05:14:22PM +0100, christophe leroy wrote:
>> Le 10/03/2018 à 15:52, Greg Kroah-Hartman a écrit :
>> > On Sat, Mar 10, 2018 at 08:27:54AM +0100, christophe leroy wrote:
>> > > Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
>> > > > On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
>> > > > > Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
>> > > > 
>> > > > There is no such git commit id in Linus's tree :(
>> > > > 
>> > > > Please fix up and resend the series.
>> > > 
>> > > I checked again, it is there
>> > > 
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d
>> > 
>> > That is linux-next, which has everything and the kitchen sink.  It is
>> > not Linus's tree.  Please wait for these things to be merged into
>> > Linus's tree before asking for the to be merged into the stable tree.
>> > That's a requirement.
>> 
>> Oops, sorry, I thought everything on kernel.org was official.
>
> That would be a whole lot of "official" :)
>
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for what the rules are here, if you haven't already.
>
>> Once it is in, do I resend the patches or do I just ping you ?
>
> You would need to resend the patches (if they need backporting
> manually), or just send a list of the git commit ids that are needed to
> be applied (usually easier.)
>
> Also, why were these patches not tagged with the stable tag to start
> with?  That way they would be automatically included in the stable tree
> when they hit Linus's tree.

Because they're fairly large and invasive and not well tested on other
platforms, so the maintainer is not comfortable with them going straight
to stable :)

Once they've had some testing in Linus' tree at least, then we'll ask
for a backport if there's no issues.

Sorry for the confusion.

cheers
