Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD25C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD25C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLKUEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:04:39 -0500
Received: from sauhun.de ([88.99.104.3]:45336 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLKUEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:04:38 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 9B7524C0E8F;
        Tue, 11 Dec 2018 21:04:36 +0100 (CET)
Date:   Tue, 11 Dec 2018 21:04:36 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 3/3] i2c-axxia: support sequence command mode
Message-ID: <20181211200435.abk3jdsmltz7c26w@ninjato>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
 <8515ba7093f5be3ad7bd31d68efedcbe17958282.1544453688.git.krzysztof.adamski@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3m5n2s5rtnxudgq"
Content-Disposition: inline
In-Reply-To: <8515ba7093f5be3ad7bd31d68efedcbe17958282.1544453688.git.krzysztof.adamski@nokia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3m5n2s5rtnxudgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> +static void axxia_i2c_handle_seq_nak(struct axxia_i2c_dev *idev)
> +{
> +	while (readl(idev->base + MST_COMMAND) & CMD_BUSY)
> +		udelay(100);
> +}

My code checkers rightfully complain about this:

  CHECKPATCH
CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt

  SMATCH
drivers/i2c/busses/i2c-axxia.c:382 axxia_i2c_handle_seq_nak() warn: this loop depends on readl() succeeding

(and I get those as well, but not related to your patch; still while I am here)

  GCC
drivers/i2c/busses/i2c-axxia.c:98: warning: cannot understand function prototype: 'struct axxia_i2c_dev '
drivers/i2c/busses/i2c-axxia.c:130: warning: Function parameter or member 'ns' not described in 'ns_to_clk'
drivers/i2c/busses/i2c-axxia.c:130: warning: Function parameter or member 'clk_mhz' not described in 'ns_to_clk'
drivers/i2c/busses/i2c-axxia.c:229: warning: Function parameter or member 'idev' not described in 'axxia_i2c_empty_rx_fifo'
drivers/i2c/busses/i2c-axxia.c:261: warning: Function parameter or member 'idev' not described in 'axxia_i2c_fill_tx_fifo'

Also, for $subject, please change the prefix to "i2c: axxia:"

Thanks,

   Wolfram


--c3m5n2s5rtnxudgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGFMACgkQFA3kzBSg
KbZjBQ/+JKkZOieWNTHYtxct2MfgBqvV/GjQ2LNchV0lAsarOYL5+70J8ZRiX3e9
PB/cb5mkjw8muL0fl41fOonxiel/mxy8X9JdVrnPJj7xSbsbbn9s91dBmaKXr8Tp
hGDfBdtTQm2EPwWWIeKsCbd6aRwXsCDdUiQLFSiw21F0QuGBJxywKT4V0rNkfBDK
whew5E94SpVKO74DZZhUO3qT3zGbJIdwfgl3jU9aPAJbpD4GxLWDMenEVkI7bnIO
SOMsmF6S6sp+O1ZSRARaO6qm28RYoi4I96hU/aoJxmT73LiUagbPuPFd9P9aV/vs
ucxXDjQhscVbvqeY+EMLU05mwLicfhwT38j0au8Xa0zDLYCKyzUNa2F7gu82yMpS
lL+LyUYsKWWLUp36pkriH3Hk24jjwXaxqv9JlTuuMf0/QuVRhoIexA9h/eUh/keB
7Xr2wHvGvLgY9VfIlXpC8PyJvnvBT6wxc/R0p8h1IRuOp234DagQhenDySV0htnx
s+9Dl+HusBfufX7ACPa/l+PwIOGCBJ7oEHASq+E5NXJ4zdtSi4d1xZToldT2JBdj
Sm0n6R2p+Gc0vegX9fmin0lqIynb9girYSl3LYbVY0ZE6eXg+8bWun4rJ3447OE7
QOFSN06zcuedwhaqcg6u2v1kBTRYJZ3qRYjMIbiSu9EwjHK9Jic=
=Oulp
-----END PGP SIGNATURE-----

--c3m5n2s5rtnxudgq--
