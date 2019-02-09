Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266ABC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E810F20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="YhLeYq3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBIKLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:11:46 -0500
Received: from tomli.me ([153.92.126.73]:54622 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbfBIKLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:11:45 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 7d5e56c4;
        Sat, 9 Feb 2019 10:11:42 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b76:76e8)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 09 Feb 2019 10:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=EBIKsvw4zmVonKYgI4gXCNmcrvM9dfpkvXYljZmtxyI=; b=YhLeYq3Gk/KgrsefJ9bu38CTw9evCEuy5zV5rEwY47pQlenVrj+fkslE7UqbM+H4JeClfPS+8Pahisbp/4260wqCQuFsJTElGaoLElLqF2V/qF7ZITkV/l1V4qD8pQS09+3Cms568ZgzCU4Bk4DfwF/TInoR/tSXHxeIeeIF011m3KYod6cgHAOlZ3WH2cUATQ/8KhEQVTyHX3ny5OfLBYYBleVgtv93KwRNzFF4YT5C+l0hd2zo1L6Jo9XPhnkab1FCWxMjSOoqlFQM6+EOuAQzGZOoyypbMKNxfK1VmsC7ViWuWUIW6MKeXqjQTuFR+PO/x8mSKEunjrFXZWUybg==
Date:   Sat, 9 Feb 2019 18:11:33 +0800
From:   Tom Li <tomli@tomli.me>
To:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Oliva <lxoliva@fsfla.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Message-ID: <20190209101132.GA3901@localhost.localdomain>
References: <20190208083038.GA1433@localhost.localdomain>
 <20190208200852.wcywd7yfcq7zwzve@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20190208200852.wcywd7yfcq7zwzve@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> To address the particular quote you give from Dmitry Torokhov on the
> yeeloong_hotkey driver - just because the driver as-is includes a bunch
> of non-input related things doesn't mean that it should or has to. From
> a look at the 2009 submission it seems to mix a bunch of policy into the
> kernel which really ought to be elsewhere. Generally the input driver
> reports that a key was pressed & something in userland decides what to
> do with it, whereas this driver seems to attempt to bypass that & prod
> at unrelated hardware all by itself.

Sure, the hotkey driver has some problems in its current shape. I think
the existing code makes some hotkeys on the keyboard behave like a hardware
switch to order to implement rfkill hardblock, and also controls the video
output switch. I think I need to investigate it further.

> Personally I see no reason for that hwmon driver to live under
> drivers/platform/mips rather than drivers/hwmon. All that does is bypass
> the attention of the drivers/hwmon/ maintainers who would be best placed
> to offer input & ensure the driver is actually any good.

Yes. I think if our conclusion is "drivers/platform/mips is not a good idea",
it should be moved to the appropriate category in the future.

> I think that question should prompt another - if we have maintainers for
> various driver subsystems, why not place the drivers under their care in
> the already established directories?
>
> Thanks,
>     Paul

Thanks for your reply, I'm fully agree with your comments about platform
drivers.

I find reorganization of the current Yeeloong platform driver is relatively
easy, since it only involves one machine, I'm already working on it.

If future developers find it's difficult to support new machines, we can simply
have more discussion, reorganize the existing hierarchy further, and make
incremental changes.

Cheers,
Tom Li
Beijing GNU/Linux User Group.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJVIRsjlaWj4OSKDx+tPrBeiOjW0FAlxep08ACgkQ+tPrBeiO
jW2Uhg//S9DyQ2E8xIFqU+qR0m93iXTPcWfX7/Z1HywSTbz32ppA5woe5VrKwDP1
wKht81YsRDQFZk2ctMh02owBB18GrhG9rgeXcdMUgTByvAfieuUju84GF6hQMMl9
NAI3AoiT1lQgGZsALvHZpFLHAVWlvd/1M120YpQnOsDCLXqaURufMIt3lDaG3dcr
0A2v0HnRc/ltklrKiHkNuQ1+h+iiYfCNH4TeMsAsti5GZ6jchxTWNy6y+M2iraPu
ltN09uu70BoQ+iXo0Cc9S0YQx/jHMRij1sC0ZEq6S3JTJtWtDx8f6+cyurjGQEc3
jJ8I5E24RQAXFlWNB/y2edgBGHVnwRVl4XROvtDnAPRFDZe82q1DQVXSpADEaGlm
a76x1eKv/hi4m6HJII8cKmRvw1uX2jx/0t3vGdqiQ2hb2qDqmTXX7sjQNPLf7olQ
y1mFS6wls0HhaqLfv4oN0I0NAPI40z/QznPeXzJurmf14WowaMDX3oalR6P/96pJ
a+aas05HjDfNyubmsntf3OhiFysbMDTC6oOVnbXZbQn+a2vQjGooaCF5pIwrKEeQ
H00t0e/EkeQosFdOvxrGY3YBgSl7G0AxtE0pfMAUs+kwWFeNkuzVUl9EP9uGYvNW
zKPBQglJnlXAn1RVpjyDkmsAv69oF9NfBwTkTPNgPl+4UPy8M8E=
=t1nv
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
