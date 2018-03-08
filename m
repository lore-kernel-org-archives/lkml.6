Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2511101-1520532265-2-7116293177602200468
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520532264; b=FniPySgh1/i8zjRfXyLV9sdmQuK7L4n0zZJ6sSN0e6xl6Xj
    1w5KhQkhY0c6sMBDlQ56IHrpX+jnI5Aj7Ra7XLI14/psI1Y5wXElgTfqmP6o15v6
    O7G+cNanahv6Oom64f0n2iPKiL4QFdp4r51aBvyBDXbg/414vq44ksdFxqZJpLrD
    QEWFk8fGYdqKVIw5L5ANd71ScxQFWkJgfHMwpnpyTrWAA3q9u7LqblmfUwM7zFms
    arv4Bn1JapWgi+HTUITNO3EvttBdyRSLJSlV+gbt1Pcnt7k2NHn2EuQgsti01qEN
    NBke04OmKCPMvTQNGQdWfSLUSeoI+qrhxzPV1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520532264; bh=YqXeMChbOElzFR7tvaTJoVXaQg
    rJxzR9GpBPBhE/jW0=; b=wh8qBTpelTJBC0xObv5GnzsCZ3bRaMClglzMCqqWgV
    QnRv62R6Iov5AIF8DlfNJcjIA5bFN4RWYmZ9LKpEDJZqtQhEXVX0PmzU6lKe6udm
    Vhsv58wRkT2yNZmT5eQyVjSKRIa13448KviWhTd4/14bU3gaKBE9l/iKM/XFCx08
    YCBkQ5MIUqWGkpFhHTkALijU29k9npOagShcnDAKgGxQ/uGCqwZkvfp3Pj+94tr9
    vFadlqImXGs7iS+QE5rVv3yyGOkpoq/CRYVDKJLGjta/97KriVi7agdFsjcsii1P
    BkB3rOQu0MoZPqcRtKp59rDLZLotJ4UUQdIOKGYDcMUQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936119AbeCHSEK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:04:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39423 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbeCHSEG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 13:04:06 -0500
Date: Thu, 8 Mar 2018 19:04:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 16/34] led: core: Fix brightness setting when setting
 delay_off=0
Message-ID: <20180308180403.GA16940@amd>
References: <20180302084435.842679610@linuxfoundation.org>
 <20180302084437.007951262@linuxfoundation.org>
 <1520436743.23626.33.camel@codethink.co.uk>
 <86d4536e-11d5-40c4-4186-21955f809005@gmail.com>
 <20180308172401.GB22224@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180308172401.GB22224@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-03-08 09:24:01, Greg Kroah-Hartman wrote:
> On Wed, Mar 07, 2018 at 09:39:08PM +0100, Jacek Anaszewski wrote:
> > Hi Ben,
> >=20
> > On 03/07/2018 04:32 PM, Ben Hutchings wrote:
> > > On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
> > >> 4.4-stable review patch.  If anyone has any objections, please let me
> > >> know.
> > >>
> > >> ------------------
> > >>
> > >> From: Matthieu CASTET <matthieu.castet@parrot.com>
> > >>
> > >>
> > >> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> > >>
> > >> With the current code, the following sequence won't work :
> > >> echo timer > trigger
> > >>
> > >> echo 0 >  delay_off
> > >> * at this point we call
> > >> ** led_delay_off_store
> > >> ** led_blink_set
> > > [...]
> > >=20
> > > The commit message got cut truncated here, which resulted in addresses
> > > being omitted when it was sent out for review.  The upstream commit
> > > message refers to a LED_BLINK_SW flag which is not used in 4.4.  So
> > > this fix probably isn't needed, though I can't tell whether it does a=
ny
> > > harm.
> >=20
> > We discussed it in [0]. This patch is not needed for 4.4 and what's
> > more more it is harmful. It introduces a bug, fixed in [1].
> >=20
> > [0] https://lkml.org/lkml/2018/2/6/726
> > [1[ https://patchwork.kernel.org/patch/10253933/
>=20
> So, did I mess something up here?  Am I missing some patch that I need
> to apply, or do I need to revert something?

Well, patch [PATCH 4.4 16/34] led: core: Fix brightness setting when settin=
g delay_off=3D0
is not suitable for -stable. It is not needed there.

(And it is also buggy and does not fix serious-enough problem to
warrant -stable).

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhexMACgkQMOfwapXb+vLrzgCeKJIQO0nmNRPy2vqNb3yLZYgi
GfsAn2bqY1B2I9JYIyDODHKAdUw1FdnX
=GIJ7
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
