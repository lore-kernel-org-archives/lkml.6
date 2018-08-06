Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD204C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F2221A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceJxWDmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F2221A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeHFMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:46:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40217 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHFMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:46:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id y200-v6so8674578lfd.7;
        Mon, 06 Aug 2018 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=O7gZQPZUdSvzQ5jmilWbUk9XFijAjpJvg1Jq4hZPThw=;
        b=ceJxWDmIxRnX38AaRURWavCxeSUxuN0xmL8NRnhYjLvI9grfrOGQFMURGwZvU8G9+d
         QMNFOA2PhEbkzG2/o0dpvMNwyTBYllUdfNpLNKz2ZHRYS8a3LvGdU/fPaHFS6boMceye
         HN45R5KrcMKetFWjynGIYn8x7fmRKiVADxBLwPAdkQhoChCbR5ipi3BEwRLt5t+D/8E5
         BF1M3lAjWbpE2UyFIOQfYtqV0ErUIcGHO/Wk5q39fKTLyrp2aJSkOiYjeiTioFQB38hd
         EWIzvhPhVeBCh0xi4ac48bpQvjunOzdrRjhttTfx45vhLM4PIedW++w8Wj4qJsKhPH3S
         WHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=O7gZQPZUdSvzQ5jmilWbUk9XFijAjpJvg1Jq4hZPThw=;
        b=amJopZDY/ySlwiRNwaOOvdIhHmP59lnRokK4PKO4SzuxceeS0uGJTLScccHJltSZaJ
         MsrhEK0JrmFvfbl+9MU8FFrSy7/O7mpT2dnFDNEXIXL5Nyy70QsKompkMm2foM5XM/92
         vXGhZayyZSlKqUfIc8SdPyki9lY0nMoe89aCIKj76WSDJ8jIiDXszKFbnIAVHYi4Rwt0
         0fZbuX/MBoyEepCQZqxaWAoLgb+U233dJ2MGjdcaoJMJZCMTlPJXSNsPLqoFrWMc7d5g
         X0ECxaz9/oTTvjbH5BDoY5krLZpxIUUv/g8gmbqX2rbP50ybOB/AwzpO43wekpC+qazt
         EZpA==
X-Gm-Message-State: AOUpUlEWrAFGl/fGHKDY0eO/T6RsI08+jzYRZ9QXqdBa2PdFsDA70IXr
        g26Mv5sHXdw1WgV6YlvhD4XVa+AwYhlhrOcD6i8=
X-Google-Smtp-Source: AAOMgpeuuRAu/TtY3BBPFrr/AIC1nUmV4jQ2jNMptGirgrOddXBoES3nkiYB1GruT9rfFENWnLrKQKOu0CTTgJ8NmxA=
X-Received: by 2002:a19:f22:: with SMTP id e34-v6mr10538804lfi.1.1533551907854;
 Mon, 06 Aug 2018 03:38:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:a87:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 03:38:26 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <c69c7292139b4e22a7d9ea3e968828d8@AcuMS.aculab.com>
References: <CAKwvOdmBtzkca-C1YpB_OYVyqFFi3P_Q8DJPaKr96DFZF0e6Hg@mail.gmail.com>
 <20180803170550.164688-1-ndesaulniers@google.com> <c69c7292139b4e22a7d9ea3e968828d8@AcuMS.aculab.com>
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 6 Aug 2018 12:38:26 +0200
Message-ID: <CA+icZUXtw6FUu8TpTY0Bn3BaDkb1zKuzLtBMz7oHLjJ=+2ojxw@mail.gmail.com>
Subject: Re: [PATCH] x86/irqflags: provide a declaration for native_save_fl
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "astrachan@google.com" <astrachan@google.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tstellar@redhat.com" <tstellar@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 12:25 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Nick Desaulniers
>> Sent: 03 August 2018 18:06
>> Fixes commit d0a8d9378d16 ("x86/paravirt: Make native_save_fl() extern
>> inline").
>>
>> It was reported that the above commit was causing users of gcc < 4.9 to
>> observe -Werror=missing-prototypes errors.
>>
>> Indeed, it seems that:
>> extern inline unsigned long native_save_fl(void) { return 0; }
>>
>> compiled with -Werror=missing-prototypes produces this warning in gcc <
>> 4.9, but not gcc >= 4.9.
>>
>> Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
>> Reported-by: David Laight <david.laight@aculab.com>
>> Reported-by: Jean Delvare <jdelvare@suse.de>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> You can add my:
>
> Tested-by: David Laight <david.laight@acuab.com>
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

On top of Linux v4.18-rc8 with clang version 7.0.0-svn338205.

- sed@ -
