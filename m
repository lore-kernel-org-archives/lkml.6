Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2094384-1524242972-2-14824152983502112102
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524242971; b=oXSGvRCkcKzhSIEB0CsXrk4XPDwDnj1GGTc3UvvxRdtr5V5IXH
    DBkH33/8ep5634NwDbiplrJu/RxnbIWN8XmtwIN4Wb47lucNhgQ4/zDcXTNY7Obb
    BnAeEwLWqbAVImxeMeL+l30Nt32EYinIugvUyerxLAlBGBTy143KZEoRSY0UHdGv
    7zn0EwOtIxevskMsUmXGn7759Wol+96fv0bsjyL/FkhwwUvtQIpR5Ok6u4chxNWt
    RXZm7G3k5MEjtCgXT3SVmBDl3eCyiGxJJ2Xb+fHvntuR8/V07kkA/hkPw8BgzXy6
    FLjhT+SSuQpU9R5DWxk0mCCp8uPKmrtfotWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1524242971; bh=m0NRk1oN/H33LyJo8mO3wJ+c8soWMG3
    8YxsnEmDY0M8=; b=YHMqza716s8CfymgXlE5KWEL3MjZryR+/PMxCCArxYiaCJq
    YfllCrnwtsZrdlSGA6wAYA+qXD+IRDIFRz1GBOg2CwaKFYoWThtoG5yAqojcuGdf
    2xGbEw6nrx0Dqcf1yxxFcnO/UQUbVMDOED/7UM7tSlvRsWANsWO5pkST3o6+msCk
    5XFGK/U1Ib83qRtmXcjThNv/GXo5YFKyUPsVTy6xaYvQrplibgxAtRTMCC4cbBgo
    4+nyAXRrBSYHSwWq7IT8vKaIKSNWAUvMXNkCDg4mdcRaz/TayigAo6wTU9qa2SAf
    I1ocuDXgcMT/akNrtYazQmkkVyLliDAsOOmAjjg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=YZyDZTUR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=sirena.org.uk header.i=@sirena.org.uk header.b=YZyDZTUR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfByRD6XNKnXSB+oKaj9QYHkiALFITKGu4P50KxH4prVSK9Yc9d/+NXEU2eM4thB9zb7XscPg6mmo7zKsGpZlxGWqaRXvD/TTuir01ihGuRHUez5BVeAg
    CuG8+6CsxTU8u4u9vU5nsO8h3HLNCE0j6KEqdqU1Svw+xF+z8HtXxLibsv5yDt8fjiK7O7TTK/YeW6OezwhXU6ll4YEXXlAFwQ6r8D2J4vzLZ1WJ08iqkxdW
    C8Hb4TNqAt8qhYNAosMSzg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=MgNfCo3lgPDDCviTjzcA:9 a=CjuIK1q_8ugA:10
    a=JJTLgCmDWxjpRr6K7t4A:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=pC-h2on8RWMA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 20 Apr 2018 17:48:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
Message-ID: <20180420164811.GC22369@sirena.org.uk>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
X-Cookie: Smear the road with a runner!!
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 devel@driverdev.osuosl.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-media@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-arm-kernel@lists.infradead.org,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
Content-Type: multipart/mixed; boundary="===============4325866435034445140=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============4325866435034445140==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 03:28:26PM +0200, Geert Uytterhoeven wrote:

> The first 6 patches can be applied independently by subsystem
> maintainers.
> The last two patches depend on the first 6 patches, and are thus marked
> RFC.

Would it not make sense to try to apply everything en masse rather than
delaying?  I'm happy to apply the subsystem stuff but if it gets things
done quicker or more efficiently I'm also happy to have the lot merged
as one series.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlraGcoACgkQJNaLcl1U
h9Dwjgf/Q07mk2IWEt7VXFh08KoOEpJEqv82iu1CWXLrjf83nqwrtopuQeod7ep3
mYoWaxwFLG+wRiICbiVvZf1E9oyGm+sd/IceJnV/6vjTX3iAS//6hUZelNkyAjNj
uvj3C3aGO+8n95ziwDEe579wVzhbzf1fNJKuXHavLmvN7Zo0q0J0Z/UcOku5bvIu
cA6uuY4IiNLgq4b2Boe1YKLb4GFrzAMsBSCtrDwhKYPuepVHFN0U9yXjKHPUj9hd
a/0SUXkvRlTTASH/rNZ/izVWymAudG+HJu4bbCuubieJZ2lZ8G3NL2TviyP9O+ql
35zxtbJRtGQ/uHkqH44QJFZmUoDoNQ==
=z1T8
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

--===============4325866435034445140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4325866435034445140==--
