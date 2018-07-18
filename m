Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD7FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498B20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C498B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGRROR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:14:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32844 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbeGRROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:14:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 64A6B263AB9
Date:   Wed, 18 Jul 2018 18:35:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: [DISCUSSION] spi multi chipselect support
Message-ID: <20180718163530.zsa5md3huz3dnotb@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzbhycylfnbjkxy4"
Content-Disposition: inline
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzbhycylfnbjkxy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

Some SPI slave devices have more than one chip select [0]. Rob suggested
to use the following DT notation for this [1]:

spi-controller {
    slave@0 {
        reg = <0>, <1>;
    };
};

I think this makes sense from a DT point of view, but this needs
quite some changes in the SPI core. I tried to find out, how to
implement the suggestion in the last few days and I see two
possibilities:

1. Register two SPI Linux devices from one DT node. This needs the
   fewest changes in SPI core. But we loose the one-to-one mapping
   of DT nodes to devices. I have a feeling, that this will backfire.

2. Add support for multiple chip-select to spi_device and modify
   the transfer functions to make use of this. Unfortunately this
   would require changing all spi controller as far as I can see?

Can you please advise me how to proceed?

Thanks,

-- Sebastian

[0] For example microcontrollers with ISP (in-system programming)
    interface, like the NXP Kinetis K20 series or the MRF89XA,
    which has one chip-select for configuration register access
    and one for FIFO access
[1] https://patchwork.kernel.org/patch/10310109/

--wzbhycylfnbjkxy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltPbE8ACgkQ2O7X88g7
+pq66hAAjxSDnlGBPukpVrvdCJ2cKIgQmiZG3Dn+1jfT71uWsk2hiA6Zolsjyhs+
0KlOT3O4cXQrQvhktLGdCeJZeZpMA/jscZ5PwXefCRN3VngYiWEdlnsMUx8iLYGV
K4MF8dexwae6aXYP6VxCy//XHEyzNrGaz8OJSdOFe8L6e5h6u9xjDPQh9J6VnAzW
gOhW23eGT89ofjl/Wb4SmOn+T+g9BOeBDOtAi4ht2B3gSgXVdlYjHC/B/ufolj0A
f7sfIQ69Bf7ngf71424An6KRsGM+vcvUQwykHgZ2jMRBu5tB+OzyOd5qQNTXUXIu
ym4sS/+as7+W36gZqTfksgVDKyq12OpiG6B2r/v3m+XvO+q8+aF7FXA5ueSFATaS
fHUSkOKZu0ny36fq6MpENisUI1ytDskcx+sTe83tgBL1eu0wzbaF4eCHfMcHIloa
1v5TYuz12NwHhQbX1rnCVWC9l1vkFFL+LVHi8UPuG16sUvpNaGI6V5X1wYAtyQoa
QJR3wyJOVum+xnoonKAmB+x7CHNF1SqJlV4VAaGAym+L+CuHmrgoGTdZuDMtW64k
aQ+4G1u90HZrw+WKzVeQWmdgn1pozNzTn7qMhgs0JQsbDJvCxRzsALiotfh+EzE1
MeM5vCS+UiUvX+Xrp6BbrTtnzXR44ggqlPJpF6yIxZ9zVs/NJGk=
=tC6i
-----END PGP SIGNATURE-----

--wzbhycylfnbjkxy4--
