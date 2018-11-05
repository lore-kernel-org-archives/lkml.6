Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D764C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C56C2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB1W0aEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C56C2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeKFGkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:40:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39908 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeKFGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:40:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id g10-v6so309451qtq.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t9KnYBbC6C6YjrLgIWaZbeCHiiTN6MB9j9oa/4TmNTY=;
        b=TB1W0aEcbD6B53CRnOOL6Vsf+Xul6db++0WgXDF6MMSF4PCi/vDGIok5FOYG6sRKuK
         K//FEH+uLa8YWLX2ae+9wrM5jbmW5NSUSHPbMAFfWjZTVEkoh2Wjne2RyHifsxbZi1FG
         lxS3z/CRFabf5GFvb+NplBbCCEqVnhoDxQ6hO6ZNjxkuMA6H7wURxCp50zfePuBYjtkc
         lZxj68OJ7PB7h1lhLxdEBrHpxE2bw75/oOZ7YGFL406A6+23LCFmfI5p8CyNVzAshH8P
         XBQ7lf+YTtgGLGt4ICAoPMBcotxwf6lwuiQWtVDNKGLCk1kVYq1YU4ZQfG/6dkolPmq5
         TD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t9KnYBbC6C6YjrLgIWaZbeCHiiTN6MB9j9oa/4TmNTY=;
        b=Rwy3Vu5Q9ylQb+IslxeBVNevNincvuYsOK9NlyAKeaGv2kQWJoHH+Sfs3JvjqEraJq
         MepJEqQkt9vXc2ZByAYCGjJrblwRamOwNYeT6uIXwxVGSjGuAIclvioxCzP7SIIrEvpl
         rry0wFi2Ik3OELGJePQ3M4hBOA6MtdJA1iP8sqRVXdOZnrxWCKdv9D8M/h9pj9sEe5w+
         9jOHoPBykFQeUCZUy4AvFc4w+M461Phx0vLZe1Wf39fkgwv2vH65F6NziYBPqX2bdAOj
         +X0i6uoAOZnuI9jzYAHb5s6Zqg/u5M5wY37H/z13UGG53T+lzfZSx5kwT8ct3+ZYlTdZ
         ws1w==
X-Gm-Message-State: AGRZ1gL8y+uLRA/fSI+L3AQ0++uQoOm920Zd2Q1T9uGs3xdVfEwXeBjT
        jlQcgtlneT3bfksiyeXBkf5HCnZx2XdAJF25n9k=
X-Google-Smtp-Source: AJdET5fHtLf/fjAPH5196VmM+Hgx4yZ2qYexwxOMJmh2a/+RyR/AhSqFgDuTgwZF/B/dd6xqje0HvvYx6yRHN/FlQgc=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr15203009qvk.40.1541452742793;
 Mon, 05 Nov 2018 13:19:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 13:19:02 -0800 (PST)
In-Reply-To: <CAHp75Vc8W6sOOOF4WUaoVD2rGijwG_5J083UG1YFgptTkuzk=w@mail.gmail.com>
References: <20181102112456.780127-1-arnd@arndb.de> <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
 <CAK8P3a1FCVTuB+ydE6syMHYPWnUW0WTCFDuyMmm35VNnpTTGBw@mail.gmail.com>
 <adc83eaa-b7c0-2c76-a434-f1d5872337f6@linux.intel.com> <20181105133545.GF10650@smile.fi.intel.com>
 <CAK8P3a0kdUtK_UuSJEPiWPxhdDULmW6RYEzu-Ug7f8VBoeWVog@mail.gmail.com>
 <s5h1s7z35t8.wl-tiwai@suse.de> <5c21e5d9-6a14-ff4f-04f2-9dbfc8665250@linux.intel.com>
 <CAHp75Vc8W6sOOOF4WUaoVD2rGijwG_5J083UG1YFgptTkuzk=w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 22:19:02 +0100
X-Google-Sender-Auth: aFi50GDS2TxdTjVrlBeUIKHDTDY
Message-ID: <CAK8P3a3yWJJMqV8mRB9bS0K=+s-nvygCEk+zdSQBU8YjGwx2iQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
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

On 11/5/18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Nov 5, 2018 at 7:19 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>> >>> We have this ("strange") lines over the drivers:
>> >>>
>> >>> config BAR
>> >>> depends on FOO || FOO=n
>> >>>
>> >>> which guarantees that FOO will be not module when BAR is built-in.
>> >> That's what I normally use, but I could not figure this one out.
>> >> One problem is that SND_SOC_ALL_CODECS selects
>> >> SND_SOC_HDAC_HDA, and SND_SOC_ALL_CODECS itself
>> >> may be =m, causing the failure for
>> >> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y.
>> >>
>> >> It might work with a separate dummy symbol:
>> >>
>> >> config SND_SOC_HDAC_HDA_FORCE
>> >>           tristate
>
>> >>           depends on SND_SOC_ALL_CODECS != n
>
> Forgot to mention that AFAIU above line is no-op in symbols which are
> hidden.
>

It's not. In this case, it will prevent SND_SOC_HDAC_HDA_FORCE
from being turned on by the 'default ...' line. In other cases, it can
generate a warning if you have a hidden symbol that is selected
by some other symbol while the dependency is missing.

      Arnd
