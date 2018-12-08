Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3C20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544284803;
	bh=7u4sLAcIWoqgO7FbIzSNvTN1AnfiCF39+hfHMIcL2FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SZe/RS/mWoCjdgUjGIO3xLJswbSSCLsM65/droug+ASBnsCFJ9EA2VYB+wGNYyQHR
	 OoJeWUDok/RQxCywmNfyc1U/0b85WA5ZFBSvsmMW++roQ6PKKYYbxLapFrNHQSvgt0
	 9YCJfICU8aFJDdvL7xoNiyaMv7L/PzyWZ0R64NRM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLHQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:00:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeLHQAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:00:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D50F2082D;
        Sat,  8 Dec 2018 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544284800;
        bh=7u4sLAcIWoqgO7FbIzSNvTN1AnfiCF39+hfHMIcL2FQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKnZPsqCsYCCC41LjUO3AeE1Q/OLp2HAWLkUfhwMVvwHVVlKAimVDpSb6QYofofcz
         H1SF6QxcaAJQzRfgSSbNSHlBl94nU0vaBZC5DjuHac9hqhVKaqzneOmyfLLJ0gVJy7
         EoiUGw8hl7rDTnpmZrhlrLie3bju9+yWnmIL9PS4=
Date:   Sat, 8 Dec 2018 15:59:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, xc-racer2@live.ca,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        baolin.wang@linaro.org, smohanad@codeaurora.org,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, freeman.liu@spreadtrum.com,
        marcus.folkesson@gmail.com, geert@linux-m68k.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: exynos-adc: Add support for S5PV210
Message-ID: <20181208155953.6e31ba04@archlinux>
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Dec 2018 20:11:33 +0100
Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:

> This patchset adds support for S5PV210 adc variant to exynos-adc driver.

This looks fine to me, but I'd like to let it sit on the lists
for a few days to let people more familiar with the platform have
time to review.

Give me a poke if I seem to have forgotten it in a week or so.

Thanks,

Jonathan

>=20
> Jonathan Bakker (3):
>   iio: adc: exynos-adc: Add S5PV210 variant
>   iio: adc: Allow selection of Exynos ADC on S5PV210
>   dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant
>=20
>  .../bindings/iio/adc/samsung,exynos-adc.txt        |  4 +++-
>  drivers/iio/adc/Kconfig                            |  2 +-
>  drivers/iio/adc/exynos_adc.c                       | 14 ++++++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>=20

