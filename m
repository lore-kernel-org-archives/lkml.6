Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BF0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF52081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agqNif+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EF52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbeKFGIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:08:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34310 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeKFGIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:08:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so17222902qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POR74V9H1zLlU/gAT03opgctU3tVzADNURrjgzcNZV0=;
        b=agqNif+sl8IqnaNO34h/gZldTm0rTltoiZ4Q2SmL9bTRjlaEM96UtIva+3N/QFFPQq
         CmhvG3DE2uJFJouNKOpi9shVZSb+kDGjAtuZ6SgEIWU3UrSjy1a9r4b7SXUEy3lFlVGN
         69Jo80PbvTK6QGBRLSwYMexx+FyYd+9pjH9tZ+Uz+25y/Zd53en5kv2ypRh+TmYot1wr
         1HMnbAsOmEcLyL1YGNqCpACIBJ1tDAtec/arxryKEmlEZJ2NVA38HHZGF21CqEF5YszB
         ZRVeZiAeSx76mwKqtiZrAdH6GW5mDKw6C8eGkyMF5O8vlr0u09vT7uy2txiQMLoijDy9
         SEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POR74V9H1zLlU/gAT03opgctU3tVzADNURrjgzcNZV0=;
        b=HJRyQbS0UanNxUWvYvoULJn/wO8WTi0ZZAAjMhhsEU7yZpMKyWcBB39DBK2cS3kdja
         E/gtiFouG1WKi4enBlyI6K18BOsPqUz+kAHc7hRTvF27p+9OZFKoLz72HrU2S3wcOUAe
         7Axwp023XsNYsGh+jzVcdDMFW3KwJQsyMXEgne1oaWmO1r3PF6ofeyKmRQlakfi4QjML
         BbeB5Iclw4RxN7BNw9PkvACI4i1aapt93ajg6y5BDoLZuL2LA96ap63ETLoPHnmMAy4c
         9uLUG6YZFn5NeTwrZZJvUJRQbm/LUykeO+uF9AkwhZYy35cN6uGJjMl5ysGTxXMvLkE1
         tDxg==
X-Gm-Message-State: AGRZ1gIMqlHrAqOkdTq69byEk35jR/QS0DaW6nRCZXTv8S8b3fOMiOi+
        UEJAluK2r9S19zXdOUum/DL3vy1f1QQg40/L1JA+RRsL
X-Google-Smtp-Source: AJdET5cBoWenJwTLt63glInRw8dxCbHTJorzZNodonqYE1m4pn+ikXe5dx1Ft/mEtPF8U7Ouprvf8El9uKBNYJbR53s=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr20874355qkc.219.1541450825994;
 Mon, 05 Nov 2018 12:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20181102112456.780127-1-arnd@arndb.de> <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com> <20181105133545.GF10650@smile.fi.intel.com>
 <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
 <s5h1s7z35t8.wl-tiwai@suse.de> <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
In-Reply-To: <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Nov 2018 22:46:54 +0200
Message-ID: <CAHp75Vc8W6sOOOF4WUaoVD2rGijwG_5J083UG1YFgptTkuzk=w@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        guneshwor.o.singh@intel.com, naveen.m@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com,
        rakesh.a.ughreja@intel.com, sanyog.r.kale@intel.com,
        sriramx.periyasamy@intel.com, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 7:19 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >>> We have this ("strange") lines over the drivers:
> >>>
> >>> config BAR
> >>> depends on FOO || FOO=n
> >>>
> >>> which guarantees that FOO will be not module when BAR is built-in.
> >> That's what I normally use, but I could not figure this one out.
> >> One problem is that SND_SOC_ALL_CODECS selects
> >> SND_SOC_HDAC_HDA, and SND_SOC_ALL_CODECS itself
> >> may be =m, causing the failure for
> >> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y.
> >>
> >> It might work with a separate dummy symbol:
> >>
> >> config SND_SOC_HDAC_HDA_FORCE
> >>           tristate

> >>           depends on SND_SOC_ALL_CODECS != n

Forgot to mention that AFAIU above line is no-op in symbols which are hidden.

> >>           default SND_SOC_INTEL_SKYLAKE
> >>           select SND_SOC_HDAC_HDA


-- 
With Best Regards,
Andy Shevchenko
