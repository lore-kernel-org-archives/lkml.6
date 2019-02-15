Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE988C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6DD21920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550231904;
	bh=Ih7uVANR1oY6oTm5m0jELauFYkw9qJfHB5KAs2FsFh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AW+xrWw6JdQIdjkwHSEkGH5eOd4IoeoPSgRKBR4GTm22ENB1vIvmbVqCGo5Wbpw3I
	 w/sMRXepXJSQHIjX9bZ7DEOTzJZKXXP0eLz0PtqckYCCjV9eUFaC7rilGEfYxhRAOp
	 caa+cAMKECS3huZ8LQ8T/AHafFVvk15booMwXfMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394616AbfBOL6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:58:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35038 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbfBOL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ih7uVANR1oY6oTm5m0jELauFYkw9qJfHB5KAs2FsFh4=; b=DUtnXEQwagouPJQSykuX197sW
        aOqrMjLzpMELvbnW9hV4nal8UYaI8CzB4X1eAjoxL0DiQusFpvO3GMFxm+7mt6pSRoWZH8GivjFso
        DszOYC1bQD2oQ2XTRcXvCR0DxsbkePivTR348TdT0Gz0zmpnZN7LUJFu5zR7oUvHE6BA8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guc8J-0006F9-B3; Fri, 15 Feb 2019 11:58:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E2A9A1127748; Fri, 15 Feb 2019 11:58:18 +0000 (GMT)
Date:   Fri, 15 Feb 2019 11:58:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [PATCH AUTOSEL 4.20 16/77] ASoC: soc-core: fix init platform
 memory handling
Message-ID: <20190215115818.GD7897@sirena.org.uk>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-16-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20190215020855.176727-16-sashal@kernel.org>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:07:54PM -0500, Sasha Levin wrote:
> From: Curtis Malainey <cujomalainey@chromium.org>
>=20
> [ Upstream commit 09ac6a817bd687e7f5dac00470262efdd72f9319 ]
>=20
> snd_soc_init_platform initializes pointers to snd_soc_dai_link which is
> statically allocated and it does this by devm_kzalloc. In the event of
> an EPROBE_DEFER the memory will be freed and the pointers are left

This is also part of the same set of issues.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxmqVoACgkQJNaLcl1U
h9BMHQf/a0tzXvjXUsHOBfiMPWD6MqcX3LMuAG1r7R7SkXQDwMeINh2RDjf4raVX
/hR2D5jGbZVhE8IceaIDJSlFD3ojhbQTNZyFf38LPDcDLdRQM4uADPoGHtMMbVUh
Sohk0A7B8wcuM8PONzrAvshfZDvWxcsHOPbWh1wLRqsH/pz5HyogH5lGfYDuV6V7
ivXV6yEqlZ4qPb722FCwvwUysRtA5wN/gF9+O8tPviFV1I7MOpjVkt65lHUcoc8D
6BLdRiwZusr1lcwcqAPkIrpOWBjKhtA4OnKB4J/rrwtS/o2tBg40M0YO09AM8FRo
rftu/m+8AksFlk5CsLUZD0mqrMdn9g==
=oIIs
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
