Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-116955-1525855508-2-11442099047389800887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525855506; b=O+1Vaasb2Oiiw+Mc0UoudNOibIKW7u2m0IZbGoum8n02v3TDZj
    RMTwsegGG1PhnKZkr7CAUl6WtUvZrosDEeLHeGSGSXSMb8p64ZBvcPx2LzO1sxv/
    QwoyzCH8q46/QU+/f6C3S64A4Z2fsIwGoK04wcdc2jz3amgvnrIg9PzZ4WxlMBrt
    yGPRepPTmA8dViwaKER0b5c25MJyBR5Pgsv/Ah9kRbcm2hOulec9KOLCHPr9KBwO
    PyNpkEDiDv589wv4kBM6pGjr1Avvy0MCJbSvynlTIUX5KTBFg/jU4ukXdqcRxmbK
    SRAPxuNFuLQPnfXIeK/jA/WU5ezkeWNR93Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525855506; bh=ON8M1Jni9IgA4ptrZXyW6Mxtq1WAiTr
    PRWoKvZSjf30=; b=ROje2Ji1h4IkbnlaB8KqSRR0iLkLdEU1Tir+80VdAveDcyE
    k9e+9rDVV4rLQ7aWoi+Ld49Z0hCm7sQd7iHvzJ5ui+83T+fk+ixti9JqISefA/zp
    uuYdar1OyBLiBekdAahWd/yxsln3c7H5KCi7jvGB6sgygHX7CKQPCqXHdCeaSbo0
    Zv2/3QrFqOuaQmdsJ/4ye3m6SWKw5jCP5Sih9yL+ydAmba62za5NFHgbMTh2gXpe
    62+8YCYzeWsfn6JxBWWwcIQbohSBJNeisct+Sfkwa1r2wv5vw0vp85gYULOsIYA5
    9GW+BYKzkAMthWgyotohDii7YFZVRSO8IwcCD/A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=BTWFKW2b
    x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=BTWFKW2b
      x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3bl1fQOk8ly0vWh8p5w/NQQJoI9kAoLYAqCLWoLqvSf6D1SfvD6H0/UamfGAgtERcdDBa+9sRP1/Bw3XcruhPZgZjADk5DZpEvwan3dpkhHEYKhgYY
    nTJNlgNy5Qic8p6VLVS+cQDCWmeUZql9A7cWBrh4TAyzA34gQ7FPY2A4nwP+BsM7wa1gJbrTeOlx7dHVwfp9l3b4SHFLYrb9LRgL2rXRr/KHyaDshW/Kp9vt
    B2ggxlvYBgc0R4SnuFBPlw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=UIYyrq9AA40r4SfqkrMA:9 a=CjuIK1q_8ugA:10
    a=nrSHN7-6WMoNIF4InBkA:9 a=ONNS8QRKHyMA:10 a=ag1SF4gXAAAA:8
    a=D-pE8fWRZ4KmsVp6X7MA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Wed, 9 May 2018 17:44:40 +0900
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20180509084440.GW13402@sirena.org.uk>
References: <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7738366289534127010=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============7738366289534127010==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aBaYPhOdNx+t7mr3"
Content-Disposition: inline


--aBaYPhOdNx+t7mr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2018 at 04:21:26PM +0200, Ulf Hansson wrote:

> Then, why don't we have a pre-integration tree for fixes? That would
> at least simply automated testing of fixes separately from new
> material.

> Perhaps this has already been discussed, and concluded and it's not
> worth it, then apologize for my ignorance.

I think this is an excellent idea, copying in Stephen for his input.
I'm currently on holiday but unless someone convinces me it's a terrible
idea I'm willing to at least give it a go on a trial basis once I'm back
home.

--aBaYPhOdNx+t7mr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrytPgACgkQJNaLcl1U
h9D63Qf/QlBiwp/EESFcBm2MHh4DWXDANQOzoL9MGxKH/xzaoErJI2VPSNc3XnD8
Kfay1kMcY+TZDfKIemq5vWRxaAodrL2EJFs+z9yEd/yVHWLzb6ptuAi5GeztiuSL
z6+wE+8IgfurggT/lg8f6azlOV9Jq0f///LsAdaycDUfS924Oug/V2VznGRWbcTB
lQeaADEyMmB65UWVr7F7Mu55bSev7t1+usM0kL0Jqa6OgKWl0EwNW/ylKUHPp3cG
io3Cn2vcuPIfVatpuPoYPXmRhGWEIoHi+a199jFQIYdmAwPpe5Cdyh25ZR3yWcWJ
7Qg3L/zUUvBFgiSorfRHtsg+avDhIQ==
=bfsk
-----END PGP SIGNATURE-----

--aBaYPhOdNx+t7mr3--

--===============7738366289534127010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============7738366289534127010==--
