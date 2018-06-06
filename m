Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CA95601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeFFO2F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:28:05 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:44224 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeFFO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:28:03 -0400
Message-ID: <33c55842c8d9ce199f0f8ef314dea85fb848b0be.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Chris Chiu <chiu@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>,
        Darren Hart <dvhart@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>
Date: Wed, 06 Jun 2018 16:27:55 +0200
In-Reply-To: <CAB4CAwfZtA8mf4MwJq1AA1wqwJB-HLXuiMmkzkow3NykRsHkSw@mail.gmail.com> (sfid-20180606_045007_040031_9EEBD50A)
References: <20180604123238.82200-1-chiu@endlessm.com>
         <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
         <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
         <bad0e19f-e994-110e-fce9-b614233e66aa@redhat.com>
         <20180605023124.GE47042@localhost.localdomain>
         <CAB4CAwc-J3+xaXzKKpFc-UMeuCsX8zbs0S7-a82x2LJcD5r7jA@mail.gmail.com>
         <38cb3527-8480-bdb9-a5d9-b601bc494a5f@redhat.com>
         <71df09bc89619aba975147e6b07920f1dfc2f46f.camel@hadess.net>
         <cd6a5d86-1fdb-2561-1e29-0553be53c41a@redhat.com>
         <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
         <0443419b-3147-163b-374d-bb8651b08837@redhat.com>
         <cfb6ff791a9034f8ade738085475e946b3d7519b.camel@sipsolutions.net>
         <362131bf-3b6b-58aa-bda6-003f5ffb5e8e@redhat.com>
         <CAB4CAwfZtA8mf4MwJq1AA1wqwJB-HLXuiMmkzkow3NykRsHkSw@mail.gmail.com>
         (sfid-20180606_045007_040031_9EEBD50A)
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5DOyyt+UA3AqAAuuzrhh"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5DOyyt+UA3AqAAuuzrhh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2018-06-06 at 10:50 +0800, Chris Chiu wrote:
> On Tue, Jun 5, 2018 at 7:06 PM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> > Hi,
> >=20
> >=20
> > On 05-06-18 12:46, Benjamin Berg wrote:
> > >=20
> > > Hey,
> > >=20
> > > On Tue, 2018-06-05 at 12:31 +0200, Hans de Goede wrote:
> > > >=20
> > > > On 05-06-18 12:14, Bastien Nocera wrote:
> > > > >=20
> > > > > On Tue, 2018-06-05 at 12:05 +0200, Hans de Goede wrote:
> > > > > >=20
> > > > > > On 05-06-18 11:58, Bastien Nocera wrote:
> > > > > > >=20
> > > > > > > [SNIP]
> > > > > >=20
> > > > > >=20
> > > > > > Ok, so what are you suggestion, do you really want to
> > > > > > hardcode
> > > > > > the cycle behavior in the kernel as these 2 patches are
> > > > > > doing,
> > > > > > without any option to intervene from userspace?
> > > > > >=20
> > > > > > As mentioned before in the thread there are several example
> > > > > > of the kernel deciding to handle key-presses itself,
> > > > > > putting
> > > > > > policy in the kernel and they have all ended poorly (think
> > > > > > e.g. rfkill, acpi-video dealing with LC brightnesskey
> > > > > > presses
> > > > > > itself).
> > > > > >=20
> > > > > > I guess one thing we could do here is code out both
> > > > > > solutions,
> > > > > > have a module option which controls if we:
> > > > > >=20
> > > > > > 1) Handle this in the kernel as these patches do
> > > > > > 2) Or send a new KEY_KBDILLUMCYCLE event
> > > > > >=20
> > > > > > Combined with a Kconfig option to select which is the
> > > > > > default
> > > > > > behavior. Then Endless can select 1 for now and then in
> > > > > > Fedora (which defaults to Wayland now) we could default to
> > > > > > 2. once all the code for handling 2 is in place.
> > > > > >=20
> > > > > > This is ugly (on the kernel side) but it might be the best
> > > > > > compromise we can do.
> > > > >=20
> > > > >=20
> > > > > I don't really mind which option is used, I'm listing the
> > > > > problems with
> > > > > the different options. If you don't care about Xorg, then
> > > > > definitely go
> > > > > for adding a new key. Otherwise, processing it in the kernel
> > > > > is the
> > > > > least ugly, especially given that the key goes through the
> > > > > same driver
> > > > > that controls the brightness anyway. There's no crazy cross
> > > > > driver
> > > > > interaction as there was in the other cases you listed.
> > > >=20
> > > >=20
> > > > Unfortunately not caring about Xorg is not really an option.
> > > >=20
> > > > Ok, new idea, how about we make g-s-d behavior upon detecting a
> > > > KEY_KBDILLUMTOGGLE event configurable, if we're on a Mac do a
> > > > toggle, otherwise do a cycle.
> > > >=20
> > > > Or we could do this through hwdb, then we could add a hwdb entry
> > > > for this laptop setting the udev property to do a cycle instead of
> > > > a toggle on receiving the keypress.
> > >=20
> > > If we are adding hwdb entries anyway to control the userspace
> > > interpretation of the TOGGLE key, then we could also add the new CYCL=
E
> > > key and explicitly re-map it to TOGGLE. That requires slightly more
> > > logic in hwdb, but it does mean that we could theoretically just drop
> > > the workaround if we ever stop caring about Xorg.
> >=20
> > Hmm, interesting proposal, I say go for it :)
> >=20
>=20
> So maybe the next stop is that I can follow Darren's suggestion to elimin=
ate
> the is_kbd_led_event() and send a v2 for review?

