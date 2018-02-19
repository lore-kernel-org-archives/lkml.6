Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeBSMIS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:08:18 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37284 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeBSMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:08:16 -0500
X-Google-Smtp-Source: AH8x224/NAHznqkGHBuSw40yWt2Vx+XtBG2qY6klo2SaEa2GU+v7gu29uCtyQ0lf9bOjbGElY8HYmcAiYpmZszRB1Dk=
MIME-Version: 1.0
In-Reply-To: <1519040779.3408.7.camel@pengutronix.de>
References: <20180219065438.19933-1-joel@jms.id.au> <20180219065438.19933-4-joel@jms.id.au>
 <1519040779.3408.7.camel@pengutronix.de>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Feb 2018 22:37:55 +1030
X-Google-Sender-Auth: 0rNM0WgskkP9BgJu-xgUWdBnU90
Message-ID: <CACPK8Xe3bKSfp=PqL8Rm9ivaM5HN0M7FbJ9Bwf_O2D5MZxEpPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset: simple: Allow user selection of driver
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, Lee Jones <lee.jones@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:16 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-02-19 at 17:24 +1030, Joel Stanley wrote:
>> Currently this driver is only user selectable if COMPILE_TEST is turned
>> on. Users may wish to select (and deselect) it, so remove this
>> restriction.
>
> I would like to keep user visible options to a minimum unless there is a
> good reason. What is the scenario in which a user would decide to
> disable the default-enabled reset-simple driver, or the other way
> around? This should be mentioned in the commit message.

In this SoC's case the driver is not essential. A system that does not
use UART1..4 will not ever call on the driver. This situation is
common as the console uses UART5.

> Maybe this is an indication that there could be a better default than
> just ARCH_ASPEED.

This is an appropriate default, as it causes the least surprise to a
user. Without taking the UART out of reset, the kernel driver still
loads, but characters are never drained from the FIFO.

Advanced users may want to save the few kilobytes that an extra driver
adds, and the boot overhead of loading yet another driver. The saving
is small, so if you feel strongly about it we can drop this patch.

Cheers,

Joel

>
> regards
> Philipp
>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  drivers/reset/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 18f152d251d7..7490a4370900 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -82,7 +82,7 @@ config RESET_PISTACHIO
>>         This enables the reset driver for ImgTec Pistachio SoCs.
>>
>>  config RESET_SIMPLE
>> -     bool "Simple Reset Controller Driver" if COMPILE_TEST
>> +     bool "Simple Reset Controller Driver"
>>       default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>>       help
>>         This enables a simple reset controller driver for reset lines that
