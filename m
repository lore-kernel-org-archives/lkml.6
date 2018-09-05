Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4501E2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHKygGGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4501E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIEWIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:08:21 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35662 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEWIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:08:21 -0400
Received: by mail-qt0-f178.google.com with SMTP id j7-v6so9078106qtp.2;
        Wed, 05 Sep 2018 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvyYXBr9qfVcz6DP1D7x3/7rpPM2d1ycecQcwvfqdCQ=;
        b=WHKygGGM8q4kWeWBhMJSi+8ja7zimFU/9GnnzHrJHm+PMX4u0hMtcmcZjezpvqDfcp
         Cr4vLzGg6T9wIkgoObNl745bXv1+T/OtkztYi6VnoyE+eokHrnyF4iq11p0H51n/Pzzz
         iJVzL2S47u+jRZ81ZHuoUdNUdJuwdelt2nVg6P26lPyfoLi4+kVnIzvUJVWHSFFxxyL3
         90zRYKw2zs2Y6qZAmlxDYKpDEVcQasJ1w9WsuFJ5O86xDlTAkbs8j8PRCiTGs0C5t04T
         /jqLW2b1+mZ5WV3UpgoJKnaJ+vLxfl9OU2CmDXypA4Z6Wgp73jkMTNsBDuFwp5jb4KWg
         Zg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvyYXBr9qfVcz6DP1D7x3/7rpPM2d1ycecQcwvfqdCQ=;
        b=FqjFyT1N0MEqv/zhyoqYsD3BZgi1E2rR309ZOUyRNEPOqWlR/+8u9ngPIsXgVx7z6d
         C6lZygpsIJZAQsFSQJxzpMDL2M428zjBQhQGM5K6rP2xAf+OGasLoHG008iclQppgKQV
         pH6LkWNXMjZ72hoKoMGLZhPf4vku0GfGzDLdzcnh8q5eCBns8PMnC20O9Io5o7dteX6I
         vOoBA+efvNm2vcbhRJBOGOt0uX+5EkR4APfjJ7pa/Z2ZK/8Sjq0W9zd8a4Efff+z6XGm
         0orgO2pbTbzOwb2306lN4dSNrF+qw3U4CL+vmba1VaKtzt+ZIVy00gVuBrigCXfjRFtj
         gkCw==
X-Gm-Message-State: APzg51Ck1KehBH4OUS8EcJ8pioJ9KYfuTTNJG0ohdhjzj/QKhz2FucUu
        fVv0ylh7gT3Vlv1WTPtvz5tnoWvjlU6EOrnVLIs=
X-Google-Smtp-Source: ANB0VdabzbY7dfiGVAVFPWOCr+BGE3c7vtElQJiXuyHdaE0UBNI9U1hCljNQ9k47Xp8GB3fhr61Oj3E+rPNdFMNAVJo=
X-Received: by 2002:a0c:c13c:: with SMTP id f57-v6mr34739474qvh.7.1536169029697;
 Wed, 05 Sep 2018 10:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-12-jarkko.sakkinen@linux.intel.com> <CAHp75VcqKunkHYNdd287_F7APHwYr7K9QD2PVCkqBqJWG2_E-g@mail.gmail.com>
 <20180905173355.GE11368@linux.intel.com>
In-Reply-To: <20180905173355.GE11368@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Sep 2018 20:36:54 +0300
Message-ID: <CAHp75Vc2SZUfRnBPZ9xJ_B=KJL7yK9hqRZiFOTswn0AzjnLD1A@mail.gmail.com>
Subject: Re: [PATCH v13 11/13] platform/x86: Intel SGX driver
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        suresh.b.siddha@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 8:34 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> On Tue, Sep 04, 2018 at 08:59:58PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:

> Thanks, very detailed! Does not make sense to ack these separately so I
> just say that I try to fix them all with care.

Just comment on which you disagree.
I think one of them is the header file location. It seems I missed
it's current place.

-- 
With Best Regards,
Andy Shevchenko
