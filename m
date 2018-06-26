Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3626B6C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="n1e5RgAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D3626B6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeFZNaf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:30:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53124 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965412AbeFZNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:30:33 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so2320330itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P2P2H0fm437n6tTQ49a9eBicnB/nfuRydIxc3Gjt56c=;
        b=n1e5RgATpo+2uShehgpOHVhMlisoMinRNyVhE7ITVtS8b0Rc0787ULFZFov1uBfxy1
         z2cM/34AzhqOdHAdneS40GgJiZgrgioFoipcSclXaAktbVmb+B4hq6XcSplzWTJqjItD
         w1MroQaU4FQtAj/nh9bImOlr4hmrh5Gz9O8ufoMX7+n6SeFPwoDtzOvunoI/zcimqJ39
         lL3fcv5uZpfLOwsYXskf4tSzl6XNFTCN71d6PhtPaZfYBe/TZ2dv+EoywXd3ZbBulX0g
         rb3dPuOjIfgm/jmCHDUk2gKnqrl5O8SOIXSuUt+QukOTCC3l8ETIBCfeI8BE6HqE3PCf
         y/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P2P2H0fm437n6tTQ49a9eBicnB/nfuRydIxc3Gjt56c=;
        b=qmtmeOtmmmInUKkjn0AcxgO5Fs4CTtdhmNoInq8GEyyqsfi2AooqliuF0fDmMyo+KV
         DBqOuPwAHD5qdQkcderUV2V3lEMkTxblNtVFAfiun/g0zpGR9Uv0DldLh5WXFsJLOuIx
         CFuG0tWTAKQnHptayMA2TBrjZSec/eT6e+5Q/ZVZHU3r5u+uEtYwc/bDBKF8kjh1ktsX
         s2YM51L9pR8l/koWJZDw1s8Icm9reYFvlNF1HDlae5xNkQTQ8XmCFHT4kmIhRzlhtnZA
         9DjaLM7jIAgf9S2BHk1K5avvSHV6mKXQ4gGVvOn92Jg3z887Vi4Qus+3d7/MJA8XvRIQ
         KPKg==
X-Gm-Message-State: APt69E0yN71FDlYbk3N3hue4s8cEyXgysPCA/BhxnMmGzGM+L4rg9KNA
        36uewEh2oVO/qNGHyc4c/q/lZUu3d5ewiBeX3NYZtQ==
X-Google-Smtp-Source: ADUXVKKseEOEEuRRQj1oVO8/mfomWwETT6FioVy8zSL+nxEHYoBDGu1G+WgbGWodZgYCvqeqF0Ii5H6DlNjasLtVwrU=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr1392936itg.141.1530019832417;
 Tue, 26 Jun 2018 06:30:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 06:30:31
 -0700 (PDT)
In-Reply-To: <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
 <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
 <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com> <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 15:30:31 +0200
Message-ID: <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alanx.chiang@intel.com, linux-i2c <linux-i2c@vger.kernel.org>,
        andy.yeh@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-26 15:23 GMT+02:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Tue, 2018-06-26 at 14:36 +0200, Bartosz Golaszewski wrote:
>> 2018-06-26 14:14 GMT+02:00 Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>:
>> > On Tue, 2018-06-26 at 09:41 +0200, Bartosz Golaszewski wrote:
>
>> > > What is your use case exactly? Do you have an EEPROM model that's
>> > > not
>> > > yet supported explicitly in the driver? Why would you need this
>> > > option?
>> >
>> > The current at24 driver has no address width support,
>
>> >  thus, reusing same
>> > (allocated) IDs (non-DT case) is hard.
>
> ^^^^^
>
>> Every supported compatible has the width already specified in its
>> corresponding chip data.
>
>
> Please, read again carefully what I wrote before.
>

Ok makes sense in that case. Could you just point me towards an
example model which has the address width different than the default
for its type?

Bart
