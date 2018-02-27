Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519738752; cv=none;
        d=google.com; s=arc-20160816;
        b=WIJVZq13SKWEg0AD1Z2hbx3OH2GrjpfyRdsxr/evfqLn/B4S8guGVkqr8ejDb1Uu7u
         2W2kIfILDzW6SvjbqffQY/gm88/Uj1c+EHV6VLIOnjcASj+3Og/8QrhY066IAtoGM3FP
         sUo9j0ajsTt3ICkUFnY2pVNYgOf8sLk1tSmZNqrqGZ6aqq1uNU0SaWdWEdUGzR/DTB2i
         sfNobP2jRACaswO1wYeLesvO0uFeQXt67o6d3P/Ij1yKkb6xyeuxcmKF/N8hYElgLfS9
         BWouakSI8QfmdDBTafgFaeUsOCbQ1uyiSw/VPd+floa4S8mmRBzBK8TUfYUMcI7dg36C
         hQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fufJXZeL8w977OSqSXu2LqUC3QGKfZ+k2A5nRG2lvNY=;
        b=qp6FoYqL8zVj3c+kqK8ZDzP1YjQHPL/cAdXNXELT7pTsQrM2c9fwVH4vzoQX0sjGex
         LoLPI3Kn5i+K2tGAmTocq2OXARTyCmrlpwhv1PQ2rwGakaEy3vXIy5m4gkICsF3Jm9mW
         +TuFHEw7IrXBNfgFxE4pNEyLB6+Z9VtPrkqvH52iI/over05t0s8XWzxozt6nWwX0Opn
         yn90d77YWIfoHAZd1dxMzhTyjnPJKLXac9gIHQOG8mdDRW3lzgED+50JiVSzdukPTd5c
         rnM4sz3R5iYndp7lvuF/I+uS3fD8FYXJGwWLr0LBhQMTtXCMdzu5tw5+lAU7uprqTgHD
         qycw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YDvfGkNx;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YDvfGkNx;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x225yZBY50/EaaSG4bE/WxblvRVQ3alsRwGCa71K8nqZrWVfQeZxxecTC21JK0vjIm/wRUZLhaOhATjcPA7Ft3Tg=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
 <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
 <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
 <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com> <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Feb 2018 14:39:11 +0100
X-Google-Sender-Auth: m_F_GGzM3YfwG7VHrn4QD46e0ek
Message-ID: <CAK8P3a2t9a=qzSpxSQ7j5r20i_cR2G=kAZE9amT2fFypU0whzw@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593294329790174573?=
X-GMAIL-MSGID: =?utf-8?q?1593561582524531271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 11:22 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-27 18:03 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tue, Feb 27, 2018 at 1:46 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> But, we need to decide what the right solution is.
>>
>> I think for consistency, we should change the existing
>> 'depends on MFD_SYSCON' to 'select MFD_SYSCON'. This
>> matches what we do with REGMAP_MMIO.
>>
>> MFD_SYSCON is really a thin wrapper around REGMAP_MMIO,
>> so I would keep using the same conventions here, even though
>> we normally prefer to not 'select' any user-visible options.
>>
>> It might be possible to make MFD_SYSCON a silent symbol
>> as well, but we'd have to make sure that all users select the symbol
>> then.
>>
>>         Arnd
>
>
> If we agree, I can send the following three patches.
>
>
> [1] Add "depends on HAS_IOMEM"
>     to all drivers selecting MFD_SYSCON
>     (Unmet dependencies will be fixed by this)
>
> [2] For consistency, convert existing "depends on MFD_SYSCON"
>     to "select MFD_SYSCON" + "depends on HAS_IOMEM"

Those sound good.

> [3] Change MFD_SYSCON to user-unconfigurable option.
>     But, for COMPILE_TEST, allow users to enable it independently.
>     Like follows:
>
>     config MFD_SYSCON
>         bool "System Controller Register R/W Based on Regmap" if COMPILE_TEST
>         select REGMAP_MMIO
>         help
>           Select this option to enable accessing system control registers
>           via regmap.
>
>
> Is this OK?

I'm unsure about the third one, since we have drivers that can optionally
use syscon, depending on the platform. With this change, any user that
manually enabled syscon to use that with a driver that requires it on their
platform but not on others will see a regression.

If we do make MFD_SYSCON a silent option like that, we should remove
the #else section in include/linux/mfd/syscon.h to force a build error,
and require all drivers to 'select MFD_SYSCON' if they are able to use it.

       Arnd
