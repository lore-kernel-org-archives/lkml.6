Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A54C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A65208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2Y2NIgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A65208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeH0TiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:38:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37756 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeH0TiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:38:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so8735972wmc.2;
        Mon, 27 Aug 2018 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lmci/lnM0eb2KVibqequYivnLeLoLQLhRryHwQGTBp4=;
        b=S2Y2NIgiZIDvZ97G82GZB6rkjNm/aJ3bbih0YR1WdnaCB1J42adO7YtR37bi70cHkI
         w5JM+q9h6hVboC1q3Gp6K5nLTUiR+ne6HeK0Pahj8+fCWat9JVLcODGtTzrpLcnxlcSk
         R2YJ2MRKvhvk4Pj90LHVZMpqK/kPjS0EybQ5opF/lzW8wxUifLKhoA1P7Q9tJ7rEtC+1
         XRnGSg6DIXFvWrFnkGcBVTpCM+ADb3Rj95veYfvC5fQPTSGEwnu6GyofaiedWLX+tIr7
         80eQU0uqVbuKhbTCaUdSMFXX+0/sI3bQjiFljbLoetcqliHrSp0/vX49SIPkwbBhaKIs
         qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lmci/lnM0eb2KVibqequYivnLeLoLQLhRryHwQGTBp4=;
        b=TaE/fGsXjTpu/vF6zpzUGhrjGE9/gpGI7D8QNZDFZ8wyYCGuBQ1MdKkRA5+/3H6PnF
         d2st9vLBR5LyJLRgk3xTcCmVp/B6ZvtQLanFV+YBfC2yYeIMFEVRzsxEchr3iVvHJE2D
         AhCup7FuMNRUlk8ovp0u9QvwCseTG7p+RmPO9jJnquLExxvZgA1DLBddHR/jrWoxBXHh
         GBLrKS2jDinDuXifhpM65uwC6cOVbJcERfuOzS71OjYteeZKRwTf03f0r0F1o2ekMyl1
         0+0mjbOWv2s4vGs6gK+X58b9UJhR/OkAs3ErF5bxKg4FtAg1S5MBHY7raZierdnwwF79
         BzvQ==
X-Gm-Message-State: APzg51BBtkNCwRL8uLl4pVb2A372GPh56dn0xL5zFNz4PW1Snjd8jCos
        gj5POqzCF7R2Aoy1nNeUn5U=
X-Google-Smtp-Source: ANB0VdYN8F1nAr27edQNKRKMRD/YXhlQDb+Oy9cfO/vhYTIMsGf0Z/rH/FlWEttSgbSUBGC9xGVYig==
X-Received: by 2002:a1c:ee97:: with SMTP id j23-v6mr6083387wmi.66.1535385055413;
        Mon, 27 Aug 2018 08:50:55 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id 184-v6sm666529wmv.6.2018.08.27.08.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 08:50:54 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:50:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Aapo Vienamo <avienamo@nvidia.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Message-ID: <20180827155053.GA6458@ulmo>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
 <1535379056.14664.13.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <1535379056.14664.13.camel@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 02:10:58PM +0000, Marcel Ziswiler wrote:
