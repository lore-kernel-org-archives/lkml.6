Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B6322360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hYVGyTx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B6322360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeKOFfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:35:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43303 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeKOFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:35:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id g59-v6so8241536plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=U4qS4sG0ZQHLRjlc+Lx3+OgO7WRcrcCm6h8smRWD5rY=;
        b=hYVGyTx9S+F4Ky/FMUWMe8BUhu9YGZ29jZAWGxPqb0jZJLC8AwjAoTLMUv43Ct9WYp
         Vlc9aTrIyw69+5JoE2KCg4cI2RNPthm7+Lv4d3EKvzumgf8qwcFB2Y1GvAtxmHPDyhc0
         VzfJQ1nUSdNzBJCk97mW+e2FqjTrGDGMQWI6iqkQgWNYWxuTyLC98xW+swBNxRAT7j4o
         IsOqR4W41HCjAFQ/nwln1X0vIz/73Nc7rFHc44zGHCJrYS0qq4n6PA7VgPJcvzxyN3Hd
         PF9HUAHJSuVdKQjDzy7VwrR07idtEV73sgsfmf0u/i801MqbpdnI+9ewyORYk1BJBSLJ
         77nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=U4qS4sG0ZQHLRjlc+Lx3+OgO7WRcrcCm6h8smRWD5rY=;
        b=s8WMyzEmHu+pwxdtc3Y59CzmSPcLFV/Pv8WBypKn8jJhUxUF5scHAkJe7onA+wDzsk
         FQPLMFJtTD5v8SOXlpxerE7gTFQLHLDLUo8cuQ6Ajjo0gvvkjh5tThh1Ric9Uf5oaNqj
         5TKMkGCy7cReo1Nzg9ji6znqIw9xtPGxizlXhGWdtCj1WiCzdHXMYFk8zc8nutzByKPD
         YRGvtvFnCv05ZtyTLWJhnNsBpf4rYP59kiwYkNX9lWJiKKy0AuFNNjgnGkU+UzDEetyi
         qvPmrGEvL3pIDFn34+M+NMHRDVN4DoO5QT+zwKpAoJWE9Nie9XU5v8WQxmvHysb1eLTt
         PXcA==
X-Gm-Message-State: AGRZ1gLHhI0pNxQTlB7QQVqw3qERbH09Eh3dI6kervA8i4gMppAxplVj
        r3eQ4mFEQ4Mawqd3Ffb1CyNmwQ==
X-Google-Smtp-Source: AJdET5ekTQj4BxDyPNq1DCAzvS1u0iO7xTYvv/Xg/zZGebI8iod/+KTRrpDPREAaKUpwZq6d6ojh+g==
X-Received: by 2002:a17:902:c01:: with SMTP id 1-v6mr3204768pls.15.1542223846326;
        Wed, 14 Nov 2018 11:30:46 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id k75-v6sm64995626pfb.119.2018.11.14.11.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:30:45 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 14 Nov 2018 11:30:45 -0800 (PST)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     paul.walmsley@sifive.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, jimw@sifive.com,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] modpost: skip ELF local symbols by default during
 section mismatch check
In-Reply-To: <CAK7LNARC2+BLFay_-CtaJXKCu3M0NZzxbeff1XandeH58BbUcg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1811141126450.22477@viisi.sifive.com>
References: <20181020131911.22443-1-paul.walmsley@sifive.com> <20181020131911.22443-3-paul.walmsley@sifive.com> <CAK7LNARC2+BLFay_-CtaJXKCu3M0NZzxbeff1XandeH58BbUcg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,

On Tue, 13 Nov 2018, Masahiro Yamada wrote:

> Hi Paul,
>
> On Sat, Oct 20, 2018 at 10:21 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>>
>> During development of a serial console driver with a RISC-V toolchain,
>> the following modpost warning appeared:
>>
>> ----
>> WARNING: vmlinux.o(.data+0x19b10): Section mismatch in reference from the variable .LANCHOR1 to the function .init.text:sifive_serial_console_setup()
>> The variable .LANCHOR1 references
>> the function __init sifive_serial_console_setup()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the variable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>> ----
>
> Could you provide me a little more information to reproduce it?
>
> I tried your dev/paulw/serial-v4.19-rc7,
> but I could not get that warning.
>
> I used risc64-linux-gcc (GCC 7.3, 8.1) from kernel.org

I observed this issue with gcc 8.2:

riscv64-unknown-linux-gnu-gcc (crosstool-NG 1.23.0.534-710c8) 8.2.0

This toolchain was built with mainline crosstool-NG:

https://github.com/crosstool-ng/crosstool-ng

using the "riscv64-unknown-linux-gnu" sample configuration.


- Paul
