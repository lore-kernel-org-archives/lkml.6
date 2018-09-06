Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66567C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084AF2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emunWXbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084AF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeIFWMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:12:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35373 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbeIFWMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:12:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id f62-v6so6169897qke.2;
        Thu, 06 Sep 2018 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yJLeQMDWomz27jyq2uEU0Dzp5ornZDwItNZ7nt6G27Y=;
        b=emunWXbB3onnwfR3kFNe//wxmSe1+pKjimPbAMeN4oHvTH09YxsiuBOCyrkZ7yaYHp
         nF1ofxFFLK/VcKM9Z0wTYeKp6L9Z3M7AOUlmnGriHtsyWdAmvD2k6Pr+bMNjYLuCOJDJ
         Ae3fQTlkgwJ3yw2fGx/4qm5Bn32X5fETmtv8admlSopnIs8YntLAxnqBgGvrMqlGE0O5
         4H4JCi+y0F77tY9sYCBs3FyW2SiHKAl2SinZTDkZ+gE5Jqoj5QqlzcaXVPbAkzxP8Tce
         NO5elyKd+1VyZHLgrA6bWLW1wAO0/mck5+ZRDnNzN1KcIBDfentLsJVEsIqDfKHoNPJ5
         wInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yJLeQMDWomz27jyq2uEU0Dzp5ornZDwItNZ7nt6G27Y=;
        b=KeIliExWkABETV58yz6vjvhValAtr0jxvaW6PRNUC6UqqMOeE4smcKxKugbr6nup9e
         23i9nNFDjvAKPrEVLtnpCNIcK/3Tb54kRv1J9MmZN4akBoHnOn4CbTdypo4C/mq45Bxp
         ET2oUn7Pj4BTZt8vaZLZQ2LvrZV1/n23U+buZkGLVew45gfOrm0QGeV2+NpNUeNQI8CI
         3fxgiKvUSfVkekmWRYZltL/k6a+qiwr4nRlLscoKe9WeeSRfqCRsC8DPq2gqndOskPoi
         +0qVH7ZKiBIxi/HXmmb487FhUyV1YvPP+v6uOrfX02z6fOUmrFlXQaxnRdZjR7jekpmL
         N+pw==
X-Gm-Message-State: APzg51AB2WCleanXyFneELSmyS6jg9eyQoLAGW3fKCKMoWmgMBLUmKG+
        OyqHadizgBwDfJMMr/cF9q7HMWcGfz8wgJ4xp9I=
X-Google-Smtp-Source: ANB0VdYfL9v/QZdbkHDkVHtUVMSeUInb4LjK73rCfTJUPOYxCcOgyB2nre+R+aC8v7zobqCBFhlKgWX9HVQ0DADQvp8=
X-Received: by 2002:ae9:e118:: with SMTP id g24-v6mr2877352qkm.306.1536255367018;
 Thu, 06 Sep 2018 10:36:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 10:35:46 -0700 (PDT)
In-Reply-To: <20180906092100.GA27302@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-12-jarkko.sakkinen@linux.intel.com> <CAHp75VcqKunkHYNdd287_F7APHwYr7K9QD2PVCkqBqJWG2_E-g@mail.gmail.com>
 <20180905173355.GE11368@linux.intel.com> <CAHp75Vc2SZUfRnBPZ9xJ_B=KJL7yK9hqRZiFOTswn0AzjnLD1A@mail.gmail.com>
 <20180906092100.GA27302@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Sep 2018 19:35:46 +0200
Message-ID: <CANiq72kpY1y2aPH+GMi8mWZdttfdYJ3wk0cvE_qVD97vdvTJbQ@mail.gmail.com>
Subject: Re: [PATCH v13 11/13] platform/x86: Intel SGX driver
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, shay.katz-zamir@intel.com,
        "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Jarkko,

On Thu, Sep 6, 2018 at 11:21 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> There is another open. If I grep through the kernel tree I see SPDX
> headers that are decorated both with C99- and C89-style comments. I
> guess I ended up using C99-style because when I was instructed to add
> SPDX headers in the first place that was the example I was given. Still
> checkpatch.pl complains about C99-style comments.
>
> Which one is right and why the kernel tree is polluted with C99-headers
> when they do not pass checkpatch.pl? How those commits were ever
> accepted?

See Documentation/process/license-rules.rst. Headers should go with
C-style comments:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source: // SPDX-License-Identifier: <SPDX License Expression>
      C header: /* SPDX-License-Identifier: <SPDX License Expression> */

And:

   If a specific tool cannot handle the standard comment style, then the
   appropriate comment mechanism which the tool accepts shall be used. This
   is the reason for having the "/\* \*/" style comment in C header
   files. There was build breakage observed with generated .lds files where
   'ld' failed to parse the C++ comment. This has been fixed by now, but
   there are still older assembler tools which cannot handle C++ style
   comments.

The ones that got in are probably either old or they slipped through
(and they do not break the build).

Cheers,
Miguel
