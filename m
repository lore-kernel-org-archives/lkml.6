Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D76B2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546609801;
	bh=OO5Ohtwh+UG/WTQWEeJrGcad402h+SgeEjPcbRKZk6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NnuIrfbHKWAj9bwH44vprpGrATmyQ8QzH2ECKIBZfiZMP7SYxeL2YJTzdL/22Cebn
	 /oPMt27XhE+tLMVCkQTORTBeldcw4e+JSdv+VTlWDLurPTHw3TJObmL9tjVRMQZXXb
	 nBytuD50baeuQBrFPnn8VkFHCB/pC8TbZt/1DMyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfADNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:50:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34222 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZkU6YOgn2Jbae0n58vanftXAPvSvmX4NS8Sp9B25s1c=; b=vQeFlz/2D9QB3TwQnI4cm7woM
        odsJ0QnF6MQCQwg06tICWTnzFmiL3B4Y5ZeultgbCOT0cWWVan8y6QL+jPhc2dZCladUmIPf7MInM
        XaBqeeOLJ8+R34lqW9h2j0O04QLwZYra1zNAPSVuzCwWhlDrFwsBS32hd/JEPNTf7VBMs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gfPqz-0001OS-Lr; Fri, 04 Jan 2019 13:49:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1BDE711270A3; Fri,  4 Jan 2019 13:49:37 +0000 (GMT)
Date:   Fri, 4 Jan 2019 13:49:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Variable "val" in function rt274_i2c_probe() could be
 uninitialized
Message-ID: <20190104134937.GB4140@sirena.org.uk>
References: <20190103215912.6071-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20190103215912.6071-1-yzhai003@ucr.edu>
X-Cookie: An idle mind is worth two in the bush.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 03, 2019 at 01:59:12PM -0800, Yizhuo wrote:
> Inside function rt274_i2c_probe(), if regmap_read() function
> returns -EINVAL, then local variable "val" leaves uninitialized
> but used in if statement. This is potentially unsafe.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwvZHAACgkQJNaLcl1U
h9C6jwf+Keh0tNKg0i8mQ5uxEDQ1Lg7bBW+fmCUAddmRcYyHe3lllL3fuauZDonb
84ms+X7TxqSJ3KR3sB1EnHb0xktJsPqkG1asj6WDdiLNteREWJyXqjH4f4cfXU+n
hLJ3LBzfBm/rJWKBV4NqLz24MvS96nasql+VW2H1b9hjr9r5fmtJeqXEMwHHCF68
dub9Yqwp1V/BWetT45o7PWQ//X5KqIa9nIxlTAzzCUGOzSwDNp4mCiN7nwDEQySW
HAt611Inky8+BMHWxKdo8rwwqxNMwx011hu9mk/ZAEkHuRaySiD8Bb8zSULj9N2N
NFS35byS6C4U22O1HUNHpoWuc2C+sw==
=FRPy
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
