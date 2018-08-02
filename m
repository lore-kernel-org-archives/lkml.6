Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03096C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5089214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="el4dC4a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5089214FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeHBLrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:47:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44242 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=88eCc1xhR5W+MwIX0g9583RSJiUnIz9pv0mXB4fOlew=; b=el4dC4a+NmXLEbMMFyPDAoIrM
        AAtK4whQ5/R2YCey2neyirbxcuHH8GB7nKnyA9z9lY5aTAkG3J5j875KpPDaELLSrmK2+hGCty4ix
        yCI1URkwSuEFuAJdO6EKnPLhF3QopY6Zi14XO36uRaE7Ea0zuv5VOG76gGg3Xv/6EN4MU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flALB-0001pV-SO; Thu, 02 Aug 2018 09:56:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9963A1124241; Thu,  2 Aug 2018 10:56:17 +0100 (BST)
Date:   Thu, 2 Aug 2018 10:56:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: AMD: Make ACP->SYSMEM DMA non circular
Message-ID: <20180802095617.GC9117@sirena.org.uk>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 12:11:54PM +0530, Akshu Agrawal wrote:
> In capture case we don't want ACP to SYSMEM dma
> to be circular. This is because if an in place DSP
> filter is applied to captured output then circular DMA
> can overwrite the filter value with stale data.

Isn't that just a problem with userspace not giving itself enough buffer
to get the in place processing done before we loop round again.  This
will simply change the type of error, it won't actually fix anything
AFAICT but perhaps I'm missing something.

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti1UAACgkQJNaLcl1U
h9D2ygf/ehYWjpfDi7yutUUdHpYQ9PM67mlWd/w7NnlZGvfY+fKwzKqv9hy1hqVR
zUqMxTLbqqsnMxwVusEfLYpF5Ckznh/EQhgFBxGbS6Ocz0e2kGN128VD2LyziboI
QWV8qp49MiBiVexgXDHpbyPw+SmnbvQyViCBqm3X8GZJkqWIUzBnCINr4fqqXAv0
Cc3DbDYs993W0Say2R95fec+DJb8jQ4MZD9nRAq0JV8kuoHW4A0Wiim8O21ELuH+
n+k9SNr/OboKeR8V/j9slWWLXGRioA31DSfatLTK3KTNRPjyIZ+x4Ce4X+D8nEm7
m4n2zRDoDbSkIYQh/uhMbmlxgGTUsg==
=PhBU
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
