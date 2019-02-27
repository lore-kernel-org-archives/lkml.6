Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8692EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D9D2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="nzJkz1PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfB0VnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:43:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38656 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0VnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:43:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id g37so5833475plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wjzFMpMJ6x1vHE4cp0ibP5GtymqbTvqwCCD4NFoxHw=;
        b=nzJkz1PN5Y3AA5g/bg/oHsp7R2YL9PsRJWX05eO+Ap3nXa65a8NKr1jMGS7FFGalmW
         zkgGJB9dgmNmrmsr/b2iJiOaaOyfpWhZPxMFD6eFdIN9MGVlR8PPg3XW0WQlx2mmDt/e
         sL4juZjUaKZrp9Td2afTQUk0idOSE4G3AcvmIc/RtrGB5PGEcyolfMAc0xzr85bfrME+
         jfaFycrueT1OEdF+HEgDMrRJU7btyzpHFTdqh50YJq3c18FTz3vpY5loN0g4a5j4jLyJ
         L8wxVGsaZ8M9OdwyiJmy/u9H2Fv9k2WMeTdIK8pXR/xHOKJIq2rsBC76mXee0/TlHQwg
         2Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wjzFMpMJ6x1vHE4cp0ibP5GtymqbTvqwCCD4NFoxHw=;
        b=pN+wwyjXWYtcLxcDXf346FB75oi7X8Xw1YJl0D2gnuQOZTAXUpJVYxGC1bYuANLhZ7
         rSEhAyws3FigZm6hdubfSNDAdBHw0nse7wn0AuF+mPGjDPvK3F+LnSCz21WgfNXTBSOV
         E1+PRDjb0pSJ0an+m/eU+fM8qxH70F27GxRjOLdbdgCJ/biWpAmELPgCsjD8p84rlW5H
         wW+AkMD54Q43MkCQbiZH5t+18vnXoh6ZpNxrIYPydqRgyFUFe2nupl0XKtFoDnC/Fm0Y
         WUULghUq9a0VYMTBsMeINvPsJDK/ZGNPRaU98COzlHsbrbxt6lW3+qbyyeEgVwFQsllk
         0e7A==
X-Gm-Message-State: AHQUAuaCB6QEqDL4ipWqLJg4mdsXSmjk3kSjB9Vf3x0elIUqLhC+tXUn
        Hfuxujpz0Ory0I9rZl6InHUFYg==
X-Google-Smtp-Source: AHgI3IYjH9NVgDu1lQuFXr/tXPKXP8pGvTYARDbz3Ryd2bJfRtqlGepZtAUZFQ2oDno3/iGUyi65vA==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr4408218pld.308.1551303779634;
        Wed, 27 Feb 2019 13:42:59 -0800 (PST)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id p6sm33221607pgd.69.2019.02.27.13.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 13:42:59 -0800 (PST)
Date:   Wed, 27 Feb 2019 13:42:56 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Harini Katakam <harinik@xilinx.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Harini Katakam <harinikatakamlinux@gmail.com>
Subject: Re: Request for suggestion on net device re-naming/re-ordering
 based on DT alias
Message-ID: <20190227134256.7522d95f@shemminger-XPS-13-9360>
In-Reply-To: <9a07d721-7ea8-03a0-d10b-5fdf2bfd9217@gmail.com>
References: <CAFcVEC+8P25MKWhizUUEuamikaZYUOjpppV=59=W3POTEfQqXw@mail.gmail.com>
        <20190227104028.707a75e2@shemminger-XPS-13-9360>
        <9a07d721-7ea8-03a0-d10b-5fdf2bfd9217@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 10:45:44 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 2/27/19 10:40 AM, Stephen Hemminger wrote:
> > On Wed, 27 Feb 2019 17:24:03 +0530
> > Harini Katakam <harinik@xilinx.com> wrote:
> >  =20
> >> Hi,
> >>
> >> We've had some users requesting control over net device name order
> >> when multiple ethernet devices are present on a system. I've tried a
> >> few solutions to this and looked it up on forums. But I apologize if
> >> I have missed something.
> >>
> >> I know that the current system allocates eth<n> as per probe order
> >> but that is obviously not stably controlled by user (tried DT
> >> re-ordering and defer probe). One solution is to use DT alias names
> >> to write to (net_device)->name as follows:
> >> Devicetree:
> >> aliases {
> >>    ethernet0 =3D &mac1;
> >>    ethernet1 =3D &mac0;
> >> };
> >> Driver probe:
> >> +       /* Read ethernet DT alias id and assign to right device name*/
> >> +       id =3D of_alias_get_id(np, "ethernet");
> >> +       if (id < 0) {
> >> +               dev_warn(&pdev->dev, "failed to get alias id (%u)\n", =
id);
> >> +               return id;
> >> +       }
> >> +       snprintf(dev->name, sizeof(dev->name), "eth%d", id);
> >> +
> >>
> >> These three drivers seem to have something similar for mdio/phy bus ID=
s:
> >> drivers/net/ethernet/broadcom/genet/bcmmii.c:409: id =3D
> >> of_alias_get_id(dn, "eth");
> >> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:43: plat->bus_id =
=3D
> >> of_alias_get_id(np, "ethernet");
> >> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:404:
> >> plat->bus_id =3D of_alias_get_id(np, "ethernet");
> >>
> >> Drawback: This approach will break if alias is not provided for one
> >> of the interfaces on board. Not to mention, there could be systems
> >> with multiple ethernet makes (for ex. Cadence macb and Xilinx axienet)
> >> If one of the drivers does not have an alias read mechanism, it is
> >> possible to have clashing ID assignments. Is there any way this
> >> solution can be changed to be stable/acceptable?
> >>
> >> One other alternative I've tried is netdev kernel bootargs but this
> >> device name was not being picked by the kernel:
> >> https://www.kernel.org/doc/html/v4.19/admin-guide/kernel-parameters.ht=
ml
> >> netdev=3D <mac1=E2=80=99s interrupt id>, <mac1=E2=80=99s base address>=
, eth0
> >> netdev=3D<mac0=E2=80=99s interrupt id>, <mac0=E2=80=99s base address>,=
 eth1
> >>
> >> Could you please suggest any alternatives?
> >> Thanks!
> >>
> >> Regards,
> >> Harini =20
> >=20
> > Device naming is a hard problem, and there is no perfect solution.
> >=20
> > Device tree should be providing hints to userspace policy for naming, n=
ot
> > trying to do it in the kernel.  =20
>=20
> And Device Tree does already, if you look at the uevent attributes that
> the kernel sends, there should be ample information to uniquely
> determine which physical network device the network device maps to, e
> for instance:
>=20
> cat /sys/class/net/eth*/device/uevent
> DRIVER=3Dbrcm-systemport
> OF_NAME=3Dethernet
> OF_FULLNAME=3D/rdb/ethernet@9300000
> OF_TYPE=3Dnetwork
> OF_COMPATIBLE_0=3Dbrcm,systemportlite-v1.00
> OF_COMPATIBLE_1=3Dbrcm,systemport
> OF_COMPATIBLE_N=3D2
> OF_ALIAS_0=3Deth0
> MODALIAS=3Dof:NethernetTnetworkCbrcm,systemportlite-v1.00Cbrcm,systemport

Then you need to work with udev developers to handle device tree better.

By design ethN is not used for persistent naming, only other names like ens=
X.
This allows for safer renaming and provides way to handle devices that may
not match any rules.

Most of udev naming is based of properties in sysfs like pci-slot, port etc.
If you had that available on these devices, it would just work now.
