Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519907868; cv=none;
        d=google.com; s=arc-20160816;
        b=oCFdtGIObiUBC02MECM2uJfCLEty+BqiX8yW1xl4tamzIhxYs8SbKc2rIsBx75wtxg
         z32t5oHG2ca/LuwPXG5taWF/C36LDG+9zBO2EL5Azc9eKH+CRBgy8ZIMe/KOt2Pc8QiQ
         ScSU1wl6ZtbX3o4WHvNi8h4PTMck+h41zpRxvxxwULQHHqv4sNq5YFn2pM5BPJMfafRw
         FUlHObrXZrk6wiNRoiyFRBw/BzsEChROeDxSZ9hqa2d1YCcCAMKBOhZtCyMH9Mf3Kbhx
         YZrANGmpm53n2uRidACqsZwdXrMogXdgx+jR/VQG58nNtzPzOetpSaat8UbtXl38NgnF
         HDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mxv7tExKGfBiaoMPBwgLlIHY1KmTQrEfqqtYtsqwfug=;
        b=z8Oe0ne9/sKprnA8xwFofpJMVWHWK36MnPCp+itfezlIEytzDZ7lia2Aj47nmEWoBm
         LkHI1TDgYIucQNWDKufWRCBzIVtxOgEPxEf9PCvX0DslB4r0xdQd+pdy7iZMWHjHNuBw
         /wKG6dSdxbET0q0FLWzdT1AN2Fd+1TtQoh/Uih3UQXGm33I1/ka0ULxIHRyXCym/i5bg
         iXgmcURRegG0ZqJ2DlsiXCMtju3eUAp9FtGldRjyGfzhiNbTFDUlnoAwqUkY+U4Ec5+d
         qeflouWyHDie2jqyNn6/JHggrfpR5QNLkx1CIKJM8J94nSONmTNA8sY7cCLPugFkSF/X
         cPXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U0Qy70yp;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U0Qy70yp;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELuHYWTOYQFbNjI0CqXP1p8oVlpcg0yI2Fmoa49sWImX0lQJI5lSwfF0je9zTwQS1eRkJKb6MRaBEgrV38t5FQo=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAHp75VcgUmOoo-jRbM-Gyp1JTY-2rJri8e7u2miYSvRM_4HmPg@mail.gmail.com>
References: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
 <CAHp75VcgUmOoo-jRbM-Gyp1JTY-2rJri8e7u2miYSvRM_4HmPg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Mar 2018 13:37:47 +0100
X-Google-Sender-Auth: uKEHVjeyjaMmWcYX2cwzmlqMrvA
Message-ID: <CAK8P3a3iK7Oo_XrkoqXyE0cXBm9Ngx18Yyvk+0UJNN1Gz5DYcQ@mail.gmail.com>
Subject: Re: [PATCH v4] Input: gpio_keys: Add level trigger support for GPIO keys
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-input <linux-input@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593648786277200792?=
X-GMAIL-MSGID: =?utf-8?q?1593738913528131698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 1:09 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 9:36 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>> be triggered by level type. So this patch introduces one trigger_type to
>> indicate if the button's interrupt type is level trigger or edge trigger.
>
>>                         button->irq =
>>                                 irq_of_parse_and_map(to_of_node(child), 0);
>
> AFAIU, 0 means NO_IRQ, thus,
>
>> +                       if (button->irq)
>> +                               button->trigger_type =
>> +                                       irq_get_trigger_type(button->irq);
>
> irq_get_trigger_type(NO_IRQ) should return 0.
>
> Therefore, if (button->irq) is redundant.
> Did I miss anything?

"irq_of_parse_and_map(to_of_node(child), 0);" is the first interrupt. A
more common way to express the same thing in modern drivers is
'platform_get_irq(pdev, 0)'.

However, there is one more thing I'm missing: with my suggestion
of emulating edge-triggered interrupts in the irqchip/gpio driver, the
trigger type here should also be 'IRQF_TRIGGER_RISING |
IRQF_TRIGGER_FALLING' in the DT description, so I don't think
we need to change the gpio-keys driver at all, just the gpio driver.

       Arnd
