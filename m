Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3578680-1523894774-2-12259913159990480774
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
    1523894773; b=FO5ND+VNHt4jrtqMiwCcHVqeYe2JJ12No3N0tMWcAk6bT7zHg/
    vt6lL2vZJ1GDr9cXpYzbKaNIpgmj0oJnQFGxRp8MPZp7ESjv8Bt0J4JD0krsr48D
    1PoLuYIQGitk0Xw0VPGiyySRwYOmX8018hkbRRMRaou00Ta9UFhtXntpYpdr4o7d
    upMov//zIGG+oHkhL52p5Vr84sCboN9NGps8Fdy0WmO2mfmQ6zpdKig7c9DPIox+
    KQYnOUMBWUVSn4DH+9zgOqSojlzJ9MDXgLJaYwwodKX0+kAKBW0ZOc8Jre82weQD
    iYBK/cG9UvCYSnPgg20ado4bNZJ3bRwIcnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523894773; bh=/iurbf7FJzuxu+1f3BiNPxL52/EbW+
    FPUoTR+TpqlO0=; b=GJMo9LHRvj6lqHHo86I4MHXkjmbx/94SBONz8UMO/pr7Kv
    O1sNEQhfyp0jVIopkLVYW+UprlZuZgHcyWTlVEJhcUOt/QRuNqClPmJe9TqTb5DA
    Y0RTdHKwdO0ubMQO4oUH1wpDg9v+/L0DoI2gKTn/lJNRPrNF7EIH3QWaokj9d77X
    CVk4N5aY/rha/0IdSBWSToAgkwQzbYJi4PTw5E3KYXTZ3KPjkmKZo71cw549wahP
    oBtRYSsOrMJWRcjfbDMX70HBFA4n6YyGuCdE6WXSbexIOLHitJnXkvaWXv1TY7L5
    k9ulsl2j06davnLIv9e1xtGCrxae5TfgmeUaKXTg==
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
X-CM-Envelope: MS4wfNLoqm6KSw573bnKykJggAt6+WZ4PZI+pBEZ9lh3iEELHXRaAnAiW2v9Se3pcG9LeeYSVrinUnicBtdTlbDcdZFxNmu//fFD/yLuaK7ubofuYCistKyE
    qkJNiV0CnH8yKIoU69X8Xca6HWOjMYprw/Ip+98UZEcUCj170XsTptNfNVe7WE2HYvShgK9JsTVWtSPNuQStDM9/xRf+NXUaWncczE5kNb98eIQfMx6n8omw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=meVymXHHAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=mus-4MKSescZZMtgpekA:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=pbjCHGjLJjkYkFSErasA:9
    a=ONNS8QRKHyMA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDPQGM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:06:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45751 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeDPQGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:06:11 -0400
Date: Mon, 16 Apr 2018 18:06:08 +0200
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
Message-ID: <20180416160608.GA7071@amd>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20180416155031.GX2341@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 15:50:34, Sasha Levin wrote:
> On Mon, Apr 16, 2018 at 05:30:31PM +0200, Pavel Machek wrote:
> >On Mon 2018-04-16 08:18:09, Linus Torvalds wrote:
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
> >
> >Question is if we need that many stable patches? Autosel seems to be
> >picking up race conditions in LED state and W+X page fixes... I'd
> >really like to see less stable patches.
>=20
> Why? Given that the kernel keeps seeing more and more lines of code in
> each new release, tools around the kernel keep evolving (new fuzzers,
> testing suites, etc), and code gets more eyes, this guarantees that
> you'll see more and more stable patches for each release as well.
>=20
> Is there a reason not to take LED fixes if they fix a bug and don't
> cause a regression? Sure, we can draw some arbitrary line, maybe
> designate some subsystems that are more "important" than others, but
> what's the point?

There's a tradeoff.

You want to fix serious bugs in stable, and you really don't want
regressions in stable. And ... stable not having 1000s of patches
would be nice, too.

That means you want to ignore not-so-serious bugs, because benefit of
fixing them is lower than risk of the regressions. I believe bugs that
do not bother anyone should _not_ be fixed in stable.

That was case of the LED patch. Yes, the commit fixed bug, but it
introduced regressions that were fixed by subsequent patches.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrUyfAACgkQMOfwapXb+vLqUACgrZVT5d1bgIPh6zWw8qPcYOP8
AxQAoLGANdVBhlKdNdoj4a7b8DIFJWeV
=hxVk
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
