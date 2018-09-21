Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D879ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF69921523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ76pWpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF69921523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeIUSAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:00:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41340 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:00:31 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so11937679iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QBC4eOvcjICWl8SkjX7Xwso3DYrnQd7SI+xze7Og4q8=;
        b=hJ76pWpa45R8fATmTWSzFweAHYFv/Zoa3PVU18zf7XMAXVAWFtswQzPMXHpd96uMks
         DAlnB/74hZCfacatffAS2VY/RhBkmccnH/TxOc5QaSnMDmlfcKB2AX68ilwxWCenJF6T
         cz6ncRDvjpNPWrPb7JGpmddcgPopetHX3b06ZknzW2k9hS3xaZ4gGRJyLchutLVa8rpz
         y1UZ8z5ltcxp6DfhpCbSzPzCGa3GobV8rm2c/RuoX78wkusd4YdqKdUT66tf0Isatq0F
         310MICxgNxH3CwRer8gO3NJgR/u6MNlJrM5SeUJ4Ztbtttv7BI5tB0pJf3NQ2Ks+lrh3
         ymTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QBC4eOvcjICWl8SkjX7Xwso3DYrnQd7SI+xze7Og4q8=;
        b=exVzRHwf4s229KI2mtSUxn/VKLHnSr9voXbk/eX66lV9iac3SbL188UHEumwtRxhrQ
         ITdjr78Rr5TPsfHFWtTyWh2FBZX0xhcqbysSB3W3gcmjXC1tH3Js+SnzSHwAlI7YH1Eq
         mJMxVWfMN8agvyD0+DLb9uO9OLPT/yRdfWv9RIZI7mrr4QLUV8vE1htKQ1lRIO8gPDC2
         FRFOF6LBXk/3NGU0xHRFxjekbErMyvr0zQy0C1YjqlxfVCBJ9S0EK2raK7UQPnyVJnep
         jDNoIwIV01fcGh+FCpPVyOEU5knh9wGHnFXb4oG27wzoeoI46Vbhpz8kyD01Rq8rAsCT
         6skA==
X-Gm-Message-State: ABuFfohTip9JY/erJpJlk3zG+/v5MMX5/vd6TNf+LlnORvB9+JJVXt5Y
        n/PawUi6tDUMpGPJBt/K5WHFwZQO1hFquyvXCiOGXA==
X-Google-Smtp-Source: ACcGV60wadvIcBszp1QVS0nmChP/mKlWZHUsNOI2jO/M8CFow797dpUfV/HqHoDVhs30SH4pYZIyh44cl1bW8pK2i2Q=
X-Received: by 2002:a6b:ece:: with SMTP id 197-v6mr146406ioo.192.1537531915286;
 Fri, 21 Sep 2018 05:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 05:11:54
 -0700 (PDT)
In-Reply-To: <CACT4Y+azFyB6xMtbOGuwUW5jo_dxchM7EdyMWHD_6CU1n9erFA@mail.gmail.com>
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <CACT4Y+azFyB6xMtbOGuwUW5jo_dxchM7EdyMWHD_6CU1n9erFA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 21 Sep 2018 14:11:54 +0200
Message-ID: <CAAeHK+xhxephgg-ibC4zw0vCMOyMBRvh2E0SHRnJgSSdcpsyWQ@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:42 AM, 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> On Fri, Sep 21, 2018 at 3:50 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> This patch seems reasonable, but you emailed the wrong people :)
>>
>> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>
>>> It turns out that KASAN in general will bloat stack frames in unexpected
>>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
>>> default to be associated with KASAN instead of KASAN_EXTRA.
>>>
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>>>  lib/Kconfig.debug | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 4966c4fbe7f7..39078a080e29 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
>>>  config FRAME_WARN
>>>         int "Warn for stack frames larger than (needs gcc 4.4)"
>>>         range 0 8192
>>> -       default 3072 if KASAN_EXTRA
>>> +       default 3072 if KASAN
>>>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>>         default 1280 if (!64BIT && PARISC)
>>>         default 1024 if (!64BIT && !PARISC)
>
>
> Looks fine to me.
> KASAN always increases stack size too for exactly that reason, so it's
> reasonable to allow larger frames rather than try to massage code
> every here and there to fit into the normal frame size.

Do we need KASAN_EXTRA then at all?