I believe the best compromise we have right now is to do what Hans
suggested in an earlier proposal. That is implementing the two separate
behaviours in the kernel

 1) handle this in the kernel as if the hardware changed it, and
 2) send a new KEY_KBDILLUMCYCLE event [default].

Which one is used would be a compile time option for the kernel.

Then we have three different choices for handling these devices from a
userspace/distribution point of view:
 1. Let the kernel handle these devices (quick fix)
 2. Assume we are on wayland and handle KEY_KBDILLUMCYCLE
    (great if Xorg support is not a requirement)
 3. For Xorg support:
    - Add hwdb entry
    - remap key to KEY_KBDILLUMTOGGLE
    - set a flag on the keyboard
    - detect the flag in userspace and handle KEY_KBDILLUMTOGGLE
      as if KEY_KBDILLUMCYCLE was pressed
    (yep, quite ugly)

The "beauty" of this approach is that the workaround from option 3 can
be simply removed again if we stop caring about Xorg (or should we find
a solution to handle high keycodes in Xorg).

Benjamin
--=-5DOyyt+UA3AqAAuuzrhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAlsX72sACgkQq6ZWhpmF
Y3CbYA/8CJj2mT6Ff5uxS6Jumf9OkIb5hA+dUxZyZ4Jo0g2wkAEnu4ojJmj6jg3X
iMVdlSIwyx/zZhQp8005b98Gnk9OTMybWgqxU79xdkwifXXArLC6HoucRaAj9kAk
rTUXAtIF3G3LPQDexymHKRwylu/1qxBn0DquLXPaio7uJyqvcV5slD1QWO2KQHF0
8yVqSnIN4RJrdmoXMpwW2cU9NnKKRY7keaFNTr+v9ze37IhFou2oA2h3proPk0wa
WWmjK1r0goVbPRbgGxz1qM0781rAfHqqa3nZbYoNEuteujR6spXUa0AcCLmbb/R8
xDkigkLq8xKfpDjvN6T/genan/ZMOGp9BAHVfNoQ/VeXJE59U/dC8TEm0GmT0uYN
xMGSyUoBHkB8hcn2JpiSwMopAHqcanfvjd9Cxj+o/keN+8UwhfwjQFb0TFaoHm8h
D4buWdSv5GqCux9PzVsgudondGIY6HxVhXQjnLEiacHjQ51RCFOFkzp6c5wQFFGX
YPVGCSSsz3g19NtrPCTIghHiGwLi3avSqhrvBCGpOYVhZraZp2ofl9BteKTA/kZD
qq6RHkICH3ssUkAnbcv6iAc4Cc0i04Nb8D29mQPAFTcnXTm1IZfWrHb8RmIwXstW
KVaAL2XQkwU9sxnCHeGtr6NLq66bsI+TLP3ewtXjxMePZNnJeTc=
=8L7p
-----END PGP SIGNATURE-----

--=-5DOyyt+UA3AqAAuuzrhh--
