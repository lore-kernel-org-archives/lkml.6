Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A08FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3A520671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l087yCLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3A520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbeGWT1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:27:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36477 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGWT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:27:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so87998wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AemlwiTnLQyHnVQEiJPRyX4xAI6W9UHDR9eHAzJdCj8=;
        b=l087yCLpUhqM55m1uwCZ+P6Al1LLWyxEj0FXrZJbbue6VOLHiW0bJH5KE+xjngdxM/
         E3RMgtx4iwIiixiKXpmDOGbWZY9Aota08vd+0t3J2cvMb7yV2TJ90PwBQcMkOcS1egSL
         YKm5MYznS+wCl80FgxIQZL6BUZcgnML/Gub7ENPSLVb9uK4W0hDNc3ATWaLlD/aR+Jhg
         3g9TehbifAPWRUpFTfYjmoHwnocDlw3nUMRkZ4s21LO3NcxerJLEmgAxGECjuxSSH5MO
         7GlkmoeUhSYO+lQXULF7rmgITgv5lWf8fASN2l4rXpYfOcByqUcF0KPra2YFsmvqYmW5
         7xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AemlwiTnLQyHnVQEiJPRyX4xAI6W9UHDR9eHAzJdCj8=;
        b=Wj8kWaDXiC7/VbBQAdSymjwJtqAejWx8YBr+hBR0L49+Pri043MPeL4YAH3GSsCDUF
         fYNe8GjQegVtnfWuVQbtlG2DKqj6IQSS9A3nMzZhiuwHV0iOGGA+UzKpUB3UMakgLw2o
         QmteLpyNvCQUjVNsNE2EAL3fxINJlM0yMSYVF24bJKRviUPJwrWxdyiFR3puT14YYZU+
         8rKFIlBuDsquYtG8Kvnq166tydf2NUddT6syPdAAFnRYIKXmVaaTHXUJSiMx6ukAdFaG
         ZjiGbfIecE/wKO8UFaQm5cn2L4CyethuEPIcHEtTviXWmNPmHqcHNZ3xNdH9t2Xm7uK8
         HV9g==
X-Gm-Message-State: AOUpUlHPHIXNlUBlSP1CuGYxqGxVhJGQDEMf0xeOun2kzN9dT/HB78V7
        ChVvQNF+raRm7XP6OWNeqdPof11kfr6L0eQDeX0DzzQ1
X-Google-Smtp-Source: AAOMgpfnwTZvm48u1mc5QoPIA2jVMJMSWhK171tmjjKjCQFXzH+hr8hOsGg7SDAbDsaQjW4Ak6PRhGfjujoeI8F3EMc=
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr66866wmd.142.1532370316996;
 Mon, 23 Jul 2018 11:25:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7507:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 11:25:16
 -0700 (PDT)
In-Reply-To: <87efjnvpjl.fsf@notabene.neil.brown.name>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
 <87sh85uzu3.fsf@notabene.neil.brown.name> <a3bb28f9-1185-3dbb-1a1f-1bfe03a8798c@gmail.com>
 <87efjnvpjl.fsf@notabene.neil.brown.name>
From:   Brian Norris <computersforpeace@gmail.com>
Date:   Mon, 23 Jul 2018 11:25:16 -0700
Message-ID: <CAN8TOE9Pr2i4tXu8mGuY7xSY5bU_r7UhQ9SxfqYg_M4YDUt0ew@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
 3-byte addressing.
