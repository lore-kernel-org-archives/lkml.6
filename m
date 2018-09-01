Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426A6C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B8C2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B8C2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeIAREF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:04:05 -0400
Received: from sauhun.de ([88.99.104.3]:38734 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeIAREF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:04:05 -0400
Received: from localhost (mue-88-130-111-030.dsl.tropolys.de [88.130.111.30])
        by pokefinder.org (Postfix) with ESMTPSA id 13FA33648A8;
        Sat,  1 Sep 2018 14:52:06 +0200 (CEST)
Date:   Sat, 1 Sep 2018 14:52:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: uniphier-f: issue STOP only for last message or
 I2C_M_STOP
Message-ID: <20180901125205.GE1196@kunai>
References: <1535725848-4076-1-git-send-email-yamada.masahiro@socionext.com>
 <1535725848-4076-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <1535725848-4076-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 11:30:48PM +0900, Masahiro Yamada wrote:
> This driver currently emits a STOP if the next message is not
> I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
> ioctl, where read/write transactions are combined without STOP
> between.
>=20
> Issue STOP only when the message is the last one _or_ flagged with
> I2C_M_STOP.
>=20
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driv=
er")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-current, thanks!


--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKi3UACgkQFA3kzBSg
KbYFHg/8CsB36E2cCqLUOSHQmYrQY5trs9MIxRqTpqJJ0O/qdFdemsq3GvzRiYpU
Ky2SH7jNMLWM+cNJ3Kb9Bx73q1HCxZ1XSiEPFl6okiCMTj6hKgTAyi75pqKv2acz
CWKf8CWpM/2wHlLHwZol809Y7NK1kbU6aPCw7G49Nt9ERkgb8zu7iM8ravPUCHYf
uU7iCcCyJbskmUuVZ2oGYTZ9n7BYFAQnKfEpBzhd8ewyEB/e1e8lTF+igdLTCKnr
wh/KhtfGcU9juoOmF1xpd+GWwDA8ul4gIHl9jnz5XvThB6oAhCjZuweY5Lnf3DiI
HIy2uznB2HgBVcEbSRZ4HT6hy+E0G8i9tiB2KEhg9JR9r6BI2dvxA/aEkwKxHtDW
MKl5nxBKghsSsfdOT354BFHFHEoZ5KACQDRf3E0lX/22YPKxZNNWxr3NP4yoY4/E
fcSx05KtFzmtsVsl4pjH58Vayiwvu6N3/X468TfCr6WdxxmDf+nbvUj64kkOwkHB
LuEMrpNOoYrWyJuw7VTDtSErtWkUepMrXnwt8sj6RCh8xZwUP6N8V7JoJxwwj21Q
g9NvGxx1QX2naVxe3dndDyb56UMnCmylY+avcuB/1a2zbv7cL+8O88Yybo4Wnnie
sXT/p5BTQVgAjSh6BXLVdY9q0y3bNK319BzMe6f+Lo+jbEiXliw=
=z8f7
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
