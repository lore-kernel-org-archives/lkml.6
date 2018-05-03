Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2309188-1525340850-2-3339939802746401639
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
    1525340849; b=KrojF8+CUy84MNijhpPnaGzcfSlJvq+mlzv1BthHlBmPt3YAXT
    V05oGK9Oci7LT6vh4gKplnk0cJFUANLOaBKUTOHaXC1x1jviO+D0xVAD5Wa9D1Rh
    FCMWfLIDSqD69/hUecrMVNWM7YIbjT/8mTjZExfDld7ZVaVNGIJlut+wYJloSY52
    pA0iFXyQjLmzOTRfH80TCrBwVrFjReAS6tvkChsKf1jzMOD4Q12N8fUjI7qIzMdp
    FyMPfPItlKmBOSOvTB/5QcWvX8dw7Cr3S656CbQEjftsw4eQ/HqHx8aj1ApK6SY0
    M4/H7WuLyWKfuBO7nIm+WHtWEScAhihgDIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525340849; bh=OzNdmQgmXTV10K8ObetSbuuf6lgoiS
    ZGX2V/wSmVGuI=; b=lteulBrjdB0Gq3JqSuo/cDNprhfvxVvPFq3ThintP/uDBs
    0MVa9xps4C/x4oypgHyUoRJDMZdB8RI2ebs1M8lDTxOKM2IZZzMcMfZ6vRD/nZ/S
    xvke6UusokDKmcR0sv9Sg+RPXhLszFqaVgLk3DBYSeUYsBZB/7lybdujigdz5xXl
    4ZfIAP9GSCmRJXA7FJ68DH4aTko+eQhAEVTeVyriaBgKR3txzqe6qh6lm6oEDnoY
    00RyPx5ZdJHzvCl12pd4VLr1H/QHZOBnBPeBL4S2L/ohzYbIYkZp3PHIWifPFaLd
    VroiaQAzBQKWS3UmysaVTwm70VBhRYhhBrW2EzhA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEXY/AvlvZL7S6azD+LVhcz+pkBnVB8rVJCZyOiRC1Wz5EjR840EDclXmsNlGWmmnC4Qek0wJxnfNH1QGe9XuDJsNo+c5ukLJIC3raK8IVjAQaLTfUtb
    eBVRDu3WCsWLVPRii4ZgimuzrRMTf0o+PYa87YJvBf6Zfuok6GIJL0sMxXZpGSzmnp7KOkp3YHZy5BSI5vAMZpM4xdYQWoDAZlYkGxIJ2PP/Zs/NDD5Vg64E
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=i9TR73pm-2qQ186Mq7wA:9 a=Eopp7V1aPKT-vB2q:21
    a=EKeaPU_0Go1w2n5V:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=1lKgfcP6AdNkLPN26kUA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeECJr1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 05:47:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42401 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECJr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 05:47:26 -0400
Date: Thu, 3 May 2018 11:47:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180503094724.GD32180@amd>
References: <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416170501.GB11034@amd>
 <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
 <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
 <20180416211845.GP2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20180416211845.GP2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 21:18:47, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 10:43:28PM +0200, Jiri Kosina wrote:
> >On Mon, 16 Apr 2018, Sasha Levin wrote:
> >
> >> So I think that Linus's claim that users come first applies here as
> >> well. If there's a user that cares about a particular feature being
> >> broken, then we go ahead and fix his bug rather then ignoring him.
> >
> >So one extreme is fixing -stable *iff* users actually do report an issue.
> >
> >The other extreme is backporting everything that potentially looks like a
> >potential fix of "something" (according to some arbitrary metric),
> >pro-actively.
> >
> >The former voilates the "users first" rule, the latter has a very, very
> >high risk of regressions.
> >
> >So this whole debate is about finding a compromise.
> >
> >My gut feeling always was that the statement in
> >
> >	Documentation/process/stable-kernel-rules.rst
> >
> >is very reasonable, but making the process way more "aggresive" when
> >backporting patches is breaking much of its original spirit for me.
>=20
> I agree that as an enterprise distro taking everything from -stable
> isn't the best idea. Ideally you'd want to be close to the first

Original purpose of -stable was "to be common base of enterprise
distros" and our documentation still says it is.

> I think that we can agree that it's impossible to expect every single
> Linux user to go on LKML and complain about a bug he encountered, so the
> rule quickly becomes "It must fix a real bug that can bother
> people".

I think you are playing dangerous word games.

> My "aggressiveness" comes from the whole "bother" part: it doesn't have
> to be critical, it doesn't have to cause data corruption, it doesn't
> have to be a security issue. It's enough that the bug actually affects a
> user in a way he didn't expect it to (if a user doesn't have
> expectations, it would fall under the "This could be a problem..."
> exception.

And it seems documentation says you should be less aggressive and
world tells you they expect to be less aggressive. So maybe that's
what you should do?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq2qwACgkQMOfwapXb+vL+vwCghFP6TJ8cVqGOVUOEE9yh53Rb
wjgAniEpje+ePNmPY5rjf6cYo/adCPLu
=8oqh
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
