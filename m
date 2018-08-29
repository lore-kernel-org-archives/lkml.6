Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DBEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6012086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6012086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeH2MpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:45:06 -0400
Received: from sauhun.de ([88.99.104.3]:45242 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2MpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:45:06 -0400
Received: from localhost (p54B3352D.dip0.t-ipconnect.de [84.179.53.45])
        by pokefinder.org (Postfix) with ESMTPSA id 2547E343FE7;
        Wed, 29 Aug 2018 10:49:14 +0200 (CEST)
Date:   Wed, 29 Aug 2018 10:49:13 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] mmc: tmio: refactor CLK_CTL bit calculation
Message-ID: <20180829084913.fgdrigpeu3vi7vqs@ninjato>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pznduqydquaabgg3"
Content-Disposition: inline
In-Reply-To: <1534999460-15111-7-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pznduqydquaabgg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (divisor <= 1) {
> +		clk_sel = 1;
> +		clk = 0;
> +	} else {
> +		clk_sel = 0;
> +		/* bit7 set: 1/512, ... bit0 set:1/4, all bits clear: 1/2 */
> +		clk = roundup_pow_of_two(divisor) >> 2;
> +	}

What about

	clk_sel = (divisor <= 1);
	clk = clk_sel ? 0 : (roundup_pow_of_two(divisor) >> 2)

More concise, but I think still readable. I don't mind super much,
though.


--pznduqydquaabgg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluGXgkACgkQFA3kzBSg
Kbawzw//cevnWqN2we7+wnmAITrE0rMxOUPFT0P8nDc/r98bsBxxSw7WHr8Sm527
7gzrdc7oM78IozpZIX3pd0YfdrKWbN2vEW698a5qSczi3DIhhBWPgfQNQJ0DrX6N
INY828lP6/eTm5N53QSEn7Xic4Y1DzSPWL+DPbH3S/HZCNcrOB4dSb89mpqurW+P
EdzL35ro3V19VHGJ1cp6JBCevR9J62cCRox2x0EwsRdgVFfL8tnnHVPzRNoFyI8x
sNqcW1o15xLoKwhJQjZjX3U8ofNrDYTjOCGjuk3N7Qe0DHJh3caVSOkX6PYbw3Ob
m7EL+gU6gJAWbMrv+TilDiJDm3nEpoIU+Lr1gD3VRZBmTwD/UMqoTif0Rm+5g7La
lk6HPFgstRkvLdKmcUzCpbipmrgnGc0RTuwtGdpTperOH3eq4u/MH2p83M4qAezL
o/q/jJNSpzH1XSnfWzS2tkh9bgbTYbI5YwYohIzbWuPfW+7m1BhPsgaUvyWjD5sE
A0p3Pxadvw6WOKHxkmfISzU09RyFt8m8DzbM4mDcFp3/Cjb/bWuyotYPvuZOjLJS
S9cr4WahvILZ5J2OIGdg8+FIuwRMO0D7y8SKmtOkAqH9cOsMvGPZfdAMxDFvwBJo
ysNzt9eZroXfkNY84z1sdJ5v3OleH1BBVzbs5APP+PfA/XjYl6Y=
=r6vt
-----END PGP SIGNATURE-----

--pznduqydquaabgg3--
