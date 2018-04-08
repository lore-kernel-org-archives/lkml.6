Return-Path: <kernel-hardening-return-12893-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/uzZbm8O1rAZlKIyhFz2J4qZv+3dSeILWoKk36GJ454e/N+9gaVj0xWEaPHY2zCg9iSvsq
ARC-Seal: i=1; a=rsa-sha256; t=1523179132; cv=none;
        d=google.com; s=arc-20160816;
        b=L2oNA8aKh0HOi/8G1SoMxihhGkoXMSWp8n1g7MX0qmlXiH2d2NcOCqi1Pha7UIgFPY
         LHo1PXgarSeJAltvjCvRZ0du2f2egWMq6x4fqHugoTc8DEf+Hal7xRbbZ/G7JxO8WNlC
         05MRoOSlKqtGECWT6+yz4ElU5WegSx8FnaYvFoCefYYzFpT0pcoMD3yNlJKLslngCwze
         AbBXEdsaRo1HA1aRqfuprr+uvuPbL2L8pq30KEWDo5sAB0opnEVW4rcAylQDiv1dxmPZ
         8XsSx0NcnRx87RZJ5PMfsQ9MGHIcTU4x7LaWzyINcU/vc0+6cMChc9zThy9A30Rcq6i6
         6gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ZrLVurKNzastxVuVnp6meA/ceL68ZcEHstk2CiysyMM=;
        b=so2dNqDzTvS71BWseS1LqHPYPidHfuQpsVvxG7TTfhFs0fZjCrkY32YUiyt/Wi7xEH
         ddCO+H4shJnfw3BeXMp2UHkerPLauk1conAEJwGNoGB2nZqz7Ncu2rkEta7U7ANOBn8r
         4czZRptCA+iQrFUZ2DWl9X9jv5sRC704gRTcr/NGq7mfbLp31xGs6qWYovEN/P/kunYp
         PlOOHB8wJ7STKUPTGk/cFqTpWf5PgXhaTeszVqgHTgtIiEB7Owfa5A5IZy9k+uWbeRG6
         xwZs/xU3l6ObqF6/BEfwkzAe4TbjKwLsF6jg9VRGlAzpp0wM/LAMpk1qwLES8SOgViL5
         +pTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12893-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12893-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12893-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12893-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 8 Apr 2018 17:18:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 2/6] crypto: ctr - avoid VLA use
Message-ID: <20180408091823.4m6xw477ly6yfnzt@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-3-git-send-email-s.mesoraca16@gmail.com>
 <20180408031935.GC25197@gondor.apana.org.au>
 <CAJHCu1LQuvcxsfTYddN5o3=pMzj6mtnBKvTG9O378pv3w_Q24Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHCu1LQuvcxsfTYddN5o3=pMzj6mtnBKvTG9O378pv3w_Q24Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113761628441569?=
X-GMAIL-MSGID: =?utf-8?q?1597169081610863412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 10:58:48AM +0200, Salvatore Mesoraca wrote:
>
> Fair enough.
> After removing the individual checks the modification to the single files
> will be just a couple of lines, is it OK for you if I collapse all of them in
> just a single commit?

Sure.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
