Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523898307-2-4556020428203895859
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
    1523898307; b=rro0zG4LFNDYpmEIh30wbvGMmlaJregDNL2SgqJkrkypUWJDnc
    Qhl50iG5Z8bCPK9aYn0hrONwJYGi+wYQIom5s1iE1JHckASBRy1A3ltI7kr76ul4
    k4LphveDgd4TaBYw1+uJFxvHPqVgxo02//WXZlrsp2Vg2NzRRIcen4xu+ikGMvZN
    BvUh6tPiS1Ksa/f2VV6ieedBYmQ/gpY/jemguovjuUBUW2adayKl5m1pIZDOB5WD
    214ROeItPkJwqr8kEJ67U4YNvoCpQS4po8cXwQaWknlLGd9pA74GVLBzDiAnOlpG
    OsXwEqz7XqHYr49BQYCaZN4s/rrCfMk/pQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523898307; bh=XvKGFOEUj+40dkiHgsx+UU1So1/z2L
    dapzE5EE8YbRs=; b=O/nokVcfxvf4wYVyZXbxRD2CMhVWAH9DyGW4BV5R4SEbZj
    Yo9vVqB2R6OsGdE3VgforwHe5asBQscBTVkeeeSg0teL99vDMyviQFWtUwkN8n/K
    zs8UXEbhHjJZnA7Rx0hmxMnwq/li7cZYbof1NWM9Jjr3RUtKJJTAb8WEtvA5vMtj
    W8ihBvnP4wEBRsg7O1ZasZr5h8pfbW7W7xpCpXyahRpoCx64QVl1X0JyOxGSDcXx
    GN5NfNziRt7QwN1SHylgVk/3FBp4q62w44yadR8OqiWUWdVYXw0PdrM+t6yXIE2E
    ofvJwQwzNdejLxtHNaruPzg1h/jqFdKM34W4REBg==
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
X-CM-Envelope: MS4wfGDmwRFi9+qYvrC7hXsSF080EINpYcPfHwETZEMAS+KBGD1pOsL9zXpYBVPHFr475GHcPHpSeGbQGh6Ik2MBvaO1DyMFZ7x+g7hhshZs5pgnnvs0TURt
    s6sXOBNKKIdH9LpxQYPOS/WW9LIZ9kgur5kWMlqYsnvayo0DT8Y9Wgwgf5S87CpnAf6dEBBZZjMOoxLNfdvTyYCzx0RJoRdsm2cXVAwqXm3Z9E4TCi/81gob
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=KdQwh2A3DXs79DoShnwA:9 a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10
    a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=w3hBUVnRlZeNTocL65YA:9 a=ONNS8QRKHyMA:10
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDPRFE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:05:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47424 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeDPRFE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 13:05:04 -0400
Date: Mon, 16 Apr 2018 19:05:01 +0200
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
Message-ID: <20180416170501.GB11034@amd>
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
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20180416161412.GZ2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> How do you know if a bug bothers someone?
>=20
> If a user is annoyed by a LED issue, is he expected to triage the bug,
> report it on LKML and patiently wait for the appropriate patch to be
> backported?

If the user is annoyed by a LED issue, you are actually expected to
tell him that it is not going to be fixed, because it is not on the list:

 - It must fix a problem that causes a build error (but not for things
    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
    security issue, or some "oh, that's not good" issue.  In short,
    something critical.
      =20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU170ACgkQMOfwapXb+vKU9wCgj1o9l05gzeDtPZ5UDbqf8Zd6
DBgAn0A+1pvWJAgDFODUnWkm2Eid6kYD
=9On5
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
