Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AB8214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GoEte3M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AB8214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIQVew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:34:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35098 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeIQVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:34:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so10332847wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZagmP0C+wtO/FGZ31dSbnE44vX4wTjO5N5JoQCdHnk=;
        b=GoEte3M99h2OFJ6EWRIASajwDj4lqxA1k/6Ca3laO3pwov/M6IMUPKSYm6GKHXVLuK
         h8cyDgi+FeBtfirO5sf85At2a30j8PTnyGp52vjz9/l1Pim59HNEng9a//AYCCZ4a0RG
         XqbYw9SDjnpiyL6KuF4ks85CVqW+tB5KUxfIGRTRHofpqCNfYQCd4tTwl6PrAL0UynbB
         ZjZfc4jHgSeAU9GdkdV9hh6FsI4jFHrBJiieHDT2UTLzBeerIa/LCtHvIU0VM6jNnhFs
         LU4lPmPk6JufQ1WsqT4J+Sul0DmAy+OJOIg0C+qyqgKPDILhD2YJ65qRgtIoOF0T3F0E
         9Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZagmP0C+wtO/FGZ31dSbnE44vX4wTjO5N5JoQCdHnk=;
        b=Z5h2GAPQ+rEPYi3U4uMDBrPyHYK/PPP3DnODRtMatBI7PR4saJSivuh65tQIfNs5sN
         IZRRmQosKKg5NbEcOg27RSAeFYPKD+NRpMuwg9puFvmvPjiCzBj8SpHBdB1ftZA0eB6C
         4nnrFVzQixjBkKTW/r0LwSmdvsd7FDh2w7Pw/fPVzF7FvmOZMl3CPUsFz6kYxuL5dWxQ
         eXtygxXgde8X+FdX/QEZHzsu8xJlS5YAD6eOVqu+pNYoqeYYlaT4xFaK+R8T71hIwofp
         XVCxSX6YakCE4Iwp4UBemEbwXLBp0jr3S9KqcLllOJ03GVAVe8IIodM4Ct5kuiTtnifr
         qlBQ==
X-Gm-Message-State: APzg51An0GRAVUmo+c0IEFyJq+nmy+3KZSamLSgoQVQv7pVjyJwiKZ+0
        YGdCgAv49XQsHsKzwOqHe1WTt9vVPgkcJBPYfqfnJyVx
X-Google-Smtp-Source: ANB0VdYLbcNThGezXvYRpV4mx7bN+uHBaNwMz5swaIhgZrvRq2WH8+2Pz/IB/IQpaaxcPmysiBxsSnEiLHGoeCyYkXE=
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr12275207wmg.149.1537200410075;
 Mon, 17 Sep 2018 09:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net> <CAHmME9qQR4ynsZ5xXejEdnr3oZcOnpRRTdohX+eT9Df+AU2_iA@mail.gmail.com>
In-Reply-To: <CAHmME9qQR4ynsZ5xXejEdnr3oZcOnpRRTdohX+eT9Df+AU2_iA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 17 Sep 2018 09:06:36 -0700
Message-ID: <CALCETrXXg_nnp_pafK3+Pwd00PRUr=X=WfLu+YFYeggRs8-i1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, andrew@lunn.ch,
        Eric Biggers <ebiggers@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 17, 2018, at 8:28 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Mon, Sep 17, 2018 at 4:52 PM Andy Lutomirski <luto@amacapital.net> wrote:
>>> * (Nit) The GCC command line -include'd .h files contain variable and
>>> function definitions so they are actually .c files.
>>
>> Hmm. I would suggest just getting rid of the -include magic entirely.  The resulting ifdef will be more comprehensible.
>
> I really don't think so, actually. The way the -include stuff works
> now is that the glue code is inlined in the same place that the
> assembly object file is added to the build object list, so it gels
> together cleanly, as the thing is defined and set in one single place.
> I could go back to the ifdefs - and even make them as clean as
> possible - but I think that puts more things in more places and is
> therefore more confusing. The -include system now works extremely
> well.

Is it really better than:

#ifdef CONFIG_X86_64
#include "whatever"
#endif

It seems a more obfuscated than needed to put the equivalent of that
into the Makefile, and I don't think people really like searching
through the Makefile to figure out why the code does what it does.
