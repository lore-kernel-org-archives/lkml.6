Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526317007; cv=none;
        d=google.com; s=arc-20160816;
        b=rdl4GgNWU/r49/JA5wWbBzFypD9QOMMTfYhcUTVfjUsoDLbWAKHqWBh/ooaP7ydRnn
         ABbWbQh7pbGeKSXhq2r8gRXMdUrSp/ELMSXUWO3GOomECWQtv6jkVybB+g7rUmnw14px
         iurm8DEW1xJN9FG0NfuN5wg2qVbdSlE0fnz+TaZUgzJOUwoNmpjmuoNRQtIJTWlwamsX
         akpkpun58TuJkEgcJkw5eUckZ4S3xgNt46WGQKqAolEuMEvXZqwNuqZz6IAh/klSR9N3
         TOfBL6V/Yl+LOPeSS26uGrBmW4BRjXJeBFWNXa91VxyqAONeEgAKOoRMluS+tDiVn1F9
         Ww8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=VmLUsHRYVdiclamykuZ8flvj9y6PY8w7F+llYQz2PFI=;
        b=cjLZ1bThKRO/Aeok091LGASDwrLQES6nHB/jEnJwUuHjY6QXmOMPb/yA1wBvXHkL66
         NOALIJBK1gLXG3KUY4Fq6BJ6+CQ6SPMSFmxAoBh8YJIqcVrm+C8jk+83lJsYpz+0ljJS
         OH2ZhDfhzu3Gs1UvpP9ScMbvcZeh8lfqLqDGZl8gJX26lS4OyFmfK8+iC2ni2KILui/T
         /A5BEhAqWGZqR1Q1ahvzK8RyavYdYFuK66M5vSCW678WuagHFvDXsiiGpyQyJ1YgVrve
         ZCOdYKut/oVm4SCfD9PteT6UxjkCGJlJvkyfxbheb/lu9NJYF5o6gIT/VjJPLLvq3G/9
         J78A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GrnP4thf;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GrnP4thf;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoTu1aG3P4e+73oOpRfLv4Q7imeaJLVbi3YxS8tGjSZLoyooL+QlqBvT1lVYZrlBc3J9KNiu4ZK1mxjqt7DbGs=
MIME-Version: 1.0
In-Reply-To: <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com> <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 19:56:47 +0300
Message-ID: <CAHp75Vdcd0MmqCMGkFXcvKLrzcHtxBDcB8U1qTzysaH9By4Y8A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Radu Pirea <radu.pirea@microchip.com>, devicetree <devicetree@vger.kernel.org>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	linux-spi <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	alexandre.belloni@bootlin.com, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163742597492266?=
X-GMAIL-MSGID: =?utf-8?q?1600459383068284255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 1:57 PM, Richard Genoud
<richard.genoud@gmail.com> wrote:
> On 11/05/2018 12:38, Radu Pirea wrote:
>> This patch modifies the place where resources and device tree properties
>> are searched.

> I think it may be simpler with something like:

> +       int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;

Isn't resource_size() macro for this very purpose?

>> +     int size = to_platform_device(pdev->dev.parent)->resource[0].end -
>> +             to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>>
> ditto

Ditto.

-- 
With Best Regards,
Andy Shevchenko
