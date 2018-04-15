Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDORRv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:17:51 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33579 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDORRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:17:49 -0400
X-Google-Smtp-Source: AIpwx4+WfITXuaYu/boH7PTS5k+fWQ6rfqGBUjzJE28VZZjI2jd4I7sKR0VQlWIcYMVdPOnpaPIDMw==
Date: Sun, 15 Apr 2018 19:17:46 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180415171746.futkvgbaoj6quy5z@pali>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
 <20180414104950.ngomyjy5l5cwhb5i@pali>
 <20180414111711.GA4245@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lsvnox7sxk76vpiz"
Content-Disposition: inline
In-Reply-To: <20180414111711.GA4245@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lsvnox7sxk76vpiz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 14 April 2018 13:17:11 Lukas Wunner wrote:
> On Sat, Apr 14, 2018 at 12:49:50PM +0200, Pali Roh=C3=A1r wrote:
> > On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> > > On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > > Do you have any suggestion to check if it connects to the system via
> > > > Thunderbolt?
> > >=20
> > > Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> > > like this:
> > >=20
> > > if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pc=
i))
> >=20
> > And what about PCI-e device attached to ExpressCard slot?
>=20
> I don't know of a bullet-proof way to recognize those.  In theory
> one could check if the PCIe port above the GPU is a non-hotplug
> root port, but I think there are machines with hotplug capable
> root ports with GPUs below them that aren't actually removable.
>=20
> However I think ExpressCard-attached GPUs were rare, much less ones
> with integrated HDA controller, so in reality that's probably a
> non-issue.

Hm... maybe another idea: Is it possible to detect which audio pci
device belongs to graphics card via vga_switcheroo? Currently, looking
at output it is same PCI device as graphic card, just different PCI
function.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--lsvnox7sxk76vpiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWtOJOAAKCRCL8Mk9A+RD
UuYYAJ9Lpy9Pz9bUaG+MA2favSZebY/RQACfTgw6dpp4U+1FXTlc++IA8aitEX0=
=vVLS
-----END PGP SIGNATURE-----

--lsvnox7sxk76vpiz--
