Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1194855-1524489711-2-14368563214483785818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524489710; b=g7rxzg0TdBvNWgBlzbjyImGiS25Kwqk29uTvBQm8aUpdiFIBsY
    DCKdOXh2QvztY3sx8YwWorLaIfNrn6xkD3vXfLjK/SuXa53arNAGs8M99WV9gMec
    WnAaOpIF5sfrAQoEmR1otsgYAaHTY6HJIpmfnyPthBbOlAAwgyrtjUj5Rzq0D4Tu
    oJNGtqHMi/iAgLzifHudZb8JTgjjBDCs1dIkSmwN0THnF5svUp1W8XzodkXnNC4p
    niFFVOQzrgwBPIklfSu/rv54xzZUKBrH76K2b8L6vT7jVJVb9EZ0yecrhZbgjcc8
    KtRwZwcS3gKTMSIFNNs9uPT8XkC4p6WZIsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524489710;
    bh=4QVPbKMwEPtzxSReQqu0KLfXDJHnve6OA6s0hw+W/+E=; b=AMF9i+tS6Uas
    Sl8gPatik0NfzlcfmWW/xf6NSbI5gZorWRFupfrdE2JNYFpHrKE3Ta2yp2IfIXsj
    1asiLC50l6MmhRv7Y98e/rk3QkXZk3zAdMNWd/r4xZf4LXrn2COqu40ea2FOhWHR
    4dtazTa/lbZZVuWbQ0yzvXQ0yIaPoXbYCel3ZVP2aQ7epS0toyLGUl4diGAcfqHG
    YNtpMukR0fevGasLZfyCOqung1GbWbP2KqVctjbtG2z+cBT0xaPu2gG0jeSsiz/K
    WkNtdnvUi4LGkdEnImtzu73Jxi0MVxamjb/s5eLEA9GUZGH5F1rDFTeEJ1ASHXuJ
    MVfLxqGr8A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHuLWM3Q57hBAeovR6iN3JnnZqo86Xlu0KZGdGVvPP5hUQmqAmrzysF2nRyqn/0QCEXdW8xP7KsmvtcMmZJJ6ORcjs4aUFu7ZyZuuTo1b1I99DirkM5o
    uxGcxAZjqCg+krsipv/bUXbUxxiGU+MTxvwDTpYuD7vtN3lirndZ3mrxkCpMVATSsO5e5EbuzTF4ki/Zupl6fJMEZysVmcwA42Iaj9XpNSFoRHkNVTz2VDWy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=Am4ss40yAAAA:8 a=AFQiphXAfxcKlUOB4MwA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=lf-hbUz_c89dky27wAWH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeDWNVr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 09:21:47 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:47882 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754786AbeDWNVq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 09:21:46 -0400
Subject: Re: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
To: Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>
CC: stable <stable@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <f8c69fee-8889-f0aa-1235-b7a65068238b@mips.com>
Date: Mon, 23 Apr 2018 14:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524489696-637139-30706-96196-1
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192287
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Michal

On 23/04/18 10:18, Michal Simek wrote:
> device->baud is always non zero value because it is checked already in
> early_serial8250_setup() before init_port is called.

True, currently init_port is only called from the one location and so 
the test is a little redundant, though I don't see the harm in testing 
both inputs to the divisor calculation immediately before use such that 
any future call path avoids setting a bad divisor.

> 
> Fixes: 0ff3ab701963 ("serial: 8250_early: Only set divisor if valid clk & baud")
> Cc: stable <stable@vger.kernel.org>

Even if the test is dropped going forward, I wouldn't consider it's 
presence a "bug" such that a fix needs to be backported.

Thanks,
Matt

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>   drivers/tty/serial/8250/8250_early.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index ae6a256524d8..5cd8c36c8fcc 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -122,7 +122,7 @@ static void __init init_port(struct earlycon_device *device)
>   	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
>   	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
>   
> -	if (port->uartclk && device->baud) {
> +	if (port->uartclk) {
>   		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
>   		c = serial8250_early_in(port, UART_LCR);
>   		serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
> 
