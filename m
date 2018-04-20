Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDTWwK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:52:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDTWwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:52:08 -0400
From: NeilBrown <neil@brown.name>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Sat, 21 Apr 2018 08:51:56 +1000
Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: clear Winbond Extended Address Reg on switch to 3-byte addressing.
In-Reply-To: <20180421001028.544f5d09@bbrezillon>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <87sh7wrq8p.fsf@notabene.neil.brown.name> <20180420215440.7b078f6c@bbrezillon> <87efj9pnyk.fsf@notabene.neil.brown.name> <20180421001028.544f5d09@bbrezillon>
Message-ID: <87r2n9o5ir.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 21 2018, Boris Brezillon wrote:

> On Sat, 21 Apr 2018 07:28:19 +1000
> NeilBrown <neil@brown.name> wrote:
>
>> On Fri, Apr 20 2018, Boris Brezillon wrote:
>>=20
>> > Hi Neil,
>> >
>> > On Mon, 16 Apr 2018 09:42:30 +1000
>> > NeilBrown <neil@brown.name> wrote:
>> >=20=20
>> >> Winbond spi-nor flash 32MB and larger have an 'Extended Address
>> >> Register' as one option for addressing beyond 16MB (Macronix
>> >> has the same concept, Spansion has EXTADD bits in the Bank Address
>> >> Register).
>> >>=20
>> >> According to section
>> >>    8.2.7 Write Extended Address Register (C5h)
>> >>=20
>> >> of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)
>> >>=20
>> >>    The Extended Address Register is only effective when the device is
>> >>    in the 3-Byte Address Mode.  When the device operates in the 4-Byte
>> >>    Address Mode (ADS=3D1), any command with address input of A31-A24
>> >>    will replace the Extended Address Register values. It is
>> >>    recommended to check and update the Extended Address Register if
>> >>    necessary when the device is switched from 4-Byte to 3-Byte Address
>> >>    Mode.
>> >>=20
>> >> So the documentation suggests clearing the EAR after switching to
>> >> 3-byte mode.  Experimentation shows that the EAR is *always* one after
>> >> the switch to 3-byte mode, so clearing the EAR is mandatory at
>> >> shutdown for a subsequent 3-byte-addressed reboot to work.
>> >>=20
>> >> Note that some SOCs (e.g. MT7621) do not assert a reset line at normal
>> >> reboot, so we cannot rely on hardware reset.  The MT7621 does assert a
>> >> reset line at watchdog-reset.
>> >>=20
>> >> Signed-off-by: NeilBrown <neil@brown.name>=20=20
>> >
>> > We should probably backport the fix. Can you add a Fixes and Cc-stable
>> > tag?=20=20
>>=20
>> It's a bit weird having Fixes when this isn't a regression, but I guess
>> it doesn't hurt.
>
> Well, I thought you wanted this patch to be backported to stable
> releases, hence my suggestion. Of course it's not a regression, since
> the bug is here from the beginning, but nonetheless it's fixing a bug.

I have not interest in this patch going to stable.  I'll be perfectly
happy once it lands upstream.

>
>> I chose
>>   Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash whe=
n exiting")
>> as this patch it useless without that one.
>
> Not sure that's how Fixes should be used. IIUC, it should point to the
> first commit where the bug was introduced, so I guess it's 0aa87b7563f1
> ("mtd: m25p80: add support for the windbond w25q256 chip") in this case.

That does make a certain sort of sense, but if you tried applying this
patch to that kernel, it wouldn't apply at all.  So it is hard to say
that it fixes anything there.

I think it is best to drop the fixes/stable tags.  It isn't a
regression, doesn't cause data corruption, doesn't make it possible to
crash the kernel, so it isn't really "stable" material in my mind.

Thanks,
NeilBrown


>
> Now, if you want to restrict the kernel releases this patch should be
> backported to, you can use the '# vX.Y+' suffix in your Cc-stable tag.
>
>>=20
>> I also fixed the comment and have resent.
>
> Thanks.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrabw0ACgkQOeye3VZi
gbnGRA/+ItahJcKPj1RgghKfxdiWwf6NmE7K02pvIucfvvX1556OySNQ/QYGS9hs
XXlxrKwDrHYaycaiJNogHxcLFqToaZ9D1l0j+WYDZgu7TYNbJdgVmmxCCp8Jva/m
+dzmCLvH9Xs0Oeh7kmtKU4Hxn9YsBsldqtI0595SP8B3uVy4IpD2ogxfzkqDdXBV
HiES6fTS14j9BpEKhhZMLKDChBec/UAxhdaPe9qUM9Au1eTrpYvYAGE05ms8WG+d
vOX02UarvIRVjLIjtFgTSC58+e9aIwSMtIGlt6pIN/OhfzbDY6d/JXbJlVa8A/6r
j4RkXuko6unm3KuwRBs4QQ2tcHThKPSiD50D47pQVVXVOUuiLkOP6ul/kJbmPnYx
lF+UoohLyu+Md2IbXUS22TmEdnzdgm+e/wiwHLr3O9azfc9nouWRKfAs+Isxtr0x
nHT9IvgXqlxGfZ40U1kgyF3Rgzn4UN0tOspDPyZVk8KoFb6lHyef0+b5VYaRtKl0
9o2WTt6ikQMIU1VnmCp5siyTQSbxkWFsEYIEG1CwWdwuUGlhX9Bq+OWPFzkM04d/
zumvE1H47BYiRpBnYNMhf3Z5R9umfJL0fIBLrvMMOkrwr+6PRPrm8lxFD+zRwViI
/g/UnnXGzyQBP4SE7EHL+wG6dc6IukTlqPq3b7/KpzjwfkghoiU=
=yXTY
-----END PGP SIGNATURE-----
--=-=-=--
