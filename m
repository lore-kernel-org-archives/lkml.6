Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519890076; cv=none;
        d=google.com; s=arc-20160816;
        b=abD+lintrX48jii0ei4h/VbN89zkeW+ua15Z0eWo7jwiNRGLQOI0IVn7SRqAV5CC/s
         7we8H9Wi9MHNtHo/Co4Rurpph+HPvgfEH3fxTPFOBucQ9VbcAyvqVc8Fk/2z8h1KgTDo
         6Nb/QuQpWfeVE6U6IhG4Lf8+7Bbezz1T7aHgv6Ly2tTz3eBcrn0puJyV7w0Wc0Zay3wC
         7tAT+hOplAeeJPZne7+qylQ4PWDdgO0AXRTVbavxQRm9EtHbavlg/hyOelRp4P3xXaKj
         amzJ40Ad1xkJoyN2HhIx3Vc6URKPFAcDGGoy5Vw5Tcu1QS0rnP6twcgiAN0wtbw5Xv+o
         H/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=rR+yhOTfmfndku+4+ZVkjfUdjmECR4VJcmO9ozhINfk=;
        b=MzsvYAc7uBQL0JW06icG0zEFOOtYINKRtjxj7cYAKsv3TAyOt5THyRGOYUm20IrDU8
         XIQ0mXzkciwglbbvRwenzMfbq+SReKsd9pqLSKW2mzvFW7aziO2bLMy9rL8Muenk538P
         HN6Uwpvg1zUWDPkalOPyy5iLQj+8CX1ZM8E5NvYsHMknE433KHSYl+ZwirjpRoUiUViP
         9XbK+iW6zgVbRFT4dzLBlISFJoMcIaAK5cdLqLVKExCyPjrFJZ1exGkbXcDIY4NUZpfG
         rxSaHDxj+VRiqTqaT8D8OB1A/97YnWjTSMw9aPJcCQm0DUuuRMmc7uNidTycbaIHGgp/
         owng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JLu9igWK;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JLu9igWK;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuW3LmwxXZRwT2i4IE7QIvNJAoeejjtXn5BwDXqG0o8Cz/ylB2iJ1qOkZX5a9uWDVM4hiOYTt8VjMoqCBemb5g=
MIME-Version: 1.0
In-Reply-To: <CACRpkdad4ZYa27Xd73QAsxvhJmBZnFRhDk-10yiitKYSrvxzWQ@mail.gmail.com>
References: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
 <20180219181159.tzbhhvbvpc236qma@rob-hp-laptop> <CAMz4kuL-VZ8XY5-ZLWfXLVXWb4zmxD-aaLQ-ka9M8V83y1B7Ag@mail.gmail.com>
 <CAMz4ku+0uzSDiM3AOnDcnVDqAjoV47nVAK+yQAw2CzgO6Yw-Bg@mail.gmail.com> <CACRpkdad4ZYa27Xd73QAsxvhJmBZnFRhDk-10yiitKYSrvxzWQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 1 Mar 2018 15:41:15 +0800
Message-ID: <CAMz4ku+g38dn2n+_VC96uXOjaxpb+zrWPXnN-rcPucZQpwDi5g@mail.gmail.com>
Subject: Re: [PATCH v2] Input: gpio_keys: Add level trigger support for GPIO keys
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>,
	stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
	Linux Input <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1593720256874762309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28 February 2018 at 20:53, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 26, 2018 at 7:24 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 21 February 2018 at 19:35, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> On 20 February 2018 at 02:11, Rob Herring <robh@kernel.org> wrote:
>
>>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>>> index a949404..e3104bd 100644
>>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
>>>>> @@ -29,6 +29,8 @@ Optional subnode-properties:
>>>>>       - linux,can-disable: Boolean, indicates that button is connected
>>>>>         to dedicated (not shared) interrupt which can be disabled to
>>>>>         suppress events from the button.
>>>>> +     - gpio-key,level-trigger: Boolean, indicates that button's interrupt
>>>>> +       type is level trigger. Otherwise it is edge trigger as default.
>>>>
>>>> No. Just use 'interrupts' instead of 'gpios' and specify the trigger
>>>> type. Or put both if you need to read the state.
>>>
>>> Okay, so something as below to get the level type from the
>>> 'interrupts' property.
>>> if (fwnode_property_read_u32(child, "interrupts", &button->level_type))
>>>         button->level_type = IRQ_TYPE_NONE;
>>
>> After more thinking, if we use 'interrupts' to indicate the irq type
>> for this case, we cannot specify the irq number due to the irq number
>> should be get by gpiod_to_irq(). So the device nodes look weird, since
>> we should define the index of the interrupt controller instead of the
>> irq type if the #interrupt_cells is set to 1 according to the
>> interrupt controller documentation. What do you think about this?
>
> I think what you're ultimately seeing is a bad fit between this
> GPIO/irq-controller and the Linux gpio keys driver, it doesn't
> have very much to do with the device tree bindings.
>
> What I think is appropriate is to try to create a new input driver
> in Linux that just takes an interrupt, not a GPIO, and let the
> GPIO chip only act as an irqchip for this.
>
> This avoid the complicated step of converting a GPIO to an
> interrupt in order to use it, when all you really want to
> do is use an interrupt, you don't really care about the
> GPIO here, correct?

Sometimes we should set the GPIO debounce, and read GPIO value to
report the event, so I think we can not remove GPIO.

>
> So we would create
> drivers/input/keyboard/interrupt_keys.c
> however I suspect a bunch of code would need to be shared
> with gpio_keys.c so maybe it is necessary to break out the
> parts of gpio_keys.c into its own helper file.
>
> Or maybe even have the
> pure interrupt handling as part of gpio_keys.c, i.e. if the
> driver can't find any associated GPIO, it goes on to
> check if there is an interrupt assigned to the device node
> and use that directly instead.
>
> Either way, Dmitry must be involved.
>
> Yours,
> Linus Walleij



-- 
Baolin.wang
Best Regards
