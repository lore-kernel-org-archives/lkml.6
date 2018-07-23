Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64440C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E102075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg5tiraT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E102075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeGWBMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:12:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39677 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbeGWBMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:12:17 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so18970867ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1DV92VKlsJjfjK5JZPktuS5NzfNzZjCRuBd7K/7qHkc=;
        b=eg5tiraTDN/+C0Fs0bgkRfjlfIP1ToasAT2jm6+RGlBV2ROw8K5mOjmfzCknqVhjbg
         j2JdhVAxVofifp3OiDsZ08qadQlE5o8EZFybHVewEIB+lR0ZHQRgodtyNZ+l/KZP4P7I
         nvw8FiLvGk1Tym4FKJresCJsVSovQ7pfwqYMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1DV92VKlsJjfjK5JZPktuS5NzfNzZjCRuBd7K/7qHkc=;
        b=SS5ZvbPuMzezWjazgUiobloSFOY3HMFCTMSm3f7pLboJJ0qO74+churzeb8KtAeTjL
         XUfsivyrHt6uWy4VvmMO2xqCv9Xub4b/cbenpnVyzz6Uo6jTvHzWlnp7dBC/6iAjqo9q
         t2hdNRt27gSiQ2jD3X+cJYToHIVLWs1R1pUBVEfL/boARK6EySkj2QM84oDeELGGs2uy
         Bo0choIMqUlROYNyrNgNfq5TmxVVhz4dZtEIThqiob74s+H/e4ugKVcXrhcLmG3VjgNd
         KIRtlxWdhfbvfc+2HxbmnhAc8xwcew1VFNCl/Qrl17EczrMmV8sWqZbjkPYWUAGP4Bx/
         lxJQ==
X-Gm-Message-State: AOUpUlFFrBlpfbisBvtlNeciziOTTdwcLgA1MfT3o2QCutOE+QGYQbj8
        /enzBU9RSKiS9r6AcuLox0c1nhw5lf5sSOl3fAiH8A==
X-Google-Smtp-Source: AAOMgpfrWDTupYCFJVcbU2gOCR+kmU+CN5IbR+kDgaRAFHJrIUrprrQ02nwf062Df9rqQl2LqWE7cY3B3Zwgw3+qA8g=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr8727989itc.68.1532304825726;
 Sun, 22 Jul 2018 17:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 17:13:45
 -0700 (PDT)
In-Reply-To: <CAOtvUMctPiTV4BMt7bp+Y7DocPtcP3HXykq4dJypN_ZcvV6b=Q@mail.gmail.com>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com> <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
 <20180719155026.GF27938@sirena.org.uk> <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
 <20180720114509.GA10784@sirena.org.uk> <CAOtvUMctPiTV4BMt7bp+Y7DocPtcP3HXykq4dJypN_ZcvV6b=Q@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 23 Jul 2018 09:13:45 +0900
Message-ID: <CAKv+Gu-Qv9_CFwvveNk0LhbcrspqSV2FgZxtMONPaQFXE8rUPg@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 July 2018 at 22:39, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Hi there,
>
> Sorry for delay in response - the patch set was sent just as we shut
> down the office for moving to a new location... :-)
>
> On Fri, Jul 20, 2018 at 2:45 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Jul 20, 2018 at 10:02:21AM +0900, Ard Biesheuvel wrote:
>>> On 20 July 2018 at 00:50, Mark Brown <broonie@kernel.org> wrote:
>>
>>> > Existing hardware can definitely do the IV generation and I believe that
>>> > it can chain multiple sectors together though I'd need to confirm this,
>>> > as mentioned elsewhere in the thread the ccree driver is for one of
>>> > the relevant devices.  I've poked some relevant people.
>>
>>> As far as I can infer from the ccree driver source, IV generation and
>>> en/decryption are separate operations, and given that each sector
>>> requires both operations to be applied in sequence, letting the crypto
>>> layer handle an entire bio does not have any benefit *at the moment*.
>>
>
> So there are two separate things that can be considered IV generation
> in the ccree driver:
> - The ability to generate a none repeating IV for encryption mode of
> operations that require it.
> - The ability to compute an IV from sector number for storage related
> modes of operation, such as xts
>
> What you saw in the driver relates to the first whereas we are
> discussing making use of the second.
>
> In essence, it means providing a key, buffer to encrypt (that may span
> a sector or possibly more) and the sector number
> and the CryptoCell hardware can compute the IV hence forth for blocks
> in the sector and across sector boundaries (it knows
> the size of the sector so can increment the sector number as needed)
> when fed a buffer that is bigger than a single sector.
>
> Consider getting a 4k page with a sector size of 512 bytes and the
> difference between 8 x 512 HW accesses and crypto APi calls
> vs just one. Of course, you can just set the sector size to 4k and
> indeed a recent change to dm-crypt allows that. You get similar
> benefit
> but at the cost of having to read 4k of data even if you just need 1 byte...
>
> I believe that other security hardware from other common vendors
> posses similar abilities - but can't really speak for them.
> I will note that the Android source code contains a hacked up dm-crypt
> that uses an out-of-tree version of a common vendor
> driver to drive this ability.
>
> What is being aimed at here is to do the same but in an upstream-able,
> community reviewed and accepted fashion.
>
> Of course, breaking it up to stages is fine - it's just that it is
> hard to show the benefits if you don't do the full monty....
>
> I hope I've managed to shed some light on the matter and would be
> happy to supply more details if needed.
>

Thanks Gilad.

So are you saying the hardware can apply the essiv algos in
drivers/crypto/ccree/cc_cipher.c (as well as perform the en/decryption
itself) on multiple subsequent sectors in one single invocation? If
that is the case, then I stand corrected, and it is absolutely useful
to increase the granularity at which the data is passed to the
hardware.

But I still think we should keep this as a separate change in the
series, and it should describe clearly what the benefits are, and
which currently known hardware can make use of it using which
combination of algorithms.

Thanks,
Ard.
