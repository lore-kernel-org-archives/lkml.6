Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-116955-1525856646-1-16613872457060078358
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
    1525856645; b=VacrQ2Obe9EcR2dZtOTdNvW35wT4Vhjrub9Vpkbzh0tepzCaCs
    jpggaihErpwn5gKDC6a7+p/Dm9IVk8XLcD77nMWpcUaN8hjv4fNfXE+lBTi9JecJ
    KRk475wVuXizALZx9ECsfrU979KPw+uw0nYYX4xKCNYl92BvJGZRh5njBylaZxJU
    aG6s6tHH248vmjy/lfUfHLIaxDXAfC/bgiKtEOwRO6aZX6s2JAfSFqpFh5Fo6W0j
    sCxcYNyBCJJVst2gp7RRh4qKFv4uY2fvERhft4Xy89b+bsQwq0rFlofRW6bQPRl/
    FI3TcseSAnu+hbeKJFj4MoxukPUW5FYcpZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525856645; bh=6kxNLufQf5IuOpKL+dgE3enPsOlROr1
    azV15kV1RKiA=; b=Ki12mk3M3U167crfNuOUxg89HV316WUTop1xalApDaGb+v2
    midGEdq9HG9tVmWEP+k+Lf/0F4BYDrLwIpjQq/1TwePdN8N2qNAT17rCA8n5AgSf
    PKNJpUrRLY07DvygTA7IFZ4ak0sCQxY+3PgW2IFvg/sbFQBVwjt/mB54MA5Oep4x
    tiXtMXWzJ+teJJ+YNGIgkpcgYHDPmTUU2HFtcpb2sU5raJnWFjuzbe+LoB4kvTEt
    ONXoV7QAhYxIkP3sCqRGsMHVurqjsfDoUgrn6lx7KpOqggNX792pIRWHofPbyxtC
    4z3/u1tqxeJrA6ayLh9ca7a91vWUYKKe3tayOqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=fs9QYCO6
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=fs9QYCO6
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
X-CM-Envelope: MS4wfNPTRuq8BkBG1qhrF6TaRtHCRc0KszqY/mskJYbM0nkQkCTy79MpZ4OjLMPPgQjekiaNnLpBzYtuMxWJ/eXK6oud60nqkTJAjcInCKhKTwXx0fkPsz+k
    o8Sp/XKRknWVg7uYsNWMAKFhrXFdG+PR7Y4TkVkY8tQVKJFjjksu6K1+ptM3mJFQfk+5iS6qEjIPquxTt6PIOjwQcAW9JARYIy/TXqVUVO/KSnbE+MdK2syQ
    QUv4FrISpz+CFGV1bQe2rQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=lnklfmdejJWvxHmdUdgA:9 a=CjuIK1q_8ugA:10
    a=szLxUHoEX-7CE0_x1-0A:9 a=ONNS8QRKHyMA:10 a=ag1SF4gXAAAA:8
    a=D-pE8fWRZ4KmsVp6X7MA:9 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Wed, 9 May 2018 18:03:46 +0900
From: Mark Brown <broonie@kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Message-ID: <20180509090346.GY13402@sirena.org.uk>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
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
Content-Type: multipart/mixed; boundary="===============7531031477356942001=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============7531031477356942001==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4GQ7sizse6iPvDe"
Content-Disposition: inline


--l4GQ7sizse6iPvDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
> On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:

> > I think this is an excellent idea, copying in Stephen for his input.
> > I'm currently on holiday but unless someone convinces me it's a terrible
> > idea I'm willing to at least give it a go on a trial basis once I'm back
> > home.

> Since Stephen merges all -fixes branches first, before merging all the
> -next branches, he already generates that as part of linux-next. All
> he'd need to do is push that intermediate state out to some
> linux-fixes branch for consumption by test bots.

True.  It's currently only those -fixes branches that people have asked
him to merge separately which isn't as big a proportion of trees as have
them (perhaps fortunately given people's enthusiasm for fixes branches
that don't merge cleanly with their development branches) so we'd also
need to encourage people to add them separately.

--l4GQ7sizse6iPvDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlryuW8ACgkQJNaLcl1U
h9AS+wf+IU1baG3wfK10UZNPg1egWmFCdvZUczLHZ4ewRAmJoCploibTdx9Km8b0
31MfKM2QZD3voLWLmN1kSpnY3cQSGp8UkY0UWLPzK/h2/qBFYp4bIUeHy8rt0Kna
3yfn/NAskVaz640YpsYzVYgE3+hbjVVlyf/ylq3CYOBFcQXELTgivQqQ0d+BxJuD
bt2rHHBtMw+vA4WmFhlIWJ7n9E/tlpuQ0ukpVA6Y0jikngEwBKI7btxNsqH2fizd
2jROtsef17gl47NKWMqoXRPhIFgysHYmf5iUhnspq6e/hji+yOW3Gope7OvM3XLM
pT60A0a9UvAPHXHwV3RpZZh6PU3cow==
=nvOF
-----END PGP SIGNATURE-----

--l4GQ7sizse6iPvDe--

--===============7531031477356942001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============7531031477356942001==--
