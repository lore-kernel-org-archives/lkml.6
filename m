Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47BA2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfBWJsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:48:45 -0500
Received: from sauhun.de ([88.99.104.3]:53758 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfBWJsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:48:45 -0500
Received: from localhost (p57BC9845.dip0.t-ipconnect.de [87.188.152.69])
        by pokefinder.org (Postfix) with ESMTPSA id 7AE942C3312;
        Sat, 23 Feb 2019 10:48:43 +0100 (CET)
Date:   Sat, 23 Feb 2019 10:48:43 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Shikai Wang <sxauwsk@163.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Message-ID: <20190223094842.GF1018@kunai>
References: <20190219012447.5900-1-sxauwsk@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20190219012447.5900-1-sxauwsk@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 09:24:47AM +0800, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.

Just checking because resetting looks like a big hammer to me: there is
no way to gracefully recover form 'arbitration lost' interrupt?


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxxFvoACgkQFA3kzBSg
KbZIOw//X4tPGtaKdCAKY08zneHiiw2dqMHmf69zg2wD7wYcSKApFyY0SdxqehEm
Zv68Ud90qMfJ+Aecvv1t5zRgwWQPNJSB6f45ujlRAdn45VKtHlMAeiyk6VYelNwX
Bx2GXX7ZedpfkmdMGEjiPRsKuHX84kug+xlAHeT5mjGJCjDIrGkZdOSuP3DTDCCM
wzLQ1U8yo9DyfNr8DerZ+co07r5Bi7JXwZdHJ1CoI59DS0gf1MnyLj1+dhv3eVU2
TVz13o0m6QO3kT1eGrDaVl4SskXBAL848Lc6r0DnkxynQs/EiosI+QwbziLZkPr2
FZBFk93NoHVJAlSYSFgpbzvWSxiHUy9pknoPTIgz0f0c1/3XmMjH2ziFALy7Uar7
T++7N8amNhDdt8GbsyEmAzIyLuZcaulLk2vS30cjTJG+Ve9crSpSDJRiMyJ/436U
WU70k9WuIVG7gwiO3PgXrxon/bu4O3bhQAIJT+Tj2lC6iOj183GJW/sxwj1Pbtb0
/iPQA38/G94zqD9lIyhfdTmsXIOJaGgaCXGlqK2TiK3idxqOuvoxVMRJFhoUb0xJ
hKHB8QVoMX0K6SCMh9Lsif6ubum0wrkP4+LFoDq1PDSDU5zlpv0fxUjrJW8p9qhm
Gp7eN5oepPgSVV51IHbbAxu8h5X8wkt2Pho8WjvZY5xwlvmty0k=
=arbP
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
