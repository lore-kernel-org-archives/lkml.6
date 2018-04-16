Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523898014-2-8549034202998912963
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
    1523898014; b=fPAV58wyZPbgyi5LtNzQmjm5WnOQoj5YrhhDjVRYC4Xrzam6W6
    nkQzZMBBjAyUbJ9bX/RWBZt6FBpRN0BB+I+OzSBbOXGitJIfCSGi2rNyY4j5wGIK
    E0PSEKIKOGod3Kek8saQa3wh7kSbK/Cz5OamMzRI3EY7DFmwtsrTBqWYAquc6bXD
    kZOUpufiJS+Ll0NKEtuMqmnIHU4Tj79xg8CC/yGThRQltFnnLCVgAdw4YdL/yXgK
    ZVC+6v3g4nWMcJsDGU1YCuDgYjGnncebyvjmW9lV6P6fHioBzzbAoR/93qRKxobA
    uygSjr2dJLvlkd2EaIWrHpdg86HMdB6/IGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523898014; bh=VUDLsm371hMh7b1NzWH/u25CbpM56c
    +wk9xWccTskgg=; b=hXnZSmbPJX0iGySj/DMdOBuwVNaXoeky1aahFtgTz1asEM
    eBLQhFew04+JkZOs4CIvqBZC9dRzTZ3Kbn7v4MNrVStksFF1ZkMPeytKw2jbcO4M
    KWktCo+lbgulKZ7cU93aUWnLisgaPTuQAkUzCGtTMSgY+g+7nP1lPoYT5d1r4+nx
    A0AdlaFZV7+IAo/fe673fsA9mdkvDYisj1zNEMV2laFP/iEDK0ydWbA50oyZvX5I
    xsZSc7EAehq8RvzbhLxqaXn3MHpQzGPTW88V2+/po+zycW9AEFyvaFSbkX8lLjqw
    FyyDNE13Iyd9CnILRDngSlblHWDICqZR3p6qXGGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPEyEMiWagBlGiCzR5ZjAhzhToYVlLzqsEhRgTuim6jrqGiBpb0zjz8rfVy7pveb8AoD1HlDpaMiiF1e9lWWKULyeMog4f3yAcK+NYDb0V2gc/KvltIL
    PZzLHT6bvWCMTEiECUP5bK12orLS+rABUHfxSiIw4jfw+H+7ucAFlx8OMIg+MS/wEIAHpnlHJ4hLxKGCrqUaaslw5fejRABfPEyBrHrCtRrb2SkPWt9W5KB7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=nwdFsgU9DsqIYtI4f-gA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=179QiPG4hJ_nctoy7Q0A:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeDPRAN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:00:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47272 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeDPRAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 13:00:12 -0400
Date: Mon, 16 Apr 2018 19:00:10 +0200
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
Message-ID: <20180416170010.GA11034@amd>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
 <20180416122244.146aec48@gandalf.local.home>
 <20180416163107.GC2341@sasha-vm>
 <20180416124711.048f1858@gandalf.local.home>
 <20180416165258.GH2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20180416165258.GH2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Let me ask my wife (who is happy using Linux as a regular desktop user)
> >> how comfortable she would be with triaging kernel bugs...
> >
> >That's really up to the distribution, not the main kernel stable. Does
> >she download and compile the kernels herself? Does she use LEDs?
> >
> >The point is, stable is to keep what was working continued working.
> >If we don't care about introducing a regression, and just want to keep
> >regressions the same as mainline, why not just go to mainline? That way
> >you can also get the new features? Mainline already has the mantra to
> >not break user space. When I work on new features, I sometimes stumble
> >on bugs with the current features. And some of those fixes require a
> >rewrite. It was "good enough" before, but every so often could cause a
> >bug that the new feature would trigger more often. Do we back port that
> >rewrite? Do we backport fixes to old code that are more likely to be
> >triggered by new features?
> >
> >Ideally, we should be working on getting to no regressions to stable.
>=20
> This is exactly what we're doing.
>=20
> If a fix for a bug in -stable introduces a different regression,
> should we take it or not?

If a fix for bug introduces regression, would you call it "obviously
correct"?

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU1poACgkQMOfwapXb+vKFVwCglrjm4215fTMbAYLHOx8MAtxa
bFwAnipr21zwvIMpsR6hS6lsLYQRnj+m
=wM9y
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
