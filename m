Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2642C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7078820839
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8SECEjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7078820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbeHGMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:35:23 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36624 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:35:23 -0400
Received: by mail-oi0-f41.google.com with SMTP id n21-v6so27542240oig.3;
        Tue, 07 Aug 2018 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZlBwScax8RMHM4ilDOiX/xv8fZ++0qOpCdvSJvlWW6s=;
        b=p8SECEjrCmCmPttGFU+OX276n6+hB6IxpVSKKSytbdf6mxpzUL9zj3CcbJlZFhu+jy
         rOYbrVEvjBxDY6Y5xobXelTvvXcbtLnO5EFYjRvD1Ege84KLfsnICkixsXNsiIJ/LQ7f
         pH6DrISG2ecQiXHHifkDD8/oM1BovWRzFi+opC/Mzm/coyLlZJi8fsqEsFUo++8FOQmr
         VeGKteodVm5dRfRmMZUgHDswh1cvGv9k28fVWqO3xzniT+w5bnhlp9/MAHLdw3SeKdDe
         lg2tD5jbk4kHkO/lUC8W+kvFob+FCS4439uVH5hitOwofkn92rpO9k6YT8825bW8Hr2M
         YpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZlBwScax8RMHM4ilDOiX/xv8fZ++0qOpCdvSJvlWW6s=;
        b=UaKLb+QVcYY1+otCbufV2AQ6lfeWpNKq2BV/aIbEbmWu0DOFsS3PVXy4ZrpjN4clF2
         HwTCyidLNwCmqGpyc6rpdyRLuoYKMjCq5N7YVhc2xTfzx2gbwxES2+M4RQ0SBpf2rkrS
         mt4g4VJ3TeOPO2ikp0Q8IN59wrcS/lIYpQmJISAjK+jR8eE8JsKT/UTxJo8mkA0BP5pk
         vUVfOkDADI/Lwz1NU6AxHWcRqa850lrZaFFkwuvZ8JKzYsxu/HtL8FuZoXdSWKgxNRIX
         fKVXWHpBo3j620V/ih8cy74LovDc8bA8eLCnBvE75kHY7WunCohylc/vdPIqDNraLCRE
         Z4/A==
X-Gm-Message-State: AOUpUlETtMewybXLJDVd3Vv9bf80iTr5trvYTgnqQO3n6JCZ0A7RA9Ra
        yKBtGB/tExhF66jj6U3lkwGd13QzRGeiuYPmiX0=
X-Google-Smtp-Source: AA+uWPwPn4TZLEXXQfB7IfYcdhfeQG3UcBngImCrVYbervryvoZJ3ofLiMl5zxA6Uepd8JeEwAwe8vJVVYcLZVM/9qc=
X-Received: by 2002:a54:4618:: with SMTP id p24-v6mr1896057oip.172.1533637305105;
 Tue, 07 Aug 2018 03:21:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aca:5352:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 03:21:04 -0700 (PDT)
In-Reply-To: <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-4-ebiggers@kernel.org>
 <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com> <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com>
From:   Samuel Neves <samuel.c.p.neves@gmail.com>
Date:   Tue, 7 Aug 2018 11:21:04 +0100
Message-ID: <CAEX_ruFp0KddnZyetZt997OvRzKDuN7U95MF_N9AgTh+mTcD7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
To:     Paul Crowley <paulcrowley@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, ebiggers@kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        tomer.ashur@esat.kuleuven.be, Eric Biggers <ebiggers@google.com>,
        "D. J. Bernstein" <djb@cr.yp.to>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The best attack on ChaCha breaks 7 rounds, and that attack requires 2^248 operations.

This number, as far as I can tell, comes from the "New features of
Latin dances" paper. There have been some minor improvements in the
intervening 10 years, e.g., [1, 2, 3, 4], which pull back the
complexity of breaking ChaCha7 down to 2^235. In any case, every
attack so far appears to hit a wall at 8 rounds, with 12 rounds---the
recommended eSTREAM round number for Salsa20---seeming to offer a
reasonable security margin, still somewhat better than that of the
AES.

Best regards,
Samuel Neves

[1] https://eprint.iacr.org/2015/698
[2] https://eprint.iacr.org/2015/217
[3] https://eprint.iacr.org/2016/1034
[4] https://doi.org/10.1016/j.dam.2017.04.034
