Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4691320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGixs3qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4691320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeGTNLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:11:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40195 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:11:15 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so14277495ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n8mrHQPBY5Gw6SwHS5W9CQR1blsNuEO7RNcy69tdUHs=;
        b=PGixs3qLiT5xID0DlRnsQUV+uwnls3vBeKwNMwG9tlyw2YnYU9APHwIoqFOCIyIUtT
         collODsQzTtKEAX9G5hNEvbIL3U5FlUUt37gjuhnnxeJeBi1bB4X70FfkOIeQg0yK2aF
         J4m/1RiKPtUB0oeANT+83Q3VI8qwoqffWngk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n8mrHQPBY5Gw6SwHS5W9CQR1blsNuEO7RNcy69tdUHs=;
        b=ad977UoT3+PBke3GtLDkPGnNVrszVOxepRWBaYM41I7mQfq8j2U1GHiAEJWaOSOPYd
         BdgycCzVc0+PRD2XTovA7ZdD8K3g6xH1IS6D2OEulayrRiB2Oeh64EfFol1A5nmYPaWP
         U3gjBf2GSFYQ8IqAsGW/Vj6GdJ/pxJPH8P8K0zVSjZ4QiA20lYzCvLt6XY/tuQ3gfKn1
         k3wP2gqtFuEeLNtpI0KCxR3HxaVSO1RBn+6r9egT23pyUbSJNkVKtb+ypModMWfPD4WV
         S2hN+hTJJ6J1jPiyS8em0hPwW2dcKt2fkbbPJSVBHLuqtS4ZFfGzWeiQCm/azAdIRDBn
         oC1A==
X-Gm-Message-State: AOUpUlFAb2fcKQVyRcCF8PRxeRV/TOmFGFwIvQO2qPAly6bgyj3dIbaN
        GVpHGSOTbxAUaclekT6MU5VgZG5ByU/Uvf1qF99tFg==
X-Google-Smtp-Source: AAOMgpcNc9qI0rsB1GJi/YPiScKI6bWBigPVpXkv9Bi9alAO+b/0Hfl1OA4PrP+mqSEFiVJYJmQRR43rJrj8C//tCIc=
X-Received: by 2002:a02:35a:: with SMTP id y87-v6mr1588357jad.2.1532089395757;
 Fri, 20 Jul 2018 05:23:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 05:23:15
 -0700 (PDT)
In-Reply-To: <20180720114509.GA10784@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com> <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
 <20180719155026.GF27938@sirena.org.uk> <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
 <20180720114509.GA10784@sirena.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 20 Jul 2018 21:23:15 +0900
Message-ID: <CAKv+Gu8=M-EE11dZwcAzy1ZrnEoz=nF++v9bneY2SUq+e217Rg@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Mark Brown <broonie@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 July 2018 at 20:45, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 20, 2018 at 10:02:21AM +0900, Ard Biesheuvel wrote:
>> On 20 July 2018 at 00:50, Mark Brown <broonie@kernel.org> wrote:
>
>> > Existing hardware can definitely do the IV generation and I believe that
>> > it can chain multiple sectors together though I'd need to confirm this,
>> > as mentioned elsewhere in the thread the ccree driver is for one of
>> > the relevant devices.  I've poked some relevant people.
>
>> As far as I can infer from the ccree driver source, IV generation and
>> en/decryption are separate operations, and given that each sector
>> requires both operations to be applied in sequence, letting the crypto
>> layer handle an entire bio does not have any benefit *at the moment*.
>
> Interesting...  they were reporting some benefits from that with their
> out of tree driver prior to upstreaming (and there are other
> implementations out there, that's the only one I definitely know about).
> I have to confess I didn't look at their in tree driver, looking briefly
> now it looks awfully like the hardware should be able to chain IV
> generation together with encryption without bothering the CPU which
> would be good enough.
>

Indeed interesting. But afaict, that would still mean that the IV
generation transform and the payload transform would be expressed as a
single crypto algorithm, e.g., 'dm(essiv-foo(aes),gcm(aes)), or the DM
layer would still need to be involved in sequencing one operation
after the other, and I don't think any of that support is in the
current series. But I'm just a drive by reviewer here, so please
correct me if I am wrong.

>> In fact, it seems to me that the ability to use protected AES keys is
>> much more appealing than any performance argument (including 'it may
>> be slower but at least it does not load the CPU'), so some background
>> on how such a change would enable this use case would be beneficial as
>> well to getting this adopted.
>
> Right, that's another benefit which was on the radar for followup work.
>
>> So my recommendation would be to focus on moving the IV generation
>> into the crypto layer, but conservatively, and not confuse people by
>> making additional changes that could theoretically improve
>> performance, but only on hardware that does not exist.
>
> It certainly seems like splitting things up will at least allow things
> to progress.

Indeed.
