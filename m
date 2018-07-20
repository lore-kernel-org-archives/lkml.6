Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8A82064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MWZ78wJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8A82064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbeGTNGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:06:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeGTNGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+bMIVmmSkdUMMRfhGlsAIyjzk3s+tFnAmpoXjLL0vlU=; b=MWZ78wJWjIf8Wd2NFh38pUwz0
        q2PaYr5z9fAGYLnqp3uolxSq5BbVwiXWgMPQUa8FLiQTbTX+aabUzReJI4K6mr+T8MAz97j0RT1+1
        kYXZfnxxu3Xc0KhFTdfKD27kX0Ch0aKVJT3/Hi0IXNADsvzBLsiJicyN5la0gIb32T9JY=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUMS-0008LS-I6; Fri, 20 Jul 2018 12:18:16 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgUMS-00065b-3F; Fri, 20 Jul 2018 13:18:16 +0100
Date:   Fri, 20 Jul 2018 13:18:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dylan Reid <dgreid@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and
 ADAU7002
Message-ID: <20180720121816.GD10784@sirena.org.uk>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 02:38:11PM +0800, Akshu Agrawal wrote:

>  static int cz_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct snd_soc_card *card;
>  	struct acp_platform_info *machine;
> +	static bool regulators_registered;
> +
> +	if (!regulators_registered) {
> +		ret = platform_device_register(&acp_da7219_regulator);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register regulator: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		regulators_registered = true;
> +	}

You should be unregistering the regulator in your remove function, not
doing this hack here.  I'd also expect to see the card made the parent
of the device that gets registered.

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR0wcACgkQJNaLcl1U
h9AbcAf9Fo9ThI5pEiQ3xKKD0YZk9HfxvxQMV9aGNR2pdVyXzGb4qsIc3Iudax1B
h4VIUfmGjPmA62O2Pw5PjSJ+yqb+gn6Rxy6KcXPgZ1b5hBavB0CHAqyD4SGKSZSf
Yn1i1HqYYWZ+ag0fYM3CIEKyQAV2vWRbOgWQadWsKj8qBUoVSFE7IvsKVDZtalxv
9hkCekoKBZcaeuby9ovPkIM5x7gMQfORmarUpbv5xzHai+yeNPl5BlGYVV1GyYoi
69F4PMy5PkV60tH4ALBAAYJMOSWdbLIWkoMivl+4yxCiuNEXBPsEifaXm/ZHqymU
nw9f8D0WNWeFz60XTZCCrTjcqxMkww==
=AQ8P
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
