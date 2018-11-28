Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7B820660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7B820660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeK1WmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:42:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:23077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbeK1WmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:42:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="asc'?scan'208";a="104410564"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.97])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2018 03:40:38 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, Pawel Laszczak <pawell@cadence.com>,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [RFC PATCH v2 07/15] usb:cdns3: Adds Device mode support - initialization.
In-Reply-To: <5BFE7D2E.7030702@ti.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com> <1542535751-16079-8-git-send-email-pawell@cadence.com> <5BFE7D2E.7030702@ti.com>
Date:   Wed, 28 Nov 2018 13:40:34 +0200
Message-ID: <87pnupzaz1.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
>> +static void cdns3_gadget_config(struct cdns3_device *priv_dev)
>> +{
>> +	struct cdns3_usb_regs __iomem *regs =3D priv_dev->regs;
>> +
>> +	cdns3_ep0_config(priv_dev);
>> +
>> +	/* enable interrupts for endpoint 0 (in and out) */
>> +	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
>> +
>> +	/* enable generic interrupt*/
>> +	writel(USB_IEN_INIT, &regs->usb_ien);
>> +	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
>> +	writel(USB_CONF_DMULT, &regs->usb_conf);
>> +	writel(USB_CONF_DEVEN, &regs->usb_conf);
>
> If you are enabling interrupts in this patch you should handle them in th=
e ISR.

Frankly, I don't understand why this is a series. It's a single driver
and splitting it into a series just makes it more difficult to review,
actually.

Sure, a single patch will be large, but there's no way to have a
functional driver until all patches are applied, anyway.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlv+frIACgkQzL64meEa
mQaSCA//ba2iHqRFxanq2zE1pQTnNGzW1MK/CdzlJ5L8YYB2g8B0CZZk/Zztvee/
0c5T/rlv60qUUVcAfXXZWjQoZZg6TUgXce6kR8C4MGnL3EHwh77TvRRYO54X90YR
Oytf4QhyAp/5fsL4DGRXVGPiK5OossxZYxIkWpXIiVyORcV7FaZuykjePTNY/vGg
Bv1AKPw+F0M+C3CSBphdxxTPqy10Su97GPCdZZql1P5j8jOVsUO6CjcNUIK2WSqn
k2r4JVnBWNO1D7v1/tGXybWxIHvUBCuSs6enFMoPdxCPTIRGtkN5ijLBkuAxiMvk
LWrV+D7vHLNCdngQmex/A/YezubvjUs0WfMDh8bTy/UjxeLZYIdWcD3JNFQ0IisV
i9g9PMfR2Gy5C3XJq3vAYZz9kQgpnzkmuHdMNfpuY56FzzkHdJXEvTVr37EGOEHx
VTbe1FkOD+dD5RoXtxK4ImaOYDoSicKQ5SqyjtCk1RypjI7FDXGucOouD6Jca2Z5
Y6fX+75juJQIhsj51s7g3fSTsnqA9IMbPOpJki+xpvGotiVCzYTdQX3Uc6Ti//g2
YjkRKmjvp6uYtqEWYimWIGHXrTJGoqvrFOh17ubF/6T4Ufv7fMBhXSTUjocBo0j2
nObCbcPqwsCs0/PWAgHd1X2kVcFUyPJR+BjmPtFwoFqeDy8W0tw=
=lrhC
-----END PGP SIGNATURE-----
--=-=-=--
