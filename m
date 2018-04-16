Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523897697-2-17960877170441469630
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
    1523897696; b=qtolqyiepoZ82DgoioEidEeUsJJyYEAsxJp2UpPEjLEbsF3cDN
    dmoynJNk4YQeZqJfQeiSUN8xGyZg1m0ALHX3uUXxKmmRMQjPnzHXwA3CGeerhMnG
    e3uZvGf99PG6q9UO+gyM9YJG+vM4DK1fYFAAJ5FKSGx3Oh2mpE0v4t4yYhGDoRR2
    GO9C+tpg/xwkPonK2QJBiAPrYwCkXfy+IRSqVffnmBOfQMQnhfiAyhhGfbeClwvV
    dyWTH1ELVKADftqOzkJ2eALBhUOP+I0tdxuMfpxf91+wVQIsiQWsWlmQ/5wnXCsx
    UIUKHGCFM9QFDvhluqxBjxefNZvFiSmfcYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523897696; bh=pngJG2h/Ygn4RHWPOw6TI+lb5e+dXu
    2SxhKi5OIMjFE=; b=IkicAnVNIBchQU/wPi9gSb47BF2yAZ8Q2r9mGh/qe34NrJ
    AVvlfewD2e5VYisCpqMCWHW0EPnm5kW9TjthfnP1wUPQ/gS09moZHnKYFW9g7RH6
    LuhZ9AFd6zdR1ITLcxbx0E5LnbZ3sjUeSU1cSiw3MhXQHuo9LMEmEebkjtIu2QIi
    g/v+1wGD5BshtQdE90wwZ3ssm8EUn6NNcwPSAMcRtgs69FHQ5MIdfmo3MotNS5Lj
    Eetbpwb43ZRqtimfJ0VZbKUZIr1FdqI9iPOEBQERuwtEcoTadny/ESs6tuOa4nyX
    ThQcyfua9BuZBrZq3+JQEaXCZmDfXKZlgnoNeOHQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfCTpIsT6udjHQdHM95pxyLlR+ad3CXSbbm/pxSwGymAmHZ332AzccAzMef68hVgTUo5Ni6etmXI7H9RQ4a4WvNYHSUD4H7zSu9kuz5m5GVZtBrgXUucl
    F4qFfhdHQs9HrWfPADIZXsO5ru8B4MHfo21VMmt28t3bOLThqA7unvWK+WENXw4hu3/BaUh3xTtsznLpszEZQdqOK5aEftys6lIQV+Q+vkP//RNVBgVDbngS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=qFmplEPGfZiViYZX9p8A:9 a=0iKm4ENoWw4u3wPs:21
    a=s15vpIE76rrINLa5:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=_MNecUK3ljkc6PbEROEA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDPQyy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:54:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47083 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbeDPQyy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:54:54 -0400
Date: Mon, 16 Apr 2018 18:54:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20180416165451.GB9807@amd>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416162850.GA7553@amd>
 <20180416163917.GE2341@sasha-vm>
 <20180416164230.GA9807@amd>
 <20180416164514.GG2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20180416164514.GG2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 16:45:16, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 06:42:30PM +0200, Pavel Machek wrote:
> >On Mon 2018-04-16 16:39:20, Sasha Levin wrote:
> >> On Mon, Apr 16, 2018 at 06:28:50PM +0200, Pavel Machek wrote:
> >> >
> >> >> >> Is there a reason not to take LED fixes if they fix a bug and do=
n't
> >> >> >> cause a regression? Sure, we can draw some arbitrary line, maybe
> >> >> >> designate some subsystems that are more "important" than others,=
 but
> >> >> >> what's the point?
> >> >> >
> >> >> >There's a tradeoff.
> >> >> >
> >> >> >You want to fix serious bugs in stable, and you really don't want
> >> >> >regressions in stable. And ... stable not having 1000s of patches
> >> >> >would be nice, too.
> >> >>
> >> >> I don't think we should use a number cap here, but rather look at t=
he
> >> >> regression rate: how many patches broke something?
> >> >>
> >> >> Since the rate we're seeing now with AUTOSEL is similar to what we =
were
> >> >> seeing before AUTOSEL, what's the problem it's causing?
> >> >
> >> >Regression rate should not be the only criteria.
> >> >
> >> >More patches mean bigger chance customer's patches will have a
> >> >conflict with something in -stable, for example.
> >>
> >> Out of tree patches can't be a consideration here. There are no
> >> guarantees for out of tree code, ever.
> >
> >Out of tree code is not consideration for mainline, agreed. Stable
> >should be different.
>=20
> This is a discussion we could have with in right forum, but FYI stable
> doesn't even guarantee KABI compatibility between minor versions at this
> point.

Stable should be useful base for distributions. They carry out of tree
patches, and yes, you should try to make their lives easy.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU1VsACgkQMOfwapXb+vLrpACfZfYG+++ePuNgKiIufAF8pCZk
cXAAn217Ofaj72rXdJQjIhhz7la4TSsT
=YGfb
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
