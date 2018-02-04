Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3990538-1517765492-5-9031142886547614680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517765491; b=lmxuix3W1KsQkNzxNLwCK92rfov6Xg0qC4KYgW+ud4jRMOS
    HZUpFj42W35zIjsG8LylKo+CMWZ8oG/ahTe3RlDFWTqjDVn6JBWOl3RTpQd0+22q
    owi+U7jy/153lAdQnmpqM/MXzLawm/Oq1WDp9ewu4mEdVvg8v8Cz/cBpRTwoiXgB
    OuyLzXIGphrZRGBFU22uq5g5K/O34g6VyMpvU8GwkP5Pu1gBqohPPTI4vmQulY5i
    4KTyYjkuni0C3p81YtU8ghhhKyCS+n0hklELRG6q12eHincumT/DW9ykKUZhk9xC
    CzGMb6lD853k/uMUY6a5+fKsw7B29lEVSXe7fBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517765491; bh=p0lKrtCU4KBGw9GdQDFq7uTmDI
    +00Z+fTQXclShFjTs=; b=GlAeNGNJLfQwz4/o8PGiSHBsfe3qrysyj80+7zC0F6
    fFnfpClcie4Zva6lO85bPZH+doKbUux8+glDSkC7z7EnqSFFnLkM/yQx1viG8HL+
    F/lslZUAwZF9lAMZ7bcv+SW54cZ0xnlcEFSosy4O2hdLcM/chvuqmnyMXjS7pan8
    WDUiGYmOBaSv5wwoUTiI6Z3h5eohZXxjahUr3J7DgcZ+3PjrhgENjcgrYlLwmawi
    8NmlMARueYpPNG8M+wVlJEu4sjIviJ3cPz79ZkEC9+FaiLZtEtbs/Lqkm0FSxnGi
    y67SCA+VKmR6avi6KuQg+arX7HGjFziVNwgWXJbNDzCA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeBDRbT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 12:31:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32778 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeBDRbS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Feb 2018 12:31:18 -0500
Date: Sun, 4 Feb 2018 18:31:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180204173116.GB1388@amd>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
 <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
 <20180204154859.zfkp4oia5iorewo5@sasha-lappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20180204154859.zfkp4oia5iorewo5@sasha-lappy>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-02-04 15:49:06, Sasha Levin wrote:
> On Sun, Feb 04, 2018 at 10:05:31AM +0100, Pavel Machek wrote:
> >On Sun 2018-02-04 00:30:36, Sasha Levin wrote:
> >> On Sat, Feb 03, 2018 at 09:35:26PM +0100, Pavel Machek wrote:
> >> >On Sat 2018-02-03 18:00:59, Sasha Levin wrote:
> >> >> From: Matthieu CASTET <matthieu.castet@parrot.com>
> >> >>
> >> >> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> >> >>
> >> >> With the current code, the following sequence won't work :
> >> >> echo timer > trigger
> >> >>
> >> >> echo 0 >  delay_off
> >> >> * at this point we call
> >> >> ** led_delay_off_store
> >> >> ** led_blink_set
> >> >> *** stop timer
> >> >> ** led_blink_setup
> >> >> ** led_set_software_blink
> >> >> *** if !delay_on, led off
> >> >> *** if !delay_off, set led_set_brightness_nosleep <--- LED_BLINK_SW=
 is set but timer is stop
> >> >> *** otherwise start timer/set LED_BLINK_SW flag
> >> >>
> >> >> echo xxx > brightness
> >> >> * led_set_brightness
> >> >> ** if LED_BLINK_SW
> >> >> *** if brightness=3D0, led off
> >> >> *** else apply brightness if next timer <--- timer is stop, and wil=
l never apply new setting
> >> >> ** otherwise set led_set_brightness_nosleep
> >> >>
> >> >> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
> >> >
> >> >Can you run the tests on the affected stable kernels? I have feeling
> >> >that the problem described might not be present there.
> >>
> >> Hm, I don't seem to have HW to test that out. Maybe someone else does?
> >
> >Why are you submitting patches you have no way to test?
>=20
> Because.... that's how the process works? -stable maintainers don't test
> every single patch that goes in. Never happened and I doubt it ever
> will.

Well, see my reply to Greg. According to documentation, stable tree is
for

 - It must be obviously correct and tested.
 - It must fix a real bug that bothers people (not a, "This could
   be a   problem..." type thing).
 - It must fix a problem that causes a build error (but not for
   things marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,=20
   something critical.
   =20
=2E This one was not tested in the stable trees, and it was not really
bothering anyone. It was not even present in some of the kernels... It
was not an oops, hang... etc.

> >Plus... you don't have PC keyboard? You don't have thinkpad notebook?
>=20
> Nope, all the (limited) testing I do happens in VMs, which don't expose
> leds as far as I know.

You still use keyboard to access the VMs, right?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp3Q2QACgkQMOfwapXb+vItuwCfTLFvw7oyhyNmBi7ZypGB6AXs
+X8AoLVxLA22chFVfiUMhyRawQ7w5+rB
=BRMa
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
