Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3709784-1523897945-2-17305781885314016087
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
    1523897945; b=aeIXgUkGrLA+Dx8KyMTa42iRWKxhfxwnW4XH3DTpSB9OGSnWOU
    gea94NaHu10Xu4/75bx9LFkxUquTUhWndhuleR2H++cppiWLye+wWphSMUHRLPmM
    /R5q0RaxCEqte+huk8t/FMpNpYvT5I+9Q50efjSqUDnrAjGnzIbOJPO9eVpcqC3J
    aenVzbWi3KP/UhTFsC47atFoi3tro30gzZTtuE07y3TuTb81Cjq4CF0nD3RTw0OB
    J6WJoOuyGP59CRb9Bw1AL5ei8NFEErz/LHyO73dbv/wpzPWwC1E7GTKYalqqlx9e
    NwC9SSm9p74VX3Ga9aupZcIbi+PYi1LHCXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523897945; bh=O79Dfqrdjd7XMIjKV/2GRPi5SoauIv
    CT8AYQdldQxvU=; b=IAu0jANFlApwWdG261hc/Bj3WTFqOAhKkYEHBH9CUfAyW8
    gD5OvOwFWBqCfC4o2hLQyeCvX4a0Rfl4eJOIpH+V5YhCNcSzpN/6+70nnFqHiw2D
    ckRsLXhDtwf0aSB8rl3s/tHNDC0Ip9pESpV+VO2KEIqOkU5dqzlTOWXIV0RS/caX
    GHYcEuPwyDycWMRVQsiJZCNwD+JnqRciN8NCThtLJJ3MEBoesXIlQTHGJ70LN/A7
    jl+rw66VcNbIWc315D+BtGC1jPO+cTPb974NtCgiobOjSd9DIDwsXqgVAG7q2c1d
    EXJjPrII6CxqAvXkPzv8wo8CdHTogeEdy5Adymfw==
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
X-CM-Envelope: MS4wfDVBZfyOq9l5PavYo6n9bUIiCCRlo2t4HVp7oSCRyrayIVOtRHva4XBFBK8DKyAPN+ky+/NeVyQLLC+qk0MHMnKTT1tTcA4iO2hB6gCSaFGWPxaUbJEL
    x9HqEuyOnLHWp8B21Q2pWg08PEYFUMVPDg43Ya57iqnNPHuI4p1naJGA9pQuO/ktFtBtfuvC1xWWqV7VhUJRp1BM0R01PDgnf7TkiKCJZ36qiARuzwJko0+m
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=MfI1Yle-FF0kq87eOk0A:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=gj4zbR4AOQ1wW90PCXQA:9
    a=ONNS8QRKHyMA:10 a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeDPQ7C (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 12:59:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47212 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeDPQ7A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 12:59:00 -0400
Date: Mon, 16 Apr 2018 18:58:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
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
        Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416165857.GC9807@amd>
References: <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd>
 <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd>
 <20180416122019.1c175925@gandalf.local.home>
 <20180416162757.GB2341@sasha-vm>
 <20180416163952.GA8740@amd>
 <20180416164310.GF2341@sasha-vm>
 <20180416125307.0c4f6f28@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20180416125307.0c4f6f28@gandalf.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-16 12:53:07, Steven Rostedt wrote:
> On Mon, 16 Apr 2018 16:43:13 +0000
> Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>=20
> > >If you are worried about people not putting enough "Stable: " tags in
> > >their commits, perhaps you can write them emails "hey, I think this
> > >should go to stable, do you agree"? You should get people marking
> > >their commits themselves pretty quickly... =20
> >=20
> > Greg has been doing this for years, ask him how that worked out for him.
>=20
> Then he shouldn't pull in the fix. Let it be broken. As soon as someone
> complains about it being broken, then bug the maintainer again. "Hey,
> this is broken in 4.x, and this looks like the fix for it. Do you
> agree?"
>=20
> I agree that some patches don't need this discussion. Things that are
> obvious. Off-by-one and stack-overflow and other bugs like that. Or
> another common bug is error paths that don't release locks. These
> should just be backported. But subtle fixes like this thread should
> default to (not backport unless someones complains or the
> author/maintainer acks it).

Agreed. And it scares me we are even discussing this.


									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrU1lEACgkQMOfwapXb+vLbpACgiQyEJcGYB3C8JRLh9fzRBOui
GUkAoJ6z5s4gm1VYxIloiLVXJnqKaDJe
=vmwF
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
