Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9CE20858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MjtR7bSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9CE20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeKPGUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:20:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46326 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeKPGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:20:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so7019155ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vAevjgMoXGxymF5+bZHqF1QU7oU437ycHKufbSxDchc=;
        b=MjtR7bSIuPtEtgHY551xH2t3SmmeidBvI7uWV6WYZq6/A5GnnE0kTa0w8/4fsfKhLK
         +SK+pRkAKNDBbwCH4DjIy4oaA2IIDcWoN3inYiOM7+Rsx6nu3+4Sr1ohhwaA3CGXJaaQ
         H6vcjmvIJwcQJWfxKgXxDcI5/NKtrzCUgZYbXpBtzgLbqnhoxP8dv5bJAl8V40lo9BvR
         6vFEfZugjyArYGClH8wAAWzluwJbZZqOwEOJekQurtM4xR6RsXhOvwL8a4WcQtwtiEsJ
         gs+/0iA6a4kclql6uF2KKsGKgn6yIss7hET7/m1/FgP2G0ytug8/THM9IQ283/yJacCt
         xN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vAevjgMoXGxymF5+bZHqF1QU7oU437ycHKufbSxDchc=;
        b=IeB8hdS6tDl6ymUTyRvqvUCXBDE9f2E6bjUOFdYaLP6OiUhtuH1korNUmagobIjA7q
         J7cp3EeTmoeoKbThazjl99lji+Okk2h+BJPPzrHfJtZKPLF0B4VArOTqovenm9yHosDf
         8OlHWaB1tcoSH+43/vc/8UQYtMoGdc2+Rxl2iLvNqQU8ojJXCV8wsKMQbB9IZLTuC6kA
         UiDdEmCcQH0rzqrd/po+EjKok1yU6djcvdw1JUsmZwQtDtZxNnRIfaoqm8ee0nTlKjsR
         5F0GUq+12A1HrZDTKFnX8alrXrpZbfMsocuWi2yrk4mPY8NxlCbM9olNBacg9W6aMeWr
         yhLA==
X-Gm-Message-State: AGRZ1gLqf3u1QiZoWL/xpmnac76yqIuy9Vg4Ga7SJ2uW4Ly7ae7eXzLO
        EveuRk1aodX03iXCdTiYc4crQQ==
X-Google-Smtp-Source: AJdET5fQia1OGaDW2lV5wjEtUuTtNrzg8K6KZ2Q0Xh/xFtyc9UJWCNHAhlIp2ptCNUlnOYuWRiflRA==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr4013858plz.32.1542312674330;
        Thu, 15 Nov 2018 12:11:14 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i189-v6sm49605953pfc.16.2018.11.15.12.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 12:11:13 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Thu, 15 Nov 2018 12:11:12 -0800 (PST)
To:     Emil Renner Berthing <kernel@esmil.dk>
cc:     paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        paul@pwsan.com, Palmer Dabbelt <palmer@sifive.com>,
        wesley@sifive.com, jslaby@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        julia.lawall@lip6.fr,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/2] tty: serial: add driver for the SiFive UART
In-Reply-To: <CANBLGcy9WoBqBKQnvz-YGQpXossP2HDmW_go8WZD7FfBZdr5VQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1811151146530.25598@viisi.sifive.com>
References: <20181020101045.15991-1-paul.walmsley@sifive.com> <20181020101045.15991-3-paul.walmsley@sifive.com> <CANBLGcy9WoBqBKQnvz-YGQpXossP2HDmW_go8WZD7FfBZdr5VQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

On Thu, 15 Nov 2018, Emil Renner Berthing wrote:

> Thanks for the patch!

Thanks for your comments!

> On Sat, 20 Oct 2018 at 12:12, Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>> +static int __init sifive_serial_console_setup(struct console *co, char *options)
>
> Unfortunately I get this error unless I remove the __init:
> ...
>  GEN     .version
>  CHK     include/generated/compile.h
>  AR      built-in.a
>  LD      vmlinux.o
>  MODPOST vmlinux.o
> WARNING: vmlinux.o(.data+0x14e48): Section mismatch in reference from
> the variable .LANCHOR0 to the function
> .init.text:sifive_serial_console_setup()
> The variable .LANCHOR0 references
> the function __init sifive_serial_console_setup()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> FATAL: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> make[1]: *** [scripts/Makefile.modpost:98: vmlinux.o] Error 1
> make: *** [Makefile:1040: vmlinux] Error 2
>
> I have
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_SIFIVE=y
> CONFIG_SERIAL_SIFIVE_CONSOLE=y
> and it happens both on v4.20-rc2 and v4.19.
> Without the __init everything seems to work fine though.

Thanks for the report.  There are some patches to address this:

https://lore.kernel.org/lkml/20181115005602.30746-1-paul.walmsley@sifive.com/

>> +#else
>> +
>> +#define SIFIVE_SERIAL_CONSOLE  NULL
>> +
>> +static inline void __ssp_add_console_port(struct sifive_serial_port *ssp)
>> +{}
>> +static void __ssp_remove_console_port(struct sifive_serial_port *ssp)
>> +{}
>
> Missing "inline"?

That is indeed an error, but the other way around: I didn't mean for that 
inline to be there.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst

I've dropped the inline; thanks for pointing the situation out.

>> +static int __init sifive_serial_init(void)
>> +{
>> +       int r;
>
> If you're sending a v4 anyway, here and in the the probe function
> using int ret; for this kind of variable is a common idiom and
> hence easier to read.

Precedent exists in the kernel for using "r" as a return value also:

$ fgrep -r 'return r;' linux/
4491
$

which probably traces back ultimately to Torvalds' guidance to keep 
variable names short:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n284

But I am not religious about it.   So if this is a big deal for you, I 
guess reply back, and it can be changed.


- Paul

