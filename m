Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A538221470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MUlhMBma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A538221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeJBDc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:32:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40043 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJBDc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:32:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so10292828pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1/uGZS4YF78Ac48mO2JvM1evD2kYx7ReQr0abHmspHI=;
        b=MUlhMBmaGDtVYyV19TVP2R7o6e281hJIrgSdX28oqC4bXYm6FzFmgUqzMeRbD6fJp2
         A38v8Hb7NUSBQQNPoDmCAMVtKiQ7LoSXcaiV9TxyUyKm6taHhRv7IDfPsFUj0COePVVy
         /60srjmcOTq9poZR6PnjnZLnL2w9ackTy/TlTc96s8fhmyYsatfkW9nF4DB8SB7QEmEi
         fCHkWFEAR1+n9RaicS2ggLTpU6AmpMfzwYy+eIn5DxhHiBtWis4lRIGWaWJEgMoHAKRu
         eWg4QaVYi9pB5rqFjs9txGXz6TVq0FW4IlZ2/HToN0sPT7HQN+8VKiZBt9qq1t3xI6Wl
         Y9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1/uGZS4YF78Ac48mO2JvM1evD2kYx7ReQr0abHmspHI=;
        b=OQ0e5Df/DSTmxJjlU1MXssXSnLFpqPR6W8oO8y4iAdgJh3fuspo6Pr67jSca4RKbM8
         J+BV2OB0flgDaftqqCF60tjnOBrpGby0ZedF9stTPvrwJnNAyQwfTSMlt1sHHhFcoMfC
         uqj9gM2QCzHPyoH6Gzrd8o6r0iFJ3Ag+k1L/Qj7HO8gPBb7sr9B7KovU58wpHYMHqWYH
         4GAwvooGoHGfH6uHmzdO760Nb5NlJmLfTSIiT7ZaztT8ycuYqHAr7T2Icrtxss4A1pkN
         XEi4nxGT6fs4OxD530vEzJcFi/WSP/uwgC6xH+BpxR/5lKFRjsUKA/pM0NgF6Af0ywdZ
         on4g==
X-Gm-Message-State: ABuFfoi/MZnpNIM+EDg78E8OwdWVbfNJ2rTiX6lHwI2WNXsc1aAROEHz
        N+gMkXeQQkJlC0GYbezFjoA843PWM6Y=
X-Google-Smtp-Source: ACcGV60zWTtf6j7GfJmAR85Gds6GJ4FtVj5BwokpvyV/VzbMchCqKC1hpbBxGT/SZ7J07GBpM03oPw==
X-Received: by 2002:a63:db44:: with SMTP id x4-v6mr11778928pgi.285.1538427168107;
        Mon, 01 Oct 2018 13:52:48 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id z3-v6sm18184120pfm.150.2018.10.01.13.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:52:47 -0700 (PDT)
Subject: Re: RESEND [PATCH v6 11/12] lib: vdso: Add support for CLOCK_BOOTTIME
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Jinbum Park <jinb.park7@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <20181001175845.168430-12-salyzyn@android.com>
 <alpine.DEB.2.21.1810012009010.32062@nanos.tec.linutronix.de>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <a602b661-dde5-399d-6245-cf48a0e43f54@android.com>
Date:   Mon, 1 Oct 2018 13:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810012009010.32062@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 11:15 AM, Thomas Gleixner wrote:
> On Mon, 1 Oct 2018, Mark Salyzyn wrote:
>>   
>> +static notrace int do_boottime(const struct vdso_data *vd, struct timespec *ts)
>> +{
>> +	u32 seq, mult, shift;
>> +	u64 nsec, cycle_last;
>> +	vdso_wtm_clock_nsec_t wtm_nsec;
>> +
>> +	/* open coding timespec_add_ns to save a ts->tv_nsec = 0 */
>> +	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
>> +	ts->tv_nsec = nsec;
>> +
>> +	return 0;
>> +}
>> +
> Instead of adding yet another copy of the same code you might want to look
> at the rework I did for the x86 vdso in order to support CLOCK_TAI w/o
> running into the issue of the clock switch case being compiled into a jump
> table and then the compile asking for retpoline.
>
>    http://lkml.kernel.org/r/20180917124533.329334911@linutronix.de
>
> Thanks,
>
> 	tglx

Great idea. Thanks!

The point of the first 12 patches is to _align_ the arm code to match 
the assembler for arm64 exactly 1:1. Then switch arm64 assembler to use 
the _same_ code in 'C' as a library. No performance degradation.

Next extend the vdso framework on arm64 to _also_ use that library for 
vDSO32 (arm32 compat on 64-bit). At this point we achieve a 0.4% power 
reduction on Android.

At that point, we would be ready for a rework that fixes all three (ARM 
vDSO, ARM64 vDSO and ARM64 vDSO32) to get the compiler to handle the 
switch statement better. One step at a time.

-- Mark


