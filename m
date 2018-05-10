Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525982232-2-10636802253430829017
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525982232; b=WW90tx1S0nn/tn1jVDonxmK7x5/YU3VwlwhIoPycp1zao66Z4R
    eg1saQ3zJNvWCukBjRq3i2POwXFZAN3iPF6fWuGlsAiABqn1Cqd77K+BlwZZv51b
    Roc6+48ORRtmButglnAgxKRnbh5RUO9lNyZtTHDjDd6grPYPHGctI1iaeax3Sb2h
    fzWFPlkL1aUhFMJ5SOH+FS431ZlWoz55VNXcD1jWuSMzUaCjI9/TloiMvPu1wAQ4
    JLFtCa7zsmJxS1F0HKf94PZbadQiNl8UeqD/bO+U9EP0H+r2NaC7GBR2+zZ3B/fY
    02/pKAm2LJyKqt6GBN4qv0LRGLpTugR4xNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:in-reply-to:references
    :date:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1525982232; bh=NW8x6pS0rULilISe73l0SN7oSSTCWR5
    1JqwPfpNhAu0=; b=Nit7G/vFgf5amqU794O7OK587TBAtqzpnJbcGeuDC6JGXK+
    3QMA7zjmIOygrv7hwflGy35qBIJK7OaXE3iJ54AEtd5bbPn9SpV8XRxqUMDLZftL
    mkJpPlIAVIMf0zpVfmjOCawem7Kv/wQ01LdxTnTw+Q7Fm5DXkQAeR1uMsZRC2Da0
    ZrI1r/LaCW5T0aKXMHXp4kgiQHrB9k6p3R5Ec0J1VEyQOxgEFy0sKa1INNMmL7g6
    5JMfMUNRhjMleC735wpJ/nIvq5sQXDFtojFdpPStGVQnD4l6ujK1HSpTWNYu/UyQ
    YXWFQi/FFo1b/6vBfG+yIcBMkbdtn3AdsLPR7dA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKB9wt+yTOBXg6JFK2mY+O7jurZNAXsnSVxuOmHjhSqbAZu0avCCQoTPXQDEL0IWAgpIZxWZ+eBF6x9G00UjhNurLoYE9k8tb5RTjjLPadOKwrYpHyJX
    PWP+JcSjx+kU3tensznIcvgk03TdGaoSP+CqshfvAO1oK1kPydIETF1sa2JGpZkgfzCk5Da2m6ilW+ByrNY+gGqGtgxfyXRwZBHmRIl/UeUfThrhgGsxjmGG
    Ckn6FYhgvBpqpomeqiNodg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=WFZIRff2AAAA:8 a=7qjWgnA1FRto4hN5v6sA:9
    a=AbjndW9IWkAA:10 a=OdbH6I1jLpq_7o6oGYIA:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 12/12] staging: bcm2835-camera: Fix identation of tables
In-Reply-To: <20180510194220.30675-13-eric@anholt.net>
References: <20180510194220.30675-1-eric@anholt.net>
 <20180510194220.30675-13-eric@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2
 (x86_64-pc-linux-gnu)
Date: Thu, 10 May 2018 12:57:01 -0700
Message-ID: <87efij708i.fsf@anholt.net>
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
Cc: Dave Stevenson <dave.stevenson@raspberrypi.org>
Content-Type: multipart/mixed; boundary="===============1510677299322028523=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============1510677299322028523==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
>
> As requested by Mauro Carvalho Chehab in review.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Ignore this one, the other 12/12 is just this with "identation" spelled
right.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlr0pA0ACgkQtdYpNtH8
nug1MBAAiTXdV64VKQfkiUreiNXviNnEUFWtFb79uaI/cd8F+w2eapuLEC+dsudO
1525CttzVnSYlLApOiEubSYh+ga4hzoXAq7lYy6HBk2PkQq2HJPWNlzkBNpGEThL
ZD5H0McRiyPI1GJ5icfVkuvAlaJH48/G6cRbtbuHA9gUJIvIjxP5FjVCgU+ei3Ik
BFM4WkUlO67OFmf3/Ul7L02mba66yj7SOjly4ZuUc4p8BrhRvvlDJPyS2hWk7JOH
ktXZCJ9kqlX5wy7Ma5UlzTLZo4RUpKe4b+sVLVpto5YRzLaF73+Jl15SnFhqHUh+
qblWufIt2vB0L6AqV3CewbtZcum0ATd+rDee0tiemoZ7KD7x42/IkuDSebAIMNGC
Gde98j1YO1MUqGtMHO97XvmsozqzxMzZNK8RPg/2aWC3kmQcW/zgQO8+231y9NMt
sCNsvjneLZqB9WI4KpzJJBBH1ztc6smSmMeERjTSnHCacOk5+fmZRkPDiVv3iM4e
sQAZT44k++lHweaMWFDLeeclEPRNlbl7F1sPxvsnlk/x6v2QBAcXh4w079CyUwMx
6gih67Y8uVbgcWvAp3yZCmUmIXrCwzErUjUMQ7v9g1XNjebigeCz6aZyyav1Lld3
doo8b8740uFlO5q0BI/SpWVFrE7cCXlIcS8BWM/ZKyFzgpqCA4s=
=DPO9
-----END PGP SIGNATURE-----
--=-=-=--

--===============1510677299322028523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1510677299322028523==--
