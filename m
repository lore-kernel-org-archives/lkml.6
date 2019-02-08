Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF55921917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="qoVDTpVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBHIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:30:50 -0500
Received: from tomli.me ([153.92.126.73]:53484 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHIau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:30:50 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 45f807a7;
        Fri, 8 Feb 2019 08:30:47 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b75:4650)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 08 Feb 2019 08:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=1490979754; bh=mFincKebPPpECswUFNTJz8kSm6XZOraDogWkrsWfW+8=; b=qoVDTpVsQRC6KxQn66wpQ+JHfmsc31x/6LLajCdcbDUrYuiUv/en/a2CDvT4Jshmk+oGnuJa4658oruqbE9GQerL7q69XBjGkWCp5j9nNEoTkdSD1MqIl64f1yfRN3RRhXOYwR1pir5DWUQOAssfUyjQ0w8XoJwiEWXSsaY698DEca2Nupc1syi0Mw7xAvWex/16lXr9aOy5rHac/dCbyvTum7bsjLZg/fLPtZ9XuflwaY13lYP4N3I4bDgnM7hOpp7nmEGmRmS3hhjFneVTWqTZc4ejvTd2U5HeJg6kWAdf3KiOph+RBHoR1bKj/zZHFbuei8H608StJSg+WURwbQ==
Date:   Fri, 8 Feb 2019 16:30:39 +0800
From:   Tom Li <tomli@tomli.me>
To:     James Hogan <jhogan@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Oliva <lxoliva@fsfla.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Message-ID: <20190208083038.GA1433@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, Greg, Ralf, Paul, James, Alexandre and Huacai

Many years ago when I was still in the middle scheool, I got a Loongson
Yeeloong laptop to explore the world of non-x86 world, as Geert Uytterhoeven
once said, there's lots of Linux beyond IA-32. At that time I've noticed th=
ere
was no platform driver for the laptop. I just assumed that nobody bothered
mainlining it and everyone were using Alexandre Oliva's tree. I've diffed
his tree, got the patches, discovered and fixed two minor bugs and submitted
to Alexandre, and called it a day.

Years later, I stared at my machine, and found Alexandre Oliva has stopped
maintaining his tree, yet there is still no platform driver in the mainline.
So I decided that submitting the Yeeloong driver to the mainline kernel is
the my current personal project of this year. I only work for myself for fu=
n,
not for profit. I see Loongson as an interesting non-x86 platform, but I do
not work for Loongson, do not explictly support them, nor supported by them
in any way.

Reviewing the previous E-mails and patches at Linux/MIPS mailing list, I've
noticed that, from 2009 to 2019, in a 10-year span, there have been at least
3 attempts by 3 people to submit the platform driver for Yeeloong laptop to
the Linux/MIPS tree, all implicitly rejected. This is not meant to be a
criticism for maintainers' hard work and high quality standard, but rather,
I think it shows a serious challenge on development of platform drivers that
worth discussing. since there's even more unsubmitted platform drivers for
more devices, especially Loongson3. We need to find a solution both for
short-term and long-term further development of these platform drivers.

Here, I give a quick summary about the situation, and see what can I/we
do about it. Digging into the mailing list, in the hindsight, it's clear
to see the fate of this platform driver. In December 2009, Wu Zhangin
submitted a refined version of the initial platform driver to the mailing
list.

His intention was to create a MIPS-equivalent version of the x86 platform
drivers, as he said,

> I like the folks did under drivers/platform/x86/ ;) which
> will be better to maintain. for all of these drivers are really only
> YeeLoong platform specific ;)

However, Ralf Baechle commented, that

> You split old, big driver into several individual drivers - good.
[...]
> Experience has shown that drivers for a particular subsystem are best
> combined in a single menu, in a single directory. Otherwise any changes
> to subsystem's internal APIs will become a major pain.

Dmitry Torokhov gave another response,

> Umm, it still mixes up bunch of stuff not directly related to input.
> I'd vote for drivers/platform/mips (since we have a few of kitchen-sink
> style drivers for x86-based laptops in drivers/platform/x86).

