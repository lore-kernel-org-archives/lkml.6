Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E965208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIzlJnfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E965208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbeKPUea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:34:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37950 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeKPUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:34:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2-v6so19201676edi.5;
        Fri, 16 Nov 2018 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vp2Q0PYz0w5vT1kbfhIGNiGqneXAlbVDcfsV37N8k0U=;
        b=JIzlJnfvBmsUTL1PhHXxBxGqMfQbEoyIByOJY+IImYqln2aQf9GzPm95dw4mLQjY6B
         QMlcTRduD6YuiAHQ95SJze9lRnmhhUrSTDsOpw7FQB/QOdgiCaVo3kiPGQ1lOjsvPLTu
         T8+SqZXGvWhtPiXBga6/OS93rS1CHHIHMg8cPbGzIbHzqchEbXypX4fDo/BpdJ3vgJke
         P2xKePL9fkNcNf5t9l1QyASPWH0UpjLuLYycpeobEW2W/+4c4O+0mKx2x6ePC0MaMRte
         SixKIEYexXuIxC6H3LOvfxhAnh+VRXk/W/ONz3yvXHp4H/74BYd4w2UgvNDhv7xmlrdI
         Ou/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vp2Q0PYz0w5vT1kbfhIGNiGqneXAlbVDcfsV37N8k0U=;
        b=i9Vmxez+bis/lxKM3neu2/YwBnusmODa9JohDNJu27GDySpqyLheOLzrn35qJ6IRiU
         RWJJgierBMMOFPuFDo1CSZm6S5QCWJKQL9NT3Z1SFlHlq1ZjGS7i+FF/+P3BEP7CgGra
         4OtrJdK1Lpn2NPIcxH6W2n6fRvUBl314n6J/2q3/desJQdJ2XVk3h0SGH/hCHPWsuQtw
         NKD4Iq46ReBwIRya8XGiSUhjQi0UahHunxFyHN7W8HMfUvMFlmMf93FJihnvnPKheYzP
         efv+0ggwLNPizejnsavklCEoxPVEKpurhFE+StFJVoUuhxz6NYG78JD4z9MWSAzxOqmf
         MBoQ==
X-Gm-Message-State: AGRZ1gKs6RQSYRRrF7/wzwE901uauf+yzlz5CdRRgwiOYOQqT69M+2PU
        GD1rve1xMVjOvcrZaW4UiB8=
X-Google-Smtp-Source: AJdET5fKVybqPDrbf3TeKf7PRY6fYs05ZXeu8W/pEQyASmfNNGnHaBIXJXAqVkH1WS7wMgPdz7QhdQ==
X-Received: by 2002:a17:906:16ca:: with SMTP id t10-v6mr8151568ejd.200.1542363766498;
        Fri, 16 Nov 2018 02:22:46 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id q4sm3764614eda.50.2018.11.16.02.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:22:45 -0800 (PST)
Date:   Fri, 16 Nov 2018 11:22:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Message-ID: <20181116102244.GB14769@ulmo>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181114124752.GI2620@ulmo>
 <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 07:47:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Nov 14, 2018 at 01:47:52PM +0100, Thierry Reding wrote:
> > On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> > > The flag 'has_clks' and related checks are superfluous as the CCF
> > > subsystem does this for you.
> >=20
> > Both of these mechanisms aren't equivalent. While CCF can deal with
> > optional clocks, what the has_clks flag actually means is that the
> > device doesn't need a clock (or doesn't have a clock input) on the
> > devices where it is cleared.
> >=20
> > So I'd actually be in favor of keeping the has_clks property because it
> > serves as an additional sanity check. For example if you run this driver
> > on an SoC that "has clocks" but if you don't list them in DT, then after
> > this patch the driver will happily continue without clocks, even though
> > it may break completely without those clocks. I've seen SoCs respond to
> > disabled clocks for a hardware block in different ways, in many cases an
> > access to any of the registers will completely hang the CPU. In other
> > cases it may just crash in some other way or give you some sort of
> > machine exception. None of those are good, and make the tiny bit of
> > additional code required to support the has_clks flag very attractive.
> >=20
> > But that's just my opinion. If you prefer to throw away that safety
> > barrier, be my guest. But if you do, please move this functionality into
> > the clock framework first and then make the driver use it.
>=20
> The usual policy is: If the things specified in the dt are
> wrong or incomplete, it's ok to fail however you like. So from a
> correctness POV I think the change is fine.

Erm... that's pretty much what I said. It doesn't necessarily mean that
it's the right thing to do, though. If we know that clocks are required
and we don't find them in DT, it's better to complain and let the user
know exactly what is wrong rather than just let it crash and have them
track down the bug without additional information.

Thierry

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvumnQACgkQ3SOs138+
s6FeCg/+IGbZAVX4NM9KqGMAlCKbZZHB50ybxRy44LZmoepfGNAyx/aTSRIUqJPJ
nZpBi4xS+lDw2cDg9yhBkIGbDvcKZciTsR7zq2AEPgg0jeigRlqZk0uTSkzJdYnA
WcNnv1MW8L3X74MpLlBVU7iqpQb1ihj3VaLgqH7ySdMVp70G+b18SSZYjxoxvsGP
9PbCroW823NhLfNLLYe6Goc3B2AzHFY3imB0wHhE3qPCewxT5qv9v7VqGRozGR4Y
Ne2gY738btUEPCiU/1ncMzNQ3zSB16ip3YUSX7abJFf8FGR2W9EZZ0KzNsNPreV/
hEDF56dJNDDB3HrpxW7t4KBOzct2tbjWLQLKNuDYxshdsOolNIb7IgtOCiddTHi/
Yo+vA74iquxsAFlL5bjWwkSyem6UeZFztBt6IQHL/WvaiosrvxGzYau061Nf3E6T
q+13Bv3bUKU3H2Fm8bLi1OnRkENUsbHurzXY+Q9uw8i0k08FIf8lH2LbDYs6E7U7
lLYfQhAaJlurHPepdctFzCZGXpUStYu/sVj/QDbhqPssXi6/AgiMcYnWLxufWDwN
/wKfjMAg9AmBpXuZTmDJBQF6KuUzDsAhvhxcbHgpfO/8tAMHC2aDKp6dTmAvC3/W
VNo/2hmln98pZlhy+cqhjygcqXl77BnSBUKSS/h1UjTuIeBvi+k=
=oX8L
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
