Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03852C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEDC2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uQrwD7lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEDC2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeKHEo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:44:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38441 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKHEoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:44:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so18613296wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p5Lw+4jChNndEjetsb1d1aMcOGAqFHMxBB+/5N3ESBM=;
        b=uQrwD7lGFHOoX2HWT9Y2R+0K/5iKTYGImuLTnA6brJgu6jgzvulW+eQhCVpQVC1Q13
         gZh1nGIj5sndZDumu2ybDUEKAN6StmdvhLClDYHxvaYYioQ8ByjogNRVHNLBuE9HGxr7
         RKzA106a0gBFFFbg+TgG1ekCGF9bVjCno0cmBmrfUELBR08oKZvBrfAl0OL14ItsDLoc
         k5QM4lwwH5PNoNFskrTJJJ8aPeP3+GR9SPP8UB/CMZjaXMM3RXXR6ye+fUZK9tjFe+4o
         nL+YmkJupfdShFPbTcPUpfisDuYgSHGj1GZjlGmb0XVJzqAyKR7D333GWP1huuIi6U37
         i7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p5Lw+4jChNndEjetsb1d1aMcOGAqFHMxBB+/5N3ESBM=;
        b=owAgYRGgrnXf6UBSZYfN3lxr9099hw2gHEPh8G6z5pQuX+gjtYYLqTvRWXvV8e7Itt
         UjwWYlfcHW4NCvbYNCihvkS943fM/gKLXyjtSlzZwFJ9s9mMSrDHE0bp5xFSz3JcR+eT
         natgW1j9hFf10ImGFulxN3rhmYfeXVpeGz9y2EOn4YMCv5yzh+ENEWiCgNrFL3j3LkCa
         HGa5DEczGosy9+CeZ0eqxdS6m3k/IsVLvge8EEBtd01/w1Rz/4gATk8tQIYs1w8C2VXl
         R5S64mLdMmKg23X+UfSMzQiiAB4GV8xaSnqgBDe1z0NJSqqnUYRWnQ/6HLljgHM4ktHW
         HkWA==
X-Gm-Message-State: AGRZ1gJTtOkvsetASgVzoHrml68ybg4mC0EKm7HwxKyeEEtC6vTNkrnp
        0++aDcAcbwy21f/zShgChyC/pg==
X-Google-Smtp-Source: AJdET5fTPUotZb2tiVw0vsZ3O7Lp1jmeK8CMkEkY7RJA88P8BmloEbJYTWbp2a4cKzeflhECBNxNkQ==
X-Received: by 2002:adf:c7d1:: with SMTP id y17-v6mr1377153wrg.230.1541617991609;
        Wed, 07 Nov 2018 11:13:11 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm747167wrv.93.2018.11.07.11.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:13:10 -0800 (PST)
Date:   Wed, 7 Nov 2018 20:13:08 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] crypto: crypto_user_stat: split user space crypto
 stat structures
Message-ID: <20181107191308.GD5133@Red>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
 <1541422274-40060-4-git-send-email-clabbe@baylibre.com>
 <20181106014419.GE28490@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106014419.GE28490@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:44:19PM -0800, Eric Biggers wrote:
