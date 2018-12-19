Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D7FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF18217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545244834;
	bh=2mo2BQGIfBqO0Nq+3x8dSCeKHAv6NdOKCAnayJnodpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GjXdc8g5bfv/QpFbofOn/s5CoB8/jT+fUhvv0p+gSyxf0saF816MwAnjirwyK/udf
	 WsPW5IsaoB3xnSVMDmEJwgfNvkpmTVp+4UArfcrnOelEUtiul1IiBLSakwdbl1Yrx2
	 hKVKfqjZI6veRCn2RpskAhpbaga0nG0QVDGY8thg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeLSSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:40:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44028 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeLSSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2mo2BQGIfBqO0Nq+3x8dSCeKHAv6NdOKCAnayJnodpI=; b=tes1xi2NJtMSglXmqdulPQOH9
        EzBWOarvYN6pp6RHIKvX/72GG5Yeus7QV1ToOFfhRfGaw5JYv67U2SiFv2CiB3w93pQP+OCJX6ncd
        HQS5HsPy6j5+qtKxbgG1qeed0dTRDw4sgFLTR+X0d/pwBTQ1x7FoQBjsuzcQkmB8Pdf+w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZglc-0005Ls-8W; Wed, 19 Dec 2018 18:40:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E1B3511259E9; Wed, 19 Dec 2018 18:40:23 +0000 (GMT)
Date:   Wed, 19 Dec 2018 18:40:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andrei.Stefanescu@microchip.com
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com,
        Nicolas.Ferre@microchip.com
Subject: Re: [PATCH] regulator: mcp16502: code cleanup
Message-ID: <20181219184023.GM8130@sirena.org.uk>
References: <1545047086-30286-1-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ARLBH93C7pgvpZY"
Content-Disposition: inline
In-Reply-To: <1545047086-30286-1-git-send-email-andrei.stefanescu@microchip.com>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ARLBH93C7pgvpZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:44:59AM +0000, Andrei.Stefanescu@microchip.com w=
rote:
> This patch does the following:
> - align parameter with parenthesis
> - fix compile error
>=20
> If CONFIG_SUSPEND is not set the dummy pm_ops
> callbacks are named mcp16502_suspend and mcp16502_resume
> instead of mcp16502_suspend_noirq and mcp16502_resume_noirq.

Thanks for fixing this.

>=20
> Excerpt from compile log (kbuild test robot):

There's no need to include the entire output from the kbuild robot in
your commit log, especially when it's much larger than either the change
or description of the change - it gets in the way of reading things as
it makes it harder to pick out relevant information.

--+ARLBH93C7pgvpZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwakJcACgkQJNaLcl1U
h9CoOAf/YDh3uJaraY3r8ssIap/lGImSllU4UNm87DsRN6fgOMo3+WFyngmQyY3u
VtSglDhnhpYbrf2XqqiCMjKnz4Ihuao1IdDYiL0LA1DBNFzzJY8Bljc1DDt+urm5
LgL5chbBQjasZqWVAdKrDT/s8FBrSTSfhWsh9eZihN5GOfvGLp3DdPQXIr7SVTmx
5ghqyonl4PM8d5ezcRfOZDyuWGImMPdDSVg/GjpReZ8Dn8604Woq6PX1KL9thFpT
jc5Q5EJnMP1o8Ix5+JCkmdij2iza0OBUl7yEDN2hdoTERI5lrocly3CA9rv3MCkN
EhyRiCNvC7oKbQ5GJjVyRkmGjHaz1Q==
=hBVs
-----END PGP SIGNATURE-----

--+ARLBH93C7pgvpZY--
