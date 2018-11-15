Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2607F22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2607F22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbeKOVI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:08:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44826 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbeKOVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:08:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id b81-v6so9028000pfe.11;
        Thu, 15 Nov 2018 03:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3FHK8EvY+Zjy0akwJHZcKL9VGkiMyUmpn5Xcm9XYl0=;
        b=KPi0hiWTDH6Jiy2qOxDAhcZdrKki3cyUUrjIN2CFz2z/qq6udtYXzgd96c1iClVLx8
         qMtokfdqesp8NmbPVU/EsmsTwP2ImT8rlz+Kh24Zvoi1+Fgii4N0hFd9ieVqyewLhCXr
         2iBGcubeRCFXZTIlSYoWLkdKzfey4ZKHsrDt1xb/MifKUhYGauKv+gUzeA4RQhlnsMj4
         psI2hAA0+o/UOyKCjOT1Zb3hQ3KSy5QC1LwjZgQFeJweXplbFFIfEsXgWbYXfQI1Qc6v
         Ob8BkRiB2UKAd7G2zHTM55dN1haEe65NytrOD9KBb0BHww4WeuxwJ1uTNkhtVhvhMAmP
         oyFg==
X-Gm-Message-State: AGRZ1gIQixPH2Ekon2RsLrsJAp+m3wt/yXFxa9esd5GeO00K9YGA51yW
        g+jOIpQzqU46WQRI2mLU5MkEQSo7o73ygKNerjE=
X-Google-Smtp-Source: AJdET5fbeO0WaXg34yZQJO9Sbkjzuh12ApiHQEVArRCqI6Y/VHA4n/h2Hk2784LD4/8Nerrojw2bcaUoZZA/7E2Vtxo=
X-Received: by 2002:a62:302:: with SMTP id 2-v6mr6085108pfd.135.1542279696518;
 Thu, 15 Nov 2018 03:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20181020101045.15991-1-paul.walmsley@sifive.com> <20181020101045.15991-3-paul.walmsley@sifive.com>
In-Reply-To: <20181020101045.15991-3-paul.walmsley@sifive.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 15 Nov 2018 12:01:25 +0100
Message-ID: <CANBLGcy9WoBqBKQnvz-YGQpXossP2HDmW_go8WZD7FfBZdr5VQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] tty: serial: add driver for the SiFive UART
To:     paul.walmsley@sifive.com
Cc:     linux-serial@vger.kernel.org, paul@pwsan.com,
        Palmer Dabbelt <palmer@sifive.com>, wesley@sifive.com,
        jslaby@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        julia.lawall@lip6.fr,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the patch!

On Sat, 20 Oct 2018 at 12:12, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> +/*
> + *
> + */

Interesting comment ;)

> +static int __init sifive_serial_console_setup(struct console *co, char *options)

Unfortunately I get this error unless I remove the __init:
...
  GEN     .version
  CHK     include/generated/compile.h
  AR      built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0x14e48): Section mismatch in reference from
the variable .LANCHOR0 to the function
.init.text:sifive_serial_console_setup()
The variable .LANCHOR0 references
the function __init sifive_serial_console_setup()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

FATAL: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
make[1]: *** [scripts/Makefile.modpost:98: vmlinux.o] Error 1
make: *** [Makefile:1040: vmlinux] Error 2

I have
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_SIFIVE=y
CONFIG_SERIAL_SIFIVE_CONSOLE=y
and it happens both on v4.20-rc2 and v4.19.
Without the __init everything seems to work fine though.

> +#else
> +
> +#define SIFIVE_SERIAL_CONSOLE  NULL
> +
> +static inline void __ssp_add_console_port(struct sifive_serial_port *ssp)
> +{}
> +static void __ssp_remove_console_port(struct sifive_serial_port *ssp)
> +{}

Missing "inline"?

> +static int __init sifive_serial_init(void)
> +{
> +       int r;

If you're sending a v4 anyway, here and in the the probe function
using int ret; for this kind of variable is a common idiom and
hence easier to read.

/Emil
