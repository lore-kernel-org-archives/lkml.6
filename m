Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519914582; cv=none;
        d=google.com; s=arc-20160816;
        b=YQvJR3Z4fO3OJuA1taFyL0WRAPKwBgwQoVGjVuEpD1J3eC+Ko1ew4kLiIWWjrAjnMy
         U5inOUP2CNTPRx2VXdHhWOvZTrnVFX62iQYgrtWhF0wodzlj7mJ+JzKN6cpkIU4kfOmo
         HdtZqMXeJ+F7/z0lpxAXDPXJIHtoWq3B9MkJS6lS6K11oLPUr3SUeMCHgc8x0/9NhW4S
         SB1p25tejcvGyCRrZCjmspiEkcfDxhNfteQOWt6rrez1/t0nOEDFSm9b4oJPxU50Qk3i
         jkXhEzhKYVqMsP6c5uXXr+UKP609nOoEcFHf/FxPoE6M6QVk9bH3wC6CZP/jW9MXwB7Y
         eDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kh4BpCRV7tlho7lNaU1DQY2/Ue2VtDfSoLer/5vayHU=;
        b=g+ptjopxtSZLjfrSNDlW+QrtfIaIIpCKTJU9S7ilwcHtrFby7z5EH+Q3b3chs0v69t
         vdpdcVp0vkFkZNn8LYU7nPK887GJ83TMqWLVwJ8896dGjuYXWCvh8jxv76OlMuZiMlkk
         ENDsrxBHUsY1RsYOULoDCXGzmWYMJ2Zat0ZNJx9bREfPmXt58U7Z2VhpYSEIOJVJs49B
         LbrTuYj3W8EvNOpMwkbvguJwyIDwt07NZysbbr0zYQnD91T3RlDAyjS/2ilfLRvKKwZH
         piuspUZ44ScQNNy39pFVwQ+wMnE5QIdITxQfydmKpdOH0v2WvQ+oFL4ItKo4xXrsjz6T
         kZFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XBqOmNPi;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XBqOmNPi;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELsOf3tF6w7dgZBXPEEHOiiJUZxAIEwq0yjtPrStQLuJgzbj0HKM1BUnx9S6hUdK57fJ01/PV+qdZ7PaZF3cPtM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAHp75VdOLUF8UQYkuK0Pmi9uefJgk4oZVBerFoBObOXM7zpCUQ@mail.gmail.com>
References: <9ea2faf9c1cf8439f3a8ad495c6a2b49dacad7bd.1519889208.git.baolin.wang@linaro.org>
 <CAHp75VcgUmOoo-jRbM-Gyp1JTY-2rJri8e7u2miYSvRM_4HmPg@mail.gmail.com>
 <CAK8P3a3iK7Oo_XrkoqXyE0cXBm9Ngx18Yyvk+0UJNN1Gz5DYcQ@mail.gmail.com> <CAHp75VdOLUF8UQYkuK0Pmi9uefJgk4oZVBerFoBObOXM7zpCUQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Mar 2018 15:29:41 +0100
X-Google-Sender-Auth: fPwQ1GXmN1jLYuGM74MuLqPdydQ
Message-ID: <CAK8P3a3q8QdpXKGw2TtRnCXpnUcRubDZp8ok2=F6evw86O+nSA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1593745952839922570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 2:59 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 2:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Mar 1, 2018 at 1:09 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Mar 1, 2018 at 9:36 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>>>> be triggered by level type. So this patch introduces one trigger_type to
>>>> indicate if the button's interrupt type is level trigger or edge trigger.
>>>
>>>>                         button->irq =
>>>>                                 irq_of_parse_and_map(to_of_node(child), 0);
>>>
>>> AFAIU, 0 means NO_IRQ, thus,
>>>
>>>> +                       if (button->irq)
>>>> +                               button->trigger_type =
>>>> +                                       irq_get_trigger_type(button->irq);
>>>
>>> irq_get_trigger_type(NO_IRQ) should return 0.
>>>
>>> Therefore, if (button->irq) is redundant.
>>> Did I miss anything?
>>
>> "irq_of_parse_and_map(to_of_node(child), 0);" is the first interrupt. A
>> more common way to express the same thing in modern drivers is
>> 'platform_get_irq(pdev, 0)'.
>
> Yes, though I'm talking about _returned_ value.

Got it, yes you are right.

      Arnd
