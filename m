Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27F8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943D120833
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="th7/JP3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943D120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeI1Vvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:51:42 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33990 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeI1Vvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:51:41 -0400
Received: by mail-vs1-f66.google.com with SMTP id v12-v6so3835037vsc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xCRJKwPQyqcEaIvsihvljNLTHQ9SrE93BNWbd8raIUE=;
        b=th7/JP3GmlJUnx3SDf6WSnSih9bHD7Mtg2dCXnCGFUP/OE2uh890YfVT9LJD5Bqhk0
         oTTiJMmH0gH4SZMlwVY3EeyciFydmy/9606g3gx4kRsV0xp0+lX/wwoY5XQNjQ7PMTFR
         RaSI0PF1s8nUiAhiyLUbDNzzdIG02R6a7/r/6XwrXfNhEEuc3nwrybQIWoWEMVcfiVYS
         9qVL/lGNFNkam3zUe8+QVZiFB9xeIUUkLmqkTYBk8wKnJl8bIPoqgrlvW+t882arWmJZ
         r3ARidAxaA/DCIIvVYeQr95y/qtKsOEsTfRi45r+8pBzNM/NN/oRGYFN2lmTDeErWuMI
         U+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xCRJKwPQyqcEaIvsihvljNLTHQ9SrE93BNWbd8raIUE=;
        b=dPyqtdWJBp0lcdxaMqG80HKLEdEyBltjiu90aRPI1TveZsGNDJJCAj92tknIi2WY3T
         ryrnzLfVlTinAJ6HDx2Mizog/zz2DNRcgl4AGTkJeMTII1RHY7s11fEE5m4k8oFdKbyX
         UXpkR08UT6QOM/5J/P7uWTzHmaQNaPQP9eGcltn6uMuBe/QRFPmN7ZyIhl8M1CGPV95Z
         5dVV7FcUxs5CtgY3iodhynXMZFAQttcd1TJPGFAiC2fArypvT1iISHrqN0z6DVIGsQ1I
         9uCI9g1Ds9IB0j2YKfw4MEVDSaRKoZsL+1P9Ud5kgaMN5nBgqomwLt/IAqjP3pbQ2PJI
         2SFQ==
X-Gm-Message-State: ABuFfoj13mvQJ4isk3KBYrDsIdupJHZuzAdwayExzHryGa8COnjLFynf
        XcC+AZnJhimjrTz0J/bn2QT3Mz0m/OErbAKysBIueQ==
X-Google-Smtp-Source: ACcGV62KolCBj4aw3pl4Xzx/eBdHrm+BeAEJlqgs53TT1l4NSMrzvg1DLTQdEiSHHnST5QpPtzMNm7DlL+HpZKCYahw=
X-Received: by 2002:a67:6582:: with SMTP id z124-v6mr2926438vsb.11.1538148444070;
 Fri, 28 Sep 2018 08:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
 <1537449521-16182-3-git-send-email-gilad@benyossef.com> <CAKv+Gu9T7Z2oV8TEaN8uVdrFxGmmCKLh6ZjDnRnhgCmLwuVf4w@mail.gmail.com>
In-Reply-To: <CAKv+Gu9T7Z2oV8TEaN8uVdrFxGmmCKLh6ZjDnRnhgCmLwuVf4w@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Fri, 28 Sep 2018 18:27:13 +0300
Message-ID: <CAOtvUMd68Bv7O8za5CLn7SGSgCDyR0fEE3MFU+5MfhfVBd2WHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto: add output feedback mode
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 28, 2018 at 1:06 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 20 September 2018 at 15:18, Gilad Ben-Yossef <gilad@benyossef.com> wro=
te:
> > Add a generic version of output feedback mode. We already have support =
of
> > several hardware based transformations of this mode and the needed test
> > vectors but we somehow missed adding a generic software one. Fix this n=
ow.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> I couldn't find any users of OFB in the kernel. Any idea who is using
> it and for what?

Most probably nothing in-kernel, as there was no generic software
implementation up till now and no one complained. :-)
It is available via the user space crpto API *if* you happened to have
supporting hardware, which is a very odd situation.

The kernel has test vectors for OFB for DES, 3DES and AES. We have
multiple HW based implementation registering
and making available their support for this mode for some time now,
but not software implementation and probably no in kernel users.

Had we have no support for it in the kernel at, I wouldn't have
offered a generic software implementation, but since
we do and have for some time supported using this operation mode (but
only if you have supporting HW), it seems
we are in a strange limbo position and should go to either removing
all support or adding generic support - hence my patch.


Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
