Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3438615-1526234703-2-15235910731534355178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fi',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526234702; b=RebWCJljetJclbUdSNSsWHWzwMyolgGBjQ+2EHwv/txcAGh7cS
    qoYeU1VUShVwdkcdqDIKBuiJfJaIGEj5mfj5LFpmn0RX7ybXzm0UnclYgO1yH57w
    rKooBiQnfB+juo92yFuqgPRBLIxOPdh8x6e7td78pjxOJ5OYT3VSytZC4wX9dMwy
    r8Lion4MmFfTHBWusFiEuvA015xc7DWfIo3WFb577FzUHghfDFOl39i4tckKFIUw
    G/93DNEy9qSvRVWsZNSEL3XOFDzPq8F7+dOKTWZa17Y60pqS+6GgILJjn1mAFnv2
    CdCy4NRTuVQpF57KSkvT3d14DgDLwp/Q3JSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526234702;
    bh=kNuWiszYZ9T22cUDowR436WBfLuPIY456bOBvHVB2Bc=; b=ZhVLaNumkLdR
    4n+czvlEGCaCQMHafEuDU+CJ9Ll+2nvYIBQtExwzHgYMQ8ZujyozbKlAZfelvDc6
    0FZ3SvbeDCQ+DYId8k1/PlCTbQTuGWWgrT5XRjbjklzNciEejqd2j/yGw77XYPhI
    L+wTZUZEvfQPbbXYm1MfcgzGtPPPmDYQJ2R3cBjcJ73npkMfNxblm0KgsVz9MZDW
    gLrr6MyfmXA03NJqmy+xGDZzbTSiWiXyuFICsoUXiW+JtF0w/OcG0iiw2URkPGhV
    RCQQlXK3TZSRZLIkEh3QreLwC5gh4a1pCWCttpkQg6WLXB0CJ5iGT6ukpMAculro
    fJBuBlwimg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kapsi.fi header.i=@kapsi.fi header.b=AU+eC3cI x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161220;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kapsi.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kapsi.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kapsi.fi header.i=@kapsi.fi header.b=AU+eC3cI x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161220;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kapsi.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kapsi.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXrZmgXHAERI42emFMX6QIbN6Sei1LOU0/skQFvmkujkhz8MZYTIg9IrQK1SQa2qCi31Sx1E/Rl3eJxEr8QqMpCPwIIejzkyjDWtXo1pcALAf458Hhc
    FVwqAowlpP/VH7XNOqSNa4rXESur9c58Lk7sDI4hRnxtA47qPqMdREHT6tJN2OhNtCHFEjDKt8J0nC+MRjsPscIIGwVSeXQ77QTc+LAvizQId164GBPJ26lu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=5hCA8pmv6GK8uQLrUjoA:9
    a=3JiVsxM0Dyk85B-y:21 a=y3AGDoexW-4yMQH7:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeEMSFA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 14:05:00 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:56555 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeEMSE7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 May 2018 14:04:59 -0400
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-7-mperttunen@nvidia.com>
 <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <662ce972-56a9-9daa-d332-faa08b89c05a@kapsi.fi>
Date: Sun, 13 May 2018 21:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfYF_u2bZ+temGbReEB9K-t3A75aUNYwffyv9-=zEi0Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.250.162.250
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/13/2018 05:16 PM, Andy Shevchenko wrote:
> On Tue, May 8, 2018 at 2:44 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
>> multiplexing multiple "virtual UARTs" into a single hardware serial
>> port. The TCU is the primary serial port on Tegra194 devices.
>>
>> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
>> are part of Tegra HSP blocks that are already controlled by the Tegra
>> HSP mailbox driver.
> 
> First question, can it be done utilizing SERDEV framework?

Based on some brief research, the SERDEV framework is for devices that 
are behind some UART interface. In this case, this driver implements the 
UART interface itself, so by my understanding SERDEV is not appropriate. 
Please correct me if I'm wrong.

> 
>> +static void tegra_tcu_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> +{
> 
>> +       (void)port;
>> +       (void)mctrl;
> 
> Huh?

The serial core calls these callbacks without checking if they are set. 
They don't make sense for this driver so they are stubbed out.

> 
>> +}
> 
>> +static void tegra_tcu_uart_stop_tx(struct uart_port *port)
>> +{
>> +       (void)port;
>> +}
> 
> Ditto.
> 
>> +               if (written == 3) {
>> +                       value |= 3 << 24;
>> +                       value |= BIT(26);
>> +                       mbox_send_message(tcu->tx, &value);
> 
>> +               }
> 
> (1)
> 
>> +       }
>> +
>> +       if (written) {
>> +               value |= written << 24;
>> +               value |= BIT(26);
>> +               mbox_send_message(tcu->tx, &value);
>> +       }
> 
> (2)
> 
> These are code duplications.

Indeed - the length of the duplicated code is so short, and the 
instances are so close to each other, that I don't find it necessary (or 
clearer) to have an extra function.

> 
>> +static void tegra_tcu_uart_stop_rx(struct uart_port *port)
>> +{
>> +       (void)port;
>> +}
>> +
>> +static void tegra_tcu_uart_break_ctl(struct uart_port *port, int ctl)
>> +{
>> +       (void)port;
>> +       (void)ctl;
>> +}
>> +
>> +static int tegra_tcu_uart_startup(struct uart_port *port)
>> +{
>> +       (void)port;
>> +
>> +       return 0;
>> +}
>> +
>> +static void tegra_tcu_uart_shutdown(struct uart_port *port)
>> +{
>> +       (void)port;
>> +}
>> +
>> +static void tegra_tcu_uart_set_termios(struct uart_port *port,
>> +                                      struct ktermios *new,
>> +                                      struct ktermios *old)
>> +{
>> +       (void)port;
>> +       (void)new;
>> +       (void)old;
>> +}
> 
> Remove those unused stub contents.

Sure. I had these here so that we don't get unused parameter warnings, 
but I can just as well remove the parameter names.

> 
>> +       return uart_set_options(&tegra_tcu_uart_port, cons,
>> +                               115200, 'n', 8, 'n');
> 
> Can't it be one line?

It would be a total of 81 characters in length on one line, so no.

> 
>> +static void tegra_tcu_receive(struct mbox_client *client, void *msg_p)
>> +{
>> +       struct tty_port *port = &tegra_tcu_uart_port.state->port;
> 
>> +       uint32_t msg = *(uint32_t *)msg_p;
> 
> Redundant casting.

Will remove.

> 
>> +       unsigned int num_bytes;
>> +       int i;
>> +
> 
>> +       num_bytes = (msg >> 24) & 0x3;
> 
> Two magic numbers.

Sure, will add defines.

> 
>> +       for (i = 0; i < num_bytes; i++)
>> +               tty_insert_flip_char(port, (msg >> (i*8)) & 0xff, TTY_NORMAL);
>> +
>> +       tty_flip_buffer_push(port);
>> +}
> 
>> +MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("NVIDIA Tegra Combined UART driver");
>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
>> index dce5f9dae121..eaf3c303cba6 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -281,4 +281,7 @@
>>   /* MediaTek BTIF */
>>   #define PORT_MTK_BTIF  117
>>
>> +/* NVIDIA Tegra Combined UART */
>> +#define PORT_TEGRA_TCU 118
> 
> Check if there is an unused gap. IIRC we still have one near to 40ish.
> 

Correct, looks like 41-43 are unused. I'll change this 41.

Thanks for reviewing!

Mikko
