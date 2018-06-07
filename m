Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FdlJBI61GFtqagAAmS7hNA
	; Thu, 07 Jun 2018 07:04:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 513C4607F7; Thu,  7 Jun 2018 07:04:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk3+JKQ1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B78A1601B4;
	Thu,  7 Jun 2018 07:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B78A1601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeFGHEJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:04:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42966 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeFGHEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:04:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id k190-v6so7634375oib.9;
        Thu, 07 Jun 2018 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VoitM8Xx0E3CEC04YfM5LZS2AeqLeaJqYhEnY6yZBvY=;
        b=kk3+JKQ1FCkQepXeCwfcjgJW9z5brylVRVEaqQML/8XkqET54K5XPAKVqC9OzFAMEE
         UFHqgYOq8NajN0ylZzJst10QMbjWD7XHCFZyi8sN9rcxBPAG3dBGTGUqAQjXs3xRwjGV
         Ark+0h8tVZfqxdlWhePTYFYTuO9row3l0BPu+In8eShQhMeBWeusKQdlS7zmAwAKp88o
         UMcOs8yNXp3D9xw/vU6bEH7k/4wQgIEnMO+RIDq6+fM5j/QmMmQJyQZIY730SmAmUwZK
         J9OIxcXVkWpUPWsXs6k3F5EanC49dumApJY26vyn5mKzCeuA2WKqLC4TcCX2GIgbcsI6
         alpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VoitM8Xx0E3CEC04YfM5LZS2AeqLeaJqYhEnY6yZBvY=;
        b=tcu3PV88Vk8RQv04oMIpfwSF/mucbj++1nyr4olxfksBPW2LnuUJWVJ3fH+FMJJB4o
         b2I2MmruFEtj3cuuEfYfll/jdHbfRHL/tbmPsgcJipcTdvpo/Y1rv8e91jy6XGMaochF
         VW6Inbsw3vDPdp/KbjWYXlDxB1xXQRGHIXp95zBya9yWP3OIJ7aHKRMjq6HZP0/0peTH
         pcQ8VMKgdeKfJQv9FZo69K0o7KUIFgOJvUWM/ckJuxWs45hmTsWwb/ANqrXmb+c88oyY
         Ll25eFAw23LMo9GS3EIjP9eQo45PEnlrEf1tbmqSk33ugHqvyAJhAsCRahSptwjXczH5
         i96g==
X-Gm-Message-State: APt69E3ztZ0QEI7mrk2Uc4sSsm7ydayVzGT6MVQhTacohCobNLm2eWn3
        YZBEeMcvOyvPWajTtTTkgcklKKnvRk5wm9GuMAo=
X-Google-Smtp-Source: ADUXVKIXqqzY5Ie2bRMJG3ZUub5+P7n3dlpZIKPOQkE4j8W8JF9ST55kJ+NKmXydaOn75lORnUIrKtIHPcO1qXtIuMc=
X-Received: by 2002:aca:ea55:: with SMTP id i82-v6mr318388oih.260.1528355046250;
 Thu, 07 Jun 2018 00:04:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:743:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 00:03:45 -0700 (PDT)
In-Reply-To: <d3c4e356-2c04-731f-a665-a445a6bf68af@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com> <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
 <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
 <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com> <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
 <CAJs94EZx2ZdEL14SCEBomEfXLRPN4FfOp4yE44kfpnE+5+Ze-g@mail.gmail.com> <d3c4e356-2c04-731f-a665-a445a6bf68af@micronovasrl.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Thu, 7 Jun 2018 10:03:45 +0300
Message-ID: <CAJs94EbY1apGLUK+6ZXy=j5Uitox+WbG903_5SX2kW_tCLQzPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-06 22:15 GMT+03:00 Giulio Benetti <giulio.benetti@micronovasrl.com>=
:
> Il 06/06/2018 20:55, Matwey V. Kornilov ha scritto:
>>
>> 2018-06-06 16:11 GMT+03:00 Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>:
>>>
>>> On Wed, 2018-06-06 at 14:15 +0200, Giulio Benetti wrote:
>>>>
>>>> Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
>>>>>
>>>>> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>>>>>>
>>>>>> em485 gets lost during
>>>>>>
>>>>>> Copy em485 to final uart port.
>>>>>>
>>>>>
>>>>> Is it needed at all?
>>>>>
>>>>> The individual driver decides either to use software emulation (and
>>>>> calls explicitly serial8250_em485_init() for that) or do HW assisted
>>>>> stuff.
>>>>
>>>>
>>>> In 8250_dw.c, during probe(), I need to call dw8250_rs485_config()
>>>> against local struct uart_8250_port uart =3D {};
>>>> Inside serial8250_register_8250_port() not all uart fields are
>>>> copied(em485 too).
>>>> So after probe, em485 is NULL.
>>>>
>>>> Another way could be to call dw8250_rs485_config() against real uart
>>>> port, after calling serial8250_register_8250_port(),
>>>> would it make sense?
>>>
>>>
>>> Look at OMAP case closely. They have a callback to configure RS485 whic=
h
>>> is called in uart_set_rs485_config()  which is called whenever user
>>> space does TIOCGRS485 IOCTL.
>>>
>>> So, it's completely driven by user space which makes sense by my
>>> opinion.
>>
>>
>> AFAIU, Giulio wants to add support for rs485-enabled-at-boot-time
>> device tree option (see bindings/serial/rs485.txt for reference).
>
>
> Yes, I want to add support for "rs485-enabled-at-boot-time" property,
> maybe I had to write better commit log and a cover letter. Sorry.
>
>> I suppose it is only important for use-case when rs485 used as slave
>> (peripheral role).
>
>
> It's important also for master, because RTS, if RTS_AFTER_SEND is set,
> remains not asserted(trasnmission) until userspace opens that serial port=
.
>

And it makes no sense, because how are you going to transmit and
receive not opening the port and not running an application?
It is master who transmits the data first. So, before all systems
going to work you have to open the port from userspace.

In case of slave this of course makes sense.

> Sorry again for not explaining myself well.
>
>
> --
> Giulio Benetti
> CTO
>
> MICRONOVA SRL
> Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
> Tel. 049/8931563 - Fax 049/8931346
> Cod.Fiscale - P.IVA 02663420285
> Capitale Sociale =E2=82=AC 26.000 i.v.
> Iscritta al Reg. Imprese di Padova N. 02663420285
> Numero R.E.A. 258642



--=20
With best regards,
Matwey V. Kornilov
