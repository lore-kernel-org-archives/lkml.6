Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D27C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DABA21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BssAaX2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DABA21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbeKNKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:35:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeKNKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MLiS8VDIv2eLVdFL9e71C7npxaO9PHbOWVggsTt3gQk=; b=BssAaX2HVTiYQBPzx6z7Nn3bx
        N0zbbjjbLiLWh6LZYYxVFMkMZiTL3LjpyaCl1g7hHeLPmEa783YQBoLLTNCFSf+YPo7Wv+xz0EvC6
        TNccAMBSYEuXp9IKKYOeLjcuky/KTk+W4PHbJuJww8h5gYOvuJcIexBO7uhHuBWLYP3Bw=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMj7w-0002oI-SF; Wed, 14 Nov 2018 00:33:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BD9A9440078; Wed, 14 Nov 2018 00:33:45 +0000 (GMT)
Date:   Tue, 13 Nov 2018 16:33:45 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Message-ID: <20181114003345.GV2089@sirena.org.uk>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kM/PxlMMHsUUNZZW"
Content-Disposition: inline
In-Reply-To: <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kM/PxlMMHsUUNZZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 06:11:26PM +0200, Peter Ujfalusi wrote:

> if we revert the commit then the original issue will re-surfaces. afaik
> it was not only audio which hit the 'last driver to be probed from the
> deferred list would never probe, unless we provoke the kernel to load
> additional module, or remove/reload the module' issue.

Right, aren't we just going to be swapping one bug for another?

> Do I understand correctly that in your case you have two modules
> (dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
> the drivers returns -EPROBE_DEFER and they just spin?

> If both is deferring, how this supposed to work?

I'm struggling to follow the original explanation too :(

--kM/PxlMMHsUUNZZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrbWMACgkQJNaLcl1U
h9BMfwf/SGcoei9hwsRaGXL/3Tv+0Qikp9WNRT/2sUol+X6k9NHZwWTd59ts+w5+
OOV7Cij0cIKBCKSr6X/AGsVL2Oa2MEU8CCdwAKSXVAcNaTXqIWraTFaXRR0YtuY4
7Uu9Na60NPsDZY/tVmxK8XnAV6wj7IWhgnDGbe05wYnxPLC2oFt2wAGDw7ZMW1RE
Bzv2NnVs11ZIPphUNa4Eu7mwmYaj9dRAHQN3FEjwMXNXnOKJS3UbRS3PKOJmfzgl
Nf5PWsBcGLgd99i+s5AZFiZHopRsO75Pld3Vu0T+U252zyXFR1eI4jicojuYrZjF
DERVmON8tTuNbxNwGpdv71b2jhzOpg==
=nxIU
-----END PGP SIGNATURE-----

--kM/PxlMMHsUUNZZW--
