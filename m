Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4533214FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UGYfwAfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4533214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbeHWNUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:20:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeHWNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P3N3DBK3VNoIGYhW3QfC7L5w0EWAO81rS0MW1fX/+e8=; b=UGYfwAfTu3XfaMfpYMuNjYx+L
        cw2XSmwOMkLageq9GqCoGDqKZZJ/iNC/XWc+x5wReP5It1V5+8n1hS66MK++ts+ama5KqjeXnLTHQ
        4rt92I7tuPAYU8hx1uLMCfLRdHBrCnCLEOGCvRoSLxsXhzVu/MXJBeFDKSf/PxlP7yBIY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fsmGi-0007G7-2t; Thu, 23 Aug 2018 09:51:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 906491124604; Thu, 23 Aug 2018 10:51:07 +0100 (BST)
Date:   Thu, 23 Aug 2018 10:51:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     ryans.lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>, ryan.lee.maxim@gmail.com
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp software reset
Message-ID: <20180823095107.GA5207@sirena.org.uk>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
 <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
X-Cookie: Truth is free, but information costs.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 22, 2018 at 05:31:04PM -0700, Dmitry Torokhov wrote:
> On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee <ryans.lee@maximintegrated.com> wrote:
> > +       mdelay(10);

> Is it really necessary for the CPU to spin for 10msec here?
> usleep_range() would be better solution.

Or msleep() for that matter, it's not going ot be the end of the world
if we delay a bit too long.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt+g4oACgkQJNaLcl1U
h9BrhQf/Zim+9StJ1iLMas05ZDR6IOmI8Vk166JzDc5Cl04crEzXRGtkjTjIPszh
nO5s0JhVanRN0I2RXQvD1nXHDeXIAOt88susgnBH86u7HFLGO471NnvZW/R7W8JD
hMUNwL3RfbRAMbkGA11dlvU/pQ/Q7nAE4NPmMIBS5Z3W3ZIb3yIXeEAO7osAtAbU
5ggStp5ly2w8A2kPEsDVuaYTDKPloD2DP+9QWl8b3c1N9PD5+kAFjGEgNR+7o3A8
cCw9zFfpkQekbYQHqsVw8iV2tWJClPqNvtwl2qbq35/MeMbfnaePaFVWDe/jBE93
LiB34dB+w7sqy1wv9Ahq+zUra29Lfg==
=Jim1
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
