Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2117204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545222458;
	bh=rddtdKQGWdMmP6esclSqznMkJeK1W7SlwIXKveDfMms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jZ01rZiN6ZbQy7A9iaUCLJfyZmHtZbVxJ+TrUt+sMUKrfc5mwFH+pwnMMPH8pB/OI
	 jj2Tl12PmERcJGVfh6+I1U71MevSWcSlJq77JEom8kc8hmRvLlotMVhrr7VMClS5Ni
	 alGKO1qFuIsL4SMTdV1ZRJ6XykXt//CB0hhPC8To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeLSM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:27:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbeLSM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WN+L2V0YoqKqg9qKr6qzaQ2AU6ZVu1HHUpLq85JXLDg=; b=b1CF6fY6WWvMyIKVg+m4magRC
        RN1+LhjGV9kyDrVcjoNJvdBusijzh7t4fut9zKY1WxaZr0FX3X3O3JPIoaVR8XseCTeq+QXOHA4vm
        KPOFl/FwTnj7O7Jk96EmVh9g7PmpKvXktNX66G4n1usvTwYIK1cdrMWb0iRRf7Z++lLLU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZawd-00041r-Sl; Wed, 19 Dec 2018 12:27:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4416911259E8; Wed, 19 Dec 2018 12:27:23 +0000 (GMT)
Date:   Wed, 19 Dec 2018 12:27:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/regulator: fix a missing check of return value
Message-ID: <20181219122722.GB8130@sirena.org.uk>
References: <20181219050413.16374-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20181219050413.16374-1-kjlu@umn.edu>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 11:04:13PM -0600, Kangjie Lu wrote:
> If palmas_smps_read() fails, we should not use the read data in "reg"
> which may contain random value. The fix inserts a check for the return
> value of palmas_smps_read(): If it fails, we return the error code
> upstream and stop using "reg".

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwaOSkACgkQJNaLcl1U
h9Axywf/QQk28N5D/NaWEgPrbz0mPuRk1r3O85sG+B+5S6Cj3lTx5Youlcmsx65j
bOWFNIe5cSOyZL8jI4aF/9/CgR0KqsO+G3I2u3G0sdSR0opKxlSo9CIzVOOcObDv
7/wRFQoxQIpHb86LT49B3upGrqqSFAdKgI4tG1N/LAhwc0iS0ewNCZ6OWAnMIOxV
CivGGDoSTvu32kmMq4QPS2rVjj1vBDtVzX1OtCnpZTVrZT+gV/mHlY8MZmj6uUyb
qY98+Q32FCbqsBWy4i98qIdJpzz9kQz5qkPJewSkQ6emppDLBRCCdA6aFLrzZKeN
KS2FbeiuVSKHS/DqOQj67XoFJy/VXQ==
=oYcO
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
