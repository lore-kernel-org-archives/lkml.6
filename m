Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0FFECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E541E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E541E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeGSLog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:44:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48771 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbeGSLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:44:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 076F980496; Thu, 19 Jul 2018 13:01:54 +0200 (CEST)
Date:   Thu, 19 Jul 2018 13:01:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu Chen <yu.c.chen@intel.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Theodore Ts o <tytso@mit.edu>,
        Stephan Mueller <smueller@chronox.de>,
        Denis Kenzior <denkenz@gmail.com>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gu, Kookoo" <kookoo.gu@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation
 encryption
Message-ID: <20180719110149.GA4679@amd>
References: <cover.1531924968.git.yu.c.chen@intel.com>
 <20180718202235.GA4132@amd>
 <20180718235851.GA22170@sandybridge-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20180718235851.GA22170@sandybridge-desktop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-07-19 07:58:51, Yu Chen wrote:
> Hi,
> On Wed, Jul 18, 2018 at 10:22:35PM +0200, Pavel Machek wrote:
> > On Thu 2018-07-19 00:38:06, Chen Yu wrote:
> > > As security becomes more and more important, we add the in-kernel
> > > encryption support for hibernation.
> >=20
> > Sorry, this does not really explain what security benefit it is
> > supposed have to against what attack scenarios.
> >=20
> > Which unfortunately means it can not reviewed.
> >=20
> > Note that uswsusp already provides encryption. If this is supposed to
> > have advantages over it, please say so.
> >=20
> The advantages are described in detail in=20
> [PATCH 1/4]'s log, please refer to that.

Are you refering to this?

# Generally the advantage is: Users do not have to
# encrypt the whole swap partition as other tools.
# After all, ideally kernel memory should be encrypted
# by the kernel itself.

Sorry, this does not really explain what security benefit it is
supposed have to against what attack scenarios.

Note that uswsusp already provides encryption. If this is supposed to
have advantages over it, please say so.

Also note that joeyli <jlee@suse.com> has patch series which encrypts
both in-kernel and uswsusp hibernation methods. His motivation is
secure boot. How does this compare to his work?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltQb50ACgkQMOfwapXb+vJRegCfdloEMqo/8OjQ8iUXht7vmf1J
/jwAn1qMR2BSC4CNsYN7BUmawMByRuzR
=wdh8
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
