Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1AFECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DCF2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hwTJfywd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DCF2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389481AbeIUOaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:30:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35619 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:30:18 -0400
Received: by mail-it1-f195.google.com with SMTP id 139-v6so1090541itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VCY11d6Q8u0HYNWtx8TAGoyh4KZuFvy2DdJdgLsq9o4=;
        b=hwTJfywdz5WnhE5Nga7GttYtqDQjsF3XZQoVKgV7ljaH2NcjzBeTucVUR8VQhvipMi
         oQePY5IU2hEXJ5e8QsU3oTa1uqKbHcn7LOj6+ynA8cMJHsW+O97BuR5FVgcbndXblCh5
         ebG9/HiOiBiYSkco9t1WePM7IrLWzWaXdA3I9S4DkBqwSzzmI0PqCg56a4z9XJfoHO81
         7e/p5PXSQPx6M4XKXw04s6qQnbVeIS04EHgsmwpnq3sOPsjkLieNQLkAX+B5e8s9zPkA
         6SWx+fwsnaS5YSWY9z+nWVeKdn4GYcuI7OUmY/aEzRUhCLRM0y6Uo2c4ByK+ScIg1LTG
         zg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VCY11d6Q8u0HYNWtx8TAGoyh4KZuFvy2DdJdgLsq9o4=;
        b=GuOz9p5GzIZWhzKgbYiS4qAxw96Oq4pY/hLx2CcUKlG5R+a5fzqAxkBLJ/36NW+w6/
         0552mnUDSpqaxexcPeUTnew60uIIKgd+b3oIBYbLF8DxkBAeP9DYM7CJrDj97lR4V9o4
         OmiDsCs/YXWVUXo4tR+IsZXisi5NYfTKxqnspVzBuNYzODhYtSsasRSMs2FqfRHwQfN/
         8mhv3cJ4bVPJjnAy6Ja7E8QSoW3NoqvTcthSzRlSOGZ3lDxT/BHtczHi7UL4aYc1DMv8
         FDhEDP7mXLdEetWZjMzCd5XH6m/k4SRn6o/aAmm2mMRCRa+Npc0n56QfOPrhExgHimgD
         tHbw==
X-Gm-Message-State: APzg51DuD3svjBITJisowqxSPew7++N2i+36r+shE9U5XMe2O6g1q7Nb
        3dPtLFwmReTDGu0uk67yQfr16+nyZoQvpslP918c/A==
X-Google-Smtp-Source: ANB0Vda+opvZmDfHV0yzKnM0MEfdpYOvtQobfHjTIRkktdS+V9kzmP2N3nt1XjannMel0sctHqyQYFRdNq6Oi9Se+uE=
X-Received: by 2002:a24:ef43:: with SMTP id i64-v6mr5075062ith.47.1537519348581;
 Fri, 21 Sep 2018 01:42:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 01:42:08
 -0700 (PDT)
In-Reply-To: <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Sep 2018 10:42:08 +0200
Message-ID: <CACT4Y+azFyB6xMtbOGuwUW5jo_dxchM7EdyMWHD_6CU1n9erFA@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Andy Lutomirski <luto@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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

On Fri, Sep 21, 2018 at 3:50 AM, Andy Lutomirski <luto@kernel.org> wrote:
> This patch seems reasonable, but you emailed the wrong people :)
>
> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> It turns out that KASAN in general will bloat stack frames in unexpected
>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
>> default to be associated with KASAN instead of KASAN_EXTRA.
>>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> ---
>>  lib/Kconfig.debug | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 4966c4fbe7f7..39078a080e29 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
>>  config FRAME_WARN
>>         int "Warn for stack frames larger than (needs gcc 4.4)"
>>         range 0 8192
>> -       default 3072 if KASAN_EXTRA
>> +       default 3072 if KASAN
>>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>         default 1280 if (!64BIT && PARISC)
>>         default 1024 if (!64BIT && !PARISC)


Looks fine to me.
KASAN always increases stack size too for exactly that reason, so it's
reasonable to allow larger frames rather than try to massage code
every here and there to fit into the normal frame size.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks
