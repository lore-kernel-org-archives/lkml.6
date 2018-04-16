Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3647214-1523896151-2-10900670732728328513
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
    1523896150; b=vFjirCWIDOBG+E/h3RtmsKuq1rtmgS/J4TOktVW2VGLmDtEIPG
    dh6hBesYHdI4s0KtVTcx8Yjuit6T1tQleeedfbsaNmXQsMoV4izzJY059Rvk0K9Z
    6YBH5MM108onLypmbVLBdkJo2DbBusMMHHHYuGZdTLmsQ6qPOWvkInHdDW8dEJkw
    LFgFAcLbHlFNr6mwcgnN9mhX26iAmjUeqeab7ZsQPA/TTj2mGMfNDU+4VpYpZuem
    RjWhPiau5eqsAHV5XXyIVElxO9/RQNlPfwFm1/hne4h8WSBAwKJnY9BNXj/GRe0Y
    XdM57KohqVLE0/MZMWlJXVC+odbW8PaxdTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523896150; bh=gF2g6RYVwMQxQ/GVZD95d/GXVL6Du7
    GhPaemCklyh/0=; b=QOkQmxZ8VLB4Lq+/HyX9TpeUvCghELRv9MCno6msK75tAf
    CBB9c694ao20KnFo7tF+eYIKdzljhMhZrCU4uvR5ugFab2JvGElgSC/BFPVN6PW4
    U7jWPGdpwLBumRVVI253ZQXMr/61IJxXF/Ow2U2uXUe23F7GSKaj5FWVYl6kiNUd
    3Z+6DUtOVYXxYM+aL0mISNHu+10bDWpegyYYfkiEzmegj2DoqWbe1/PZUhhQ+Afq
    vzdG16ih2Uu947dlMGeK2dLmzaPr8f1p5pCDCbOnd1vexggLVGcSHjA1W1t+rMb4
    Jz8mZmVcwtl6C9NouurYKziV/m5jZVPlcQge8XAQ==
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
X-CM-Envelope: MS4wfNTppaCDXv0FsaFU2aOv8qMPI5uwPwoHmnvGkqBRMiLpAHuJoOt1aLIu01czPrzDlXif5qY9rsc5bIclrMeIDhmx+52Sj09fKWpSbGZWm9jxbr1Z3KyI
    8BJnr7/HffOqFjMvtg/HIn/5zVC54uINNvxnm9QF9fbK5x9UuwxO1v6e75tLzMdk6VjHFKN44IZCDf5ZGXr7sJO/k47PdJXXB6CnZSMKyRDdPCYAcg4cbnOK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=fZb54PuC3bKsKzaqHkQA:9 a=EEQltoo8Mku_bgns:21
    a=JLcZIgEgOaL6Tcp0:21 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=bSvtkV5B5q9jQtdLPdQA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbeDPQ24 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:28:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46310 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeDPQ2x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:28:53 -0400
Date: Mon, 16 Apr 2018 18:28:50 +0200
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
Message-ID: <20180416162850.GA7553@amd>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416161412.GZ2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20180416161412.GZ2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> Is there a reason not to take LED fixes if they fix a bug and don't
> >> cause a regression? Sure, we can draw some arbitrary line, maybe
> >> designate some subsystems that are more "important" than others, but
> >> what's the point?
> >
> >There's a tradeoff.
> >
> >You want to fix serious bugs in stable, and you really don't want
> >regressions in stable. And ... stable not having 1000s of patches
> >would be nice, too.
>=20
> I don't think we should use a number cap here, but rather look at the
> regression rate: how many patches broke something?
>=20
> Since the rate we're seeing now with AUTOSEL is similar to what we were
> seeing before AUTOSEL, what's the problem it's causing?

Regression rate should not be the only criteria.

More patches mean bigger chance customer's patches will have a
conflict with something in -stable, for example.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrUz0IACgkQMOfwapXb+vLVqgCgpovthKKD5cKnjDTF2vKcm28Z
S60AoKn4WoAGsERhssfgqOAyyKo9t5IB
=mh5U
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
