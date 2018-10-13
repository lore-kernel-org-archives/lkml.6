Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A8C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C4B206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elektron.elka.pw.edu.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJMXan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:30:43 -0400
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:49441 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeJMXan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:30:43 -0400
Received: from [172.19.1.1] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id 295A368B016;
        Sat, 13 Oct 2018 17:53:00 +0200 (CEST)
Subject: Re: Bug introduced in the of_get_named_gpiod_flags function.
To:     Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>, wzab@ise.pw.edu.pl,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
 <CACRpkdYQBxvHh-AfODddzc5G+BMBhUBSRXUdLVO8_99yniUYPQ@mail.gmail.com>
 <5d33d03a-5d62-c8c8-c9cc-2ccbe1b464f2@xilinx.com>
From:   "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Openpgp: preference=signencrypt
Autocrypt: addr=wzabolot@elektron.elka.pw.edu.pl; prefer-encrypt=mutual;
 keydata=
 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
Message-ID: <efcb67bf-bdf3-e3a8-5139-0f778ea00f1d@elektron.elka.pw.edu.pl>
Date:   Sat, 13 Oct 2018 17:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5d33d03a-5d62-c8c8-c9cc-2ccbe1b464f2@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 10:54 AM, Michal Simek wrote:
> Hi,
>
> On 11.10.2018 10:27, Linus Walleij wrote:
>> Hi Wojciech,
>>
>> (Thanks also Randy for forwarding this!)
>>
>> On Wed, Oct 10, 2018 at 6:32 PM wzab <wzab@ise.pw.edu.pl> wrote:
>>
>>> The function of_get_named_gpiod_flags in older versions of the kernel
>>> (up to 4.7.10 - https://elixir.bootlin.com/linux/v4.7.10/source/drivers/gpio/gpiolib-of.c#L75 )
>>> contained an important workaround:
>>>
>>> /* .of_xlate might decide to not fill in the flags, so clear it. */if (flags)
>>>    *flags = 0; Unfortunately, newer kernels do not contain it. Therefore if the
>>> "xlat" function in the gpiochip driver does not set flags, (like e.g.
>>> the Xilinx AXI GPIO driver: https://github.com/Xilinx/linux-xlnx/blob/c2ba891326bb472da59b6a2da29aca218d337687/drivers/gpio/gpio-xilinx.c#L262 )
>>> the random, unitialized value from the stack in of_find_gpio
>>> ( https://elixir.bootlin.com/linux/v4.18.13/source/drivers/gpio/gpiolib-of.c#L228 )
>>> is used, which results in random settings of e.g., OPEN DRAIN or OPEN SOURCE mode.
>>>
>>> I have also reported the problem in the Xilinx forum:
>>> https://forums.xilinx.com/t5/Embedded-Linux/Bug-in-of-get-named-gpiod-flags-function-in-the-kernel-random/td-p/897695
>> It seems the commit removing this is:
>>
>> commit 762c2e46c0591d207289105c8718e4adf29b2b34
>> "gpio: of: remove of_gpiochip_and_xlate() and struct gg_data"
>>
>> But I honestly don't see a problem with it.
>>
>> You are referencing an out-of-tree driver. Use the in-tree gpio-xilinx.c
>> that does not do any custom xlate and you will be fine.
>>
>> I looked over the driver doing custom flag translation in the kernel tree,
>> and they all set flags, so this is not a problem in the upstream kernel.
> There was an attempt to sync up xilinx internal gpio driver with
> mainline by someone else but not sure what's the status.
> If you have issue with xilinx internal patch please talk to us.
> If the problem is with mainline please use this mailing list.
>
> Thanks,
> Michal

The question is, if there may be any other in-tree GPIO controller
driver that does not initialize those flags?

Anyway the current situation is somehow dangerous.

Maybe the best solution would be to initialize the automatic variable in
the of_find_gpio?

With best regards,

Wojtek

-- 
Wojciech M Zabolotny, PhD
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology

