Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FCECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A76F2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IlRnLxiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A76F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeKDS0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 13:26:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52881 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeKDS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 13:26:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id q19-v6so5421540wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 01:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8gruHeKqcj7oe3IAWnb3YlnJKLTRGMOLy1XkObAe9s=;
        b=IlRnLxiPjhQa928qruFc5Pg0GZdtxqw3d/S9G0Tk73CupGR10uVouME9gChx+ITzKc
         OSFwhFIhWqfijBekhIJSZS+7uNAyaO0DHFIYAwrsTfVnPzJJF+NnFP2j5/p+axn2UYbw
         /rlGVj0LVmfWrwNpfQYNV20+i8htyzoDo5RKu5TrRjoXldv+H4asbJBXRetqNW9zyzM/
         UeOm+ibXpfO4QAXFTw3+q6EtX5lUIH0gwwYEkW7mLmxnqP9XHUACShZEyso0Fv5ky6BB
         7efymqcqOsIe3ZNkXVmLtxTF2hIILRQ46S1pWa2CDvjtm8VFSTKxb5eRO0G4nCnr3XtZ
         Sl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8gruHeKqcj7oe3IAWnb3YlnJKLTRGMOLy1XkObAe9s=;
        b=s2A9+FxLKuuFwO6g49POa06OPwrDe4dWFq2SIDUushF2T7OFi6p10SKiWwtaSzRCNP
         4LjuNCNREOk+6+dSl3uUsUxLBKyagJPIlqX3qLTcFtN00EiXyCE4KQTSP3uRascO75j0
         9/OBS/FFXINqlkV3hLJyVcChw8RWc7/t+aK7OJnJSILQmIKJgOmXov43irQvufzhoagO
         FGRErTi8Uz183Tbj8awcZq/U0Pkdeq1QK8sqay9HBQHIKWiqjfEPt6c4WUfjJmxLC0XK
         V8BnAv00c7MFIRgS8dS+HlV9uqCCmank9pUayLlGnvbkXUxHn+vsBORqxz81WaLVJSeK
         Nlqw==
X-Gm-Message-State: AGRZ1gIiy6oNc6mWDqXCC88ThX/rZGsOVEh2eUQiqeiH70QKBfj2Qvlb
        SgRFp3bXfbALPxI1yVU81AIFHA==
X-Google-Smtp-Source: AJdET5eL9f+hMN85hSU7MZBwhRgDJouzTp3ZmHesbi4M08Qg3cmwoJaYioPQ66TasNb9A+OAxQtfVA==
X-Received: by 2002:a1c:83cb:: with SMTP id f194-v6mr2721409wmd.26.1541322733881;
        Sun, 04 Nov 2018 01:12:13 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l67-v6sm70427750wma.20.2018.11.04.01.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 01:12:13 -0800 (PST)
Date:   Sun, 4 Nov 2018 10:12:11 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: Implement a generic crypto statistics
Message-ID: <20181104091211.GB6963@Red>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
 <20181103225234.GD808@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103225234.GD808@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 03:52:35PM -0700, Eric Biggers wrote:
> On Wed, Sep 19, 2018 at 10:10:54AM +0000, Corentin Labbe wrote:
> > diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
> > index 19bf0ca6d635..6dafbc3e4414 100644
> > --- a/include/uapi/linux/cryptouser.h
> > +++ b/include/uapi/linux/cryptouser.h
> > @@ -29,6 +29,7 @@ enum {
> >  	CRYPTO_MSG_UPDATEALG,
> >  	CRYPTO_MSG_GETALG,
> >  	CRYPTO_MSG_DELRNG,
> > +	CRYPTO_MSG_GETSTAT,
> >  	__CRYPTO_MSG_MAX
> >  };
> >  #define CRYPTO_MSG_MAX (__CRYPTO_MSG_MAX - 1)
> > @@ -50,6 +51,16 @@ enum crypto_attr_type_t {
> >  	CRYPTOCFGA_REPORT_AKCIPHER,	/* struct crypto_report_akcipher */
> >  	CRYPTOCFGA_REPORT_KPP,		/* struct crypto_report_kpp */
> >  	CRYPTOCFGA_REPORT_ACOMP,	/* struct crypto_report_acomp */
> > +	CRYPTOCFGA_STAT_LARVAL,		/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_HASH,		/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_BLKCIPHER,	/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_AEAD,		/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_COMPRESS,	/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_RNG,		/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_CIPHER,		/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_AKCIPHER,	/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_KPP,		/* struct crypto_stat */
> > +	CRYPTOCFGA_STAT_ACOMP,		/* struct crypto_stat */
> >  	__CRYPTOCFGA_MAX
> >  
> >  #define CRYPTOCFGA_MAX (__CRYPTOCFGA_MAX - 1)
> > @@ -65,6 +76,47 @@ struct crypto_user_alg {
> >  	__u32 cru_flags;
> >  };
> >  
> > +struct crypto_stat {
> > +	char type[CRYPTO_MAX_NAME];
> > +	union {
> > +		__u32 stat_encrypt_cnt;
> > +		__u32 stat_compress_cnt;
> > +		__u32 stat_generate_cnt;
> > +		__u32 stat_hash_cnt;
> > +		__u32 stat_setsecret_cnt;
> > +	};
> > +	union {
> > +		__u64 stat_encrypt_tlen;
> > +		__u64 stat_compress_tlen;
> > +		__u64 stat_generate_tlen;
> > +		__u64 stat_hash_tlen;
> > +	};
> > +	union {
> > +		__u32 stat_akcipher_err_cnt;
> > +		__u32 stat_cipher_err_cnt;
> > +		__u32 stat_compress_err_cnt;
> > +		__u32 stat_aead_err_cnt;
> > +		__u32 stat_hash_err_cnt;
> > +		__u32 stat_rng_err_cnt;
> > +		__u32 stat_kpp_err_cnt;
> > +	};
> > +	union {
> > +		__u32 stat_decrypt_cnt;
> > +		__u32 stat_decompress_cnt;
> > +		__u32 stat_seed_cnt;
> > +		__u32 stat_generate_public_key_cnt;
> > +	};
> > +	union {
> > +		__u64 stat_decrypt_tlen;
> > +		__u64 stat_decompress_tlen;
> > +	};
> > +	union {
> > +		__u32 stat_verify_cnt;
> > +		__u32 stat_compute_shared_secret_cnt;
> > +	};
> > +	__u32 stat_sign_cnt;
> > +};
> > +
> 
> All the 32-bit fields need to be 64-bit.  In some cases, UINT32_MAX crypto
> operations can be done in seconds.
> 
> It's also weird that everything shares the same crypto_stat structure.  I think
> there should be a different struct for each algorithm type, like there is for
> the existing crypto_user algorithm reporting.  In fact you are kind of already
> doing that since the struct is loaded full of unions.  But it would be much
> cleaner to use actually different structures.
> 
> - Eric

Hello

I agree, separate structures will be cleaner.
I will address this in a followup patch.

Thanks

