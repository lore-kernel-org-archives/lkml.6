Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E812075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaO19WBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E812075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeKTFJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:09:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42599 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTFJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:09:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so10763564pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tIwxcgj7Njf3cyZayrHB912g3H7YUcxzjJly/I9+WS4=;
        b=oaO19WByLms7QaoeyvfnOhioPNN2qnHM5bFhFBXXrJ4XHMTsskDzRFYyo45hHI9Gx9
         459MiOqjYDCEhm96l3dBXlnJk/MV5eO1/HYQ0qYMngv3EA1oEAkelxn2zPdFM3pgWGzp
         FRjhxsONq6JxVGXpfadaqKbRn2SrAxVE5tvc8Wv4wWoU4KI5texvFR9bTYLY6bOCzqnx
         XKF21YZ7BnyyvBAT/8d/qjG183kbQsymlbAyaRF84DwJtVs5BHYuc9cHOWEeLHbGZs7/
         MIfcqvRzOtoFLqNPyCk2AfnaAmVow+iVGt/xypCtKm1ue43FWV462Ig66OHgGnnsRqU8
         o4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tIwxcgj7Njf3cyZayrHB912g3H7YUcxzjJly/I9+WS4=;
        b=rk4J9anCTwtVPH2kC5bGt59CdwuMtqOVGIFNm3S8OkM17mVDsc9HeFFsVdirjzb03N
         X8Itl/U3IroxS9o6xkr3PwcsluvyP7MK9nW6BqwvT2odjOmqwrKz18d6+MMr18fWcNBv
         R8oHKKOvaXNiidOBOqeUQNT31WzsJGF4Tvwc6wUp10Ag/HA43KEzYcKzOWvlgcSFjl/A
         vjVcDJUC2xg+f8Y66aDOXZIlXtrG0mFBol4W9HsTszMuO9DUpwDlmsSDfWYkNRw7TPyR
         H4R5WWChju9AfmzW12y+ZywFBEet5YcN8ze8Dl0URA9uyWqMq+yn3r3uZrs9UBtIiaih
         brKQ==
X-Gm-Message-State: AGRZ1gL93G/tuQQr5zEFEUwQjIgeSnES0s65UqMXmlKZY4QyJMs9o3L3
        GR3wgxEoh0yfrEdKgMCKG4QbOK0L
X-Google-Smtp-Source: AJdET5ciGiyPa6bhMjTgO1jJWAC6UjFn14PQmR6SaBQSzYt0JtKMcC6KuFpKb4L7yhmQgBpKlMP10g==
X-Received: by 2002:a62:1c7:: with SMTP id 190mr17088710pfb.46.1542653078544;
        Mon, 19 Nov 2018 10:44:38 -0800 (PST)
Received: from [10.67.49.23] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 6sm28081545pfv.30.2018.11.19.10.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 10:44:37 -0800 (PST)
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
 <20181115172535.GA26922@roeck-us.net>
 <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
 <20181116011656.GA21813@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ffff966c-d6ae-1487-5269-b86df0824d1c@gmail.com>
Date:   Mon, 19 Nov 2018 10:44:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116011656.GA21813@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 5:16 PM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018 at 11:48:20AM -0800, Florian Fainelli wrote:
>>
>> OK, would you mind testing this below? It seems to me that 8250_of.c is
>> incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
>> is causing the issue here.
>>
>> diff --git a/drivers/tty/serial/8250/Kconfig
>> b/drivers/tty/serial/8250/Kconfig
>> index d7737dca0e48..21cb14cbd34a 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -483,7 +483,7 @@ config SERIAL_8250_PXA
>>
>>  config SERIAL_OF_PLATFORM
>>         tristate "Devicetree based probing for 8250 ports"
>> -       depends on SERIAL_8250 && OF
>> +       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
>>         default SERIAL_8250
>>         help
>>           This option is used for all 8250 compatible serial ports that
> 
> 44x/virtex5_defconfig has both PPC_UDBG_16550 and SERIAL_OF_PLATFORM enabled
> and fails to boot (or display anything on the console) with this patch applied.

Thanks for trying, can you either share or provide a link to the mpc85xx
and ml507 qemu command lines that you use? I spent a good chunk of my
time trying to get a kernel to boot but has failed so far.

Thanks
-- 
Florian
