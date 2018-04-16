Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3665621-1523898370-2-675496824565973643
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
    1523898370; b=VBdU9zcvRe79wrJTQY8FO3b3bZge9vDJwYd/SkRh0LapAH9tjC
    hEDh7WrNU9WuX+w0s6NexAj/hw3qJw6rMjzhL9ZIlegYWn4CHDT5uLnwfNkMZsBd
    XqXC/SEfQTipj7MbSm3D+0zMVU2DCfA5YLq63buLmpVN1ay5AvB8UKAn3y6neK7P
    ZpsOlaE/AUcO118rxDTiuU7HIZnmFtqIZmfHb4iDjRNjMdTQ2EtbMTigQ4Wt6ZV9
    JXtfmFGep54A15Kq6AA6oUyNjBYnChOHTxiKT4p8gZtPZBzK+iDj89+IGHcejT/a
    qG/RxFEi+LgWyUZ+A1u+DoGZGiMowGReV3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523898370; bh=Hxaw/4c12TsaDRhjqu/LbzT9RntLRb
    6LOoP47AJ+euo=; b=Xmq/6R67yrRRYts502yIAhIBBwqoVlQfV1svElIiXofEmr
    MTQvTSUd7aawJ36WQ/YYck/AL/YABqDFeWNxzZLsjbX7ddXR3WtlAXjDl15TCV54
    ER2rh3paMfhWz7jKYR22zU4B5Khn9t8f/ySaYqzRxcGt4CuPPyg6NFFDzKPLTgsl
    PKKsoF/eq7YXjtQS50sy5c8LNwQE6Sf0o70f7gRoOAsU7SuqpPQF07ABoCS2LFKi
    +gExFOAChl8GdMKNXEFhvSTjF/dyVpmVZ0EQp+v/DyuBxfdgX33+d4Q5mHxzW6FO
    QpW6ML31bdOEPntupDA+oQjL/pZKHC+g8htK6Yqw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJT+Xpa2GEeQ+E5a+GI+oad2zMiYYreNVPPUXiV7DaTNo6QFKwEYdrO9Bhu8wlUMzcFMllHcj3c+xVkMm8LvGDfZvCOuDOkRqhg4Xo3Ry8j5xcRheOIq
    CQiZcOyWL0J3bW5zVzcXlUph5HpxvmIcZpcUi3ROy24PLBLIeN8qEIDw3kfn6TsRJ/sqc2bTnHOyrdYOKQinr0BxPIgK83IZxvQnYkFS/mMYOyeSp2wYmuer
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=MoAfGkeP1fGCM2AtiikA:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=KIW6dZIBL3GQWFl3_dkA:9
    a=ONNS8QRKHyMA:10 a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDPRGH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 13:06:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47468 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeDPRGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 13:06:06 -0400
Date: Mon, 16 Apr 2018 19:06:04 +0200
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
Message-ID: <20180416170604.GC11034@amd>
References: <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home>
 <20180416161911.GA2341@sasha-vm>
 <20180416123019.4d235374@gandalf.local.home>
 <20180416163754.GD2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20180416163754.GD2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 16:37:56, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 12:30:19PM -0400, Steven Rostedt wrote:
> >On Mon, 16 Apr 2018 16:19:14 +0000
> >Sasha Levin <Alexander.Levin@microsoft.com> wrote:
> >
> >> >Wait! What does that mean? What's the purpose of stable if it is as
> >> >broken as mainline?
> >>
> >> This just means that if there is a fix that went in mainline, and the
> >> fix is broken somehow, we'd rather take the broken fix than not.
> >>
> >> In this scenario, *something* will be broken, it's just a matter of
> >> what. We'd rather have the same thing broken between mainline and
> >> stable.
> >
> >Honestly, I think that removes all value of the stable series. I
> >remember when the stable series were first created. People were saying
> >that it wouldn't even get to more than 5 versions, because the bar for
> >backporting was suppose to be very high. Today it's just a fork of the
> >kernel at a given version. No more features, but we will be OK with
> >regressions. I'm struggling to see what the benefit of it is suppose to
> >be?
>=20
> It's not "OK with regressions".
>=20
> Let's look at a hypothetical example: You have a 4.15.1 kernel that has
> a broken printf() behaviour so that when you:
>=20
> 	pr_err("%d", 5)
>=20
> Would print:
>=20
> 	"Microsoft Rulez"
>=20
> Bad, right? So you went ahead and fixed it, and now it prints "5" as you
> might expect. But alas, with your patch, running:
>=20
> 	pr_err("%s", "hi!")
>=20
> Would show a cat picture for 5 seconds.
>=20
> Should we take your patch in -stable or not? If we don't, we're stuck
> with the original issue while the mainline kernel will behave
> differently, but if we do - we introduce a new regression.

Of course not.

- It must be obviously correct and tested.

If it introduces new bug, it is not correct, and certainly not
obviously correct.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU1/wACgkQMOfwapXb+vIjgQCdEVO1o/y2VmXGEcZZyPdYbKfc
GZoAn3Hi6VsBPbA2sH/ZU7m8YVz1KnWd
=jdee
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
