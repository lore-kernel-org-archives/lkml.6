Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710301-2-7182714724114950146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710300; b=hiSaiC6FrzOObnN3f0Pk546G40YeGiDn2qcK/K9/E8XTFV9
    GW8ZwNYxvGFFKYbfX8Jqmp5+KkdknFi1E7U/yX6gTWJmtENWsOXQA3xTU4v77H1h
    JwVLQ/ad5z3lEINSuNFDpa6xE3GLmadfPYbh1QR6TPg2mdiqk5T6Ao8DmmzwZx+b
    HX7/XRPAHUSMAynRdAh6dgGwPNdzIiEvEpSqFMKNT+WhxY9DjvkTq25RWx4m3uJ9
    VUCR27K7Y/kU4w/LXgRBeBw3ajGhuJFkvgdaNPIwFYwpdeQyRU2RM5IEDbFK6vEW
    5sbjTwF0ge8Iv8WHglCuM6ttt132wTETxsuEBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518710300; bh=p
    IFhRkFZ/D7ISjtYWvxAd9mKAghR8C5wZPjFc16JZ+0=; b=JrlriflEUTaqONUA8
    VR19DSMvPSbHvIMO7ZQvXpHpAEtMy9CrEbT8EgJJpMoxeczq7rFCbJRE6nM3uNE7
    2sXkHN8nNJ4ediRFmSjbR4qcOwHpaBo1vZhCW/UM6IxBSv+SUIPXVK8IWA++NdLk
    rMXbPRcT9gM4uTuvycv0z6zfLYPK4Z/Uxip2zSiKXw3Y0GNl1YZ4A8Vz2jNlGSLq
    rz9TM8AgKKbIiIiqG68l2G6F+87m1nAPtTfbC8sJ+/XIGmEJhDGKNQASeKCJaghf
    dF4B3R2FgrVNrD4hX23aPhYX6C802sywNLp6Uk2wDVIQBwi/644/FXpk+mOk8f9C
    vT0qA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Feb 2018 23:41:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: [PATCH v2 0/7] crypto: ccree: Introduce Arm TrustZone CryptoCell
Message-ID: <20180215154150.GB7352@gondor.apana.org.au>
References: <1516613230-4524-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516613230-4524-1-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Ofir Drang <ofir.drang@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 22, 2018 at 09:26:58AM +0000, Gilad Ben-Yossef wrote:
> Arm TrustZone CryptoCell is a security hardware IP that
> includes support for hardware based hash, digest, cipher
> and AEAD operations. This driver provides support for
> these as part of the Linux Crypto sub-system.
> 
> The driver spent some time now in the staging tree being
> cleaned up and is now submitted for review for the
> purpose of moving into the crypto tree. The first patch
> therefore renames its copy in the staging directory
> Kconfig define and marks it broken, otherwise there is a
> build failure due to global symbols collisions.
> 
> Please note that the driver include stubs for yet
> unexposed functionality (ivgen and secure HW keys),
> which will be added later.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> 
> Changes from v1:
> - Use KConfig directive to stop staging tree version to not
>   collide during link time as opposed to deleting it as indicated
>   by Greg KH.
> - Switched from legacy ablkcipher to skcipher interface as
>   indicated by Corentin Labbe.
> - Removed unused zero_buff struct as indicated by Corentin Labbe.
> - Moved to kzfree for all IV/key buffers as indicated by
>   Corentin Labbe.
> - Moved to using __des3_ede_setkey() in lieu of home grown
>   version as indicated by Stephan Mueller.
> - Fixed multiple small coding style from Dan Carpenter and others.
> - Fixed pointer signedness sparse warnings as indicated by Jeremy
>   Sowden.
> - Rename all registered algs driver name to -ccree prefix
> 
> Gilad Ben-Yossef (7):
>   staging: ccree: rename staging ver and mark as broken
>   crypto: ccree: introduce CryptoCell driver
>   crypto: ccree: add skcipher support
>   crypto: ccree: add ahash support
>   crypto: ccree: add AEAD support
>   crypto: ccree: add FIPS support
>   MAINTAINERS: update ccree entry

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
