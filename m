Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2309188-1525339939-2-6768552514853574287
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
    1525339939; b=nivDcwHtMOYzid0bDm6ab3nndtNQMCaf+JHSaSAqWl9U0AerKK
    sboXKBtpuJX2X3fC4VXxobW0MUfW7gbVenqVBhcwrDcJbq4DYeaBv+p/CCCN3MbT
    ZlPRdpgSKjTOf3N0yChrk3cGLzoqgNENJ2cE3lf9XbTJ2OjwpsWbVSDJyks2l7/B
    QjzsmhWH4Rmu16hVXq5emvX0E8xKNE0evGUdJjUATyDP1krgUXBf+zTUhIm4tR/k
    cafFlHmasdCTLJu4LHXPLO00YXPEb1MBhEHTZD9MtonHYQS6manEnOzfb4AaZqgK
    FSVI+0gSoDmGkoPu6rA05n7ZD37JedPTfOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525339939; bh=yaWPdQ7T/g8oiKuDzkPH4at/wnC/7q
    2zeqPonOSuGXg=; b=ldp7V27LodC+abDxgWltT/TR1FtozX3gddQotsCIADScFB
    IhgMFPtjWj0sS+GHMMyjfpAm3XL43jBno+JivfxjHirHzpTSxYZPBuijpQbKuU3O
    5ZBhYEL1pOi6De0wRxCDksiAeI8+7i2v+rFVZ4ljuRJWCBE8ablvR+phjv9aUKQF
    wzkY147KVjRAw21SsLdXxNDZWv3y+ivzj9RCQS92dXgr7zxef7EXx1h0kI6jvRrR
    VMnB5tCXkbxBcRT6J4o/WukpgsG4VejXmkS1krJvBnygX2Ns28FjjvdG4ljKeuGs
    /GIXNQx2DohidcZDSsF94ufOaadNSnFUxGdNM2NQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfHaUZNmRFBM1pRTyNWVw1lcXW0ZIAyKSOVsSnMf7ex66ZC1I23fFgvdOBxb/gDPlxbhPKi+Yfwa/PdQFUAGoFp9ydFdtKTdJlewM10z87Lv4TbskkjdV
    y/AFUPykyNWGSdKCNaKZhMVJTuxVJnTor0/Ue8Ck/NCUCSP35RlAFL4uky/9AAIbYy9i+VCPZNfbDBjIgcP5MFpgtI0DGOD/Vg8eOaOmRiyQXgldCVxu0PLw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=0ScIZKqQG_d4XNaN4scA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=PJAKvaBL_nSTgfJ0VKAA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeECJcR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 05:32:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42016 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeECJcR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 05:32:17 -0400
Date: Thu, 3 May 2018 11:32:15 +0200
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
Message-ID: <20180503093214.GB32180@amd>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
 <20180416163754.GD2341@sasha-vm>
 <20180416170604.GC11034@amd>
 <20180416172327.GK2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20180416172327.GK2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >- It must be obviously correct and tested.
> >
> >If it introduces new bug, it is not correct, and certainly not
> >obviously correct.
>=20
> As you might have noticed, we don't strictly follow the rules.

Yes, I noticed. And what I'm saying is that perhaps you should follow
the rules more strictly.

> Take a look at the whole PTI story as an example. It's way more than 100
> lines, it's not obviously corrent, it fixed more than 1 thing, and so
> on, and yet it went in -stable!
>=20
> Would you argue we shouldn't have backported PTI to -stable?

Actually, I was surprised with PTI going to stable. That was clearly
against the rules. Maybe the security bug was ugly enough to warrant
that.

But please don't use it as an argument for applying any random
patches...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq1x4ACgkQMOfwapXb+vIIvwCghIH6ADk+P65RCxtQarChlpTS
4vkAnjYpE+F4FX/4kE6re5OJ/lo449zH
=5n+g
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
