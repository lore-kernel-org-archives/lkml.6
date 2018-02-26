Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519640262; cv=none;
        d=google.com; s=arc-20160816;
        b=peshlKPnYW8ZSlXgyVJS9MJa9r0ngJV/sW5cqkJk2Hlx95h90ZHdNd8gjXM7duJz0j
         O33A1Pl66fFvdb2i+oXLLOhtyOtZk4jdAKYGlQ6Ii+ESfx6PUuno91ctZ/mpgjI4Poik
         qiZpLJ4tyJLmLzrrU/8ovavPAE0y0Sw096BzQ6+tMJ04g4cIU1ESUq8p+eL4SeFuqSTF
         8BKulRcncL+exBZg1IMqe4sTNhc0CaybL48ri9jGQBUNEQUnTgU78w3zl1HLnDH/9kjL
         2X65rrNfmJtXbFudJ1HRGZz/ytbCNl4pZNfrLnlsqIaGm75SDhS9lrCDfAIWr8EaKhgT
         dp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gDO6E0rO2zgIhX3+EcTcIzt0J8tv+TDa1C0aXyiXklk=;
        b=kfGLxHoMU54l+5sXcIsgo/S7ZYON9A7tcsH3IVTyqGSwS81OwYmzfN2XnTuAWoFMYf
         UhHcEUoAL4VPY0cZgWKfp3wXm+OuEpkbepe8FaOdf6WiYJ/2++uPImPkGZ+9iUAGBmlD
         gquC+YsXkEHbvXNYlNfbThtBbHC7yToCtHNkGzahJCjbJ+RH69gJOuV3iHPW2RX4udNH
         jDa1BqVg+tobajXPK1Pnl2hynP2asHxW31aXTa/JkGZ9nCXMyUZjHWPb2+iVDgZcICq9
         CeNiZcmRTsuU9Y8egnXnWyPCbM+FdrvNpFwB8aADnB0pWql5s4ED1LYBKUxxl95koPnd
         qIHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jNJMof/D;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jNJMof/D;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtC3Qi1dN5ORySA7lVrA3KhBDsKq7/2nADngquPzMZKgeFHxGHlu0HrJG9uatesYmUcZHrSeCQ6Z6HwG/5mx+4=
MIME-Version: 1.0
In-Reply-To: <1519633504-64357-1-git-send-email-leo.wen@rock-chips.com>
References: <1519633504-64357-1-git-send-email-leo.wen@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 11:17:41 +0100
Message-ID: <CACRpkdaD+kFcOKP+V642r86hqwOO7h1UyA4wWBqGWdm3mjuhLA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: Document the Rockchip RK1608 bindings
To: Wen Nuan <leo.wen@rock-chips.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	jacob2.chen@rock-chips.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
	Eddie Cai <eddie.cai@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593451230041702429?=
X-GMAIL-MSGID: =?utf-8?q?1593458307618018434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 9:25 AM, Wen Nuan <leo.wen@rock-chips.com> wrote:

> From: Leo Wen <leo.wen@rock-chips.com>
>
> Add DT bindings documentation for Rockchip RK1608.
>
> Changes V2:
> - Delete spi-min-frequency property.
> - Add the external sensor's control pin and clock properties.
> - Delete the '&pinctrl' node.
>
> Signed-off-by: Leo Wen <leo.wen@rock-chips.com>

(...)
> +- reset-gpio           : GPIO connected to reset pin;
> +- irq-gpio             : GPIO connected to irq pin;
> +- sleepst-gpio         : GPIO connected to sleepst pin;
> +- wakeup-gpio          : GPIO connected to wakeup pin;
> +- powerdown-gpio       : GPIO connected to powerdown pin;

All these should be named something like:

reset-gpios = <>;
irq-gpios = <>;
etc

See
Documentation/devicetree/bindings/gpio/gpio.txt

So all in pluralis even if it is just one line, that is the standard.

> +- rockchip,powerdown0  : GPIO connected to the sensor0's powerdown pin;
> +- rockchip,reset0      : GPIO connected to the sensor0's reset pin;
> +- rockchip,powerdown1  : GPIO connected to the sensor1's powerdown pin;
> +- rockchip,reset1      : GPIO connected to the sensor1's reset pin;

Also get rid of the custom names here, either no lines should
have a "rockchip", prefix or all of them. Use the name of the
pin on the component, I suspect just

powerdown0-gpios
reset0-gpios
etc

By using the standard "*-gpios" suffix the kernel consumer API
will be much happier as well when you use gpiod_get() & friends.

Yours,
Linus Walleij
