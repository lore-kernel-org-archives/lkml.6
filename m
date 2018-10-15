Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11542083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11542083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeJOTS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:18:26 -0400
Received: from sauhun.de ([88.99.104.3]:46290 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeJOTS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:18:26 -0400
Received: from localhost (p54B33719.dip0.t-ipconnect.de [84.179.55.25])
        by pokefinder.org (Postfix) with ESMTPSA id 336C32CF683;
        Mon, 15 Oct 2018 13:33:33 +0200 (CEST)
Date:   Mon, 15 Oct 2018 13:33:32 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mmc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: tmio: simplify the DMA mode test
Message-ID: <20181015113332.uqnd4kmoabzto5kr@ninjato>
References: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223636.GH3260@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7goolrfafe6rco6m"
Content-Disposition: inline
In-Reply-To: <20181014223636.GH3260@kunai>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7goolrfafe6rco6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 12:36:36AM +0200, Wolfram Sang wrote:
> On Sat, Oct 13, 2018 at 12:03:08AM +0900, Masahiro Yamada wrote:
> > host->chan_{rx,tx} represents the DMA capability of the platform.
> > Even if DMA is supported, there are cases where we want to use PIO,
> > for example, data length is short enough as commit 5f52c3552946
> > ("mmc: tmio: use PIO for short transfers") mentioned.
> >=20
> > Regarding the hardware control flow, we are interested in whether DMA
> > is currently enabled or not, instead of whether the platform has the
> > DMA capability.
> >=20
> > Hence, the several conditionals in tmio_mmc_core.c end up with
> > checking host->chan_{rx,tx} and !host->force_pio. This is not nice.
> >=20
> > Let's flip the flag host->force_pio into host->dma_on.
> >=20
> > host->dma_on represents whether the DMA is currently enabled or not.
> > This flag is set false in the beginning of each command, then should
> > be set true by tmio_mmc_start_dma() when the DMA is turned on.
> >=20
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>=20
> I like it. Much easier to read!
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested on R-Car H3 ES1.0 and ES2.0, M3N, and H2. No regressions,
especially no performance regressions (since "when to enable DMA" code
was refactored).

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--7goolrfafe6rco6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvEewwACgkQFA3kzBSg
KbZMBRAApYq21ZuXhgZCqB8ZFEjOPPo3rbUqZiTDFtUIaIbfywVpqLMtbeIjGn2K
7Sx6fuvtIs+usb292zwZfV4RBQHJek35T60MAs2z/t6Ye4WjKQlTinWEMwqQfoJW
mbFZc6jlXlA7vTc4ji72l8htng7weUuqAruwuPtoE57dHLNIKyUxyKd2zAmwN7yg
DFfrGmiDHh7B9s/bewdmMFbQ3lLz/LNOHyrhOtYH0l7gLPPN79BhF2NnOa7aqf/d
ATR81u/VQAGnuITtY6PQhxhNO/EKaFXv1awO244yczvs72M441t4hWG66gMgDB6g
d7aVEajAuARFvgYpJ0t2BxI1mMtAOFCjS/zN26lyl3tk4UHSC/vX4s/6WL99Dra8
3Hyi1mfLWL6ypusEpXeEQPAEAqH8W5nfYpTU3WzxsZaLElS3qOMfvYBk/hAnI2c6
OZJcOcN7NL/4NN38tOty2jWCLB5RSBwdbmmR33L1GhmQ+0T2nTtrO6nmVah1RkXi
juQn9Zdox/vJr5vIG1O0nex87v3r2MKDdfGrGFkbvD3hiqGXPhX2906pQrkiSCux
S0H0QIo7tj0cxkxDzP14s8Rkus3mLFhkHrdWSYANFKWh2fla+jIJUhP67Ydgs575
gelVZHlD8xxC/d3ncv7LiFKeWQQLMfFUeqUEIsDCPCXKUrbC46g=
=J9y+
-----END PGP SIGNATURE-----

--7goolrfafe6rco6m--
