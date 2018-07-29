Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD0EFA3754
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A3120893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A3120893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeG2MCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 08:02:10 -0400
Received: from sauhun.de ([88.99.104.3]:37388 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbeG2MCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 08:02:10 -0400
Received: from localhost (p54B331DF.dip0.t-ipconnect.de [84.179.49.223])
        by pokefinder.org (Postfix) with ESMTPSA id 1F954658E25;
        Sun, 29 Jul 2018 12:32:09 +0200 (CEST)
Date:   Sun, 29 Jul 2018 12:32:08 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH v7 1/4] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
Message-ID: <20180729103208.uyxp2feonvznmzsp@ninjato>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
 <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ns6ol5ohpitnty2i"
Content-Disposition: inline
In-Reply-To: <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ns6ol5ohpitnty2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 11:09:05AM -0600, Karthikeyan Ramasubramanian wrote:
> This bus driver supports the GENI based i2c hardware controller in the
> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> module supporting a wide range of serial interfaces including I2C. The
> driver supports FIFO mode and DMA mode of transfer and switches modes
> dynamically depending on the size of the transfer.
>=20
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Looks good except one minor thing:

> +	pm_runtime_set_suspended(gi2c->se.dev);
> +	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(gi2c->se.dev);
> +	pm_runtime_enable(gi2c->se.dev);
> +	i2c_add_adapter(&gi2c->adap);
> +
> +	return 0;

i2c_add_adapter can fail. So, I'd guess you want to check the return
value and move it above the pm_runtime calls?


--ns6ol5ohpitnty2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltdl6QACgkQFA3kzBSg
KbbpRQ/7BY/oo/gRQ8eUBnz5fBJ3bMzwg6CwHH3zsZwEWyT7/MqP6O0ToSIMXiSL
CsR9snfwAqHev+eJiLVgsFZ3OvLSK+Kizm+HpgAM21A7wy9/hXawPy7s34PkIqDA
Ive1qOF0Dj+k/mtEwBFp3Pmw2kKVkCPg7KwBbtCnk8bvFKzCFbFvI7eBim+Ox75c
7riFRuDKzQJpX5m10l8p2ysC7xlnncIY/5gL1lfdjSIv0qU4vQrP8BRBtXKNy89U
kyWqWVIZVW/O4jsXd3ww4YqDGe/3rjIykXv8xU0BBj6640rQW7D9ZOzowa2W7jbU
UT9GMhrag1O9w7j9EiMjZ1+u1/yRw2vfzneJxf8s0eslz/5rJ+HV9qJdkn4JvSQ4
8eAfJ4+SUB/9S7ApDIkkhOauFO3n3nnO6wOqxtaUSjNBTpDfwSOidCc61cHhzx1k
AwUyYTz/Ap6ASlBx9q411qubYiJRfXOs2fntBhw4pGxpMdLMfq9OAThISoYlygf+
mlMdg7KPssbuX7O3JOKiOiuk3uAPdsfQkb/x8pXkji+oUNj9iKpi/vLDMO1ahnex
Stv69cq4TtP+JdJIdRaquVP3S3W8urjqKxnfX1apVQkrcQEv7DdiL1BY66BX0VPI
4IMZbKOgy4MYCgFfA+tCSSkvwHpbjLKMtiaAEtUqq6m1z0Fo/qk=
=H+It
-----END PGP SIGNATURE-----

--ns6ol5ohpitnty2i--
