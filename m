Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3865C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8822145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="aa1Tv3aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8822145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeJRV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:27:16 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42460 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJRV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:27:16 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so23046642vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7D7uTyDGwUyou8Rg/88nt7xvFgNvhoSiEjO/nHUzGQ=;
        b=aa1Tv3awzssfhGrS0l6+YYWatN424wGorqGgIEiI5OJZxAPch1qLzTUnXxQS7kEAtA
         t31MHYoFEGCbqTjmuWWkqn73eW3kOaoSggrIewpHawXvFZARLsZmTx9tebSeheQDORDa
         +agpjM+azW2tBf3NeIlFbXgj7F1OKxyi+/Aqdo7kPMcQjP8+iUOa3VKeTDCB6/2TnvTE
         52DDlkNCS6Paywc/ZZ44n5yjWiTqEuUFvYg1kgW45sR5axncddsnwKePgWT6jM5PMCfR
         U6LxVY0PAmuXoguNMS448/hM6MgGGJE6mVewU5wsxN41xo15nBHyMYU4PM1jZtrewMNd
         YCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7D7uTyDGwUyou8Rg/88nt7xvFgNvhoSiEjO/nHUzGQ=;
        b=a/3k3qyvl5VMVtgNO2uREYWE6hspf9j0ZnOHGggZPXev1xU59+vFK44+kQ8GK3hmzW
         GKj2CKoZoirD66i2lw1r75LRSS8gXYifGH+4GNpD1ntQ9bpdIwQ4Uk4HvvrVQCdOjeSK
         WwqE64XJpSoIzi0Juwtbb3+uKSoSh6kNGqMYq1i28BaZa286iXnlnG2It1SQYzV/b+7y
         B9FkNQrQDslWYD0wIkaTwpxpwbvRqOvLcj3ZziZGowEAbJNJCDpGXk9JS2dPRAhS5rG7
         R4ELamL9iKRt8iod7ecEANgdtmxQ++1OKyTAmj+xtlSPUpoRt2KaqnrKDTFc0JrEFdVZ
         bfbg==
X-Gm-Message-State: ABuFfogSP2NTFjxa6EdpkmuDOdvDWV+VPBUAQnSMzXkBx5QE5QFbXaKA
        iTE8URd71W9n17ZTTRfQ/E1wAfUC6vUJht8yn7jCqA==
X-Google-Smtp-Source: ACcGV61EMXc68U8cdYbfJtav/9G5RXqYgMLj4TKIJM53lpvrWH46vhT8Jiq/EOOfNhzBHM5VT+84nuMgRGC4MaaKQpM=
X-Received: by 2002:a67:3e81:: with SMTP id a1mr12340511vsi.136.1539869173007;
 Thu, 18 Oct 2018 06:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <1539867599-20504-1-git-send-email-yael.chemla@foss.arm.com>
In-Reply-To: <1539867599-20504-1-git-send-email-yael.chemla@foss.arm.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 18 Oct 2018 16:26:01 +0300
Message-ID: <CAOtvUMe8ACJtadM1B50qBT=TBwD45rPN-89Pw+AdU20uMqyU-g@mail.gmail.com>
Subject: Re: [PATCH 0/3] crypto: ccree: add SM3 support
To:     yaeceh01 <yael.chemla@foss.arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:00 PM Yael Chemla <yael.chemla@foss.arm.com> wrot=
e:
>
> Add support for SM3 in CryptoCell 713.
>
> Yael Chemla (3):
>   crypto: ccree: adjust hash length to suit certain context specifics
>   crypto: ccree:  modify set_cipher_mode usage from cc_hash
>   crypto: ccree: add SM3 support
>
>  drivers/crypto/Kconfig                  |   1 +
>  drivers/crypto/ccree/cc_aead.c          |  19 +++-
>  drivers/crypto/ccree/cc_crypto_ctx.h    |   4 +-
>  drivers/crypto/ccree/cc_driver.c        |  10 +-
>  drivers/crypto/ccree/cc_driver.h        |   2 +-
>  drivers/crypto/ccree/cc_hash.c          | 175 +++++++++++++++++++++++---=
------
>  drivers/crypto/ccree/cc_hw_queue_defs.h |  27 +++++
>  7 files changed, 182 insertions(+), 56 deletions(-)
>
> --
> 2.7.4
>

Herbert, these go on top of my own previous patch set that adds the
CryptoCell 713 and its SM4 cipher support.

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
