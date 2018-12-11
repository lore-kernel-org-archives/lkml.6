Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D740C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E0D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537175;
	bh=qHuk0s9oZ1dUJnf671CHu6opZpsqOFphQEoMTEyG//A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=apKiNi1iVtkYR8OEiTYCu/uj3P3nkp8rqyFgtmg01HpTAzxxcUiVmwbpm5Tk/ut+a
	 /D3mai9m2GuSYnt/AESVJMMj97fu8XIOwpXYNR2rfCzpkVpkB70KNKHVYJmIqW1RuE
	 IMT6fZ5y4sIk5bR6QqV3ja8kbw7pmuQ2HmSQtUOg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeLKOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:06:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeLKOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dcmFOvbLU2N9hJeL+no1ZLRM99AyO0uFTUlDrCU7RW8=; b=oeteazkgMvqzL17OWWbLHiW/H
        4Py/CUg9HEvvQyrCtpUKmzsEB3bzGOxJMFjUPLERI/yB1fbCjhjPTnZcN2qKcjYHWxtrz2dMG4jMr
        KOk0E6rBT+wgpSJWCLAtBv0B1zRQwXaEWlUU8xC7oLqD+SBvHTDEojmUkkjgljUsTV2EY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWifp-00015r-W6; Tue, 11 Dec 2018 14:06:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 84F25112540E; Tue, 11 Dec 2018 14:06:09 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:06:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Evan Green <evgreen@chromium.org>, masneyb@onstation.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
Message-ID: <20181211140609.GD6686@sirena.org.uk>
References: <20181206222318.240401-1-dianders@chromium.org>
 <20181210154311.GF6307@sirena.org.uk>
 <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
 <20181211005221.GB3004@sirena.org.uk>
 <20181211010032.GE3004@sirena.org.uk>
 <CAD=FV=Xh26OSoMVTJCLiinw94MmgqNRexc=uWP+-58L8fBUavQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xh26OSoMVTJCLiinw94MmgqNRexc=uWP+-58L8fBUavQ@mail.gmail.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 06:40:53PM -0800, Doug Anderson wrote:

> Can you confirm my patch applies cleanly to your for-next branch?  I
> can see that it doesn't apply to your 4.21 branch but I can't see it
> fail on your for-next branch.

No, I tried both and it didn't work on either.

> The problem is that commit 2bb166636933 ("regulator: core: enable
> power when setting up constraints") touches the same code but isn't in
> the 4.21 branch.  If you pick that to your 4.21 then my patch applies
> cleanly.

> If you'd prefer that I post my patch atop 4.21 I can do that tomorrow.

I'd prefer that you resend like I said :(

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPxFAACgkQJNaLcl1U
h9AOtwf/X8fdb0TdTEblIdfBN4DiYCcUwdgN2Vw+5q8yuetr3BSGqSbHsbJe/NQM
x5cP8IwRfBe7A1gpJ+fBtFaFVGZfBgXa6T9mJvvOYOQeMhmR8ot7vjctL6nqPlRT
hkW1hSwIVAn0drppgxW/5F8NJ+iNGFCd2yo628vUAWvUTm/ENytf8+sgl51N3+Fm
d3djWoHNK1XuQuaMxqa/s/Y6A2Hjyx3Bvye3AQ++cXEGHWBqfExS/GDypTKjLw/+
Oh/PTsxKOVDpbYAbAjfPCyjuwC5w74v+1lTFPVRAEbvWq3arO7kEi+b59e21rJwQ
mzq8Av+L8Wz75Df/3+GWANzHurUrqw==
=LICg
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
