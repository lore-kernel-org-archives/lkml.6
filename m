Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AH8x224b6Oj8eTEiv0ohR2iAMugkVIXiE0xOrhIFsiujmpJM89Q9auAF3WFrelDFAQRcQIcqHUUe
ARC-Seal: i=1; a=rsa-sha256; t=1518684552; cv=none;
        d=google.com; s=arc-20160816;
        b=rvJ7Nn3RvyyhTTQAZjPSXCaOZ7BX7fIkDQAECRyDhs8Wm49rurkSXP28PzwYMFvG1d
         tBIxtjkXOUlVOpxgkfh8PObcjAclp9Cy+1G1AMzy9UkC2cXFjEaLg6UDiB/iSdcYUfdQ
         Vt4v1x4dhbx/xtTMzSOHERvzUdGrm+0fjmEGE2A/GL3FrQLocvOrmDNaz07pgtqcttVI
         hlKnc3vSl1Cx4qYhn2HOVtcgOvTLCwuk/VzY2VV7b2wwp2Cyjb7dGfvs3jtxAsFXPzr/
         VcUZO7HBGxkkEpwVy7Ema+PnBtymwMoWbLElsquwz+b8TfFhtS0zaMww2/LdV+4mSakL
         eTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=i7NBuz1LuOwRrpNkp6CFS9TO8In8vWhpWbESvqTvKEI=;
        b=aRwbYEFEAoPN2L2wuW0baagAp6eiiLUMkaqvVewOG3jQCnIZXC+QNha+eI150opRmQ
         kAuaxyozSZV+8b8Yip7SCqQqP4Xe5E3ymXieEeOv+XlWh3j86qpG887ipzYK7ddvsmY+
         OW8pPd/eH+cow6obRm3ebGYe9yOBigF2l7XmUctr9NlVZ9ZsmMOpgwTtTiM+lT9j3Mth
         JQ99PBJIsFH32xTpQhgBwev/o91r3QNZVCr/+iXhaT+/ukgugO3qg8kNtf1lZtaS4vIJ
         vjhK3o9ZeX5vrkQGz18xgdAvt8IFeZJBLZvvhZ/LUYNOrsz4s3AsaEyq6pDarc9pBRJQ
         oCHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Thu, 15 Feb 2018 16:48:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lionel Debieve <lionel.debieve@st.com>
Cc: Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>,
	Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH 0/5] hwrng: stm32 - Improvement for stm32-rng
Message-ID: <20180215084855.GB5577@gondor.apana.org.au>
References: <20180129170521.1862-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129170521.1862-1-lionel.debieve@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590947307203068801?=
X-GMAIL-MSGID: =?utf-8?q?1592456173365975236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 29, 2018 at 06:05:16PM +0100, Lionel Debieve wrote:
> This set of patches add extended functionalities for stm32 rng
> driver.
> Patch #1 includes a reset during probe to avoid any error status
> which can occur during bootup process and keep safe rng integrity.
> 
> Patch #3 adds a new property to manage the clock error detection
> feature which can be disabled on specific target.
> 
> Patch #5 rework the timeout calculation for read value that was
> previously defined based on loop operation and is now based on
> timer.
> 
> Lionel Debieve (5):
>   hwrng: stm32 - add reset during probe
>   dt-bindings: rng: add reset node for stm32
>   hwrng: stm32 - allow disable clock error detection
>   dt-bindings: rng: add clock detection error for stm32
>   hwrng: stm32 - rework read timeout calculation
> 
>  .../devicetree/bindings/rng/st,stm32-rng.txt       |  4 ++
>  drivers/char/hw_random/stm32-rng.c                 | 44 ++++++++++++++--------
>  2 files changed, 32 insertions(+), 16 deletions(-)

I never received patch 5.

Which trees are patch 2 and 4 meant to go through?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
