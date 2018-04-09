Return-Path: <kernel-hardening-return-12929-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49lmzLEgfPWVIWk/u/nS5TmW6/x3ENPxO3Mk1mDsTa3jud1THKSjZhweKr2g95g4YxsLnVv
ARC-Seal: i=1; a=rsa-sha256; t=1523284515; cv=none;
        d=google.com; s=arc-20160816;
        b=Nud8s89WfrUhUcs73KY6K8XAO8z/3+B9Ln9SZyaqXYyJAqaVOh0a2Q4Vq0y/NSSqnQ
         vroVGxlRuEi0x21t5myQ9HYRgO8oJ8mA+5VkNY2G/RKgEHVY9WCHRKbP/s6XXVlRGSvf
         TRt40sZYmTTD+xQ6CexmeCg2covOrSEttwoOI2CiSfAZY/2SNyPJT42okS9QzYnYBw8x
         W7uCg0KYIc3bpfSz2uUJ/cjH80U/Fj7XL//dYhQHu0hL4F9QWFvsK7g7C7s2WQzMUCaQ
         GMbx/KDwAeQFYJrWv8tACnruDfFHnNFf2Qimt6JBt5SOF5IaibiJ+ApMsdKuu0Z/vH/W
         mhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=pzqkt9yVTAvIeYEAVZEWRJ7fKB3V7tCAQNb5zePAe1Y=;
        b=oQoIURwwGf03h0M2GxNSpXesiW8Rr56WKuAEdcltCvFD0ZAye288CSvihpX1Pi93S9
         7tOYEcM31FHpjJWBDzyuWG2qXKMb4MT5iRtYGWG9Jy9S1tW9wxFL0GAuctvRILR3NSgK
         69Od/d6VaTLjXOMavbYL5X6EDkdfetaHqp1KoxEqtR9XuZWzku1LWm/E3/txtMCc3gOm
         37ci2hXG/hyGtUe8BcCREvpoZj+IasE/HW94y6UWIEdx5WWzUtbrmFA2gMaLpSCPSzH+
         goWbkVUmXnwaPTv84uyuOPc4ziW1lixv6iQLVXNheMYCJxEFSnA9Bi+0rt4XxgU/9uk6
         lXsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12929-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12929-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12929-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12929-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Salvatore Mesoraca' <s.mesoraca16@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kernel-hardening@lists.openwall.com"
	<kernel-hardening@lists.openwall.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Subject: RE: [PATCH v2 0/2] crypto: removing various VLAs
Thread-Topic: [PATCH v2 0/2] crypto: removing various VLAs
Thread-Index: AQHT0AqPFLFjzadDvEuYJrE7teT3QaP4fQXg
Date: Mon, 9 Apr 2018 14:35:50 +0000
Message-ID: <ca31b95a8b8e4dab90c5ea2eb6e6477f@AcuMS.aculab.com>
References: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
In-Reply-To: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1597277119052489301?=
X-GMAIL-MSGID: =?utf-8?q?1597279584134849639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Salvatore Mesoraca
> Sent: 09 April 2018 14:55
>=20
> v2:
> 	As suggested by Herbert Xu, the blocksize and alignmask checks
> 	have been moved to crypto_check_alg.
> 	So, now, all the other separate checks are not necessary.
> 	Also, the defines have been moved to include/crypto/algapi.h.
>=20
> v1:
> 	As suggested by Laura Abbott[1], I'm resending my patch with
> 	MAX_BLOCKSIZE and MAX_ALIGNMASK defined in an header, so they
> 	can be used in other places.
> 	I took this opportunity to deal with some other VLAs not
> 	handled in the old patch.

If the constants are visible they need better names.
Maybe CRYPTO_MAX_xxx.

You can also do much better than allocating MAX_BLOCKSIZE + MAX_ALIGNMASK
bytes by requesting 'long' aligned on-stack memory.
The easiest way is to define a union like:

union crypto_tmp {
	u8 buf[CRYPTO_MAX_TMP_BUF];
	long buf_align;
};

Then in each function:

	union tmp crypto_tmp;
	u8 *keystream =3D PTR_ALIGN(tmp.buf, alignmask + 1);

I think CRYPTO_MAX_TMP_BUF needs to be MAX_BLOCKSIZE + MAX_ALIGNMASK - size=
of (long).

	David