> On Fri, 2018-08-10 at 21:08 +0300, Aapo Vienamo wrote:
> > Hi all,
> >=20
> > This series implements support for faster signaling modes on Tegra
> > SDHCI controllers. This series consist of several parts: changes
> > requried for 1.8 V signaling and pad control, pad calibration, and
> > tuning. Following earlies patch sets have been merged into this
> > larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI
> > enable
> > 1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
> > padautocal procedure". Also the patches for enabling SDHCI tuning
> > are added.
>=20
> I tried your tkln/hs200 branch on Colibri T20, Apalis/Colibri T30 and
> Apalis TK1. It at least does not seem to make things any worse but
> HS200 on TK1 still seems to behave strangely. During boot I do get the
> following message (mmc0 being the SDHCI instance of one of them SD card
> slots):
>=20
> [    3.238360] mmc0: Internal clock never stabilised.
> [    3.243183] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI RE=
GISTER DUMP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    3.249649] mmc0: sdhci: Sys addr:  0x00000000 |
> Version:  0x00000303
> [    3.256138] mmc0: sdhci: Blk size:  0x00000000 | Blk
> cnt:  0x00000000
> [    3.262657] mmc0: sdhci: Argument:  0x00000000 | Trn mode:
> 0x00000000
> [    3.269119] mmc0: sdhci: Present:   0x01fb00f0 | Host ctl:
> 0x00000000
> [    3.275580] mmc0: sdhci: Power:     0x0000000f | Blk
> gap:  0x00000000
> [    3.282041] mmc0: sdhci: Wake-up:   0x00000000 |
> Clock:    0x00000401
> [    3.288485] mmc0: sdhci: Timeout:   0x00000000 | Int stat:
> 0x00000000
> [    3.295037] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab:
> 0x00fc0003
> [    3.301559] mmc0: sdhci: AC12 err:  0x00000000 | Slot int:
> 0x00000000
> [    3.308022] mmc0: sdhci: Caps:      0x376fd080 |
> Caps_1:   0x10000f70
> [    3.314527] mmc0: sdhci: Cmd:       0x00000000 | Max curr:
> 0x00000000
> [    3.321159] mmc0: sdhci: Resp[0]:   0x00000000 |
> Resp[1]:  0x00000000
> [    3.327642] mmc0: sdhci: Resp[2]:   0x00000000 |
> Resp[3]:  0x00000000
> [    3.334144] mmc0: sdhci: Host ctl2: 0x00000000
> [    3.338613] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> 0x00000000
> [    3.345110] mmc0: sdhci:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> And it subsequently stalls waiting for interrupt for more than 8
> seconds before continuing to mount the rootfs as follows (mmc2 being
> the SDHCI instance of the eMMC):
>=20
> [    4.874017] tegra-hdmi 54280000.hdmi: cannot set audio to 48000 Hz
> at 297000000 Hz pixel clock
> [   13.930136] mmc2: Timeout waiting for hardware interrupt.
> [   13.935603] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI RE=
GISTER DUMP
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   13.942071] mmc2: sdhci: Sys addr:  0x00000000 |
> Version:  0x00000303
> [   13.948511] mmc2: sdhci: Blk size:  0x00007080 | Blk
> cnt:  0x00000001
> [   13.954948] mmc2: sdhci: Argument:  0x00000000 | Trn mode:
> 0x00000013
> [   13.961385] mmc2: sdhci: Present:   0x01fb00f0 | Host ctl:
> 0x00000031
> [   13.967821] mmc2: sdhci: Power:     0x00000001 | Blk
> gap:  0x00000000
> [   13.974263] mmc2: sdhci: Wake-up:   0x00000000 |
> Clock:    0x00000007
> [   13.980692] mmc2: sdhci: Timeout:   0x0000000e | Int stat:
> 0x00000000
> [   13.987119] mmc2: sdhci: Int enab:  0x02ff000b | Sig enab:
> 0x02fc000b
> [   13.993546] mmc2: sdhci: AC12 err:  0x00000000 | Slot int:
> 0x00000000
> [   13.999974] mmc2: sdhci: Caps:      0x376fd080 |
> Caps_1:   0x10000f70
> [   14.006415] mmc2: sdhci: Cmd:       0x0000153a | Max curr:
> 0x00000000
> [   14.012845] mmc2: sdhci: Resp[0]:   0x00000b00 |
> Resp[1]:  0x048062bf
> [   14.019272] mmc2: sdhci: Resp[2]:   0x314a8000 |
> Resp[3]:  0x00000240
> [   14.025697] mmc2: sdhci: Host ctl2: 0x0000000b
> [   14.030132] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> 0xfbc6b208
> [   14.036561] mmc2: sdhci:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   14.044332] mmc2: new HS200 MMC card at address 0001
> [   14.050656] mmcblk2: mmc2:0001 016G30 14.7 GiB
> [   14.056376] mmcblk2boot0: mmc2:0001 016G30 partition 1 4.00 MiB
> [   14.063563] mmcblk2boot1: mmc2:0001 016G30 partition 2 4.00 MiB
> [   14.069589] mmcblk2rpmb: mmc2:0001 016G30 partition 3 4.00 MiB,
> chardev (247:0)
> [   14.078260]  mmcblk2: p1 p2
>=20
> After that it actually seems to work quite nicely:
>=20
> root@apalis-tk1-mainline:~# cat /sys/kernel/debug/mmc2/ios
> clock:          200000000 Hz
> actual clock:   163200000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> root@apalis-tk1-mainline:~# hdparm -t /dev/mmcblk2
>=20
> /dev/mmcblk2:
>  Timing buffered disk reads: 408 MB in  3.01 seconds =3D 135.39 MB/sec
>=20
> Have you ever observed similar behaviour? What could cause this?
>=20
> Anybody else tried it on TK1?

I can't reproduce this on Jetson TK1. Things boot normally and I don't
see the controllers switch into HS200 for either eMMC or SD card.

Did you update the device tree to enable HS200 on Apalis?

Aapo, isn't there a mechanism to prevent HS200 on devices where it
hasn't explicitly been tested (and enabled)? I thought we had discussed
that this was going to depend on pinmux DTS entries, but I can't find
the actual code where any of that would be checked. I only see checking
NVQUIRK_NEEDS_PAD_CONTROL in tegra_sdhci_is_pad_and_regulator_valid(),
but since we don't enable that quirk on Tegra124, it would seem to me
that we always enable fast modes on boards that don't need pad control.
Is that really what we want?

Also, if the above is correct, then why am I not seeing faster modes
getting enabled on Jetson TK1?

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluEHdsACgkQ3SOs138+
s6F3VhAAoQTAu+tI11tyTh/3QuI5dlKcgB5GOtnRbfgr/BJFwzZjd30bO++yjdIM
L7tIl59h/hbfB7pQcN9WyIQR9iWEE02vtLoyYR4h5sO0EaBLh5ZigPRiDXjlSajc
pEeXx+1RWowUQolpCGbqQ+a5nZOy6nNvjj8ZrsQ1ahTNKlLMfFAdenHuscbV8J1Z
e6vl/UQAOMOxhRAxboy2BX3lhXoVS3VdehZLgkar8dD76mL2SLaR6sXZIZPvvmSs
6nkLpZOYK7faOg9U6D0JTnVxHbbN7nMhZlxafBI/Fqh5m9qiMaJS0r1dIFXt3EE4
LfLAsNEwMgIAwlv+MkoeCFd7dh0qYWVOuEk33xkFgIcSEtKpwANmy1oMel88DIaq
IS8KyGOprHDLQ3WAN/sIuhTYmcftEJJuMX7g0fv+HJnNztPHMb9SWp4In9FIATGN
jRHslWKiJ8pLjKd2clufMS8DBnt+5YINVjyQ42q7UqgutYqpyIbDDIe8G7kzkfkB
zl98SwQ6LcLGXADSMkDDEPCzBiQxC5qqTJi5vJVKWRUudnu9NCFqFhWuaXYz0qbP
Yab7TFP2jQNFP17zoOJ3mnznjpY7td9tGBVioLF65q0pNouL40g3VTkBnKO3uOMC
hxI2rL46jPi4c12qQ62UwrqaF+0Nzgo1voIxE2xjeUhTPclzQj4=
=32Fn
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
