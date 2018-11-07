Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4BDC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099BD20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iaW6txQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099BD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeKHEaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:30:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45160 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKHEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:30:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so15582379wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bvz4tB1LNY/gc/mjCYlvIM7t6UGBtFaayf4QdhN8Rjc=;
        b=iaW6txQeDuffTLORs44F6bMvZqmeYv2VJt1/SC6lfHm3rNiQfQR9OUZ1wgImwx3s27
         SzuAkC0hfOrBvsyGiaImclcRYA6jhLLr5dgOCUHJdUnK4s0PWHmPIYgOlI8L18uIXKdW
         ORJUxEuvjt1UVf13QQCQYrjJK5M83ew4FSEBShV+ruM6m7h6MhtxNql5lf7zcbFfBkQB
         38K/3pjjy28McxgsVQ55NIwDolmBsnX9RE8XGGbzzyfREfBcvt/VOOQbHSsauP/70N15
         /OLhJwMaMetps+pkseFGTMLJUjlKubDesi1uOmd6icJyl5GvN5p/gvsA42QtpUHTbd+g
         orjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bvz4tB1LNY/gc/mjCYlvIM7t6UGBtFaayf4QdhN8Rjc=;
        b=XG40Q+Q8KDHhpvASDKeT7n3SzRSsrWSU9iB2FEAv7jOFHw6Qf5uRFqLwkBIgOLddMR
         MNCNz+LV1/bFOBOUgXb3G8wzAOEKDr7XrpiqOTaeX4unHRY9XN/4g+i/PckxoXQQH0Sn
         gzBuXtAI3aLXoVYu/LSE8da+Ipw080s9A5qnJaMPxw1v1qp4Hj6RkQor5NsjimWFhU+R
         ev2taZ6m9mwiAM5ujvmFqGg49QRn9z9tMnGngaDiaHqGPcAR3Wilv2c3dNv3xOwSKsED
         WMVDoUsat0iZ4zkUlgnhAslETj3G+3QTccMRdW6f1YeYMFqXR2nHlmSMY9q3Ai86r8AJ
         ahSA==
X-Gm-Message-State: AGRZ1gJyBRGhEnELDW28jToGO0Db9wABx1RcpXWmBMAP49HnhcZs1TGe
        ur5c81rdNUfLIEEm9dvoHs2Xzg==
X-Google-Smtp-Source: AJdET5cDf8An+6w2imVC3+OY8FKCg0jfbaSZw/s4lOU14UwVgom0NgyFJbOOAQB/RXOV8vC4BGvzmg==
X-Received: by 2002:adf:dcd1:: with SMTP id x17-v6mr1334145wrm.212.1541617123692;
        Wed, 07 Nov 2018 10:58:43 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u8-v6sm1797881wrr.33.2018.11.07.10.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:58:42 -0800 (PST)
Date:   Wed, 7 Nov 2018 19:58:40 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] crypto: crypto_user_stat: convert all stats from u32
 to u64
Message-ID: <20181107185840.GC5133@Red>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
 <1541422274-40060-3-git-send-email-clabbe@baylibre.com>
 <20181106014242.GD28490@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106014242.GD28490@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:42:42PM -0800, Eric Biggers wrote:
> Hi Corentin,
> 
> On Mon, Nov 05, 2018 at 12:51:11PM +0000, Corentin Labbe wrote:
> > All the 32-bit fields need to be 64-bit.  In some cases, UINT32_MAX crypto
> > operations can be done in seconds.
> > 
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  crypto/algapi.c                 |  10 +--
> >  crypto/crypto_user_stat.c       | 114 +++++++++++++++-----------------
> >  include/crypto/acompress.h      |   8 +--
> >  include/crypto/aead.h           |   8 +--
> >  include/crypto/akcipher.h       |  16 ++---
> >  include/crypto/hash.h           |   6 +-
> >  include/crypto/kpp.h            |  12 ++--
> >  include/crypto/rng.h            |   8 +--
> >  include/crypto/skcipher.h       |   8 +--
> >  include/linux/crypto.h          |  46 ++++++-------
> >  include/uapi/linux/cryptouser.h |  38 +++++------
> >  11 files changed, 133 insertions(+), 141 deletions(-)
> > 
> > diff --git a/crypto/algapi.c b/crypto/algapi.c
> > index f5396c88e8cd..42fe316f80ee 100644
> > --- a/crypto/algapi.c
> > +++ b/crypto/algapi.c
> > @@ -259,13 +259,13 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
> >  	list_add(&larval->alg.cra_list, &crypto_alg_list);
> >  
> >  #ifdef CONFIG_CRYPTO_STATS
> > -	atomic_set(&alg->encrypt_cnt, 0);
> > -	atomic_set(&alg->decrypt_cnt, 0);
> > +	atomic64_set(&alg->encrypt_cnt, 0);
> > +	atomic64_set(&alg->decrypt_cnt, 0);
> >  	atomic64_set(&alg->encrypt_tlen, 0);
> >  	atomic64_set(&alg->decrypt_tlen, 0);
> > -	atomic_set(&alg->verify_cnt, 0);
> > -	atomic_set(&alg->cipher_err_cnt, 0);
> > -	atomic_set(&alg->sign_cnt, 0);
> > +	atomic64_set(&alg->verify_cnt, 0);
> > +	atomic64_set(&alg->cipher_err_cnt, 0);
> > +	atomic64_set(&alg->sign_cnt, 0);
> >  #endif
> >  
> >  out:
> > diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
> > index a6fb2e6f618d..352569f378a0 100644
> > --- a/crypto/crypto_user_stat.c
> > +++ b/crypto/crypto_user_stat.c
> > @@ -35,22 +35,21 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> >  	struct crypto_stat raead;
> >  	u64 v64;
> > -	u32 v32;
> >  
> >  	memset(&raead, 0, sizeof(raead));
> >  
> >  	strscpy(raead.type, "aead", sizeof(raead.type));
> >  
> > -	v32 = atomic_read(&alg->encrypt_cnt);
> > -	raead.stat_encrypt_cnt = v32;
> > +	v64 = atomic64_read(&alg->encrypt_cnt);
> > +	raead.stat_encrypt_cnt = v64;
> >  	v64 = atomic64_read(&alg->encrypt_tlen);
> >  	raead.stat_encrypt_tlen = v64;
> > -	v32 = atomic_read(&alg->decrypt_cnt);
> > -	raead.stat_decrypt_cnt = v32;
> > +	v64 = atomic64_read(&alg->decrypt_cnt);
> > +	raead.stat_decrypt_cnt = v64;
> >  	v64 = atomic64_read(&alg->decrypt_tlen);
> >  	raead.stat_decrypt_tlen = v64;
> > -	v32 = atomic_read(&alg->aead_err_cnt);
> > -	raead.stat_aead_err_cnt = v32;
> > +	v64 = atomic64_read(&alg->aead_err_cnt);
> > +	raead.stat_aead_err_cnt = v64;
> >  
> >  	return nla_put(skb, CRYPTOCFGA_STAT_AEAD, sizeof(raead), &raead);
> >  }
> 
> Why not assign the result of atomic64_read() directly?
> I don't see the point of the 'v64' variable.
> 

Yes it will be more compact and easier to read

Thanks
