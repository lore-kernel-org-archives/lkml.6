Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F188EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A667F2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrshXKKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A667F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeKPDKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:10:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36258 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeKPDKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:10:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id s11so9352896wmh.1;
        Thu, 15 Nov 2018 09:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HU/XOL7HmAFf+KHAyZhHlYS1+yJjFugoI+2KOIlKZNM=;
        b=KrshXKKdnMGY3d/dFyr9OItLw4KKSE1A6yUKltcrIgncP6s+rfuvGOLpUd3sWWSz1j
         4U3JbG0PM/7S+XUof0QI3HZiDCu2CiiJj0GsAJk4Vx4B4gmmis7p3LOVPSX6pRb7AEPe
         3mzuYklCBZtKht27MLz6ovxDd04Vo7xxVQ79oHDEoBJFz7R087EEj7zQd4GR2zrw87py
         nkkTIA1+SsMI9oGw4OhAIJlJmw1q57zx6CB32sL+Kq92B6JIeefIW9VvLOx9sjMWKRbG
         D6MFleWzOwGE6VRLgtrhgMbgaz1xrOoEq1hs7vqvBuxsPeuLNe6z06jxxVTs/0QjwBmc
         pFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HU/XOL7HmAFf+KHAyZhHlYS1+yJjFugoI+2KOIlKZNM=;
        b=p1n6NPKa/MNj/ZPzSQNwsOI2mSL1jWQz6f6WW/LbXpx0PJd1x6WnVvTGjJbGtOVnOA
         B6QU/eguKORid7ohBw2VrezQd5zIxYUqffPjTKnSuLwBAfMT/bluoHZeR6whuNFhmBpM
         C3otD7Spoae9NGo46Nm8qCpghrepfjPFWGJSjo6vMPErYymYhFZbXN8OxokNByc3uER0
         HwbhG1224kGN9jMMMvHCyP4ekxCoaAY6KgtxieijW6YJdhn6g1bWJFyrEqaPQvFWkm0W
         6nrfcfFJzOQV8hANVqAWjQrQC1ZQGcY+CosAubZtMI0xHGTrFh0yVRIGZC7fq1dPhmCY
         iYOw==
X-Gm-Message-State: AGRZ1gIa9bX+jB15Sy2ttCWmkmyPK9WL1lyXo2P5zljsoKV8a/vOMYXZ
        5LT8mu22PTMxq0hY4n/22M6qiOO6
X-Google-Smtp-Source: AJdET5exomEEWX5ZxXdVYzPhCXCCtfUOkbBVXpLsLrHc7Cpec9IGabjBRKTX6LubXJRSNwffYx0Ksw==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr5707848wmj.30.1542301312623;
        Thu, 15 Nov 2018 09:01:52 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 133sm642723wme.9.2018.11.15.09.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 09:01:51 -0800 (PST)
Date:   Thu, 15 Nov 2018 18:01:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>
Cc:     Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux: sata_nv: adma support
Message-ID: <20181115170150.h5cj5hiblizgadqs@pali>
References: <201412232051.07067@pali>
 <201508021108.52978@pali>
 <CADLC3L3eym59Agpm2J_Oy_Eyfq=9iUTwi2BPxnLxoEM_Yx9cfw@mail.gmail.com>
 <201508042006.57727@pali>
 <20180510135157.awgoymyr2p5vbmlq@pali>
 <20180809114852.cwvyqeuilxv4qbsq@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yayhgksxvyrch76o"
Content-Disposition: inline
In-Reply-To: <20180809114852.cwvyqeuilxv4qbsq@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yayhgksxvyrch76o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tejun & Robert, just a friendly reminder for an email/issue below.

