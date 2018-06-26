Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D7DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B27726DE2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="k7lTkD26";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="npmjSNaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B27726DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeFZRCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:02:34 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33978 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbeFZRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:02:33 -0400
Received: by mail-yw0-f193.google.com with SMTP id n187-v6so2867843ywd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qrw8YOhghCb56pjSVaku2nRybHH7DHNHzmJpOHoV3x0=;
        b=k7lTkD26kGxwiRnuUCfFzMC/R7aqrMIbfY0SOS4xdIMHo5CB1rHxYK1ugIbZ4ERML8
         btCu4YWkI3+igYF9VZt41FtW2aB+OHEO25zBoODmmvaoL5tyvxHxTIK3yewM+4v5ccVa
         nh8TQYgKm8Mnu0SiOqr4P63wOYnOnsQ0iy1pTcfoQZhXT1vLKZJw/p2fLnzO91YkRaGq
         16HeNLTq3HRjv0/1DWj3BB//vARwQzievimIIVpdtVODrum88YsIFz7A9QkZaTvIuTa/
         T4QYAPN9OHhBmmKzgo4vA5mxxQ3C2SDFoBsv2Uqg308EkVpJNz1+18p7M58PMnbSYcVu
         q/xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qrw8YOhghCb56pjSVaku2nRybHH7DHNHzmJpOHoV3x0=;
        b=npmjSNaWkm87YNMSEd3bEJjj8VJ2hN4i0/G2YKhWGKijCUWePWb2C3yzpmk30UOidX
         gzCRP5fMeTnyblCQbOXmrWVhY5tSuzSzRw+9Bx+DdUK60PXFKbmr5fUEF2kB0CZoV4df
         1TcK1gZYTKJ+EkgQn5W298Y3VLk+QY+oT9s9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qrw8YOhghCb56pjSVaku2nRybHH7DHNHzmJpOHoV3x0=;
        b=QirpHndlF73AWlBFq72teufD1NinsBXKdwioHJBlkEjk0S+t0ojj7wVsEmHfd7UjpQ
         /cEbSJqyVkFPdufdn3B4Qo7j712CKoD0BtqZ/URKNu7aVTB0zgAyDYF1uRgdEgHaASlS
         buL06W6IxJLD4+u6H6LdjLl6LfevCbAKZR5th8cXLK/bMwt1WXpwrzXVHYTKcZB11Npw
         +F4oI89/+5YiDCt4+P9mTD45OCPndlblRJwI/eFCf56usv7HDdXs3liwP5YphsQ/xpbx
         Nk5Lnp+O1hpyVzbktw001DQY+wIG+pWWwbX4xrZIYI2zjRxYMjsx/8p3Q03LRQJ/Y0+I
         HKYw==
X-Gm-Message-State: APt69E29xAwhBUejNrzZZO65afhOPjQLxdwQHz7Qc6BlsFlcJlWX2NoI
        RDXmNRuMeUZDT/cglYpZtoSxmwfknVVBq0xwDkTHEA==
X-Google-Smtp-Source: AAOMgpdJO3Be0brK+QE/y0ttRMZYCqrBAxRq4khJO8PqxaU28lOmK1wqFS2H9S/v+mEqr75jmYJaQoEv2S2AsCNJsDU=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr1131583ywf.129.1530032551786;
 Tue, 26 Jun 2018 10:02:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:02:31
 -0700 (PDT)
In-Reply-To: <20180626091958.zy3m24sjukfbn7av@gondor.apana.org.au>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-11-keescook@chromium.org>
 <20180625225609.GA181665@gmail.com> <20180626091958.zy3m24sjukfbn7av@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 10:02:31 -0700
X-Google-Sender-Auth: G9ZTBIz-4kRPeNrAGCMrMpJIQIM
Message-ID: <CAGXu5j+2UEUMJ0RL_XDm+Z2jBaPgshbiKaKmrYTQiP7yB2eKng@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v2 10/11] crypto: ahash: Remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:19 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Jun 25, 2018 at 03:56:09PM -0700, Eric Biggers wrote:
>>
>> > diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
>> > index a0b0ad9d585e..d96ae5f52125 100644
>> > --- a/include/crypto/internal/hash.h
>> > +++ b/include/crypto/internal/hash.h
>> > @@ -142,6 +142,7 @@ static inline struct ahash_alg *__crypto_ahash_alg(struct crypto_alg *alg)
>> >  static inline void crypto_ahash_set_reqsize(struct crypto_ahash *tfm,
>> >                                         unsigned int reqsize)
>> >  {
>> > +   BUG_ON(reqsize > AHASH_MAX_REQSIZE);
>> >     tfm->reqsize = reqsize;
>> >  }
>>
>> This isn't accounting for the cases where a hash algorithm is "wrapped" with
>> another one, which increases the request size.  For example, "sha512_mb" ends up
>> with a request size of
>
> I think this patch is on the wrong track.  The stack requests are
> only ever meant to be used for synchronous algorithms (IOW shash
> algorithms) and were a quick-and-dirty fix for legacy users.
>
> So either check SHASH_MAX_REQSIZE or just convert the users to
> kmalloc or even better make them real async users.

There is no SHASH_MAX_REQSIZE?

As for users of AHASH_REQUEST_ON_STACK, I see:

$ git grep AHASH_REQUEST_ON_STACK
arch/x86/power/hibernate_64.c:          AHASH_REQUEST_ON_STACK(req, tfm);
crypto/ccm.c:   AHASH_REQUEST_ON_STACK(ahreq, ctx->mac);
drivers/block/drbd/drbd_worker.c:       AHASH_REQUEST_ON_STACK(req, tfm);
drivers/block/drbd/drbd_worker.c:       AHASH_REQUEST_ON_STACK(req, tfm);
drivers/md/dm-crypt.c:  AHASH_REQUEST_ON_STACK(req, essiv->hash_tfm);
drivers/net/ppp/ppp_mppe.c:     AHASH_REQUEST_ON_STACK(req, state->sha1);
drivers/staging/rtl8192e/rtllib_crypt_tkip.c:
AHASH_REQUEST_ON_STACK(req, tfm_michael);
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c:
AHASH_REQUEST_ON_STACK(req, tfm_michael);
net/wireless/lib80211_crypt_tkip.c:     AHASH_REQUEST_ON_STACK(req,
tfm_michael);

Regardless, I'll take a closer look at these.

The other patches leading up to the REQSIZE ones, though, I think are
ready to go? They're distinct from the last two, so the first 9
patches could be applied and I'll continue to improve the two REQSIZE
ones? If that sounds okay, do you want me to resend just first 9, or
do you want to take them from this series?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