To:     NeilBrown <neil@brown.name>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a little late to this thread, but I recently noticed (and
complained about) commit: 59b356ffd0b0 ("mtd: m25p80: restore the
status of SPI flash when exiting").

On Mon, Apr 9, 2018 at 6:05 PM, NeilBrown <neil@brown.name> wrote:
> On Mon, Apr 09 2018, Marek Vasut wrote:
>
>> On 04/08/2018 11:56 PM, NeilBrown wrote:
>>> On Sun, Apr 08 2018, Marek Vasut wrote:
>>>
>>>> On 04/08/2018 09:04 AM, NeilBrown wrote:
>>>>>
>>>>> According to section
>>>>>    8.2.7 Write Extended Address Register (C5h)
>>>>>
>>>>> of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)
>>>>>
>>>>>    The Extended Address Register is only effective when the device is
>>>>>    in the 3-Byte Address Mode.  When the device operates in the 4-Byte
>>>>>    Address Mode (ADS=1), any command with address input of A31-A24
>>>>>    will replace the Extended Address Register values. It is
>>>>>    recommended to check and update the Extended Address Register if
>>>>>    necessary when the device is switched from 4-Byte to 3-Byte Address
>>>>>    Mode.
>>>>>
>>>>> This patch adds code to implement that recommendation.  Without this,
>>>>> my GNUBEE-PC1 will not successfully reboot, as the Extended Address
>>>>> Register is left with a value of '1'. When the SOC attempts to read
>>>>> (in 3-byte address mode) the boot loader, it reads from the wrong
>>>>> location.
>>>>
>>>> Your board is broken by design and does not implement proper reset logic
>>>> for the SPI NOR chip, right ? That is, when the CPU resets, the SPI NOR
>>>> is left in some random undefined state instead of being reset too, yes?
>>>
>>> Thanks for the reply.
>>
>> Sorry for the delay.
>>
>>> "Broken" is an emotive word :-)  Certain the board *doesn't* reset the NOR
>>> chip on reset.
>>
>> It's not emotive, it is descriptive of what it really is. Such boards
>> which do not correctly reset the SPI NOR can, during ie. reset, get into
>> a state where the system is unbootable or corrupts the content of the
>> SPI NOR. This stuff came up over and over on the ML, it seems HW
>> designers never learn.
>
> Ok, the board is broken.
> Still, Linux has a history of even supporting broken hardware -  Spectre
> and Meltdown for example.

Except those can generally be worked around at the expense of
performance. This is impossible to workaround completely without
hardware changes.

> I wouldn't propose a fix that harms the kernel in any way (hurts
> maintainability or negatively affect other hardware), but I don't
> think my proposed patch does.

No, yours doesn't, but the original patch (Commit: 59b356ffd0b0 ("mtd:
m25p80: restore the status of SPI flash when exiting")) started us
down the slippery slope. If things work 99% of the time, people often
fail to notice that they are broken for the 1%. Thus, that patch can
harm future development, where unwitting designers think things are
working fine and fail to fix their hardware. That's not to say
designers always notice even when things are really really broken, but
that patch makes the brokenness much harder to notice.

>>> However the NOR chip doesn't have a dedicated RESET pin. It has a pin
>>> that defaults to "HOLD" and can be programmed to act as "RESET".  This
>>> pin is tied to 3V3 on my board. If it were tied to a reset line, it
>>> would still need code changes to work (or switch from the default).
>>
>> I'm afraid this needs HW changes. The solution for SPI NORs without a
>> dedicated reset line is to just hard cut the power to them for a while
>> in case the CPU core reset out is asserted.
>>
>>> A few month ago:
>>> Commit: 8dee1d971af9 ("mtd: spi-nor: add an API to restore the status of SPI flash chip")
>>> Commit: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when exiting")
>>
>> This works when reloading the driver, but not when restarting the system.
>
> I don't understand what you are saying.
> The second patch provides a ->shutdown function for the spi_driver.
> This is called by spi_drv_shutdown which is called by the driver
> ->shutdown function, which is called by device_shutdown(), which
> is only called by
>   kernel_shutdown_prepare() and
>   kernel_restart_prepare().
>
> So it works exactly when restarting the system, and not when reloading
> the driver.
>
>>
>>> were added to Linux.  They appear to be designed to address a very
>>> similar situation to mine.  Unfortunately they aren't complete as the
>>> code to disable 4-byte addressing doesn't follow documented requirements
>>> (at least for winbond) and doesn't work as intended (at least in one
>>> case - mine). This code should either be fixed (e.g. with my patch), or removed.

I would (and already did) vote for removal. The shutdown() hook just
papers over bugs and leads people to think that it is a good solution.
There's a reason we rejected such patches repeatedly in the past. This
one slipped through.

Brian
