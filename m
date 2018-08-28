Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618D4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20B62087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYrftMT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20B62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeH1OjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:39:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35999 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeH1OjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:39:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so1505094wmj.1;
        Tue, 28 Aug 2018 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P2HpVa2oKz/ywEbQL1paku2SnjVp9HmBjy4GekP89+M=;
        b=HYrftMT7SG3DSghac/gbBf4fPsEYS6Tj1gVY9m7tAMQlwsix75vB9473ABStAid+Nz
         Dtk34JHGuG/j6t43Q/eBJcqNrwDmFGiV/9Xclht5ln5r17+0VaJfp721FytHO105xOJk
         x0U39uMgYTpf7r+k8HO3wdo3A1Qmt7dlEL79FKcNY3Ip3bwFhBuO3WGMlmNxd1WW8Zc2
         lmgwH2SV3E0k8QRkY18dwLqV1F246r96YdxBEPV3B9/hwpmA5ewP3cqwEz2wYHt9301/
         kF++9m+OFdKYZQ3r2J6tGZNA12A6qjOiPpQCar7NPAUCKe7br4bWqjBPfoGcEGJnuL8g
         MTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2HpVa2oKz/ywEbQL1paku2SnjVp9HmBjy4GekP89+M=;
        b=OI574vlFm1xM6qbh28MQC+ouppXUCYErv/37fXJ+MRhIuCOj2XygSvQkJDYcwD1zbf
         jvx9mBjUdRDrfRMuSQsJg5tU9mFhLXO/k//e3mgOpImZ4zlF2DD02PVfmFfkRwMRM+Fu
         EY33dvhYcXyplFCPu9mRJFR6Slpt++nQvHoTAszL35WA/YhiGLoNeMY43lwkEdusbStg
         9fplswuo5ZM7TWrZxSGmx0HxZel82nFvvqWLrh4tr1B4gEVgvXV4pMhGb1Kj8vcM6R4e
         EJfjkFiy4FGMWtiYPP5XabuNMjF6Bn8YV0gg55QzFaAu8FB4irNW0mJWzDIGmO2ZIWOB
         QbPA==
X-Gm-Message-State: APzg51BGhLYhiSdqEOoLpfvxjE9zgO6dJLOZAQClYWPjWQ7S1WmfPBEJ
        v4TSbfq1/lpZjBQPWyqv2zdkNpwG
X-Google-Smtp-Source: ANB0VdaNOxM1aT1Gzck31LOPGj6NBALz9fGQeScrLKpSmPJNEpR1LtKE2DomrSeAzy6zY7LvsLIH+A==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr1032758wmd.79.1535453277179;
        Tue, 28 Aug 2018 03:47:57 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id v7-v6sm492616wrr.19.2018.08.28.03.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 03:47:56 -0700 (PDT)
Date:   Tue, 28 Aug 2018 12:47:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Message-ID: <20180828104755.GC9386@ulmo>
References: <20180818155430.5586-1-digetx@gmail.com>
 <20180818155430.5586-7-digetx@gmail.com>
 <20180820191209.GA28618@bogus>
 <b46cac22-9b31-9aa7-7eca-4725156346bb@gmail.com>
 <4538309b-fcb3-73ee-04e3-6cefcedd376d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <4538309b-fcb3-73ee-04e3-6cefcedd376d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 10:35:54PM +0300, Dmitry Osipenko wrote:
> On 20.08.2018 22:27, Dmitry Osipenko wrote:
> > On 20.08.2018 22:12, Rob Herring wrote:
> >> On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
> >>> Splitting GART and Memory Controller wasn't a good decision that was =
made
> >>> back in the day. Given that the GART driver hasn't ever been used by
> >>> anything in the kernel, we decided that it will be better to correct =
the
> >>> mistakes of the past and merge two bindings into a single one. In a r=
esult
> >>
> >> As a result...
> >>
> >>> there is a DT ABI change for the Memory Controller that allows not to
> >>> break newer kernels using older DT by introducing a new required prop=
erty,
> >>> the memory clock. Adding the new clock property also puts the tegra20=
-mc
> >>> binding in line with the bindings of the later Tegra generations.
> >>
> >> I don't understand this part. It looks to me like you are breaking=20
> >> compatibility. The driver failing to probe with an old DT is okay?
> >=20
> > Yes, DT compatibility is broken. New driver won't probe/load with the o=
ld DT,
> > that's what we want.
> >=20
> >> OS's like OpenSUSE use new DTs with older kernel versions, so you shou=
ld=20
> >> consider how to not break them as well. I guess if all this is optiona=
l=20
> >> or has been unused, then there shouldn't be a problem.
> >=20
> > That's interesting.. Memory Controller isn't optional, I guess we could=
 change
> > compatible to "nvidia,tegra20-mc-gart".
>=20
> * I meant it's not optional in a sense that it's enabled in kernels confi=
g by
> default and driver is functional, but it's okay if MC driver will stop to=
 probe
> with older kernels as it is used only for reporting memory errors.

Yeah, we don't really regress at runtime. The errors reported by the
current driver are very rare, and even if you encounter them, they're
pretty cryptic, so I think this is one of the exceptional cases where
breaking the ABI "for the greater good" is acceptable.

Thierry

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluFKFsACgkQ3SOs138+
s6GS/A/9FhKnGuXL6ULi7ClHQ6T1WzcoA6pRh6hBKmB9PF5mRwBVTSXS8Gp8rcP5
V3UPHXcmSvNY9nhIaBUUehhYzlscsbnwcXeSsOmZ9j82WeVblDAZc5410/vXI5HE
8/lUptmH735FWQvDvadSNAknz482xvZ6FyAP7eXwYUK9Zx1x59EfP7BVfotVrk4O
hjeUYZuhyLc5vz3Cnu7Rs+dCjNIabr/cRGENZP7HNpZoRwePtjoplk3xtkZg5riL
PQpPgVUueHEo5Wk1IhpKXoroNfRKBTY0im65Qmf9k4/SdPp0ewEFaUsvD96k5sFV
5sIApSAr3KubixXCgNQke+kRFYM120pT4ybGAi7/VN414t9vJu5QKcDRj3qFGqaY
7NscjWhSk1kHFgpsgyqs72RZWklA8BbxU1WSQQbRHdPgdwVv0mHCWtzPG/sXD5sh
ImrJcREiVXmNwvQMPwquSiY5xNueH6avqPxdaHwYz4CECrzKihiasLXg8hfIE/2L
Xf+2MGJ95qv5ZpoFBR6JPYgiR+JLhi90UE2iRJZpFuwCjIPTY6l1yPHpobB5wJVP
2zXAiAU3teTmip6K4lx+pFs/YN48OaOGlAHeTGZCr9M2ZxqBZsw2DsKnq8WC5Nn9
d2SJ31Cj2vJGBSQtOnKAqPIvamEC67kLk8tG10pOSM1AIZV2WZ4=
=9ErX
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
