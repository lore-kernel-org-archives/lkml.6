Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4066542-1522708813-5-4991949099959042701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: to='utf-8', plain='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522708813; b=XzWDmE0kSuhe7rfO6xjhwTXAHKyP07wk6sPCPB0LzQXuUVs4FS
    yzI2KfJr2PTi6j99siVzxwMXWosftkKI2r6KKFxzBkvrrC3eC8mV2V+2gmge/M2L
    XEwPQO7zV/J1lpJOKL4IBI6HMfvOPMGMadagHjyZ27DRdd/zGLZbYIodCuRwPROI
    A5ZHLYxYF02EPB69sBT1/1Ka8E1U/MzlcXywfgkpHHLKX2fVOv999L1lm5OH0sgu
    aNwmD2EQHORpf/QusPQvOp2qo5kVkrdSomT/zxB5E8cOkcW4NATjbqLojcWEpq3L
    vpaDXHNHo7Hl3tpnkqbZPe0yULXNL0NJpxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1522708813; bh=Qs3WA3WEoTmhMNEJVSjTCGmirYAJ8vW
    YyjF2X+ENZuE=; b=m47t+yrv+KE2RcIRz0J6dBS9Bdv0ljnMokWtASLOmvF8fco
    2pCefVpj6Zk2tvsIOVMDe8CjlbNOyfD7R+r4gXIZTtKtk+7jKyXO0cytEaQlzjAJ
    6VkzYWoGAi8Pmyh7WmBFRKiWl9UQ5TR0UlWJZt3cJbzaNJFes1wXR5ZrpTQt3Asx
    rn6wamofnagnihA89cO8eg93aU2PTE+UdgcgNUE1weydQw8LLLLaq4tV434zwi7L
    BmSLXEcCKvEs5X12SUzWir5D9V6QbuwLgQs/YwlJFXL3/BsHiqm+txpL325pbX28
    7g1bvNkGh4r8JmyFlokbAOxonY8bc/6vEgoR2wQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMKiUJ8SIr7jWsclIwIv7LB85Rbu/7HqZ5c+Ef/2lozC30z5t0LP5HXrlj67Tua9HCovH4uyhqZ3NpgRR6o7bRX8Efi8ahnoIiRz0qzGXTrHI43twFfR
    h1A4oPFHa03oOxhZag3jPxu7UEE73bW6I/eNG3PtJ8zYYzJTSh9DKTwB4m7+jUgG6bH+8zesrBIXEJpssRFjGRWkwFxGQV8iaAfi9FxrBmyUGUcX7KhlLqKL
    dwR1H8di+PKrbfmGMqcB0w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
    a=Kd1tUaAdevIA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=uZnc7bg5Dmgpu3O4tmYA:9 a=dcoWzPrFgDycuLpB:21
    a=CV0ICVfKCE6eihEo:21 a=QEXdDO2ut3YA:10 a=YCZ1P6Mqj-XUE9o3ndgA:9
    a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8 a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10
    a=pC-h2on8RWMA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>
Date: Tue, 03 Apr 2018 08:39:55 +1000
Subject: Re: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <20180402114103.GA29354@demeter.lkamp.de>
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
 <87vada1owt.fsf@notabene.neil.brown.name>
 <1522638255.18424.44.camel@mtkswgap22>
 <87po3i1dhu.fsf@notabene.neil.brown.name>
 <20180402114103.GA29354@demeter.lkamp.de>
Message-ID: <87efjx1bd0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Chris Coffey <cmc@babblebit.net>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7649931353465849308=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7649931353465849308==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 02 2018, Christian L=C3=BCtke-Stetzkamp wrote:

> On Mon, Apr 02, 2018 at 01:41:33PM +1000, NeilBrown wrote:
>> On Mon, Apr 02 2018, Sean Wang wrote:
>> > Hi, Neil
>> >
>> > Forgive me I cannot find the cover letter in the original series in my
>> > mailbox to make a reply, so I rudely made here just letting you know
>> > something good to the growth of mt7621 support in upstream.
>> >
>> > If so, it would become a bit easier for me that maybe I could give a
>> > hand for migrating these staging driver for mt7621 to mainline. I
>> > thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
>> > current mainline code.
>>=20
>> I agree that it is quite likely that several of these drivers could and
>> should reuse current mainline code.  I would love to have some help
>> sorting this out.  I won't have much time myself to dig into it for
>> several weeks, but I'll make time to review and test any code that is
>> contributed.
>>=20
>> Thanks,
>> NeilBrown
>
> Hi,
>
> I have started a patch series for the mmc driver that is currently in
> staging, that makes some of the first cleanups (whitespace, indent,..)
> and also starts to clean up the code, to make the similarities and
> differences to the current mainline code clearer. The series is far
> from being complete, but I think I'm going to send it out today, so
> you can look and comment.
>
> I would suggest that we continue cleaning the code that is currently
> in staging to remove the dead parts and make the diff to the mainline
> code obvious. Do you agree with that proposal or do you suggest a
> different plan?

I think this is an excellent plan - thanks for doing it.
I'll hopefully look over your patches today and send any comments.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrCsTsACgkQOeye3VZi
gbnWZBAAgM+nDheq63eqsAz9aPkevInjx3b4v591NkaKQ7TwjZhonCYMOBZaz9LV
gRQ3i6ybs+muzGOe1BkaRjZDQJ3EP4GJ6jm4d6IUwu0SXNqa0qcyDa3Z/QmeYGb+
0BkGJFqf1jYtsgt5VeLLZdhsoR3GyzwLaWCGxOlwhnbT+8Xm4+97t18AzQjHMmER
vJjY8BnfoaZM9FGosDd/VeFqtaPg91LhHMzdb/AXBP5d/K5vF6HugSIjsLCOwsR4
HxoqM83IehvEozmDIjfSVuqLanaP03VylBDTdFjy4N/ATkUriNOG8M/Bt6ForbWS
JNuWtl7jtOFEkD/5v5rK1x0RfJtt/AOAFnGVKTrH7nrswW407pf//6lU/Wmdb8jN
gADYgnPp/Pz9CkKmLy/yKO9Q3Y+j8v36bhc4mEMrZfcRKL3m6C6oFAhzS2ZJ0Ktg
M6/LgZeExXGiNbeaSCUbg5+8XJqn5jgRN4MWY/YGNx3nH/lqr29ou5GVTLShQub3
ZsJEjMdQmqi0W4P6/ZKkTLh2AdoPos/PYATgfg2Ls8ov7BpTugAKJAkFP7LHBQDz
vKp+wpVXh17Y/OhlhDu6yoyqh/irdGQk+T0tfWF4BaJI1RNIGBaaVPt2J4jHqKlZ
Ac75L70vuGRVYw7B3jsZx7IjOwFFk1FKiz///GUbPSuIC7OYEKg=
=F9Ie
-----END PGP SIGNATURE-----
--=-=-=--

--===============7649931353465849308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============7649931353465849308==--
