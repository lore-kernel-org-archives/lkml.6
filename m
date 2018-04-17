Return-Path: <Nicolas.Ferre@microchip.com>
X-Google-Smtp-Source: AIpwx4/ROFxP/nZOBsnYuCg4kE4vSlGiRpwsPHUrJZlWSkyFItiuqLocXxSHbHaQjejjz3suGJze
ARC-Seal: i=1; a=rsa-sha256; t=1523953498; cv=none;
        d=google.com; s=arc-20160816;
        b=YqF60C0SO2bNb74ha0VIGW71xyOXbJmBJbkj6OUeXOeqUPBIbbfIwgVkfKIQDnxpox
         67TSg2xCGJWiP1zPbaJ05DqRvY2dKCEfW0IA3Evq8po4qa227AINsgQ/ogSNkBiuYyQC
         6wLScn4lNshcUz3VjgqZ/YMYG2LFgiJ1dNe73PKgbChbxXbMY3G2fWDyC40pR1c78SH3
         nl9tmhxcQQtNS69G2imjFcssTWdbkJG2oOeVJJdZP08c8g90fG8M65pZ8wpQjYy5Tq0v
         zpXNtKcp7SLDRHH4t57m+eqDW2yn0JlaR6kHn5U88YMrr6aVm2gU6E8PJakb250O7ngk
         wQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=yuBGwUMxSSx6ydJKOPHNc3h4arAcEQgR+dfWOd3vU0A=;
        b=t3gVtKP94vr3CRWkIbC3IVHaf8iIH8ju7W5CVt494kb5bCiv6JmtXzgYkVILA6dTC4
         1PPm4nwYKoQyCiQSRh6vvdc+Icu4PQn2MVZbgUUkMSWN80QZUG5BWsZMcwtMoDvzNIMB
         zxKIjG9INrhNtiTN7e4AgDVHulT7ETErXfg7+an2rZ+iob75fUQKoLzbZQEDttev2g7Q
         bUVeptnbR7sDDnC8xL6MI3Oc3YOEbh0+rZ7RpdGUhH7hFa3NNm2HM8z7QuuFqeIkiEqR
         W8OCnNC49VCR1sv11NltKz+FREGM9iqdakT7zyo4rYPk5nlc4rXPDO7VAFJfZkkApvCY
         n0Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of nicolas.ferre@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Nicolas.Ferre@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of nicolas.ferre@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Nicolas.Ferre@microchip.com
X-IronPort-AV: E=Sophos;i="5.48,462,1517900400";
   d="scan'208";a="13885648"
Subject: Re: [PATCH 0/3] Fix an Atmel USBA UDC issue introducted in 4.17-rc1
To: Romain Izard <romain.izard.pro@gmail.com>, Felipe Balbi
	<balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-usb@vger.kernel.org>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <cbdab54a-d01a-2668-c3bc-b5b334a555e0@microchip.com>
Date: Tue, 17 Apr 2018 10:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416093405.16612-1-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894864444372008?=
X-GMAIL-MSGID: =?utf-8?q?1597981063579068486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/04/2018 at 11:34, Romain Izard wrote:
> The use of GPIO descriptors takes care of inversion flags declared in
> the device tree. The conversion of the Atmel USBA UDC driver introduced
> in 4.17-rc1 missed it, and as a result the inversion will not work.
> 
> In addition, cleanup the code to remove an include left behind after
> the suppression of the support of platform_data to declare USBA
> controllers.
> 
> These changes have not been tested on any hardware, as I do not have
> a board that needs to use inverted GPIOs.
> 
> Romain Izard (3):
>    usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
>    usb: gadget: udc: atmel: Remove obsolete include
>    usb: gadget: udc: atmel: Fix indenting

To the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thank you Romain.
Best regards,
   Nicolas

> 
>   drivers/usb/gadget/udc/atmel_usba_udc.c | 22 ++++++++++------------
>   drivers/usb/gadget/udc/atmel_usba_udc.h |  1 -
>   include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
>   3 files changed, 10 insertions(+), 37 deletions(-)
>   delete mode 100644 include/linux/usb/atmel_usba_udc.h
> 


-- 
Nicolas Ferre
