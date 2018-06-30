Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A22CC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174A9242BE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BplzAP9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174A9242BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030291AbeF3L7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 07:59:11 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37006 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934688AbeF3L7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 07:59:09 -0400
Received: by mail-vk0-f68.google.com with SMTP id h22-v6so6780291vke.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PYSv375y/UZ+BU+FOsbApa3vuf6glPy07dxxTwe1jc4=;
        b=BplzAP9bp9zDbBWvRBT4fxGsB5+BbQPCnRFYjB1u4NKIMBL2vTcUM6lZ+RrXQ+ZRlA
         a/09a2lFpcJZshDwxKobpNmUYfrFEZGV5nmH5+uLsbjxHaClfrtAPiwapZDay97S4YVO
         aybYW9oj359wSuLZWEMvzHNFS81pQclfChNlzy24nzo9h+ZQ4DjJOSamGUca7bMjLDcv
         8Xw6NuxoJovslzJM4GWvqMsfhG1eIkNpQ9UEvZCmq/Kke3tNHPMZC17OfouAaTaPWoFN
         fdhpgfwk6f6s2vbyRYcklA4QgFJ2Ew7/WelUSO8gRVhBFDjqFQCoxLl8S0gkCjg5Ib2T
         +EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PYSv375y/UZ+BU+FOsbApa3vuf6glPy07dxxTwe1jc4=;
        b=oiVYCC+E8YldBxXRodoUVy8zMHdkgMPmVIRNZApBa+ELPTqpC4eNNTVOBOS5vjQFTS
         TzZjJo8gMkTh3lH5aCnlhTQlx1CDbQDCwANcbNBV4aQvXiowfjVO1RSySZGeKZbrLToo
         LohH6q/CmG6bS3n1Ru+2q9/7jAmnZbUEZMfKKTjI0FkjoHnWglprQO+OS8sX28j8+1pd
         nHQQ8GxzAViCPcNG6mxWfhkWTCGysGg6q+8RAJT/BUKffXSVc3TuK/Gn0Okugyme86ys
         K5pyPZQyDYHXnXsh1Zukhu0YmKn5fyqNXf17Lq1LANZIOwPNGDJ34KX6OfpwxLRF1XoT
         eEUQ==
X-Gm-Message-State: APt69E2tlfWGNqxEdOHbs9StqQiwqGQQR75h6eonZGaoYoGk+SZWuSG/
        +c205ndT707Uaj4NSCinjYUXwjMeaJKUY+cgjLA=
X-Google-Smtp-Source: AAOMgpcXbWA+HLk2zENdQMT+uFOG6IxCu+H9iToACc93Kn/jS3Gzl0KvbjkzCVgHU7VcMhNym0f2S2udX/mAo+b9Lc4=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr11741211vkd.161.1530359949113;
 Sat, 30 Jun 2018 04:59:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 04:59:08
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806301120010.1595@nanos.tec.linutronix.de>
References: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com> <alpine.DEB.2.21.1806301120010.1595@nanos.tec.linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 Jun 2018 14:59:08 +0300
Message-ID: <CAHp75VfY5w_c-V2D6NwraUMxtz_xfAEFanm8jTeF11=nrb5t1Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] x86/tsc: Clean up legacy code for Intel MID
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 12:24 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 29 Jun 2018, Andy Shevchenko wrote:
>
>> As Thomas noticed there is unusual initialization is going on on Intel MID
>> platforms when TSC is being calibrated.
>>
>> It appears that we have tsc_msr.c to support Intel MID in a more generic way.
>>
>> So, this patch series removes legacy calibration code and does accompanying
>> clean ups.
>>
>> Has been tested on Intel Medfield and Intel Merrifield platforms.
>
> Nice series from a quick glance! I'll have a deeper look on monday.
>
> One thing on top. From your earlier reply:
>
>> This sounds like a stub against very old calibration code since Intel
>> MID has no PIT, HPET, PMTIMER to calibrate from.
>
> As we already know that the legacy calibration cannot work on those
> machines, we really should splt out the msr/cpuid based calibration method
> into a separate function, which is set for the intel MID stuff and called
> from native_calibrate_tsc/cpu.
>
> Hmm?

But that's what has been done back in 2013! By some reason, I dunno
why, the same author didn't clean up it.


-- 
With Best Regards,
Andy Shevchenko
