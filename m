Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E56D2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546880366;
	bh=Yx/CXCGumEO0HdcC+giwxPW8SUYoXFX0P7uH20hhv6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zoB+NurOwI0YeN8VoJJhmu3qjVsPvQ/r3D2oW10wCfsvn0xIfBGjRjkRnzRZUOQkO
	 6qKK9P6LJHZmCM+bXVp+iq8ZFQdYLtg8THBO/eNAXYUTxDnd2Oz6D79aGUfuvfG86d
	 /qbu2ELfBQ1qbf6tITBvf3ChBcNtiqJhm9T5uDa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfAGQ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:59:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAGQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yx/CXCGumEO0HdcC+giwxPW8SUYoXFX0P7uH20hhv6Q=; b=nzDTK5HGQbQJWF9aYVi2dsr4q
        w+GE9FJcq6ajDRUjcXCYXjsju2FhKlDfOULCex3Thg4Kr6+90ZAVBlLC42wLIqJErPcDO+h3eh4LX
        VclyVFpUrUOICxz5eGRPGC+PwAiQuf94gkKnYedTSKdUJ8J/9lev8zqWnDiGxktX9YQIc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggYEV-0007VS-5A; Mon, 07 Jan 2019 16:58:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6CF8F1127491; Mon,  7 Jan 2019 16:58:34 +0000 (GMT)
Date:   Mon, 7 Jan 2019 16:58:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt274: Variable "buf" in function
 rt274_jack_detect() could be uninitialized
Message-ID: <20190107165834.GL9570@sirena.org.uk>
References: <20190104202708.14759-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UK1lfQXsnwKrySH9"
Content-Disposition: inline
In-Reply-To: <20190104202708.14759-1-yzhai003@ucr.edu>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UK1lfQXsnwKrySH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2019 at 12:27:08PM -0800, Yizhuo wrote:
> In function rt274_jack_detect(), local variable "buf" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used to calculate "hp" and "mic" and
> make their value unpredictable while those value are used
> in the caller. This is potentially unsafe.

This doesn't apply against current code, please check and resend.

--UK1lfQXsnwKrySH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzhTkACgkQJNaLcl1U
h9BfYAf9HvrQb91OEUf4LOhKH18sRQCLgHXtlFFN/H7s1ST+zIQONgvRr0X3UrHT
iiMU0dGygbKV4KNin/sZqJSrHEKJkXc2gSAV1S8iSEgb2VZOMb3kPu2uTbIEQYGA
GqYkrSTcMawcOpD7XWn+9/UIe7+pYzqhrWpsdFw2bTvHFskfqesBAa19lnMKTW+6
wj4CCSLrCPw1/xaiK4rTkbeX7eax2okHyqjnNamaiBIgFU7bcN76kblxhVBXIBfs
zuTZGqiYj2XktV57oOEr2g3mNyd6eRV/qVZbj7/MIrldAaAGmVixIBbzLQUZwG4E
PVXRn4S0NeolG+Rwa6ttkqi34nelIw==
=6AXx
-----END PGP SIGNATURE-----

--UK1lfQXsnwKrySH9--