> Hi Corentin,
> 
> On Mon, Nov 05, 2018 at 12:51:12PM +0000, Corentin Labbe wrote:
> > It is cleaner to have each stat in their own structures.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  crypto/crypto_user_stat.c       |  20 +++----
> >  include/uapi/linux/cryptouser.h | 101 ++++++++++++++++++++------------
> >  2 files changed, 73 insertions(+), 48 deletions(-)
> > 
> > diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
> > index 352569f378a0..3c14be2f7a1b 100644
> > --- a/crypto/crypto_user_stat.c
> > +++ b/crypto/crypto_user_stat.c
> > @@ -33,7 +33,7 @@ struct crypto_dump_info {
> >  
> >  static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat raead;
> > +	struct crypto_stat_aead raead;
> >  	u64 v64;
> >  
> >  	memset(&raead, 0, sizeof(raead));
> > @@ -56,7 +56,7 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rcipher;
> > +	struct crypto_stat_cipher rcipher;
> >  	u64 v64;
> >  
> >  	memset(&rcipher, 0, sizeof(rcipher));
> > @@ -79,7 +79,7 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rcomp;
> > +	struct crypto_stat_compress rcomp;
> >  	u64 v64;
> >  
> >  	memset(&rcomp, 0, sizeof(rcomp));
> > @@ -101,7 +101,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat racomp;
> > +	struct crypto_stat_compress racomp;
> >  	u64 v64;
> >  
> >  	memset(&racomp, 0, sizeof(racomp));
> > @@ -123,7 +123,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rakcipher;
> > +	struct crypto_stat_akcipher rakcipher;
> >  	u64 v64;
> >  
> >  	memset(&rakcipher, 0, sizeof(rakcipher));
> > @@ -150,7 +150,7 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rkpp;
> > +	struct crypto_stat_kpp rkpp;
> >  	u64 v;
> >  
> >  	memset(&rkpp, 0, sizeof(rkpp));
> > @@ -171,7 +171,7 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rhash;
> > +	struct crypto_stat_hash rhash;
> >  	u64 v64;
> >  
> >  	memset(&rhash, 0, sizeof(rhash));
> > @@ -190,7 +190,7 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rhash;
> > +	struct crypto_stat_hash rhash;
> >  	u64 v64;
> >  
> >  	memset(&rhash, 0, sizeof(rhash));
> > @@ -209,7 +209,7 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
> >  {
> > -	struct crypto_stat rrng;
> > +	struct crypto_stat_rng rrng;
> >  	u64 v64;
> >  
> >  	memset(&rrng, 0, sizeof(rrng));
> > @@ -248,7 +248,7 @@ static int crypto_reportstat_one(struct crypto_alg *alg,
> >  	if (nla_put_u32(skb, CRYPTOCFGA_PRIORITY_VAL, alg->cra_priority))
> >  		goto nla_put_failure;
> >  	if (alg->cra_flags & CRYPTO_ALG_LARVAL) {
> > -		struct crypto_stat rl;
> > +		struct crypto_stat_larval rl;
> >  
> >  		memset(&rl, 0, sizeof(rl));
> >  		strscpy(rl.type, "larval", sizeof(rl.type));
> > diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
> > index 9f8187077ce4..790b5c6511e5 100644
> > --- a/include/uapi/linux/cryptouser.h
> > +++ b/include/uapi/linux/cryptouser.h
> > @@ -76,47 +76,72 @@ struct crypto_user_alg {
> >  	__u32 cru_flags;
> >  };
> >  
> > -struct crypto_stat {
> > -	char type[CRYPTO_MAX_NAME];
> > -	union {
> > -		__u64 stat_encrypt_cnt;
> > -		__u64 stat_compress_cnt;
> > -		__u64 stat_generate_cnt;
> > -		__u64 stat_hash_cnt;
> > -		__u64 stat_setsecret_cnt;
> > -	};
> > -	union {
> > -		__u64 stat_encrypt_tlen;
> > -		__u64 stat_compress_tlen;
> > -		__u64 stat_generate_tlen;
> > -		__u64 stat_hash_tlen;
> > -	};
> > -	union {
> > -		__u64 stat_akcipher_err_cnt;
> > -		__u64 stat_cipher_err_cnt;
> > -		__u64 stat_compress_err_cnt;
> > -		__u64 stat_aead_err_cnt;
> > -		__u64 stat_hash_err_cnt;
> > -		__u64 stat_rng_err_cnt;
> > -		__u64 stat_kpp_err_cnt;
> > -	};
> > -	union {
> > -		__u64 stat_decrypt_cnt;
> > -		__u64 stat_decompress_cnt;
> > -		__u64 stat_seed_cnt;
> > -		__u64 stat_generate_public_key_cnt;
> > -	};
> > -	union {
> > -		__u64 stat_decrypt_tlen;
> > -		__u64 stat_decompress_tlen;
> > -	};
> > -	union {
> > -		__u64 stat_verify_cnt;
> > -		__u64 stat_compute_shared_secret_cnt;
> > -	};
> > +struct crypto_stat_cipher {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_encrypt_cnt;
> > +	__u64 stat_encrypt_tlen;
> > +	__u64 stat_decrypt_cnt;
> > +	__u64 stat_decrypt_tlen;
> > +	__u64 stat_cipher_err_cnt;
> > +};
> > +
> > +struct crypto_stat_aead {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_encrypt_cnt;
> > +	__u64 stat_encrypt_tlen;
> > +	__u64 stat_decrypt_cnt;
> > +	__u64 stat_decrypt_tlen;
> > +	__u64 stat_cipher_err_cnt;
> > +	__u64 stat_aead_err_cnt;
> > +};
> > +
> > +struct crypto_stat_akcipher {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_encrypt_cnt;
> > +	__u64 stat_encrypt_tlen;
> > +	__u64 stat_decrypt_cnt;
> > +	__u64 stat_decrypt_tlen;
> > +	__u64 stat_akcipher_err_cnt;
> > +	__u64 stat_verify_cnt;
> >  	__u64 stat_sign_cnt;
> >  };
> >  
> > +struct crypto_stat_compress {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_compress_cnt;
> > +	__u64 stat_compress_tlen;
> > +	__u64 stat_decompress_cnt;
> > +	__u64 stat_decompress_tlen;
> > +	__u64 stat_compress_err_cnt;
> > +};
> > +
> > +struct crypto_stat_rng {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_generate_cnt;
> > +	__u64 stat_generate_tlen;
> > +	__u64 stat_rng_err_cnt;
> > +	__u64 stat_seed_cnt;
> > +};
> > +
> > +struct crypto_stat_hash {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_hash_cnt;
> > +	__u64 stat_hash_tlen;
> > +	__u64 stat_hash_err_cnt;
> > +};
> > +
> > +struct crypto_stat_kpp {
> > +	char type[CRYPTO_MAX_NAME];
> > +	__u64 stat_setsecret_cnt;
> > +	__u64 stat_kpp_err_cnt;
> > +	__u64 stat_generate_public_key_cnt;
> > +	__u64 stat_compute_shared_secret_cnt;
> > +};
> > +
> > +struct crypto_stat_larval {
> > +	char type[CRYPTO_MAX_NAME];
> > +};
> > +
> >  struct crypto_report_larval {
> >  	char type[CRYPTO_MAX_NAME];
> >  };
> > -- 
> > 2.18.1
> > 
> 
> Is there any particular reason this patch only changes the UAPI structures, 
> not the internal structures in 'struct crypto_alg'?
> 

While changing it for user space will be clearly better, I didnt see any benefit for the internal ones.
But perhaps it is cleaner to have the sames.
I will do it.

Regards
