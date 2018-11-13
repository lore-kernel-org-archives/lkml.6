Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C02245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0hI7ZVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C02245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbeKMSVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:21:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41259 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbeKMSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:21:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so5337596pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5AE1ok4zE17TW0bCUbkSxwRKLjVn+j/ZKwar8AT50xE=;
        b=A0hI7ZVISWsuwxkb9eDCkXYouueaewPoON7s9ckSeI3TpfjP/kRkxfrK1NfOCAFktk
         tkgsMXhEsrSN3pTjVhn7YuLBhnnztRGw4wDnPWJZdiJjZ7yRzVlL8V6aw00mYLgrGFKq
         clGByIWt22ELgbfvyY/teQVCOmDLPsjhiYA5tjYmP5j0YuGJwqMOn9V7RBY/YuJSrSkQ
         AsqN7NxYk5pQsS7nrDXqzV4hMfiVE+q3I5RVAL9SYCnwwrHSE2rOkQfnukdHczLiH3lk
         9UBGrqbeijo530FyhynY1BKJtOBdVjqS/DGaboluDPBuQXV3WLumAE+pFdDISeh8Hibd
         QOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5AE1ok4zE17TW0bCUbkSxwRKLjVn+j/ZKwar8AT50xE=;
        b=YpURiPYOzxiqMwouevV3I8W877W+WqI/CsrpzIHA1Jn67LlMVt1wGu1WbxDs9Mzlr2
         mhpVwuBGyHoQ4E7XmAiajAn089gN5qdro3pdM3zCrent2rvbihD5fr0gQAhBgWCWwsXX
         OATjJnldg5KMQjRzKh0kJ1mFyN3G5h5W7gfwtUf+U+IjxQC0ya+7LoFTg3RuegChGIQz
         oLjG7HksZVgvRQ62aDgMg/shlY8cnuHZZB65wQVqUfLKKEyQ4iVlIb6fI0Lt6/NKZmHS
         GxbMuOgp6ZBEWdymDAru5cJhSItDapzqXF56Io0Az0Uen7mtQMi5cN0sEQj0ke02QgGT
         0h1Q==
X-Gm-Message-State: AGRZ1gJ+hHPIWSqdrmwxNIBhFpZo9x9aDR9yEK6KBZFnTcVRdDh4ywJh
        6MWpQHr5i2JMPsnL4IqhVm4=
X-Google-Smtp-Source: AJdET5fNGIZ4kI+tsNhRhIATEh1eYeWx0+hRH8wbjyF4Cim0gBf/x62aDFGBeFmAYTu3PnB6poEvmw==
X-Received: by 2002:a62:fc86:: with SMTP id e128mr4256560pfh.54.1542097478239;
        Tue, 13 Nov 2018 00:24:38 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id 124-v6sm46327734pfb.132.2018.11.13.00.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 00:24:37 -0800 (PST)
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
 <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
 <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
 <alpine.LNX.2.21.1811131413210.362@nippy.intranet>
 <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com>
 <alpine.LNX.2.21.1811131700010.366@nippy.intranet>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
Date:   Tue, 13 Nov 2018 21:24:30 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1811131700010.366@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 13.11.2018 um 19:15 schrieb Finn Thain:
> On Tue, 13 Nov 2018, Michael Schmitz wrote:
>
>>
>>> (It appears that a QEMU-emulated Mac does not benefit from having a
>>> clocksource that's more accurate than the 'jiffies' clocksource, in
>>> spite of "clocksource: Switched to clocksource via1".)
>>
>> With the current code, kernel log timestamps have 10 ms resolution on
>> Atari. Time resolution of times reported by initcall_debug is roughly 40
>> us. I'd expect that changes with falling back to jiffies only. Might be
>> worth a try on QEMU Mac.
>
> The initcall debug output shows the same precision as my earlier tests
> with userland. The VIA timer only gets updated when QEMU wants to update
> it, which seems to be about every 9765 us. Hence, using the 'jiffies'
> clocksource would be effectively no regression for a virtual Mac.

Running a recent kernel under ARAnyM shows 40 ns resolution so the Atari 
hardware emulation is a little more complete.

Using that for initial tests, I can confirm that timer resolution is 
reduced to 10ms after patch 6, and gets restored to 40ns after applying 
the full series (once clocksource_init runs, that is - the first part of 
the boot is at 10ms resolution only, a regression compared to with use 
of arch_gettimeoffset).

Unfortunately, I can't log in at the console with all patches applied. I 
immediately get the 'login timeout exceeded' message. Weird...

Cheers,

	Michael

