Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8778AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAFC22B69
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYvJ14rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAFC22B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGFUNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:13:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35688 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754036AbeGFUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:13:17 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so10703289lfc.2;
        Fri, 06 Jul 2018 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XMrY7YOO7CL1LLcYwG+3HVKeZLcyV9Q77HYbZ3gMvbw=;
        b=UYvJ14rS7SQd3tu7QC8mko3jzvtvnjJa6xLi1jp9hzWei2WgbES9N2p+ZUA7N3AGSp
         onQ2aWJiKj6bzImprs/KwI0M7jatakEyAskYSQJMWgf9CWXUgqNeCUkRXaNnRj7sIOCO
         ikmWJ9KGlBpX5lAwtmAkhoT2Ckw2qDrKLhd2NFB87ae6/8TX3bpsMt+DyDM23p1cou6N
         X//Eu25Sny//QzhxDRZn7G3AVtAmdoRBVXwA4tHFOlYTWUJbES02IsnSPuHeaZCt+1l6
         LjrZwhG3/yRj0EDzaO4CJIE5jBHUlYS4pgPdwQnCkRag73frZgxgIiruYhD2qE5UiDqc
         OYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XMrY7YOO7CL1LLcYwG+3HVKeZLcyV9Q77HYbZ3gMvbw=;
        b=lPE8ybwd1i5eqgTBepsBrdBU0AiNbPra/pvwu2iK87HbRQNO53xcGd5rUiiBPxMKr7
         ebm00wR70D/cx3e9wK5msIKq1qoS3mSkJN+IUpA2JlKpKUsny4DoGHDV0plQncI8q3mx
         IOXQf2Q4nj+I3EfC56QphvFxVS+GG2R+d9NBbY8jxpbZhMp+TOdaPKnlnMnwT2LBjKze
         myqQwB/+6ZvEVyLzMiz/xHK5bJLpffUkPUGMpwHjk79WzsL1+n/r79tSZr6U+VU8n9Rv
         o59BUAMxVmADZFG+F6IHEc0i0giTtx9aPCTre0SLlwz4TWEGTvOzwXfaPpZwfVH+Mgor
         lg7Q==
X-Gm-Message-State: APt69E0Ca0hu9zzGsblO0YbfRZtGDuiMSmhp6Tsj5+WyvHlLJ2vz4gTB
        76dauRxuKGTBpzsZKbtrCMYUy6C2clmrNBzeRTs=
X-Google-Smtp-Source: AAOMgpcIOxn/AOuY5xY0miXbp+FI34Y4OsEhr2PTnXm9EKpliGwK05S9GgHoevCAfvGwKL7TZYgDnbhaENICFlie9lw=
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr8197139lfe.60.1530907996081;
 Fri, 06 Jul 2018 13:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:741:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 13:13:14 -0700 (PDT)
In-Reply-To: <CAMuHMdXTF=Zfm7Dm1+_q6yhccQXYsPc=wQaHDBSsq4X7ujg4sQ@mail.gmail.com>
References: <20180706151610.3783638-1-arnd@arndb.de> <CAMuHMdXTF=Zfm7Dm1+_q6yhccQXYsPc=wQaHDBSsq4X7ujg4sQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Jul 2018 22:13:14 +0200
X-Google-Sender-Auth: P2iSGNl7pL4JbE9m-JIqQb-tAUA
Message-ID: <CAK8P3a3qCAxBKBs0vcr0Y9HXm0DHY7aii4S3P7M010JOkcxCvw@mail.gmail.com>
Subject: Re: [PATCH] soc: r9a06g032: don't build SMP fiiles for non-SMP config
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 5:23 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Arnd,
>
> On Fri, Jul 6, 2018 at 5:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> Without CONFIG_SMP, we get a build failure:
>>
>> In file included from include/linux/byteorder/little_endian.h:5,
>>                  from arch/arm/include/uapi/asm/byteorder.h:22,
>>                  from include/asm-generic/bitops/le.h:6,
>>                  from arch/arm/include/asm/bitops.h:342,
>>                  from include/linux/bitops.h:18,
>>                  from include/linux/kernel.h:11,
>>                  from include/asm-generic/bug.h:18,
>>                  from arch/arm/include/asm/bug.h:60,
>>                  from include/linux/bug.h:5,
>>                  from include/linux/io.h:23,
>>                  from drivers/soc/renesas/r9a06g032-smp.c:11:
>> drivers/soc/renesas/r9a06g032-smp.c: In function 'r9a06g032_smp_boot_secondary':
>> drivers/soc/renesas/r9a06g032-smp.c:43:21: error: 'secondary_startup' undeclared (first use in this function)
>>   writel(__pa_symbol(secondary_startup), cpu_bootaddr);
>>                      ^~~~~~~~~~~~~~~~~
>>
>> This makes the compilation of that file conditional on SMP support.
>> It would probably be better for consistency to leave that file
>> in arch/arm/mach-shmobile/, matching what we do for all other smp
>> operations.
>
> Shouldn't that comment be moved below the "---"? ;-)

Maybe

> I thought the (10Y ;-) plan was to have no more code under arch/arm/mach-*/?
> Note that the suport for the new RZ/N1D SoC doesn't use any other code in
> mach-shmobile.

The SMP code is the main part we never figured out where else to put,
so it's typically the only thing we still have for new platforms under
arch/arm/.

>> Fixes: cde4f86f9249 ("arm: shmobile: Add the R9A06G032 SMP enabler driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
