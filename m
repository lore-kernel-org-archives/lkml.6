Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AG47ELt37SaLlAjtAAaStbXQAVnwPc7iXNld8PsUiumkL1gzcnQlQBmDgzE9Uji+f4jq7a02SVCy
ARC-Seal: i=1; a=rsa-sha256; t=1521632832; cv=none;
        d=google.com; s=arc-20160816;
        b=Zo1ZLcDhRT/3OLgbFcZiTDL8G4jHyiLDRfhpfHFJndGyHuM8dEEPEzlsyMZJgwVHAq
         dsGKh5TIWUN8nToz8ALRbHFeIscIFp0WLBOkqp7KePrgJeS/CybmNq9PqJsSWZ2JjXQJ
         oimhurttbUp6wTBSW+eDp6ynKLapLg+IEWWgezpnVAX8eAjGdnX8DXbOQJeSrTTYS5qN
         fNvGi8wjLydHKf8N9w8Ks+9KUACHjd+8pnVmT4rBJwarlZVk6jxavtwCTXLyjEyQVQn8
         YdZWKNJP+acHlyiTKWG60/QoOwqObAfUp4PqcU8Ya3rNoVGKg+VDKpRhea3rdnmSnDCV
         TCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=42tiAbZ3wfgkykPIgaLMCVRH0MQbuGel8bxxsybUj3U=;
        b=jyITo1M67Umknqk89/tS3yYrExLj8gs1hH7eWZWiSF0U7+L3JDIrrvY5f932am2qzI
         /hIzIoNkkRRzBSJz9+HMTeFoAreLQO9WBeND2DYyreQCzyNBjV7r4aLWSoTPrKMgAKSf
         1M/CM9hMYMnHnVsQ1ZQKH6NR1HX6JCTpyCGb3qCKPnO+5Tsz8mtiBRPzafTJqF45Vvu7
         XSU0eKkxyjXkIAmY9aS9Z/C+y+UcyO90iiUgxg5PAc/t2C8mmjRxoIj6RVyDEJf6SNGi
         9yLTNjaq/sj/6C2/d88EENMLP71bMOeiXA86bCiCfjNA0nZTok54NfQD0zLm+cc2sImr
         J+QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.192 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.192 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: "'hariprasath.elango@gmail.com'" <hariprasath.elango@gmail.com>,
	"ruxandra.radulescu@nxp.com" <ruxandra.radulescu@nxp.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "gehariprasath@gmail.com" <gehariprasath@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH] staging: fsl-dpaa2: replace simple switch case by if
 statement
Thread-Topic: [PATCH] staging: fsl-dpaa2: replace simple switch case by if
 statement
Thread-Index: AQHTwQY99HFy4WEVM0a+/SD9vn9jDqPakoWQ
Date: Wed, 21 Mar 2018 11:48:08 +0000
Message-ID: <faa92f0e20fc44019ee0b64b04413d69@AcuMS.aculab.com>
References: <20180321111604.9902-1-hariprasath.elango@gmail.com>
In-Reply-To: <20180321111604.9902-1-hariprasath.elango@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595545752605466743?=
X-GMAIL-MSGID: =?utf-8?q?1595547669004458074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: > hariprasath.elango@gmail.com
> Sent: 21 March 2018 11:16
> From: HariPrasath Elango <hariprasath.elango@gmail.com>
>=20
> Replace a couple of simple switch cases by if condition

Why?
In principle extra 'case' might be needed in the future.

...
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers=
/staging/fsl-
> dpaa2/ethernet/dpaa2-ethtool.c
> index 070a3f2..fb517cb 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
> @@ -171,8 +171,7 @@ static void dpaa2_eth_get_strings(struct net_device *=
netdev, u32 stringset,
>  	u8 *p =3D data;
>  	int i;
>=20
> -	switch (stringset) {
> -	case ETH_SS_STATS:
> +	if (stringset =3D=3D ETH_SS_STATS) {
>  		for (i =3D 0; i < DPAA2_ETH_NUM_STATS; i++) {
>  			strlcpy(p, dpaa2_ethtool_stats[i], ETH_GSTRING_LEN);
>  			p +=3D ETH_GSTRING_LEN;
> @@ -181,18 +180,16 @@ static void dpaa2_eth_get_strings(struct net_device=
 *netdev, u32 stringset,
>  			strlcpy(p, dpaa2_ethtool_extras[i], ETH_GSTRING_LEN);
>  			p +=3D ETH_GSTRING_LEN;
>  		}
> -		break;
>  	}
>  }
...

	David