On Thursday 09 August 2018 13:48:52 Pali Roh=C3=A1r wrote:
> On Thursday 10 May 2018 15:51:57 Pali Roh=C3=A1r wrote:
> > On Tuesday 04 August 2015 20:06:57 Pali Roh=C3=A1r wrote:
> > > On Monday 03 August 2015 05:02:15 Robert Hancock wrote:
> > > > On Sun, Aug 2, 2015 at 3:08 AM, Pali Roh=C3=A1r <pali.rohar@gmail.c=
om>
> > > > wrote:
> > > > > On Sunday 02 August 2015 03:45:32 Robert Hancock wrote:
> > > > >> On Sat, Aug 1, 2015 at 2:09 PM, Pali Roh=C3=A1r <pali.rohar@gmai=
l.com>
> > > > >>=20
> > > > >> wrote:
> > > > >> > On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
> > > > >> >> On Tue, Dec 23, 2014 at 1:51 PM, Pali Roh=C3=A1r
> > > > >> >> <pali.rohar@gmail.com>
> > > > >> >>=20
> > > > >> >> wrote:
> > > > >> >> > Hello,
> > > > >> >> >=20
> > > > >> >> > I have nvidia nforce4 motherboard with nvidia sata
> > > > >> >> > controller:
> > > > >> >> >=20
> > > > >> >> > 00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Seri=
al
> > > > >> >> > ATA Controller [10de:0054] (rev f3)
> > > > >> >> > 00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Seri=
al
> > > > >> >> > ATA Controller [10de:0055] (rev f3)
> > > > >> >> >=20
> > > > >> >> > I manually enabled adma mode (which is disabled by default)
> > > > >> >> > by adding sata_nv.adma=3D1 to grub cmdline. In git history I
> > > > >> >> > found that enabling adma mode includes NCQ support and
> > > > >> >> > reduced CPU overhead. It looks like adma mode is working,
> > > > >> >> > but at every boot I see one same error message in dmesg:
> > > > >> >> >=20
> > > > >> >> > [   16.823514] ata1.00: exception Emask 0x1 SAct 0x0 SErr 0=
x0
> > > > >> >> > action 0x0
> > > > >> >> > [   16.823520] ata1.00: CPB resp_flags 0x11: , CMD error
> > > > >> >> > [   16.823524] ata1.00: failed command: SET FEATURES
> > > > >> >> > [   16.823530] ata1.00: cmd
> > > > >> >> > ef/05:fe:00:00:00/00:00:00:00:00/40 tag 16
> > > > >> >> > [   16.823530]          res
> > > > >> >> > 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> > > > >> >> > [   16.823533] ata1.00: status: { DRDY ERR }
> > > > >> >> > [   16.823535] ata1.00: error: { ABRT }
> > > > >> >> >=20
> > > > >> >> > When adma is disabled then this error message is not
> > > > >> >> > generated.
> > > > >> >>=20
> > > > >> >> It looks like something is trying to issue a command to disab=
le
> > > > >> >> APM power management on the drive, and the command fails
> > > > >> >> (likely because it doesn't support that command). I'm not sure
> > > > >> >> where that would be coming from - I'm pretty sure the kernel
> > > > >> >> doesn't issue that command itself. Something that's part of
> > > > >> >> your distro perhaps?
> > > > >> >>=20
> > > > >> >> I don't know why it would only be failing in ADMA mode either,
> > > > >> >> though depending on where the command is coming from, maybe
> > > > >> >> it's not being issued otherwise for some reason?
> > > > >> >>=20
> > > > >> >> > What does that error message means? It is critical? What is
> > > > >> >> > that command SET FEATURES doing? Are there any problems with
> > > > >> >> > adma mode on nforce4 motherboards? Because I did not see any
> > > > >> >> > problems (except that one error message).
> > > > >> >> >=20
> > > > >> >> > --
> > > > >> >> > Pali Roh=C3=A1r
> > > > >> >> > pali.rohar@gmail.com
> > > > >> >=20
> > > > >> > Hello,
> > > > >> >=20
> > > > >> > now after long time I did more investigation and that error is
> > > > >> > reported for every connected HDD. I identified that it comes
> > > > >> > from udev script
> > > > >> >=20
> > > > >> >  /lib/udev/rules.d/85-hdparm.rules
> > > > >> >=20
> > > > >> > which just call script /lib/udev/hdparm for every one connected
> > > > >> > HDD.
> > > > >> >=20
> > > > >> > Script /lib/udev/hdparm just call:
> > > > >> >  /sbin/hdparm -B254 $DRIVE
> > > > >> >=20
> > > > >> > And that -B254 cause above error message in dmesg log. Output
> > > > >> > from
> > > > >> >=20
> > > > >> > hdparm is:
> > > > >> >  /dev/sda:
> > > > >> >   setting Advanced Power Management level to 0xfe (254)
> > > > >> >   APM_level      =3D not supported
> > > > >> >=20
> > > > >> > Any idea why in ADMA mode it cause above error (APM unsupporte=
d)
> > > > >> > and in non ADMA mode it is working fine? Maybe APM ATA commands
> > > > >> > should not be sent via ADMA?
> > > > >> >=20
> > > > >> > Here is another output:
> > > > >> >  $ sudo hdparm -I /dev/sda | grep -i power
> > > > >> > =20
> > > > >> >             *    Power Management feature set
> > > > >> >            =20
> > > > >> >                  Power-Up In Standby feature set
> > > > >> >            =20
> > > > >> >             *    SET_FEATURES required to spinup after power up
> > > > >> >             *    Host-initiated interface power management
> > > > >>=20
> > > > >> The "set features" command is a non-data command so based on our
> > > > >> current knowledge, it should work in ADMA mode. However, these
> > > > >> NVIDIA SATAs are black boxes, and rather buggy ones at that, so
> > > > >> it's possible there's an unknown issue there.
> > > > >=20
> > > > > Maybe I should note that hdparm -I did not generated any error
> > > > > message. I post is here because it show "Power Management feature
> > > > > set" is supported by HDD. This indicate that HDD supports -B (APM)
> > > > > command, right?
> > > >=20
> > > > As far as I know, yes.
> > > >=20
> > > > >> The easiest way to test that would be to take out the condition
> > > > >> check for qc->tf.protocol =3D=3D ATA_PROT_NODATA in
> > > > >> nv_adma_use_reg_mode in drivers/ata/sata_nv.c. That would force
> > > > >> it to disable ADMA for all non-data commands.
> > > > >=20
> > > > > Ok, as now I have just SSH access to that machine, I will do kern=
el
> > > > > patching later (when I have physical access to it).
> > > > >=20
> > > > >> I really don't know why Ubuntu is disabling APM on all drives on
> > > > >> bootup however. Especially for laptops, that seems like a silly
> > > > >> thing to do explicitly. Sounds like one of the silly things
> > > > >> Ubuntu is known to do without consulting people.
> > > > >=20
> > > > > Looks like this comes from upstream udev/systemd project :-(
> > > > > Anyway, for laptops on battery ubuntu has another set of scripts
> > > > > which turn on APM (based on connected/disconnected AC adapter).
> > > >=20
> > > > There's no such scripts in Fedora, so either they removed it, or it=
's
> > > > something that either Debian or Ubuntu has added in.
> > > >=20
> > > > > That udev script which turn off APM is called when any disk is
> > > > > attached to system (so at boot time it is called for every one
> > > > > disk).
> > > > >=20
> > > > > Now I just masked that udev script and it is no longer called...
> > > > >=20
> > > > > Anyway if I call hdparm -B /dev/sda I get output:
> > > > >=20
> > > > > APM_level      =3D not supported
> > > > >=20
> > > > > And important is that there is no error message in dmesg. I get it
> > > > > only if I call hdparm -B with parameter (set option). But APM
> > > > > should be supported, right?
> > > >=20
> > > > Does the get command work without ADMA enabled?
> > >=20
> > > I requested to boot that machine with turned off ADMA. I verified it =
is=20
> > > turned off as I found sata_nv.adma=3D0 in /proc/cmdline and file=20
> > > /sys/module/sata_nv/parameters/adma contains big N.
> > >=20
> > > I called hdparm:
> > >=20
> > > $ sudo hdparm -B254 /dev/sda
> > >=20
> > > /dev/sda:
> > >  setting Advanced Power Management level to 0xfe (254)
> > >  HDIO_DRIVE_CMD failed: Input/output error
> > >  APM_level      =3D not supported
> > >=20
> > > It failed, but I do not see any error message in dmesg. There is noth=
ing=20
> > > new in dmesg.
> > >=20
> > > So looks like I'm not able to set APM... But why in ADMA mode it=20
> > > generates some error and in non ADMA mode no error? Strange!
> > >=20
> >=20
> > Hi Robert!
> >=20
> > After long time I tested it again. I have there two SATA disks connected
> > to that computer. Running hdparm -B (without number) just print "not
> > supported" and hdparm -B254 still cause above kernel dmesg error.
> >=20
> > But second disk print via hdparm -B current APM level and via -B<num> I
> > can set a new APM level. And it does not print any error (nor in dmesg
> > or on stdout).
> >=20
> > Therefore first disk probably does not support APM and above kernel
> > dmesg error is caused only when I'm trying to set APM level on disk
> > without APM support.
> >=20
> > So... is not this problem in kernel libata or sata_nv modules which
> > parses error messages for unsupported operations?
>=20
> Tejun, you are libata maintainer, can you look or check if this is a
> problem in kernel's libata? I guess that this is problem in propagating
> APM errors. At least disk without APM support should not cause such
> errors...
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yayhgksxvyrch76o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW+2mewAKCRCL8Mk9A+RD
UhHEAJ4yxCSrs5j2YoC0OCDlrqVBTgsFyACeIAPpdUFDdQwK5lQkGRm0ZhWdiSg=
=gpqT
-----END PGP SIGNATURE-----

--yayhgksxvyrch76o--
