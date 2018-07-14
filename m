Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7F1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 03:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09BC208A6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 03:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JCc3H21E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y43/OtVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09BC208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeGNDYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 23:24:35 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39531 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbeGNDYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 23:24:35 -0400
Received: by mail-yb0-f194.google.com with SMTP id k127-v6so13518483ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pvnPaPD9YDywKuQt3xInNbLKsoXiMWRfEUVZJPUIlHo=;
        b=JCc3H21Et7Pb0EnGNHX55VZqQD5K64ikQarZ6eNFce7wuahpVzCyUZkis57HXAFI/S
         O7eUDderklZ1cj8wfW2OiN7AAChas/PAvqma69C5ERDovPpaZInedyRU6xjYSHyN3zoI
         FuLzthakYyFCMu0idnwkO3Noep08e6ijOAl7DtxyY5DeWxHelbyReyKQu9dP0MD52v7Z
         scxlVx96plgSf9JR/jYejFzOMiEFUMNFUVVvOPWIjyWQ6bYYVjJkH4k8fA1XAhnrvEpv
         1bzuh5dMDUlz6F+/xTaV15bKD5CrokNEIM0/6lWsLLC6yyzkxEAOYdZ7IVRv9ES9CT4c
         eRgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pvnPaPD9YDywKuQt3xInNbLKsoXiMWRfEUVZJPUIlHo=;
        b=Y43/OtVwSRiDT4wdoN5VlUPQg/KNzL9+NdgEM1jJA90Go+QFRRgee38MAXbx8rl+FW
         cB3nXtNoNTo3bF71W5Up9Hs7pY/yXrcOBbQil2qjkgAWW/hyWoXkm5v9iC2jRu6BhXqH
         x4d5Nq3bPh6XXliRjoYoSPtr1ARfT54UlrT9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pvnPaPD9YDywKuQt3xInNbLKsoXiMWRfEUVZJPUIlHo=;
        b=jldTwE2TrTtNEQxkQWLTttBrMlIfv+DLIHqXVFTarOb6WRF5xN+EfCeQrdUjESnMYp
         dYRLA2CDQCJDZRPerpXtnkV8DNzsvPoPrd/sqoCHLk+rlSCZXGNqT09IroI1edbMWRWG
         CcdPv7xQdm8L0ac5FaOoGS1rjLAhRZ4goqh+xn0BdijV3yN6H4AmI224c6DBcg0o+73F
         k0HsWukx7ehNiHz8o334Gf2NEW2ZXfRdb6pKtJUgjEhFi9f0CMPWVjs6y7HzLYswewPL
         hZWinpfTPvAYM4yPEEZssFEV/X+pOzh0nlxK6Qp3hp4TjvyavMr/RdmFejvvL0czmFlJ
         FASg==
X-Gm-Message-State: AOUpUlF+LcwoY3Ra4KZv7e+1WDnXorOqXxUBY2tU59VzQvsSQbpcCANl
        I2gAAJha+RY5SVt2sPY2qmeFS/sAxm/Q4AVDUsdw0A==
X-Google-Smtp-Source: AAOMgpdc9N1uIlC0jjUCcEV3i6zfHKo07QGCYXYw9b6zdItyffjyhJdtrVrITQafxm/TR8KPaOXS8ZMQZsEMgRwrY3Y=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr4479551ybj.343.1531537631584;
 Fri, 13 Jul 2018 20:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 20:07:10
 -0700 (PDT)
In-Reply-To: <20180713062204.2o7gz5xri374nii6@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jJOZ3u1BTf8U20wErphfjKzaGK+m1sdhA89LqVP3MDYZA@mail.gmail.com>
 <20180713062204.2o7gz5xri374nii6@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 13 Jul 2018 20:07:10 -0700
X-Google-Sender-Auth: NMGv4R2RnPDsptgCbzl-FwPBPpk
Message-ID: <CAGXu5jJp3Y4RZD+ZUYsWqf+sTbGJwdN3M=KOiPBn9VecYE4OgQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:22 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Thu, Jul 12, 2018 at 11:16:28PM -0700, Kees Cook wrote:
>>
>> Is this correct? It seems like you did the bulk of
>> AHASH_REQUEST_ON_STACK conversions in 2016. Can shash grow an sg
>> interface?
>
> shash does not need to grow an sg interface.  All users of
> AHASH_REQUEST_ON_STACK set the CRYPTO_ALG_ASYNC flag to zero
> when allocating the tfm.

On a plane today I started converting all these to shash. IIUC, it
just looks like this (apologies for whitespace damage):


 static int crypt_iv_essiv_init(struct crypt_config *cc)
 {
        struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
-       AHASH_REQUEST_ON_STACK(req, essiv->hash_tfm);
-       struct scatterlist sg;
+       SHASH_DESC_ON_STACK(desc, essiv->hash_tfm);
        struct crypto_cipher *essiv_tfm;
        int err;

-       sg_init_one(&sg, cc->key, cc->key_size);
-       ahash_request_set_tfm(req, essiv->hash_tfm);
-       ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
-       ahash_request_set_crypt(req, &sg, essiv->salt, cc->key_size);
+       desc->tfm = essiv->hash_tfm;
+       desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;

-       err = crypto_ahash_digest(req);
-       ahash_request_zero(req);
+       err = crypto_shash_digest(desc, key, cc->key_size, essiv->salt);
+       shash_desc_zero(desc);
        if (err)
                return err;


(I left out all the s/ahash/shash/ in types and function declarations.)

Does this look like what you were thinking of for converting these
away from ahash? The only one I couldn't make sense of was in
drivers/crypto/inside-secure/safexcel_hash.c. I have no idea what's
happening there.

-Kees

-- 
Kees Cook
Pixel Security
