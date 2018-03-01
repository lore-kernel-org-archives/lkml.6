Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519912752; cv=none;
        d=google.com; s=arc-20160816;
        b=0GlwpVBQeRNRSFFa74U/toclk12v7QOg1KNT7w1xXCLOyeoofTIpBFr17mbGW0SAaf
         T69EgMod55dDkrjBvyBswZDNk1PFMR8fxodHkdeiHIJKB1FLdt/a7s4wF6BeJacf5teR
         pqVkdl29iMDv0S3CmWInh8ywpV6DZK4mDczhqfHWjbRcCMASJqPyaFnFKyJjPxLPiLCL
         Fdt79qRMMo9mcTV4o9H8rsb9prOM46ar3YnOCL83gO2CwPixhX4G2/To+1rmyQeTRDMl
         40EplFngUakZ0qjNFr5Xx4IqWvNHi6FHLhZHJVo8Qj+Ygxy/oHGQdPXqzt5YgNeMYw0U
         uvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KfontG6W3TBXe7pwLy9tyiUOl9sP5VPvBoU+M+TkNXY=;
        b=nZjr57NRUI9G+Tv7HrRzHGR4jmE5vjMIFjdIot9i7CTCSXa5ZGysdOCnYjgj9M+yy8
         6iyYc7aLuPphgkYtzCOeUevuFP70VgCl5kfeBaW15Njnyt78cb8uVWxIQFt/0qu9kZDX
         W/2hRh/8G/YHgl69yfPQrp47tJRU8+VAiTtWbvAfltjoiwoih5Y2uwfz1EAu6XwoZ4K/
         GjLjMPYgKU53zjVBX2Gp/UlcbgsvP25ErxM2DnTq2mpRwc2BvkxQJt2HgLgIoZRGlTmk
         3j+pAH2BOeDbavTQeTQWb0bHUuu1ip9Nz+6/HpJjKKXcUxbeNmvB4Ye0+j4MhRt8yRXq
         ZSVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ckWuIIg3;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ckWuIIg3;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELubX3VlXEzNGsewPkz44TPONzvyepMg9yhpSfhwRKR/JhCXdnSwyH+2UUMZvmVOwEaY6B754ep9Ov0bl1auNSc=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3iK7Oo_XrkoqXyE0cXBm9Ngx18Yyvk+0UJNN1Gz5DYcQ@mail.gmail.com>
References: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
 <CAHp75VcgUmOoo-jRbM-Gyp1JTY-2rJri8e7u2miYSvRM_4HmPg@mail.gmail.com> <CAK8P3a3iK7Oo_XrkoqXyE0cXBm9Ngx18Yyvk+0UJNN1Gz5DYcQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 15:59:11 +0200
Message-ID: <CAHp75VdOLUF8UQYkuK0Pmi9uefJgk4oZVBerFoBObOXM7zpCUQ@mail.gmail.com>
Subject: Re: [PATCH v4] Input: gpio_keys: Add level trigger support for GPIO keys
To: Arnd Bergmann <arnd@arndb.de>
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
X-GMAIL-MSGID: =?utf-8?q?1593744034803210166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 2:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 1, 2018 at 1:09 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Mar 1, 2018 at 9:36 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>>> be triggered by level type. So this patch introduces one trigger_type to
>>> indicate if the button's interrupt type is level trigger or edge trigger.
>>
>>>                         button->irq =
>>>                                 irq_of_parse_and_map(to_of_node(child), 0);
>>
>> AFAIU, 0 means NO_IRQ, thus,
>>
>>> +                       if (button->irq)
>>> +                               button->trigger_type =
>>> +                                       irq_get_trigger_type(button->irq);
>>
>> irq_get_trigger_type(NO_IRQ) should return 0.
>>
>> Therefore, if (button->irq) is redundant.
>> Did I miss anything?
>
> "irq_of_parse_and_map(to_of_node(child), 0);" is the first interrupt. A
> more common way to express the same thing in modern drivers is
> 'platform_get_irq(pdev, 0)'.

Yes, though I'm talking about _returned_ value.

> However, there is one more thing I'm missing: with my suggestion
> of emulating edge-triggered interrupts in the irqchip/gpio driver, the
> trigger type here should also be 'IRQF_TRIGGER_RISING |
> IRQF_TRIGGER_FALLING' in the DT description, so I don't think
> we need to change the gpio-keys driver at all, just the gpio driver.

Sounds even better.

-- 
With Best Regards,
Andy Shevchenko
