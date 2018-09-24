Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA533C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793D12098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793D12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeIYDtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:49:41 -0400
Received: from sauhun.de ([88.99.104.3]:38638 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeIYDtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:49:41 -0400
Received: from localhost (i577B9B6D.versanet.de [87.123.155.109])
        by pokefinder.org (Postfix) with ESMTPSA id 3897C2C0599;
        Mon, 24 Sep 2018 23:45:24 +0200 (CEST)
Date:   Mon, 24 Sep 2018 23:45:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Message-ID: <20180924214523.GA18592@kunai>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 13, 2018 at 08:30:10PM -0700, Guenter Roeck wrote:
> Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") moved interrupt acknowledgment to the end of the interrupt
> handler. In part this was done because the AST2500 datasheet says:
>=20
>  I2CD10 Interrupt Status Register
>    bit 2 Receive Done Interrupt status
>          S/W needs to clear this status bit to allow next data receiving.
>=20
> Acknowledging Receive Done before receive data was handled resulted in
> receive errors on high speed I2C busses.
>=20
> However, interrupt acknowledgment was not only moved to the end of the
> interrupt handler for Receive Done Interrupt status, but for all interrupt
> status bits. This could result in race conditions if a second interrupt w=
as
> received during interrupt handling and not handled but still acknowledged
> at the end of the interrupt handler.
>=20
> Acknowledge only "Receive Done Interrupt status" late in the interrupt
> handler to solve the problem.
>=20
> Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq event=
s properly")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-next, thanks!


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupWu8ACgkQFA3kzBSg
KbZRaRAApSJxYi1ZDY/OJdAFFgXK2twFN3Ct3WPrD9FOf86oHX3eyX+YAtiWN2G2
qAVNs6JNX3rVlUKiN5UJVxR7b9LxsXeB0djnPp0wrfoscHsVC7nNsf0/4jW8T6rD
56M/lNPk7f0oWFn3gB8rWnfxJ5LQ7j9bS/VPIGrEEhZNzpS/ewyCWuQXvZX5NGLv
suwyL431enqXKyVYZAwm+Wg6G8xlO2wzLTsPSttpWNDBxriyWSf/L9BkrbHQbezT
idtCXG7PR2JDerWDVvTHrUXqJdLowHBe18umR3kNUnHoe5T7/OCg/AIRtUgEn9C9
H9L40P3IQJVcSDfBOGixkt29RPuFdwHchaCapJkdanIwmE/+JdYZR0CekKBIJheO
jikCLMnH2ryaOH38PCjiEK6CIdZ886ZSA8rDXTWrEX3AfUbKI6CpwdPByqpbwwTY
kAI3z5ufTBI+PGwpGgrIs5AKGN/kkQtAUFsw5r0OcNM1E6CpO234dGizpgoYpDQi
lloJ8ZAC2qir3+uj3p6PlK7r5n8UQt4rA6vI1OsfFSHDKTQilOdCm4zoYY5RnSOO
A2VAkE3nmIiWJ/rBmGZsx4BWDlpsdWSklSzkyOKwA6hVBypP0fLiF2mPzPKOAioK
AUXMsCPXeA6/9ahVOcMNcFmsCYMZpKsp07mvAmyMRHNukrxqBD4=
=TQ2O
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
