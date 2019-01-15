Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96265C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628FD20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547580388;
	bh=d/qpTkWUKHbIqMVN/Nja1akTs2mQhZuriQmcOLrPE9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTh+Z5ebC3u8O9rWy44mOnKS22gUPd4ZHMXzjeVXU+cSytZZJbdmQZgfwVksRK1iZ
	 sC8b2qeDmq5BnIBC5FMswZiGtEM8PQ+9ch4Zt1xMTl/e174T99wscZP+GMzshsRdIg
	 B82QreDuFtOuix2rE+0DEPwIgMFhjQwNy6qoaDwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbfAOT00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:26:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOT00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d/qpTkWUKHbIqMVN/Nja1akTs2mQhZuriQmcOLrPE9w=; b=blfqMy6p3wSUH8fjZo0wlKnQ/
        1Ux4f7n3ZAB2/GpJp/iC+/Qh1Ui+YGhzLLOvZQjbn8beRlB6QZzaUDaj+rV0mlWMa7mmISaTsZAJb
        WeF72mSMyiMGc8rOX5Hizt6jA2j5X7kXZ93x4hZIek1fe6+kfFJdhb7GjGeLHwDN7Lm0I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjULs-0002M5-CB; Tue, 15 Jan 2019 19:26:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BA41A1127848; Tue, 15 Jan 2019 19:26:19 +0000 (GMT)
Date:   Tue, 15 Jan 2019 19:26:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernel@martin.sperl.org
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190115192619.GG5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 06:39:27PM +0100, kernel@martin.sperl.org wrote:

> Is it possible that the specific flash is not using the =E2=80=9Cnormal=
=E2=80=9D=20
> spi_pump_message, but spi_controller_mem_ops operations?=20

Right, that's my best guess at the minute as well.

> Maybe we are missing the teardown in that driver or something is
> changing flags there.

> grepping a bit:

> I see spi_mem_access_start calling spi_flush_queue, which is calling
> pump_message, which - if there is no transfer - will trigger a delayed
> tear-down, while it maybe should not be doing that.

If nothing else it's inefficient.

> Maybe spi_mem_access_end needs a call to spi_flush_queue as well?

Hrm, or needs to schedule the queue at any rate (though this will only
have an impact in the fairly unusual case where there's something
sharing the bus with a flash).

> Unfortunately this is theoretical work and quite a lot of guesswork
> without an actual device available for testing...

Indeed.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+M9oACgkQJNaLcl1U
h9Ax0Af/aOKsziyOkq8/ZbakEdsATprCNt/E+Y0zLxAMfn9nXuaZ4a/WZJLA9hu8
TC0pZTNicwIrkIdU+ItoqssWN7NiDCR41cJEw2gDk35A9nVuwR7cJG0Vi7YbaZLH
zbRRc6TUO68wEwx0lfm8njejzbtYjoos/WywKKRAs1GblvCP57MN0mjjV96/gGAz
0JXQjAFdq58kfHGPClmmgLKMCW5DYkOeMO8RudSCpVRL06uOHGfretNDGeMkLGiv
7g2dlxm/8yByb3vK21AS5UfFKj0M2I7Au6k6mTGMwxkm/GBYEtp9PqmrJ0Ru4gPl
cE8Hgb0jb7c7hOzdxLPeFniKm8vFow==
=0mz9
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
