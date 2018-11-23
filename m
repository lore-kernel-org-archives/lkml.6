Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2140BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E4420685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQGKeTFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E4420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439765AbeKWX4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:56:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33491 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbeKWX4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:56:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id r27so10263673eda.0;
        Fri, 23 Nov 2018 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fiOiczY5EEBCtpidNJ6S5rSUJb77lILBkDmRXRt3Okw=;
        b=NQGKeTFOPt9I6bag/ucl8JmzUh26wcucbIGFn8f3tTAzcdyyCLXJcu0YXn9AVkn7wx
         4lvWhOSd07ukZLvH8uhgF2vyNSOYCefZqvKgWQ/0xNLSLT4Tww6rw45pXBUK0ChURCCm
         E2TN0vgoBcuLdYWMApInUlw0yVYMnNOxJ+1tZwjxzWdhyhCNiitiUkuiOxxN9EOc6wEU
         gsc7ciqSTdWeAnyvEu8J5d26MIVOKjVT5K3OZfrk7/a1cUagqGx3PNAJlzCKswrNDgEd
         nVdcEpt69LRAp06gMTPQmSXmjSkOuaAECcmNjRbeX5ZhOIXJcAGfwjm3iUHG3BpbjQ3G
         x/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fiOiczY5EEBCtpidNJ6S5rSUJb77lILBkDmRXRt3Okw=;
        b=to8F70UcFSlJTijD7xIa0TGhbFJZaVpjilHIdcl0zAmiBvIwGh6RQ15+hWDYjB1kQ3
         K6Rl826o1eNc+gOTGtz01KLUeAD9a5BJjnrdmmn9rsdRsS+ZgZBemTaq6b2+zijgUKz8
         HNFJ+Dd4chgWmjj4q+M6kK/TxNQd0daeel1i1HIzDQT7g+H5UuOSdt3RWdSnNcUFryeG
         pqji0kR2uPotOX/dbNijO8uHaFepKDacHH2s5AnfGM5K6OCfJf+X7pQqwtpcFBHyr4B/
         plFPj5Vt7RgCn+eEAKrTpilDO497VtJg/X68MxxSQmg8ocTodBJEV2RBtQY/DlcT554D
         qwvg==
X-Gm-Message-State: AA+aEWZGv8tcDA5q1ZCdzHcnINyhKv08D6N6Pyx2LF2s91lMS65J8+Db
        qq44LggAPpozKg/nPQrq7+A=
X-Google-Smtp-Source: AFSGD/Xaxao3UafpL5mNUsbNsH0JethRfNNE53eAz1P0dvKPRjtbFkFdLn31h76q+RG0lVHuui3eMQ==
X-Received: by 2002:a50:c182:: with SMTP id m2mr6215306edf.139.1542978753465;
        Fri, 23 Nov 2018 05:12:33 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z9sm1298782edr.61.2018.11.23.05.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 05:12:32 -0800 (PST)
Date:   Fri, 23 Nov 2018 14:12:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
Message-ID: <20181123131231.GB21651@ulmo>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
 <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:44:02PM +0000, Jose Abreu wrote:
> On 23-11-2018 12:21, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Setting up and tearing down debugfs is current unbalanced, as seen by
> > this error during resume from suspend:
> >
> >     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to=
 create debugfs directory
> >     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup=
: failed debugFS registration
> >
> > The imbalance happens because the driver creates the debugfs hierarchy
> > when the device is opened and tears it down when the device is closed.
> > There's little gain in that, and it could be argued that it is even
> > surprising because it's not usually done for other devices. Fix the
> > imbalance by moving the debugfs creation and teardown to the driver's
> > ->probe() and ->remove() implementations instead.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >
>=20
> Did you test trying to dump "descriptors_status" file when
> interface is not open ? I think that's the main reason why this
> is not in probe ...

I can't say that I did. I'll run a couple more tests and see if I can
fix both of the issues.

Thierry

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv3/LoACgkQ3SOs138+
s6HYpQ/+NA43XmFdoOhzRJjZZqjcPO9spvtNYupeIUjcSJUeMQQErnJkCimsSzfO
w7hfmHi2o81v1gwvnjPO6oU8dmIMQXbfSSkKsDaIuAz5bBKIZn3eL1+dAL+1aABk
D+y/oiYYT3sFFKIOIcisxIIVw9oMXfyD/JNclwHjNrYt7HiUeYi0pdKTjDz02IZT
WlF/yvnFIaiGOCQDVNJ4zCxsKPnlutyZbg4TlyrvApFXLX64uDyNIMCWvQBAtY7f
92gAvs0/J+6E/0/bDulHLVIoPxRX8oo/Ar6FfRsYJCK6+T3J+TnVJaUNhJoVNA4r
GprA5ncNTUsjVxfMNtXuLpABcebqqcxMEUXYiBKwphrjg7PwBTFiGwE74vZPIlmB
oG8YkaopH06f17+7/6nx9z4eLSPZBNWFGhaIUPYQq42TmmQKSqb5OYA2blndGaCa
xtlCG/YomKwY1J71bUI30zTRV4254aTwtJCOl3l5OHs583Bhi+iN2VtL3eC/5iAE
XMn5HcP9qgI7951a+QXpNS9SEJqZsDuGrG48qkdnNAzhwQu4DWjKGoa/rY1L/8AD
VJBC1ustpfGVp8hZwxxfYRsKLp6tbIOHUVA8OT1I0i/Iz4zzwY+Mbem4QCam3fuH
hmfXx0U16mBV6XpyfFxLgacdm81KMbpwGqTtVsaLFTvqkImUaJ4=
=RqG/
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
