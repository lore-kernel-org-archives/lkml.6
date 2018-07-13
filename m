Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AD5208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kzZ8KNQI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8u+gJWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AD5208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeGMFa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:30:28 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35852 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeGMFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:30:27 -0400
Received: by mail-yw0-f194.google.com with SMTP id t198-v6so11331285ywc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=adAs1tuhSf31cNM08arVDju/6k8ZuobMdvo+FfZhXtA=;
        b=kzZ8KNQIXd5OrN7qPPmxM0CnshK2vndAX9ogtQJ4veegm6KYGv2+IIDGO0ZSzem8L2
         iIEEkyWBiLyM7b0vj0LCx4CqPpYcHkJd8C6idTBBRiqhFkHk2H2rHtnShECZtSpaI3O4
         hYnVjitVmgSrEvHwR+e6fCzukYOsX6g4vyr5GDD63zTo0qnGSJ5WF9hMU7y1VlA4gPw0
         5dX/B1r5v0snKx/wKcVlL+EXQhgmY3lC3fREO2vf2On+bjvyjZSlEu4tEgvMFoqNuzaY
         /JOpWlIWJM2LLFBolp064rHiNWW+Hep4oWRkiElabpjg+BLzkSoFAA3b7J28ZFQFTuqM
         4o3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=adAs1tuhSf31cNM08arVDju/6k8ZuobMdvo+FfZhXtA=;
        b=j8u+gJWV8vnqFlqTGqJFEJMTnTYw4m7pQbD2Wd5NrOvK8FHF3xgRUxt/v6cJ7JcakB
         uC5Y5YMDYFnBg0+4h0djA6m+YUL7hBMfTzhkm5QBAk0kusOEX4lbgC4VsyLwXPA0egt3
         O9ukjb4bGAR5IJm1UQ5eyasWzw3bIRo+G1bJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=adAs1tuhSf31cNM08arVDju/6k8ZuobMdvo+FfZhXtA=;
        b=fYCgJ8zrg11KXz2J0f8LPn++TGvlnX/vatKVfM9CaygTn0OlhwEdQiuXvB1u9it+rP
         kOBE+hESE+lJNE6OeVBTioZ3D2ss2h2o6RXq8ydrL18NDZrteOYbW44flvAV3xYGTo/1
         XGZO6pMtwML9htN5lvFt+aFTh1/e26gW5F4m4cP68BZz4BVt7xqFc9ToNUgshl+FH2dm
         B6aBTRevOzTP5K1UY6hwERvVaPc2Z4PZCaFXouct3O3FQ5F62vLOHwVDkhIXMwAW8ZYY
         A+geY6x6Qr034H/fubJe/INRPSbP/ZUISPw2N2CL/PXuuiUvtWRkzA4yV+A0qliTwam3
         kWsg==
X-Gm-Message-State: AOUpUlEQNt93bOac6TeyEfyFRDQAPBP40vRCBZqV3z0YKqSjzpgbqTTx
        TRHZTm3CQYwJF52yIgYUdqVrwllncp7s1qjVaCxbNg==
X-Google-Smtp-Source: AAOMgpca2QHp5WCLTd6yFWaaz6m3/C0Yr56Nxl+uQTPedOAaBr1Am4E7cqqOFbGarCKjdVB/6habkndsfYC1gy6yfNQ=
X-Received: by 2002:a0d:e2cd:: with SMTP id l196-v6mr2434613ywe.38.1531459050702;
 Thu, 12 Jul 2018 22:17:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 22:17:29
 -0700 (PDT)
In-Reply-To: <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jLYmC7U=bucFZCLsSXNX=T4WhCccR6hx9dwROYF+ZMt0Q@mail.gmail.com>
 <20180713034406.zwu2pkp3f2onybxs@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 22:17:29 -0700
X-Google-Sender-Auth: 0fqaXGIIDQ87BVSgsW5pTVkqCvE
Message-ID: <CAGXu5jLR0zJ6b9axJuG_uvttNShNcN3rhQKGVjW37qPd9saY-Q@mail.gmail.com>
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

On Thu, Jul 12, 2018 at 8:44 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Jul 12, 2018 at 08:33:24PM -0700, Kees Cook wrote:
>> On Thu, Jul 12, 2018 at 5:40 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> > On Thu, Jul 12, 2018 at 06:02:26PM +0200, Arnd Bergmann wrote:
>> >>
>> >> Looking through some of the drivers, I found this interesting one:
>> >
>> > As I said before these patches are fundamentally broken.  Users
>> > of AHASH_REQUEST_ON_STACK can only use sync algorithm providers
>> > and therefore drivers are irrelevant.
>>
>> I don't understand what this means. Can you give an example of what
>> you want to see happen that will accomplish the VLA removals?
>
> Any algorithm that is async must be ignored when you're calculating
> the maximum on-stack size of the request.  For example, sha512-mb
> is marked as async and therefore must not be used in conjunction
> with AHASH_REQUEST_ON_STACK.

Then why does the instrumented tcrypt output show the huge size? Is
tcrypt doing something incorrectly?

What is the correct value to use for AHASH_REQUEST_ON_STACK?

-Kees

-- 
Kees Cook
Pixel Security
