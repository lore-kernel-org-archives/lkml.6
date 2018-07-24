Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8142C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81151205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HuqwPSgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81151205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeGXPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:17:10 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40140 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeGXPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:17:09 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so3838514ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kb2TEyjeql1hkKijTW1lW48oHwRS0nwKHhakJ0wPYpg=;
        b=HuqwPSgHdCfPPhwdQaIVTQZVyaiqFZe0SVYwynhceVdBMcOat8WtDOoKs2R31iGL6V
         7o6WNPSEy37yO+BOriRiCPvMEowUjR5NfE6oWrVMwMASivEYZAh+6Cqj6CKts1uHWVz5
         W8R2lVjaq0KrR7d+1Lsk7+5XvVItvCXe6yNitSAF7Kyx2RS5cpgkA1sYtsNXoN7qRU6x
         GwdSD32fHP1lREx4dVgH5cexpZyGadEskm33d9ImOD4/DrnKozwGxv+IIJzyiG0X0Dmu
         c26TQtMTG0w4btBpa+Ih9okThPBTS5vDOvvHN7lB4BkIcqUUlKwSQJsdNrA/TSTxls4h
         ygmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kb2TEyjeql1hkKijTW1lW48oHwRS0nwKHhakJ0wPYpg=;
        b=KXEDxlSiQ7BUdgnTD9Tyms+odQltqBPBJ057+JhhPMWEqrJYyLpKsDgEVrqAsi2Q6d
         tuPQCneglaAUE0ZVdgP6fOXC+KItS59Z5U40RMw7eswj0NziLNpKf5gS2VGC47vU77iy
         g/Q8rW8yWnUV9Du/TukIBQp7C8vMDO4alsYWOT7taYJRxqOzbDGQSFrWSUG5WoK4Z/kW
         gG7O+Klr+rQmFO8VlAXhCiH1ojmfsvMpKPButW74ga5oJvN++OJK343gEfrPez2bTW7T
         f2+AJQ6JI//sBQffZmAjcIVCOFErjD9I3ZKOjRVkkm8E0C8JFfijheAwIFMAAshG+GPV
         d8/A==
X-Gm-Message-State: AOUpUlG7Kh85+uSl6Ft2y7gULQc4V18yrCRZdAD6YQPMj7HV/Y9j87N7
        mOCsImcXjjP6aTSr4gi0X3Y40KmAEJt5MrHiN2kohg==
X-Google-Smtp-Source: AAOMgpdmsT/KDrzacuwQn/JeqQd9Jqk/+l8kVPc2UXwOxloJwFaILJDXBpjzsoRhgql+/DPio2CQm8yW95tRGjjHNH0=
X-Received: by 2002:a02:943:: with SMTP id f64-v6mr15537838jad.31.1532441429560;
 Tue, 24 Jul 2018 07:10:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 07:10:29
 -0700 (PDT)
In-Reply-To: <20180724110712.2f26evp3kdbnhyhd@paasikivi.fi.intel.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com> <20180705212204.GA10449@rob-hp-laptop>
 <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
 <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
 <CAMRc=Mc4s6tJw6dAHYCPQdsPox9V8sBTqY3LHi5XMWALwOZdyA@mail.gmail.com>
 <CAMRc=MfNa0OwMbJ6ibbCJJD0pV9tKtyTZ3cQi34ra5oc_-5jYw@mail.gmail.com> <20180724110712.2f26evp3kdbnhyhd@paasikivi.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 24 Jul 2018 16:10:29 +0200
Message-ID: <CAMRc=Md_A3_aiuOwCiBKPyBBZ8EtOxfVyttWp7uH2Em_DRWmDg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width property
To:     "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
Cc:     "Chiang, AlanX" <alanx.chiang@intel.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Rob Herring <robh@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "jcliang@chromium.org" <jcliang@chromium.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-24 13:07 GMT+02:00 sakari.ailus@linux.intel.com
<sakari.ailus@linux.intel.com>:
> On Tue, Jul 17, 2018 at 10:01:17AM +0200, Bartosz Golaszewski wrote:
>> I will soon be sending my pull request to Wolfram, so if you still
>> want that applied for 4.19 - please resend with the commit message
>> fixed.
>
> Alan?
>
> Not sure whether it's too late for 4.19 now though.
>
> --
> Sakari Ailus
> sakari.ailus@linux.intel.com

I may still be ok until tomorrow if Alan resend it.

Bart
