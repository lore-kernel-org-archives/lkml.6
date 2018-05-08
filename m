Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2554686-1525770997-2-2562650701288286150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525770996; b=Z0Kg0WJrJHxCuxVTaOUp55GK1HDqEB6aB0y5+ZQU1/dtrG+4so
    U9IOLyh8q1ySO8nYdaOvYS4WAonV3prUmHbmT1QvtH2KSArvCKUtXSV0Z9jwmCxP
    TvbXMKxXDKBjqBiV2rroeJF3WSe3fVEvaloiyqFNEgCvklEv/vbDu16QA/CljvnT
    qQ0Yz61UYaR1kUWscoUGaTUK6fMl5S+mz4QPqbeYaba28LNcE1NimJVMmuRqUYkA
    sk7ekDrnOiJkhYF1e0oOfbIpyFKZPwC5G5pEdmjRd9N/Hwt2WrVKxYcZXx3gW9O7
    iNnLNdpPNjSBPI7KQIP4KtBgJjFcVthYOgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525770996;
    bh=cVDH7mSZGTqz512o6XgwetEi6d7VT+hdjDmBGS3Xblc=; b=MpcG+WGDTFSk
    c9unS4gekI/z8ec9B4t0J0x69AGzmsQFpb151lQxFixGMyn9rb58xrzIZegLyA5E
    5l0hiIXQKe0aT3vyTbN9gnRFuPOJ5lDmD2gSH/xn8ni4vsz1LImaD/fie6wiX9HP
    kr6h54O0LbG+ZlcmA90uni+fEtA0I9PIL+8y1vAc5MofuHvYjm97gNJp/DmYCPnx
    wr5849yFpGw8pjlrAtB3N2qS/28jWs8I9N/WJwtlUpvdnTjKAGL7WAjwAK0Ev3qK
    hM42mhnA2tt8lVWcgTZC21TxucFcdfzgbpacH0nKgaaUhA21urqcrfV/WzYN2cNC
    OK+2+tSVXg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBMZn7ZPno01Iu6BQfvpX10+AGUmbmPpUNdE1vq0bJypQOzQuUmHZybncz1w6+ug6i6g8rKgQEf/DoO3cRe27WxbRbggjRQ57lX1+DuLfnsgfKQha2F0
    fVlTz9vxYN6tSO1h8+1kAT/+tei89b61BXw3XPvdJLTTsipMC9vwSym0JeC7leVFW8GFIESTKY1T128ToZyGPuTotFURdpSgi1m9KiClFbEh7Lw769GcT6Zq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=oLkrN1oqsHwA:10 a=N659UExz7-8A:10
    a=VUJBJC2UJ8kA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=1M1aVxPywekf_0DQKO0A:9
    a=Vn7jcPL1jMO36X0v:21 a=Vh1QX6vnj_Dfr-54:21 a=pILNOxqGKmIA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeEHJQU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 05:16:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754577AbeEHJQS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 05:16:18 -0400
Subject: Re: [PATCH v2] serial: 8250_of: Add IO space support
To: <gregkh@linuxfoundation.org>, <jslaby@suse.com>, <joel@jms.id.au>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>, <fcooper@ti.com>,
        <sergei.shtylyov@cogentembedded.com>,
        <yamada.masahiro@socionext.com>, <khoroshilov@ispras.ru>
References: <1524825366-155559-1-git-send-email-john.garry@huawei.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <664f5d8a-bb9e-cb36-2360-1a905c239728@huawei.com>
Date: Tue, 8 May 2018 10:15:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1524825366-155559-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27/04/2018 11:36, John Garry wrote:
> Currently the 8250_of driver only supports MEM IO type
> accesses.
>
> Some development boards (Huawei D03, specifically) require
> IO space access for 8250-compatible OF driver support, so
> add it.
>
> The modification is quite simple: just set the port iotype
> and associated flags depending on the device address
> resource type.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---

Hi Greg,

Just a gentle reminder of this patch. I didn't see any response.

BTW, I think that this patch should still cleanly apply to your 
tty-testing branch.

Thanks,
John

>
> Changes v1->v2:
> - rebase to Greg's tty-testing branch
> - use resource_type() helper
>
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 3de8d6a..bfb37f0 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -92,13 +92,43 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		goto err_unprepare;
>  	}
>
> +	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
> +				  UPF_FIXED_TYPE;
>  	spin_lock_init(&port->lock);
> -	port->mapbase = resource.start;
> -	port->mapsize = resource_size(&resource);
>
> -	/* Check for shifted address mapping */
> -	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
> -		port->mapbase += prop;
> +	if (resource_type(&resource) == IORESOURCE_IO) {
> +		port->iotype = UPIO_PORT;
> +		port->iobase = resource.start;
> +	} else {
> +		port->mapbase = resource.start;
> +		port->mapsize = resource_size(&resource);
> +
> +		/* Check for shifted address mapping */
> +		if (of_property_read_u32(np, "reg-offset", &prop) == 0)
> +			port->mapbase += prop;
> +
> +		port->iotype = UPIO_MEM;
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +			switch (prop) {
> +			case 1:
> +				port->iotype = UPIO_MEM;
> +				break;
> +			case 2:
> +				port->iotype = UPIO_MEM16;
> +				break;
> +			case 4:
> +				port->iotype = of_device_is_big_endian(np) ?
> +					       UPIO_MEM32BE : UPIO_MEM32;
> +				break;
> +			default:
> +				dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
> +					 prop);
> +				ret = -EINVAL;
> +				goto err_dispose;
> +			}
> +		}
> +		port->flags |= UPF_IOREMAP;
> +	}
>
>  	/* Check for registers offset within the devices address range */
>  	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
> @@ -114,26 +144,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		port->line = ret;
>
>  	port->irq = irq_of_parse_and_map(np, 0);
> -	port->iotype = UPIO_MEM;
> -	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> -		switch (prop) {
> -		case 1:
> -			port->iotype = UPIO_MEM;
> -			break;
> -		case 2:
> -			port->iotype = UPIO_MEM16;
> -			break;
> -		case 4:
> -			port->iotype = of_device_is_big_endian(np) ?
> -				       UPIO_MEM32BE : UPIO_MEM32;
> -			break;
> -		default:
> -			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
> -				 prop);
> -			ret = -EINVAL;
> -			goto err_dispose;
> -		}
> -	}
>
>  	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
>  	if (IS_ERR(info->rst)) {
> @@ -147,8 +157,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>
>  	port->type = type;
>  	port->uartclk = clk;
> -	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
> -		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
>  	port->irqflags |= IRQF_SHARED;
>
>  	if (of_property_read_bool(np, "no-loopback-test"))
>


