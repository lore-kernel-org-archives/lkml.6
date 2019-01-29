Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35300C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60E2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548781305;
	bh=hXaj3tL9W7EKslzzjYnEL47o3TGvZn2E/qmJYjuvx90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elckP8z4u/gdG+11bR9InpjhnPfukgCgAPNTFJ2GzO3LMF5IGUVTLo6WgzjAdUL0Q
	 weC0mE98uPVIhZ7yOiy+6ZEVyggpo1W8RLJk/UxJo6+mAGTpTuD7zC3p91eLesv0m1
	 AxkMdyNW6V0XcBy0umNtDpqJBZyoskEnF2eW+5LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfA2RBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:01:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54098 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2RBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hXaj3tL9W7EKslzzjYnEL47o3TGvZn2E/qmJYjuvx90=; b=mKiPSk+c+3aYabz5XJ1CrAAKu
        LmyKycUX99QuKFV5cXoifl1kiBC1XPnY1OoJZvqHbJalQcgwERt7lSc0TpmTpX8Yh/fOLDJb2kXy2
        rbzZbUOW5yCVRW849r6srfvK9q46camOm/S1vFdF9Vd6IwX99tpMJ0DK04oM1FatncEBM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goWlM-0000ft-JD; Tue, 29 Jan 2019 17:01:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DEF8E1127D50; Tue, 29 Jan 2019 17:01:27 +0000 (GMT)
Date:   Tue, 29 Jan 2019 17:01:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129170127.GG10524@sirena.org.uk>
References: <20190129164813.GA5720@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20190129164813.GA5720@atomide.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:

> regulator-dummy: Underflow of regulator enable count

> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

Given that this is a new warning my first guess would be that it's
legitimate...

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQhucACgkQJNaLcl1U
h9DvNgf/afV1Q9dfKEBi5X3uqIODf6E85oTYa+NZvgVWnAWdwnUWzNtkeevo/L7z
kbDoRiyhz8txKBiwZqyh46yWeTDKJepSfunaqT/1ZQfbkr2SnNDDncEB0W/TOk8g
PMLIGlK5rw9Y1P2TGWuCel/XAXF64fdlMz7HiM0PJco6RFbZgnMa85i8IfYCL6p0
IzC/dC3XQ6NeczMa9qLnrNHMp4iMF27OsNKgB1VLLzcb7TePFJDQUJAB4GDWvl4s
WrKl/MqQhQNfWPsQ+DRSYVnAphWyQZe+6RPInZOEVEBVZ8AKpAXnYz8g/aSyyQpU
L9r597E1hN+WOn4igpiu7y8UTEle7w==
=waLs
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
