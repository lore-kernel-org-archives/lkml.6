Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qM5nB/4nGVv6egAAmS7hNA
	; Thu, 07 Jun 2018 12:43:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 226C0608BF; Thu,  7 Jun 2018 12:43:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="HDQh8KCF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 88357607E7;
	Thu,  7 Jun 2018 12:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88357607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeFGMno (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:43:44 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:39260 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeFGMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:43:41 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A2227B008DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 14:43:38 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1528375418; x=1529239419; bh=bcPBoc31b/1e+Gq/xYXnLNKefw4lvE+Lc/z
        wHXs3aEw=; b=HDQh8KCFl3OEZj/BKuF2d619P9iC+spv/METn9G0yJP8PLapVsF
        dcaCnF8y7i5Yq38R9N7yqeatfcgYzaI4PYrt//7WWauNYR7E2sa7odNOcblSyXh6
        oKgZCXqa499ibtnsXJoSzbZwqE9dXZxDRwgvEVDlcDecHokxGaHlkfmA=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xwfQEBDkczJB for <linux-kernel@vger.kernel.org>;
        Thu,  7 Jun 2018 14:43:38 +0200 (CEST)
Received: from [192.168.2.109] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 82205B007E9;
        Thu,  7 Jun 2018 14:43:36 +0200 (CEST)
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
 <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
 <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
 <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
 <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
 <CAJs94EZx2ZdEL14SCEBomEfXLRPN4FfOp4yE44kfpnE+5+Ze-g@mail.gmail.com>
 <d3c4e356-2c04-731f-a665-a445a6bf68af@micronovasrl.com>
 <CAJs94EbY1apGLUK+6ZXy=j5Uitox+WbG903_5SX2kW_tCLQzPw@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <0dd0cea7-9c12-dfc8-2a29-fa499d609e32@micronovasrl.com>
Date: Thu, 7 Jun 2018 14:43:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJs94EbY1apGLUK+6ZXy=j5Uitox+WbG903_5SX2kW_tCLQzPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/2018 09:03, Matwey V. Kornilov ha scritto:
> 2018-06-06 22:15 GMT+03:00 Giulio Benetti <giulio.benetti@micronovasrl.com>:
>> Il 06/06/2018 20:55, Matwey V. Kornilov ha scritto:
>>>
>>> 2018-06-06 16:11 GMT+03:00 Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com>:
>>>>
>>>> On Wed, 2018-06-06 at 14:15 +0200, Giulio Benetti wrote:
>>>>>
>>>>> Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
>>>>>>
>>>>>> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>>>>>>>
>>>>>>> em485 gets lost during
>>>>>>>
>>>>>>> Copy em485 to final uart port.
>>>>>>>
>>>>>>
>>>>>> Is it needed at all?
>>>>>>
>>>>>> The individual driver decides either to use software emulation (and
>>>>>> calls explicitly serial8250_em485_init() for that) or do HW assisted
>>>>>> stuff.
>>>>>
>>>>>
>>>>> In 8250_dw.c, during probe(), I need to call dw8250_rs485_config()
>>>>> against local struct uart_8250_port uart = {};
>>>>> Inside serial8250_register_8250_port() not all uart fields are
>>>>> copied(em485 too).
>>>>> So after probe, em485 is NULL.
>>>>>
>>>>> Another way could be to call dw8250_rs485_config() against real uart
>>>>> port, after calling serial8250_register_8250_port(),
>>>>> would it make sense?
>>>>
>>>>
>>>> Look at OMAP case closely. They have a callback to configure RS485 which
>>>> is called in uart_set_rs485_config()  which is called whenever user
>>>> space does TIOCGRS485 IOCTL.
>>>>
>>>> So, it's completely driven by user space which makes sense by my
>>>> opinion.
>>>
>>>
>>> AFAIU, Giulio wants to add support for rs485-enabled-at-boot-time
>>> device tree option (see bindings/serial/rs485.txt for reference).
>>
>>
>> Yes, I want to add support for "rs485-enabled-at-boot-time" property,
>> maybe I had to write better commit log and a cover letter. Sorry.
>>
>>> I suppose it is only important for use-case when rs485 used as slave
>>> (peripheral role).
>>
>>
>> It's important also for master, because RTS, if RTS_AFTER_SEND is set,
>> remains not asserted(trasnmission) until userspace opens that serial port.
>>
> 
> And it makes no sense, because how are you going to transmit and
> receive not opening the port and not running an application?
> It is master who transmits the data first. So, before all systems
> going to work you have to open the port from userspace.
> 
> In case of slave this of course makes sense.
> 

Yes it's true, my mistake, it works as master, even if bus will be held 
busy by master until port is open.

As slave it keeps bus busy.

IMHO it would be the best to have rs485 free until port is open,
this also reflects the reality:
when rs485 ON and RTS_AFTER_SEND is set, if port is closed or open 
without transmitting RTS must be asserted(pin low, rx mode).
Agree?

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
