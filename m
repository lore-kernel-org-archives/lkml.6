Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2440679-1521584813-2-3154466837170814213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521584813; b=im6ix1VjvbeirtHqo6flnVnIL+gIUaGTbNHeOSmeWicBoFk
    /bJ37KjTcq2x6hgIs4X165IhmxaTY886HpJHeoLaA6p2nVUmYT/j/vt+ktqFdG8J
    fC6l9IOSR7vOm6vxYflyy8D9j2oe6Hcl7mVlbxfAGaCdrt+vY0wgQQm2+AY9fO1e
    8CytJlmaMD2GTFAwyaDLRcpuS3rdfdxxpUWPBxqqKfFDt4yYLF8zviHCRYDwdPVg
    kMxzZomV50/pkhOVokXhbBNW2WlKIYUC9uDgc/kUfVip2QFCkyHAGOtpILr5MRsM
    oOuvxkwwS7g3G0uGwd+Dy0Tuo/EqBSIf77FGwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1521584813; bh=pdpMWKVTzj38p6/9ozySrmqvuVT
    WFbqZ10jhTPHevG8=; b=Uq2Rx8bFWY5iCPvBmsCmpKanR0dNwuLxem5OMiVBjLu
    fPy2q/qDhOc6lLtjZzRAyqdtx3w6AY2cdY/8KeROtyeecC993wCQ948hUE3jiH/j
    8aMIwDvtJQGcMpYDbgTfQPxxFA1S+imvhLIuO2W9OMKevALYJbHach2RzQPKcNME
    IARkek9BjHVSo79CfWIb2eXt3HiWwAm1IO25Na6b4wcnw03+PITY2T4Kc840UzEc
    dX6T7cs0cKcuApPSxl+CypEU9XecLxeyEaXAsRH6dE300HFcnA0MOfPjIAXzAS6A
    YpFH7uEQzT3X0KRybMvu7Sfikg2wbXnXlkSv5e1E3jA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=brown.name header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: hariprasath.elango@gmail.com, blogic@openwrt.org,
 gregkh@linuxfoundation.org
Date: Wed, 21 Mar 2018 09:26:33 +1100
Subject: Re: [PATCH] staging: mt7621-gpio: remove redundant owner assignments
 of drivers
In-Reply-To: <20180320074558.7851-1-hariprasath.elango@gmail.com>
References: <20180320074558.7851-1-hariprasath.elango@gmail.com>
Message-ID: <87d0zy8jty.fsf@notabene.neil.brown.name>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 HariPrasath Elango <hariprasath.elango@gmail.com>
Content-Type: multipart/mixed; boundary="===============0454499809870187429=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============0454499809870187429==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20 2018, hariprasath.elango@gmail.com wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
>
> Remove the reduntant owner initialization from this platform driver as
> the platform_driver_register() takes care of it.
>
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> ---
>  drivers/staging/mt7621-gpio/gpio-mt7621.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-gpio/gpio-mt7621.c b/drivers/staging/=
mt7621-gpio/gpio-mt7621.c
> index 5c57abe..830d429 100644
> --- a/drivers/staging/mt7621-gpio/gpio-mt7621.c
> +++ b/drivers/staging/mt7621-gpio/gpio-mt7621.c
> @@ -339,7 +339,6 @@ static struct platform_driver mediatek_gpio_driver =
=3D {
>  	.probe =3D mediatek_gpio_probe,
>  	.driver =3D {
>  		.name =3D "mt7621_gpio",
> -		.owner =3D THIS_MODULE,
>  		.of_match_table =3D mediatek_gpio_match,
>  	},
>  };
> --=20
> 2.10.0.GIT

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqxipkACgkQOeye3VZi
gbnClxAAmctzovi5++15bv1g90IeyuNY4EnTLqpM2yfTwPRvTqID9lkvn52zWQV5
F/6EbMYYQCTugyBkK5GJ7/9TFva1QI1NS3FSraPw3RFwWXe2ouoI1A1DAddJRFGL
iF8l2Yn6MA/5NgzsTE9ubHev85a40HFqKDuyrpJhvCBqjQgswYmsySoBaoj+WApo
FNPsCt9AtviGd1bNOFShk/TzzXPy5P4QE/7A6ZupeS49fSz0YGkD4trerY0kqUtq
MRStE+yKFildzm40hts9YdqHYICTG29jHb8bz95eJFABOIauJwd+feVmiR+RNahl
4gh5es+J8TL3Pk009+XJVggzOI6mCTD+kCcbpgcyRMbtdZrNDLVUTRbDs6ux01FM
rx2ivzEuJl3N23IV1Ets8pYlqMyAXammMSokEoHVNATgDKgYmRdoM7wnFsyTU+OU
uyTHgQkAWKEUGAqhMK1Omyjyekcj46NTJScgJotsi1Lz4rWGSfQ5dXrpmAOx4BK+
bjM3MzIPwngwDehouynt8x9WJI72ftOYzbBQXM7OBD1GBEN9i/uq44VFIIuvWKQV
+fNPwJPBBuBlRp0PkJQJEf3WYFi4kVUrOwvufFvtTU7cGFFi7j97sUN910WyXBvR
Bx5eOEuBmyya7I4J/WTFsK7H+OyoK89y9YVAOFXsvBXjF89t15M=
=f3O9
-----END PGP SIGNATURE-----
--=-=-=--

--===============0454499809870187429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============0454499809870187429==--
