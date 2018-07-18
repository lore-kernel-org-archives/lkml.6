Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917622084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caONgYQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917622084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeGRLgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:36:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44746 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeGRLga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:36:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so3695036ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0kLWQTfq5LAA1BnO2fp+afjjJWyP1LVL96/r5dLLiKk=;
        b=caONgYQvLhoNbe6yrfKgqHJtN192/2iMChyZF+KVEhfBa/nD645yUDqWxIQ8p3io9J
         lkuBuEMxOh1oS+y9ZSROhYyR1cH3oJFZyogBe9+NoKgFCbOQaNuy9p4WKdhbB/SLoI5b
         eBRzz6wq5Jnv7tzfb1Ml3PIcizsC6M/yqIp9UcxNN7M4A8Ja9QqJdejlxqFCWbVp1XUy
         rOdFZwR1cfQrVslMGOQAe/v9kxOAUYXtyDiHe5sfdQNitIX0QOWcbrpYmmEOb168KpfZ
         oqvNj/sFypMjWWylmaFJbLPtqgoTanFgFswUvdkqGjYnMvaTNn6ZViDX5sesEOmPFzT2
         qJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0kLWQTfq5LAA1BnO2fp+afjjJWyP1LVL96/r5dLLiKk=;
        b=oxydUAaNRGve0FicctEL5XDZNpi6H1qKgGWaIMegHG/piIu7wpe99Ilfx4c6L8ImUr
         cj/JUDi0nWmA/OTua0PxgRIYZJld9BqUD9DzL4kyxnjK0RQSjeHW8WM6I7+6A3DSTjgA
         ODJN4ncM+XsnCFtZ99ThT1qZWrh05V3/NCCLhHrQmKt/qXGi1IM1qsMK9FscE8gcH2eW
         UhYGDFokVsKJeVecEBR1MA/k6ToSfMMOQlnVpD5Yj04GUqLe5W5pNKphGMVD+Lu2ocY7
         7SUqxGi/7h8mo2TGEzXxoLOM13qoYgNLvk130FEi0y/s9WbdNGuWcjcmpcbu/LhaslwS
         7E5Q==
X-Gm-Message-State: AOUpUlGAQ0Xt6Q4llywWbSk+KOBNGihWkLaKhIBKw9cY+75bC/Ofk8P+
        Bii5A9IEMPm+VXwE20U9ZnZBhXAzWT1U+a5TmhQ=
X-Google-Smtp-Source: AAOMgpeFP7VLQqFNJXTZlHnB0jyp03aL8VYk7VtpTIrqHnaZbH8nbkEDMbQW0wuk1sE3kDs8ZzbNaZoin1+juJVwfug=
X-Received: by 2002:a2e:998e:: with SMTP id w14-v6mr2976202lji.7.1531911548067;
 Wed, 18 Jul 2018 03:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:59:07
 -0700 (PDT)
In-Reply-To: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jul 2018 12:59:07 +0200
X-Google-Sender-Auth: _4nrKyBKtowWESGC3X8p5Xcu4ck
Message-ID: <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 9:30 AM, Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> I tested the performance of software implemented ciphers before and after
> applying this patchset. The performance didn't change much except for
> slight regression when writting. The detail information is as follows.
>
> The command I used:
> cryptsetup -y -c aes-xts-plain -s 256 --hash sha256 luksFormat /dev/sdd1
> cryptsetup -y -c aes-cbc-essiv:sha256 -s 256 --hash sha256 luksFormat /dev/sdd1
> cryptsetup -y -c aes-cbc-benbi -s 256 --hash sha256 luksFormat /dev/sdd1
>
> cryptsetup luksOpen /dev/sdd1 crypt_fun
> time dd if=/dev/mapper/crypt_fun of=/dev/null bs=1M count=500 iflag=direct
> time dd if=/dev/zero of=/dev/mapper/crypt_fun bs=1M count=500 oflag=direct
>
> Performance comparision:
> --------------------------------------------------------
> algorithms      | before applying   |   after applying
> --------------------------------------------------------
>                 |  read  | write    |  read  | write
> --------------------------------------------------------
> aes-xts-plain   | 145.34 | 145.09   | 145.89 | 144.2
> --------------------------------------------------------
> aes-cbc-essiv   | 146.87 | 144.62   | 146.74 | 143.41
> --------------------------------------------------------
> aes-cbc-benbi   | 146.03 | 144.74   | 146.77 | 144.46
> --------------------------------------------------------

Do you have any estimate of the expected gains for hardware
implementations?

Would it make sense to try out implementing aes-cbc-essiv
on the ARMv8 crypto extensions? I see that Ard has done
some prior work on aes-ccm in arch/arm64/crypto/aes-ce-ccm-*
that (AFAICT) has a similar goal of avoiding overhead by
combining the usual operations, so maybe the same can
be done here.

      Arnd
