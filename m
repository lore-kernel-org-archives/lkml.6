Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0451C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C9D20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIBpQP0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C9D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757043AbeFSKSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:18:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39391 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757102AbeFSKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:18:21 -0400
Received: by mail-lf0-f67.google.com with SMTP id t2-v6so22869637lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZOevVGOnHluOjuZq1XEyFEq0N3VIhtahmszAw14I/lI=;
        b=WIBpQP0Mz0J6IPE8GSCkEU3zV5H252ZmbqfJwn5Rd3UCncxp0W+orU9G/2coLHpPKa
         JCp7SIkA7GSyLZ4UDxoZqkuNN+IGtdCSutL+MX52QBCJaPF6H4Aqkaw/JtCwN6uZ6phn
         tyVPgiNbokKqxEhlJ75QFKBkOBsvYGsVjJF4tOXUAhpYcdCw+LwJ8KQZFHHB29FQItFD
         KmHSvF41BlWBRXOhZFPr9VnH+bj0MoXyTzgkj7io5nH64TQSaT+OerGzX7wN+c1dovPI
         MNmvU3LuX8nhtfUjcCXJdTKcw2E84fcLV2fNP/VXy7ndWG/86wRnm9YVDn1R4/AkiLto
         gf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZOevVGOnHluOjuZq1XEyFEq0N3VIhtahmszAw14I/lI=;
        b=QItmHO1XLthHT1abV73tBMFfOTsh11ptrsNUERD/hmUBqvFGLLNXdhDmqoh8pVxsL/
         JnQujjW0fYrlhAcwE4mdpE3EeQY49+25KLlsD4b+GLbzho54RG1uNm+KRRO6TyQ7Ahqz
         wvhOfU6leb23yGhDQWN+W497EooOERuzStsKaWzVJaaC1Ao3KHxntkNag/pdzgX7t14P
         77fWQdpOyspeKup8t11WVCdMmLB9SB7GK5daMs4PT2AV7OUavDK7Fk+mBvv5Crf2eo0A
         L0BZOo6ysfgiqb4qBW1MkQEBauDcrNrdHN+rkGsP8fJ5VJ+RgU/3hWjA9iL7lUVTrL+n
         CpLA==
X-Gm-Message-State: APt69E2KENkjwr2OvZI6pFp8/zd9trWwYbbh501ZYV+XLI4Ftje1bHK9
        Lzkz9k/McMMUj3xLjkaRtnLc6+AbSzT90B2gIIQ=
X-Google-Smtp-Source: ADUXVKLXESrMCII8aCJSgDWgh/HEUnwNt9yFlreaA6/RlzxGkqc3blGSIHE+eW/zaj5IeVvEZ97nBgI2oO1Bfcgd52w=
X-Received: by 2002:a2e:401b:: with SMTP id n27-v6mr11165813lja.6.1529403500182;
 Tue, 19 Jun 2018 03:18:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 03:18:19
 -0700 (PDT)
In-Reply-To: <87efh3hndq.fsf@igel.home>
References: <20180618140518.2920804-1-arnd@arndb.de> <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
 <87efh3hndq.fsf@igel.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 12:18:19 +0200
X-Google-Sender-Auth: MdqxXDPbAxwNfuoxN-1mDW-Jtr8
Message-ID: <CAK8P3a1_3UfYGnTcWJ7GS_gO+_WOhS90pUoC97yVAgkox9sQeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mac: fix rtc read functions
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Meelis Roos <mroos@linux.ee>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:04 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Jun 18 2018, Mathieu Malaterre <malat@debian.org> wrote:
>
>> Sadly, trying again today does not work anymore. Adding some printk
>> just before WARN_ON:
>>
>> +printk(KERN_ERR " rtc DBG pmu_get_time1: %lld %d %lld \n", now,
>> RTC_OFFSET, now - RTC_OFFSET );
>> +printk(KERN_ERR " rtc DBG pmu_get_time2: %x %x %x %x %d \n",
>> req.reply[0], req.reply[1], req.reply[2], req.reply[3] ,
>> req.reply_len);
>>
>> leads to:
>>
>> [    0.000000]  rtc DBG pmu_get_time1: 14096662 2082844800 -2068748138
>> [    0.000000]  rtc DBG pmu_get_time2: 0 d7 19 16 4
>
> A good value would have 0xd7 in the first byte.  The problem is that
> pmu_set_rtc_time is also broken, and leads to an invalid time value
> stored in the RTC.  Since pmu_request is a varargs function passing
> values of type time64_t without casting won't work.
>
> You need to reset your RTC before you can continue.
>
> I think the right fix is to change nowtime in pmu_set_rtc_time and
> cuda_set_rtc_time back to unsigned int (or to u32).

Thanks for the additional analysis. I'll do it like you suggest and send
an updated patch.

       Arnd
