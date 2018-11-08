Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD70ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF72086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="n/89vOsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EF72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeKHPen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:34:43 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:46496 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LR4y7gZbT/FkNTTZFnq5lJ8lIM/Ksa5/e2rFob+Aypc=; b=n/89vOsjyE2cSJnvH1jqVCduB
        PfHBMPpFupthNXnFVqKXP7uojq3uNsR660zzMfd63Q5AjgP2G3MxNU3sM+lgnh3lgVuaa8J7DRkdz
        kuQ1wFtfqh31aV3ts7sEYoC/ZCaEVVrTRuxsu9X0bPQTS742hXYsobGt2dcJE1n2c5t1c=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gKdMx-0001RE-Jq; Thu, 08 Nov 2018 07:00:43 +0100
Received: from localhost ([127.0.0.1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gKdMt-0002Ll-0W; Thu, 08 Nov 2018 07:00:39 +0100
Date:   Thu, 8 Nov 2018 07:00:30 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH 0/2] mach-omap2: handle autoidle denial
Message-ID: <20181108070030.5febd96b@kemnade.info>
In-Reply-To: <20181004203817.22101-1-andreas@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9j=CCNKyjqUyJ.4CB2by9aA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9j=CCNKyjqUyJ.4CB2by9aA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

ping.

..after stumbling again about that problem during testing with 4.20-rc1.
will retest it there.

On Thu,  4 Oct 2018 22:38:15 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly describ=
ed
> in the flags but the code to handle that is incomplete.
>=20
> To handle multiple users of a single ick, autoidle is disabled
> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
>=20
> Changes since the RFC version:
> - mutex lock for autoidle changes
> - deny_idle/allow_idle calls moved to clock enable/disable of the
>   individual modules
>=20
> Andreas Kemnade (2):
>   clk: ti: add a usecount for autoidle
>   arm: omap_hwmod disable ick autoidling when a hwmod requires that
>=20
>  arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
>  drivers/clk/ti/autoidle.c        | 32 ++++++++++++++++++++++++--------
>  include/linux/clk/ti.h           |  1 +
>  3 files changed, 37 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.11.0
>=20
>=20

--Sig_/9j=CCNKyjqUyJ.4CB2by9aA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlvj0P4ACgkQfb1qx03i
kySkfA/+PrdYKmkw6xOcY332Q+GNnH+A+p5AD2Sj9R21fJFwPZ8DbRoOWbgV8PPZ
VdbOGrOeL6cFW18HdyU/N6kd4ZUl3VNylWiT8JYf4ScHqbznjFZvrgUDAOCKBJur
eSvthilX2XGYNldaWod6BG+cdy62hgO1Zf4r8Q16Y6mgcBIyS4z5hRKgFWcI/QBX
3s3yOQn5aNGtAnwB2RF5d4U+dH31KZ199WdOB3S5Z4lucVSm5Gk4EtHQ5NoxXgSN
R97YSebOhgKBi8OyzF3q9NpRsZxBsDCroVfTyYMY2qoTJ6q93LGYt137X0JODQTv
lEC/n7P+G0nZBfOyWGXGduEEz4GLHScMQEnDG0z4RyKZFbknqjE1fbp2GV+WC/BT
6dwQQFniE/Dhpb0K5XUkpZQMSGH0cFWUZr5TMuMLM7jt/YtBZqzmNBJ4QhFQSPXp
81pRffp628MclWGWQSyfdVpRGioVvq6lGytjynotXFO5e3kyCAI0Jzs/rOmNRRnO
k98qwNpqQRJjh2Fm6hSz7TSsWbh4Zu6sR7wH3yoyZuzi9H2HZClEZb3EHX4a3Y3u
iG9DbUArU/g/xH5bs6HbL/DzEYdTGjQQDOVjfh7abY5TjK0RBMGihbK1OKHoxfWB
hqWYkDAa85q2skB/RgUjx1wTW22/YLCMByd31hJ4UNrYbmimf40=
=qljx
-----END PGP SIGNATURE-----

--Sig_/9j=CCNKyjqUyJ.4CB2by9aA--
