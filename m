Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3595654-1523895022-2-10282370175938249583
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
    1523895022; b=O5+WxMmr1AHnm1lXBDZlL+/Vx5RcFR/jtYWNM20CD8zP+F7X+C
    OrccmiVkJGDyMdWGAt51Q27zb7ajumv6mqVZlKm81+zkuHr7lFXlLS5xPKJrNp15
    sNLk4Rs6ldFH6Iwsjksx746Vf76Lc3ZPsomMeI0Fi9O5Bk3fp5GJ5jklDndDh2GD
    xHmMSoHEWgLhDhIf2+4k5GJsaOjyfgKtR6VXi9wqXSJrmvH3CUvp2SfCsMzXznN7
    j7hoHfZQsCq9uucAvgxhxlkfw7cefvESOcSwWFdP5nX1dr4HAwzJr4F0fntz7sKU
    3N1b7NTkDBMZ7EpuUe98d7I57guJWpkY+5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523895022; bh=00/y1oDhWWZc/Oo/yNT90IdMDMc7qD
    kV6Dv/YCCPJlU=; b=loXauisg7yobrwSwdNBcGGwNhkAznzpobYeGzmYRIxicrz
    iWfmp0/NXClBquCf+kluz1SKwAk6mkG2ps3YV8j4H4wqHrOnAn/W56c9fJU6SW2r
    zV4iMhbYKsq7O73Upjkw33xUQduAzGZy5Mw70mPRYjuPM5wkKlP+do0qRfRIEID8
    Kz85dVtdVSTrLVQpIcq5vIim0JDKDdiashwXLJxMwyb5r2mz64XMvAJT3e83Exlq
    GT5WxHhrDTBHeNr5YRGPih6U0dqmdJ1SeEWjIh3SbqLt1m85nQsUrITvTvq/owdv
    tW849ClY4+hHoGvcb9yw3W6S98T3CSB4rKFgojpQ==
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
X-CM-Envelope: MS4wfOuzEuP1V804lA3lv4aOFu6HWXZySkIzTfe1PP/N+9zFL7OK64H83ZIrctWcPYukSIDeolA+AkO9A+cSCNY7nidYReTuCbx29N/hi7fNH0zI4Pjz1vH4
    ev+5S5aEjj47DM3tS/aOtruZiHXyqA64+ifmsfGdL3ngUaaUW8br67awchIFzXMJVOTeLrZ67jo3vOf/ZG925Lty6Iy5K8ePHW7XpbhX8SzKax9IsxFFkpD0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Z4Rwk6OoAAAA:8
    a=meVymXHHAAAA:8 a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=DOm5AfCqRI6R3UImkkkA:9
    a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10
    a=uIMjPGEnOdS370d-aBYA:9 a=ONNS8QRKHyMA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDPQKT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:10:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45871 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPQKS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:10:18 -0400
Date: Mon, 16 Apr 2018 18:10:15 +0200
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
Message-ID: <20180416161015.GB7071@amd>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home>
 <20180416160200.GY2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20180416160200.GY2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 16:02:03, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 11:36:29AM -0400, Steven Rostedt wrote:
> >On Mon, 16 Apr 2018 08:18:09 -0700
> >Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >> On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
> >> >
> >> > I wonder if the "AUTOSEL" patches should at least have an "ack-by" f=
rom
> >> > someone before they are pulled in. Otherwise there may be some subtle
> >> > issues that can find their way into stable releases.
> >>
> >> I don't know about anybody else, but I  get so many of the patch-bot
> >> patches for stable etc that I will *not* reply to normal cases. Only
> >> if there's some issue with a patch will I reply.
> >>
> >> I probably do get more than most, but still - requiring active
> >> participation for the steady flow of normal stable patches is almost
> >> pointless.
> >>
> >> Just look at the subject line of this thread. The numbers are so big
> >> that you almost need exponential notation for them.
> >>
> >
> >I'm worried about just backporting patches that nobody actually looked
> >at. Is someone going through and vetting that these should definitely
> >be added to stable. I would like to have some trusted human (doesn't
> >even need to be the author or maintainer of the patch) to look at all
> >the patches before they are applied.
>=20
> I do go through every single commit sent this way and review it.
> Sometimes things slip by, but it's not a fully automatic process.
>=20
> Let's look at this patch as a concrete example: the only reason,
> according to the stable rules, that it shouldn't go in -stable is that
> it's longer than 100 lines.
>=20
> Otherwise, it fixes a bug, it doesn't introduce any new features, it's
> upstream, and so on. It had some fixes that went upstream as well?
> Great, let's grab those as well.
>=20
> >I would say anything more than a trivial patch would require author or
> >sub maintainer ack. Look at this patch, I don't think it should go to
> >stable, even though it does fix issues. But the fix is for systems
> >already having issues, and this keeps printk from making things worse.
> >The fix has side effects that other commits have addressed, and if this
> >patch gets backported, those other ones must too.
>=20
> Sure, let's get those patches in as well.
>=20
> One of the things Greg is pushing strongly for is "bug compatibility":
> we want the kernel to behave the same way between mainline and stable.
> If the code is broken, it should be broken in the same way.

Maybe Greg should be Cced on this conversation?

Anyway, I don't think "bug compatibility" is a good goal.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrUyucACgkQMOfwapXb+vKsLgCgkBwiBshOxVG9qEz4hcJr4E+h
RBIAniyDsb9f2LcoUr2MS3ZSknJRu5gK
=WpRw
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
