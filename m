Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C441DECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3F920874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="Q6ZoVDPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3F920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeGVOgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:36:16 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41792 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeGVOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:36:16 -0400
Received: by mail-ua0-f196.google.com with SMTP id t14-v6so10147549uao.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qnAhNW20wIaJAK8/KcaJKA0PMXL60t3oY/uJsyWYVAo=;
        b=Q6ZoVDPmMmkbsE+Q41xKt9jRGlNQlgZem6381XqEyOwyA6USWkGGbo8qGSIU8w5ogt
         h2n1XNLcriE5hWy7xMap/rbY/lllHdJSANTZbLiuWaubRqridpSarr4Ml97suKX87jKG
         8p/oacYjoIJ3JDlmR1jyrS5RydVm/7fn9WmzmkVA756KE/TdCe/qD4F547aDMoZoZnol
         8GnP+uRDIF04JClbz55V/dft2qmlIpM09/kyrkL5yRttc27NZ7/d1B/i55H5S7FuomJr
         I25Oj+otQ8r6Fh6Bi4DV0IFi5jgryD3jb3oIrWnfif9utWM+BJYmHs5rnhbcrYmIY07B
         sQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qnAhNW20wIaJAK8/KcaJKA0PMXL60t3oY/uJsyWYVAo=;
        b=cGyHBj1HI8HsXmF4LS5lq6tqiGu76vOD6/ilN/emT9EyK5heK9YZ7DMuIrQ4xFOo+k
         6eZ0i3C1qkvG+YE9uKvssOKgF7FNjxBB7Fj3BpWARdY8T8onNobjVrrLSVG1KVDCkfpd
         LohqtznOb67pEs615cc+3RG1KhTqRFkxLncbFh3eao79ZbuplkVDMNdHXRZad22NiKpl
         F/Ti1qkmrYt6YSkWBKV7/7oTIhy4bGCIRsLEiwkNGJLn5OJUslvUtFmCGgWrnstIMufE
         MDpOA1ib3aEo7viBmnb4DBvJhGnoyZW80sK0UEvfrujgJQ++YZKGW471nr/7/kXmWrGU
         17+Q==
X-Gm-Message-State: AOUpUlGlL1Ay2J6TA9Wo5ncscJCWilggWtU5OfPcCnLz+WtEwPmPNvtR
        4a/WsseykaY98fASNqrnOqXUmbdPuxDTyXUPVyvJFxKuh/g=
X-Google-Smtp-Source: AAOMgpctE/qbHOlJNQLXeHh3hyJ2rdFSdyRX0i9likOLc5cYMZyxp1rzz6ovipBbJonBAbnA1m3bgjlvxNbPp2j1Nlg=
X-Received: by 2002:ab0:6583:: with SMTP id v3-v6mr6255787uam.107.1532266772240;
 Sun, 22 Jul 2018 06:39:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:74d7:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 06:39:31
 -0700 (PDT)
X-Originating-IP: [217.140.106.29]
In-Reply-To: <20180720114509.GA10784@sirena.org.uk>
References: <1531899055-29362-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a0T0Ku-2GOY8fT38LVy4GpvVSsx=szi0ZNEUq8Z_hZweQ@mail.gmail.com>
 <CAKv+Gu8uD4NNS9SaWdSST7n+984ybTBLhGDpq3k5GG4o1+PMWA@mail.gmail.com>
 <5d0bb72c-862e-63be-3cc5-83ed02b9a575@huawei.com> <CAKv+Gu-hvEUyOOh_xpYsSj2WTcbM1FwRnJ1DkTGH1UjxkppNMQ@mail.gmail.com>
 <20180719155026.GF27938@sirena.org.uk> <CAKv+Gu_mb26HRi==5oeQyZ7ZOgifg7RUNt2c2V=tTqvFrMYq5g@mail.gmail.com>
 <20180720114509.GA10784@sirena.org.uk>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 22 Jul 2018 16:39:31 +0300
Message-ID: <CAOtvUMctPiTV4BMt7bp+Y7DocPtcP3HXykq4dJypN_ZcvV6b=Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] crypto: add IV generation templates
To:     Mark Brown <broonie@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Sorry for delay in response - the patch set was sent just as we shut
down the office for moving to a new location... :-)

On Fri, Jul 20, 2018 at 2:45 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 20, 2018 at 10:02:21AM +0900, Ard Biesheuvel wrote:
>> On 20 July 2018 at 00:50, Mark Brown <broonie@kernel.org> wrote:
>
>> > Existing hardware can definitely do the IV generation and I believe th=
at
>> > it can chain multiple sectors together though I'd need to confirm this=
,
>> > as mentioned elsewhere in the thread the ccree driver is for one of
>> > the relevant devices.  I've poked some relevant people.
>
>> As far as I can infer from the ccree driver source, IV generation and
>> en/decryption are separate operations, and given that each sector
>> requires both operations to be applied in sequence, letting the crypto
>> layer handle an entire bio does not have any benefit *at the moment*.
>

So there are two separate things that can be considered IV generation
in the ccree driver:
- The ability to generate a none repeating IV for encryption mode of
operations that require it.
- The ability to compute an IV from sector number for storage related
modes of operation, such as xts

What you saw in the driver relates to the first whereas we are
discussing making use of the second.

In essence, it means providing a key, buffer to encrypt (that may span
a sector or possibly more) and the sector number
and the CryptoCell hardware can compute the IV hence forth for blocks
in the sector and across sector boundaries (it knows
the size of the sector so can increment the sector number as needed)
when fed a buffer that is bigger than a single sector.

Consider getting a 4k page with a sector size of 512 bytes and the
difference between 8 x 512 HW accesses and crypto APi calls
vs just one. Of course, you can just set the sector size to 4k and
indeed a recent change to dm-crypt allows that. You get similar
benefit
but at the cost of having to read 4k of data even if you just need 1 byte..=
.

I believe that other security hardware from other common vendors
posses similar abilities - but can't really speak for them.
I will note that the Android source code contains a hacked up dm-crypt
that uses an out-of-tree version of a common vendor
driver to drive this ability.

What is being aimed at here is to do the same but in an upstream-able,
community reviewed and accepted fashion.

Of course, breaking it up to stages is fine - it's just that it is
hard to show the benefits if you don't do the full monty....

I hope I've managed to shed some light on the matter and would be
happy to supply more details if needed.

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