This discussion is frozen without any progress in the following years.

For example, when the driver was resubmitted to James Hogan in late 2018,
he noted, possibly without knowledge of the discussion in 2009,

> I can't help thinking it would be better to separate this into separate
> drivers for each part (backlight, power supply etc), and move them into
> the appropriate driver directories (drivers/power/supply,
> drivers/video/backlight etc). That way each part would get proper review
> from the appropriate maintainers (or at least they should be Cc'd).
>=20
> Is there a particular reason for it to be a single driver?

So I think it's the time to restart this discussion. Should the driver be
submitted as a platform driver, or be splitted and merged into various
subsystems? I've considered reasons from both sides.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Argument FOR platform driver
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

* Unlike other drivers, platform drivers are only written for a specific
machine, or a specfic family of machines. They are usually useless for
other computers. A central point-of-maintenance is easier to manage than
running between different subsystems. Also, many drivers only have trivial
code for each device, splitting it creates more boilerplates.

* Platform drivers are not universal, architecture-wide, instead, they are
tightly-coupled to a specfic hardware controller and/or BIOS firmware. On
laptops, the Embedded Controller is responsible for controlling the battery,
keyboard, backlights, and other opeartions. In this way, it's better to see
a platform drivers as a driver for a single controller chip, instead of a
series of drivers for a keyboard, a battery, or a screen. These kitchen-sink
drivers don't really fit into a single category.

* Since a platform driver talk to the same controller, shares the same head=
er
and I/O functions, it's difficult to split different operations on the same
chipset. First, code-sharing of the underlying EC operations can be a probl=
em.
Also, modification to a single driver often touches the underlying EC logic,
which need to touch the core architecture code, and it also affects on driv=
ers
in unrelated-subsystems, thus creating many troubles on coordination. Even =
worse,
they are only designed to interact on each other. For example, closing the =
lid
may deactivate the screen and changes the behavior of a light sensor, a pow=
er
button, and a 3G modem and their respective LED indicators. From a EC driver
perspective, it's easy to manage, but harder to do so independent drivers.

* Some computers have different hardware functionatilies, e.g. different
screen sizes, types of batteries, or keymap, but often share a single family
of the EC chipset and they can be controlled in a similar way, or have simi=
lar
characteristics. Using single platform drivers is easier to add support of =
a=20
new machise, or to reuse code among different computers - simply extend the
existing platform driver is enough. In our case, It's expected to support m=
ore
Loongson PCs of the same family, such as Yeeloong laptops, MengLoong machin=
es
and FuLoong Mini PCs.

The platform drivers in drivers/platform/x86 is representative for the poin=
ts
above. For example, Greg Kroah-Hartman's samsung-laptop.c.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Argument AGAINST platform driver
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

* Loongson is only a subfamily of MIPS systems. Unlike x86, where there is a
massive number of platforms which need custom platform drivers, the vast
majority of MIPS are servers/workstations or embedded systems, which does n=
ot
use platform drivers. Introducing platform drivers will encourage unrelated
drivers to be submitted to the Linux/MIPS mailing list, creating more press=
ure
to a small team like Linux/MIPS.

* Linux/MIPS is specialized in maintaining core MIPS code. The developers
should not be forced into reviewing and maintaining unrelated subsystems, s=
uch
as battery, LEDs, or hotkeys, which they are not responsible to. They should
be reviewed by the maintainers of their respective subsystem, this also
encourages higher-quality drivers.

* x86 platform drivers are maintained independently from core x86 code. in a
separate tree, and has its own community, platform-driver-x86@vger.kernel.o=
rg.
However, there is nothing is this in Linux/MIPS.

* The code reuse and coordination problem is simply an excuse, it can be
solved by providing a generic EC interface in arch/mips/loongson64 for each
driver in its respective subsystem. Monolithic Kitchen-sink platform drivers
are anti-patterns and they shouldn't be developed.

In conclusion, in my opinion, although having a central location for Loongs=
on
platform driver is preferable, but consider the current circumstances, it's=
 a
bad idea, and in particular, bad for Linux/MIPS maintainers. I think the be=
st
way of doing it under the current system is splitting the drivers to their
respective subsystems, and put the EC-related code in arch/mips/loongson64
and export the symbols. If there's consensus on it, I think I can starting
working on it immediately.

Nevertheless, I think a longterm solution is needed to facilitate the
development of lots more platform drivers of Loongson mainches. I've noticed
that Google has a similar problem developing their own platform drivers
for Chromebooks, their solution is creating drivers/platform/chrome, so
they can work on i2c, lightbar, LED backlight, etc, drivers tightly-coupled
with the Embedded Controller in a central location, with its dedicated tree
chrome-platform.git, without disturbing the ARM developers by sending unrel=
ated
drivers. I think we should adopt this model, having a drivers/platform/loon=
gson
should make the development easier.

Unsolved problems still remains, however. First, how to solve the coordinat=
ion
problem? Linux/MIPS is a relatively low-volume and slow list, what to do if=
 the
unmerged MIPS patches becomes a blocker for other drivers? Second, we alrea=
dy
have a hwmon driver under drivers/platform/mips, should we put a warning th=
at
says new drivers under this directory shouldn't be written? Third, if we ag=
ree
to create drivers/platform/loongson in the future, how can we ask the maint=
ainers
of other subsystems to review the drivers in it? I think Google bypassed the
problem because they have lots of kernel developers, but not us. Does anyone
know more about Chromebook's development procedures? Also, if we want
drivers/platform/loongson and its own tree, what are the procedures to get =
them
created?

All comments, suggestions, criticisms, etc, are appreciated.

Thanks,
Tom Li

Beijing GNU/Linux User Group

[1] 2009/12: https://lore.kernel.org/linux-mips/1259679137.12571.4.camel@fa=
lcon/
[2] 2010/05: https://lore.kernel.org/linux-mips/cover.1274622624.git.wuzhan=
gjin@gmail.com/
[3] 2017/11: https://lore.kernel.org/linux-mips/20171112063617.26546-3-jiax=
un.yang@flygoat.com/
[4] https://www.spinics.net/lists/platform-driver-x86/

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJVIRsjlaWj4OSKDx+tPrBeiOjW0FAlxdPiYACgkQ+tPrBeiO
jW3FOg/8Dzcq5uTWIoqQb0APzi1HUBspcWMZ/S4NNVXdx2bcePuEbTBijVT9P5fx
0AluLKK0fTDGeM0YzPXHrumJp+IaOGE2RBeK9haH0Ye4U9eJcHqT5isLfLActkf+
/l3KTleUmX4VT19e64H1aOirxJxCsOpEKG9cBnlBpjnVyCUE1zrFCViv5nrdYqKj
qv3kDfdCrjtUa+/XUcIH5nxGDdb3DvsdqDrL8ZdbYQvW7NgR5vyp9W0xXuIViw1q
CFfiUJmtfyZyjA0X/N+8kOc6/AinJxWwO0EV2y7waxSxeG0lVuelxQxQNBQRlZ5d
4GXy9naLr4M93vv8+DwbCXsRe2LaMX+xeNQaXGNu22eCL6shpVJHxFr+3Q8BOkRl
dES0K9b7IjeajUZ0EHUcUekdpIqNfhOdTjybA2nm96Y4hidtHQhaypfCJanUcIsg
3GWucEpohvuuSwa5PsCWhNmIM82dhlRO0vum09NK7+ok66azrwP8huOqFy25u7Ir
Xhy+gFK4WRc7z526k2cLU+QZ7PRvzwsfr7J5tNKjcY6cBuWHjjJ2gjJ/6DSuFy1I
RYUGHIJuEtXH+zwuyc/eU9cq+SDVBtqZK1n4v+qJch9KX6nDz1QeDaHA096HLGWh
3E2tOKa7HEUiL1EKHIYst8QyzBLKFIvAUhM0299tSBMkalrOUcw=
=Xbyq
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
