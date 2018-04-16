Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523896798-2-13511503445191476628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523896797; b=EiCyo1Z83JV/wUh6l9f21bexV5OdxVfQto+w2RDQS16zHGJzA1
    +ZKlTvZToU68z+03iix5z0caKoyubBDl3J1VbQMMZm+HM6AzYnBQosPyrkEdF1Cs
    TD4oFdqtI3sC7SwWBdpYUEzsAy4qg650EZjG4YRr+qgDFtXznDovUZcaW7sMExIt
    f+G4/2D8nXUPTdJoiXVoU7FLgBL3YEj+gFudbVKJtMPrdLdbj5oio22umci5oi5c
    q7EcS60Dj9aDaHJwWYuWDCQLbvoPzrV1LlWi8GMHlu7VfGfp/X5uQjy56Y2jdATV
    NqhcSI9PWMQ58ryht/ZfXxUD2pDPqhVpfISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523896797; bh=fo2IC+q/wsA4bSYebBjwtIszgjMnca
    oMEkwdqKVd0TA=; b=ozRxxv+L1e2p/6hMc7lXE+gtI11nsjuXHOkHQSQRpIJjSt
    tiVTd0BXlNR7cuTCOzsMGza7jNd/KjS7iTOgMAlSdVp9QA3QhvMQUFlFAyQQMT07
    xrZzYw04zguVC1bsRXzXrcUnfjlPmJacRA1Jku5nALvcyK8XHFdzlEZiBmh2mWol
    HZ9zDTgsKrR7Eyzp9QlzkHcPXV6DRkVlFGIw/KSImHHwB4fOwqpH5hcB7Xzlb5/+
    lhGQqLPqWzmozSFYLELCseUHg9IMhq5IkYPkPc7V+k6BkCTZUjkAqhD/gOn7LdG4
    jKZdvCXJt/7o8ae0dQjEweq1rezlCDQheQaP9lkQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9HB5CVgnfh4zvxavwryXYDoo+gbvFeEMSC+BkBS7IgmvlBVBEs8Jxyz84z0SU4twrnt372SWUw33Pu+8H17+D0EziznBOFFGV4cc5uQfI+UHszgulU
    HXoVriTCp5Jn1hfIuQCuXIJ94kjzuBbniB33/9GWxSFsm5NQlJomQni2/zsalvi91Z/2n2NEaJbGQJVWHBTlOq430Q03SDxqbGDOLw4cd6ni9dBkgD10+Hie
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=papLBdEcFvpwAIJBx2QA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=uQVyEQHFqsH8K7bieEMA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeDPQj4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:39:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46606 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDPQjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:39:55 -0400
Date: Mon, 16 Apr 2018 18:39:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416163952.GA8740@amd>
References: <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20180416162757.GB2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 16:28:00, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 12:20:19PM -0400, Steven Rostedt wrote:
> >On Mon, 16 Apr 2018 18:06:08 +0200
> >Pavel Machek <pavel@ucw.cz> wrote:
> >
> >> That means you want to ignore not-so-serious bugs, because benefit of
> >> fixing them is lower than risk of the regressions. I believe bugs that
> >> do not bother anyone should _not_ be fixed in stable.
> >>
> >> That was case of the LED patch. Yes, the commit fixed bug, but it
> >> introduced regressions that were fixed by subsequent patches.
> >
> >I agree. I would disagree that the patch this thread is on should go to
> >stable. What's the point of stable if it introduces regressions by
> >backporting bug fixes for non major bugs.
>=20
> One such reason is that users will then hit the regression when they
> upgrade to the next -stable version anyways.

Well, yes, testing is required when moving from 4.14 to 4.15. But
testing should not be required when moving from 4.14.5 to 4.14.6.

> >Every fix I make I consider labeling it for stable. The ones I don't, I
> >feel the bug fix is not worth the risk of added regressions.
> >
> >I worry that people will get lazy and stop marking commits for stable
> >(or even thinking about it) because they know that there's a bot that
> >will pull it for them. That thought crossed my mind. Why do I want to
> >label anything stable if a bot will probably catch it. Then I could
> >just wait till the bot posts it before I even think about stable.
>=20
> People are already "lazy". You are actually an exception for marking your
> commits.
>=20
> Yes, folks will chime in with "sure, I mark my patches too!", but if you
> look at the entire committer pool in the kernel you'll see that most
> don't bother with this to begin with.

So you take everything and put it into stable? I don't think that's a
solution.

If you are worried about people not putting enough "Stable: " tags in
their commits, perhaps you can write them emails "hey, I think this
should go to stable, do you agree"? You should get people marking
their commits themselves pretty quickly...
								=09
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU0dgACgkQMOfwapXb+vKZNQCffEDUMR9dsaiM6OWcxujTun0x
yFwAmwQdBZnRo/K55M/VNiSnmOOKXC9H
=ZOmi
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
