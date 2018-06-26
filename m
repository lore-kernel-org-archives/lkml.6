Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33C626A9F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wrDg8gpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33C626A9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934839AbeFZMgE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:36:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55195 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934275AbeFZMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:36:02 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so2048831itx.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=okkySY9KxEoUIlM0lHrmCrCFegum6Zxhe9BfflLqbtw=;
        b=wrDg8gpCAokQ4KZQHCr0zXvBwxZSxcL+Aa3Y24cSKm6l9dSnV6qD7WXbjjGGk/a/Xf
         DhH82Hevyor1JuhBlrnCqrLd5A5AUpUPPKgECbLmzQZvQ2CXXwKIut/rGQOG12kEzn6f
         h6I9ZJBnlS9hORXsqNWgRTdsddfeqbU417LTfxQm7s4Jb8CUP3A+BSmivNnTXTUbrWOB
         yzGTsZHwRJaNbb9H7UCsn4I+KZlQvrAfdhp3KUWKpuvsOiUNLwfADZ/ii1RcoAYO1BzB
         RnAtw80p1w9WR/q6xi08baCFZvdFC/s52YLYqbFDlJN+EjnFCdd8RVgyH0b+3FTXmPIT
         /ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=okkySY9KxEoUIlM0lHrmCrCFegum6Zxhe9BfflLqbtw=;
        b=LrkyrK+jrLIf8jqLSDtZkapTz6tOCT2iB3ozuyZR7kegi8xqpiid81lszSO+jscvTq
         gsTr0WFJpN5svngJe5rBm/OkqJGF6entUtgBvRVrH5vd51tuPn9BI+W45rvAkhHDLqTk
         Mb1YPLwDdCu0vsahvgENkR7zjr+AIxzbPSeEpNSs8f1jkQpoKatV6ZyeIXx8eQeYuDi1
         q1noVZ7VORhM3Zwac7UHOwZHXL/RWMK/r5btvaqg7Qr4MdT5IysPODz8s9bhY2TChCDx
         iiO8o9vhfNHV9IKw85SfRm7TgwOLUrhPQn6fSVFrHQK1TTZLUTQ9EUgDFsYxjUMPNAp5
         rsNg==
X-Gm-Message-State: APt69E0LDDzLsjU6MhkrZR+r6A0ngqaQCEEkAw2g0+laBpGaKRjnvEDP
        mD4bMyErlHQFcHpjhq7YHdt2Zl227oMMQHS4BuAw5A==
X-Google-Smtp-Source: AAOMgpe8oSG+HwIhEPN6NaPdfpcom82j7W+/AtDxoox8B54wYrfSy1PiTNtHmPLTpVVzpKfNuifrPZ+JdlyIsPgvs2c=
X-Received: by 2002:a02:950:: with SMTP id f77-v6mr1069597jad.31.1530016562044;
 Tue, 26 Jun 2018 05:36:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 05:36:01
 -0700 (PDT)
In-Reply-To: <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com> <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jun 2018 14:36:01 +0200
Message-ID: <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alanx.chiang@intel.com, linux-i2c <linux-i2c@vger.kernel.org>,
        andy.yeh@intel.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        rajmohan.mani@intel.com,
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

2018-06-26 14:14 GMT+02:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Tue, 2018-06-26 at 09:41 +0200, Bartosz Golaszewski wrote:
>> 2018-06-26 8:22 GMT+02:00  <alanx.chiang@intel.com>:
>> > From: "alanx.chiang" <alanx.chiang@intel.com>
>> >
>> > In at24.c, it uses 8-bit addressing by default. In this patch,
>> > add a property address-width that provides a flexible method to
>> > pass the information to the driver.
>> >
>> > alanx.chiang (2):
>> >   dt-bindings: at24: Add address-width property
>> >   eeprom: at24: Add support for address-width property
>> >
>> >  Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
>> >  drivers/misc/eeprom/at24.c                        | 16
>> > ++++++++++++++++
>> >  2 files changed, 18 insertions(+)
>> >
>> > --
>> > 2.7.4
>> >
>>
>> What is your use case exactly? Do you have an EEPROM model that's not
>> yet supported explicitly in the driver? Why would you need this
>> option?
>
> The current at24 driver has no address width support, thus, reusing same
> (allocated) IDs (non-DT case) is hard.
>

Every supported compatible has the width already specified in its
corresponding chip data.

Bart
