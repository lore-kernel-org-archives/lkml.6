Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B619C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F276B20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXl1VRWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeFSWYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:24:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37416 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFSWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:23:58 -0400
Received: by mail-it0-f67.google.com with SMTP id l6-v6so2760552iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hp0qVuAzvncLr85bRrtlos/ezWls24VEo2ER6340AIk=;
        b=GXl1VRWAsUO3w5sQsWsWMDSQsOyTTcKLHgT4Vs+OlohvzYIpsRLBdej+u2uTbRvsIP
         roCOHWAK8pbpRPMnl3CN4CU2iwCsUW9X0YnItPh+NTXgeBB/SPvO02dmhhLWlyrqsOem
         GWOOl9YPbhQb6jx8C/SASG3+FQGWx7SBKbWfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hp0qVuAzvncLr85bRrtlos/ezWls24VEo2ER6340AIk=;
        b=ZgzY2gFPLKmFBNy9vbwk+ivXSBycePv/zI2zD8I/6z2S03M4lcmzlSsr9ekNXFRXN+
         AplnGw8WVTAH5zjYmqGyAs6skcwHJ/gHjNqnsjJpyTBAhbrOCsHYftspnJDEBo+HNOAx
         hXYH3YUg8McKvi5GwfB0HLz9kcQnYutRU0AxBTmYXO73vCLSc0lU1FxSMxY7K/tE8KT6
         WcLajjBjpKTNwp+1R0/3tmyuonCF0VuP3fAsQLVcHXtZ7457aSeyMjEgU8Cet1Cgl1f6
         2WLwRHBQEh8CncM9WQj4R9DgIhGtSW9nF1fqb9dVguaAovxFAdNRC3CCBcX9RsBuuDy3
         j3wQ==
X-Gm-Message-State: APt69E2vScyD93q9ozPAkejeSAiJHskAu1ygSdgOzdCU9wuTlHtbuA+3
        PzPWToeSNWnEuMYilElVUuXvwvyeoY/QwBPmStFICA==
X-Google-Smtp-Source: ADUXVKKJaCcAMB/6Kd6XGvyyHkNAa6UuiQDB4U1rJcgpV9wHmoWd6XMX2YmBg4bd5SkQuVpQNwMAIDD52uwcTj/2rNs=
X-Received: by 2002:a24:e105:: with SMTP id n5-v6mr14634810ith.68.1529447037527;
 Tue, 19 Jun 2018 15:23:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 15:23:56
 -0700 (PDT)
In-Reply-To: <20180619204531.GB28370@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net> <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
 <20180619204531.GB28370@roeck-us.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 20 Jun 2018 00:23:56 +0200
Message-ID: <CAKv+Gu_zsSxb_8Ej-6QwZOW2X5VfgW0gnjpnHpi62L6nPALoHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make badr macro compatible with newer GAS versions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 22:45, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 19, 2018 at 10:34:38PM +0200, Ard Biesheuvel wrote:
>> On 19 June 2018 at 22:32, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
>> >> Work around the mindless and backward incompatible change in GAS that
>> >> prevents us from using a simple addition to set the Thumb bit in local
>> >> symbol references taken using 'adr' instructions (#2)
>> >>
>> >> As a preparatory step, remove badr occurrences in ARM code sequences
>> >> contained in Thumb2 kernels.
>> >>
>> >> Ard Biesheuvel (2):
>> >>   ARM: avoid badr macro for switching to Thumb-2 mode
>> >>   ARM: assembler: prevent ADR from setting the Thumb bit twice
>> >>
>> >
>> > This doesn't work for images built with a toolchain based on gcc 7.3.0
>> > and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
>> > binutils 2.30.
>> >
>>
>> Sigh.
>>
>> So does it fail? Or is the resulting binary broken?
>
> Hard to say. It crashes early in boot, even before earlycon can say
> anything.
>

OK, so even the linker handling is inconsistent.

Working (binutils 2.30)

c0301164 <local_restart>:
c0301164:       f8d9 a000       ldr.w   sl, [r9]
c0301168:       e92d 0030       stmdb   sp!, {r4, r5}
c030116c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
c0301170:       d117            bne.n   c03011a2 <__sys_trace>
c0301172:       46ba            mov     sl, r7
c0301174:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
c0301178:       bf28            it      cs
c030117a:       f04f 0a00       movcs.w sl, #0
c030117e:       f3af 8014       csdb
c0301182:       f2af 1e83       subw    lr, pc, #387    ; 0x183
                        c0301182: R_ARM_THM_ALU_PREL_11_0       .Lsym28


Broken (binutils 2.26)

c0301184 <local_restart>:
c0301184:       f8d9 a000       ldr.w   sl, [r9]
c0301188:       e92d 0030       stmdb   sp!, {r4, r5}
c030118c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
c0301190:       d117            bne.n   c03011c2 <__sys_trace>
c0301192:       46ba            mov     sl, r7
c0301194:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
c0301198:       bf28            it      cs
c030119a:       f04f 0a00       movcs.w sl, #0
c030119e:       f3af 8014       csdb
c03011a2:       f2af 1ea2       subw    lr, pc, #418    ; 0x1a2
                        c03011a2: R_ARM_THM_ALU_PREL_11_0       .Lsym30


Note the even immediate in the subw instruction. So this is another
dead end, unfortunately.

Thanks for testing.
