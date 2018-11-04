Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93EEC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9712082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9712082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeKDUnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 15:43:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38767 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbeKDUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 15:43:47 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8338A80985; Sun,  4 Nov 2018 12:29:04 +0100 (CET)
Date:   Sun, 4 Nov 2018 12:29:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86, olpc: Indicate that legacy PC platform should not
 register RTC
Message-ID: <20181104112905.GB23864@amd>
References: <20181004160808.307738-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20181004160808.307738-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-10-04 18:08:08, Lubomir Rintel wrote:
> On OLPC XO-1 we're discovering the RTC via device tree from the arch
> initcall. Don't let the PC platform register another one from its
> device initcall, it's not going to work:
>=20
>   sysfs: cannot create duplicate filename '/devices/platform/rtc_cmos'
>   CPU: 0 PID: 1 Comm: swapper Not tainted 4.19.0-rc6 #12
>   Hardware name: OLPC XO/XO, BIOS OLPC Ver 1.00.01 06/11/2014
>   Call Trace:
>    dump_stack+0x16/0x18
>    sysfs_warn_dup+0x46/0x58
>    sysfs_create_dir_ns+0x76/0x9b
>    kobject_add_internal+0xed/0x209
>    ? __schedule+0x3fa/0x447
>    kobject_add+0x5b/0x66
>    device_add+0x298/0x535
>    ? insert_resource_conflict+0x2a/0x3e
>    platform_device_add+0x14d/0x192
>    ? io_delay_init+0x19/0x19
>    platform_device_register+0x1c/0x1f
>    add_rtc_cmos+0x16/0x31
>    do_one_initcall+0x78/0x14a
>    ? do_early_param+0x75/0x75
>    kernel_init_freeable+0x152/0x1e0
>    ? rest_init+0xa2/0xa2
>    kernel_init+0x8/0xd5
>    ret_from_fork+0x2e/0x38
>   kobject_add_internal failed for rtc_cmos with -EEXIST, don't try to
>     register things with the same name in the same directory.
>   platform rtc_cmos: registered platform RTC device (no PNP device found)
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve2AEACgkQMOfwapXb+vL7GACfS4U/zFMaOLfdvbcEoyWNRD2B
IMAAnAqfM6mhhw2RssS/zr24FrYalslL
=fKec
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
