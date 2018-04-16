Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523896956-2-9049075273443807233
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
    1523896956; b=jAN3WQV8kN6d2zmQwRCTuKyhfzb3kgJLAefFmSGe/9ip8aRjwP
    lUve86Y9ZF/jO/9Oha4pl/J5WQasfg4XFUNThknmBcaf4yPQSyq2FJGDhN1g7ExZ
    5x5bUdKrdTCmXhya9NPUanqpX8jFnTeGU02ScbLlIAmBUFFWIgrssdtv2PRXUprI
    BVhYPRYS9qiALhzDgMDlG6soPfoVs+DHKPYIemLdASJ8UhYXSFczHt62BBKnwxGS
    XHfttVRHSIKPXnuYm1I8n4xdPFEmTPR58HoGr1PUHv54bYSfa+xEa09odcqFSGdO
    1nG41anusLglYPubIgxjqhPOw8OQPY7uU6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523896956; bh=3mzvROS3PYZYBvH1rFrHISXI9IlTpb
    h+Uhp+XAyRFtk=; b=O9bpGu4mZMFR9pXpb5k4+kc2yGopmviqcmhqzSyVMDr3Dz
    KJzCQZmAMIM17d6QCw6C86/7rv/bltG6wO7krkujsLaToHLluLj8LJ9H/4PVGL56
    YWZ6JK2y1PzCQ2Ysr9jtCUNrb8Rk8jvCR1CQi4ds8RKzlnJkjWNqQrwLEF8xhjoI
    XziNphGbbRWvRE24H+fdm6gJa+ihJIXLaY65TeQDLlystvaKJ+hf39V/YjpxXIfT
    P2/l0jvX/RSEPOKDkZ6cCV710kfWEpH89wvHGU4EjKqwb43JP/YeT49dUsOoETPk
    cVyC4R9CMeP+uleWAltCfOhcOiC5sdlgfPuKTW9A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPMLuYGMq1Ct9OikDyR7FDLkma0TcG7FZ5fue5zsSUA9EX1l61t79G+wzqcp2RVsG5H204lM14dQPtujslPqXgy783BCpJ++SBqSmOQTCnCY4162AVDJ
    +I7Kz987iSrJ+apTwW+ne5K32P7N85+w/7YXfL8c5FT6cwXHgNRfkFZpCHR6m7NR3ympHasF+9ECyCMEsxORKiWslt7Jy9od/3Ho4Yxj7+EUyqDfDk12YH93
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=pyyYw8uEA_H_DcB0DKEA:9 a=eqQrVjtLNACfTabN:21
    a=lC6Z3Gmw1FAsoRZg:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=vnf0XGqIHaovtgiIoCkA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeDPQmd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:42:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46703 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeDPQmd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:42:33 -0400
Date: Mon, 16 Apr 2018 18:42:30 +0200
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
Message-ID: <20180416164230.GA9807@amd>
References: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416162850.GA7553@amd>
 <20180416163917.GE2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20180416163917.GE2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 16:39:20, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 06:28:50PM +0200, Pavel Machek wrote:
> >
> >> >> Is there a reason not to take LED fixes if they fix a bug and don't
> >> >> cause a regression? Sure, we can draw some arbitrary line, maybe
> >> >> designate some subsystems that are more "important" than others, but
> >> >> what's the point?
> >> >
> >> >There's a tradeoff.
> >> >
> >> >You want to fix serious bugs in stable, and you really don't want
> >> >regressions in stable. And ... stable not having 1000s of patches
> >> >would be nice, too.
> >>
> >> I don't think we should use a number cap here, but rather look at the
> >> regression rate: how many patches broke something?
> >>
> >> Since the rate we're seeing now with AUTOSEL is similar to what we were
> >> seeing before AUTOSEL, what's the problem it's causing?
> >
> >Regression rate should not be the only criteria.
> >
> >More patches mean bigger chance customer's patches will have a
> >conflict with something in -stable, for example.
>=20
> Out of tree patches can't be a consideration here. There are no
> guarantees for out of tree code, ever.

Out of tree code is not consideration for mainline, agreed. Stable
should be different.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU0nYACgkQMOfwapXb+vK4LwCgiKi4ndB8QkImv8i+2CnZOiN8
xWsAn2jvJu/AuyU9cIwgMG0CPbq8xRWF
=Xc7g
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
