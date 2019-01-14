Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD0AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E201B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AilkFF74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfANUBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:01:32 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51363 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:01:30 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so1463214ite.1;
        Mon, 14 Jan 2019 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gXVANtXOLUDqPrgfHVs++49MbsP87dwStc1KS983FQ0=;
        b=AilkFF746oWeF63YYXnBm4DjH6p9x6QtREBs3eXXG+NvSE4eTTqAEypPzPobaoQbDl
         1M24pgTma8dYXPPLCNgsX5VRywY4SjfROzOub4wpGPSFyzw7V6PJdNJcMsUncT0hdAel
         dqT89PewzmRmKGO/HoGJj2zWSn9obwj5+sxR6A1x3Aac3lOs9lkGflH3Xa3u2CBiEao2
         JFXrlhhV2ASDjyx2wZWBdp+8yo+A09xkhmEqcH/rLHp9uwIhYfhWVNR60ALWuzIYRjk4
         n6nMw/ABbJ/9E9x2WTh6qVil0Y1wtxaxx71edNfrdtfSgfMOI73QNv0yZIZOG1esJMeT
         qDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gXVANtXOLUDqPrgfHVs++49MbsP87dwStc1KS983FQ0=;
        b=dijFAQHK3qj/faw/5rAW18O57uQ39jR55990v2ociMQnuik73wGNtu9gmMhbGmaTFr
         ymbi54WEcAL0vsHB87kOdEySwQtVf7/efVg2SzsBXzLtN22ljAjQuCMDeZ3rPsyZ+8HV
         4AXsLjMaQBUP8nGlITSOlpIhm88CT8C/jTFPC3TJXAWAq9u3TQHEXbIi8f/HsQvRsuk9
         GBvWAoRPbUrPsj0XmJnKcrd/v3jEndgi6BKW6LIEPQSOsPhIx4BIH0B8f0j9+X4d9ovw
         HvDnWYRcZcaJgqj0aCbRXYfSfyxb9IZ/D9RCbpYKYMI2GeglPDZURLo4PeVtVokJoPFS
         Pv7g==
X-Gm-Message-State: AJcUukcM9pL/F+RLJXBYosEZWKNdEnO5WKAbooAZNFjMuoqcEWIvZwyD
        K34uOUS/ukG2QMyHkDUoIyw=
X-Google-Smtp-Source: ALg8bN7GoY6YiLXrsDbiyE4qihvcBYAsGde+BLp0WekNtnQEv3a80DLbskSw+mePgEVawZ4nXR0pJQ==
X-Received: by 2002:a24:c584:: with SMTP id f126mr581663itg.162.1547496088988;
        Mon, 14 Jan 2019 12:01:28 -0800 (PST)
Received: from [192.168.1.133] ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id v202sm713405ita.13.2019.01.14.12.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:01:27 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
 <20190112094226.GA910@himanshu-Vostro-3559>
From:   sebastien bourdelin <sebastien.bourdelin@gmail.com>
Message-ID: <2522efda-2762-01a6-7597-38c086779b74@gmail.com>
Date:   Mon, 14 Jan 2019 15:00:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190112094226.GA910@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/19 4:42 AM, Himanshu Jha wrote:
> On Fri, Jan 11, 2019 at 03:53:58PM -0500, Sebastien Bourdelin wrote:
>> This commit allow the driver to work with device-tree.
>>
>> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
>> ---
> I get the following compilation failure:
>
> Below I have `allyesconfig` except 'BME680' configure as [M]
> in case you wish to reproduce.
>
> himanshu@himanshu-Vostro-3559:~/linux-next$ grep -i -w 'CONFIG_BME680\|CONFIG_ACPI\|CONFIG_OF' .config
> CONFIG_ACPI=y
> CONFIG_OF=y
> CONFIG_BME680=m
> himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
> make[1]: Nothing to be done for 'all'.
>    CALL    scripts/checksyscalls.sh
>    DESCEND  objtool
>    CC [M]  drivers/iio/chemical/bme680_spi.o
> In file included from ./include/linux/acpi.h:41:0,
>                   from drivers/iio/chemical/bme680_spi.c:7:
> ./include/linux/module.h:213:1: error: expected ‘,’ or ‘;’ before ‘extern’
>   extern typeof(name) __mod_##type##__##name##_device_table  \
>   ^
> drivers/iio/chemical/bme680_spi.c:119:1: note: in expansion of macro ‘MODULE_DEVICE_TABLE’
>   MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
>   ^~~~~~~~~~~~~~~~~~~
> scripts/Makefile.build:291: recipe for target 'drivers/iio/chemical/bme680_spi.o' failed
> make[1]: *** [drivers/iio/chemical/bme680_spi.o] Error 1
> Makefile:1741: recipe for target 'drivers/iio/chemical/bme680_spi.o' failed
> make: *** [drivers/iio/chemical/bme680_spi.o] Error 2
Thanks for the test, this is bad, i will fix that!
> BUT if:
>
> himanshu@himanshu-Vostro-3559:~/linux-next$ make allyesconfig
> scripts/kconfig/conf  --allyesconfig Kconfig
> #
> # configuration written to .config
> #
>
> himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
> scripts/kconfig/conf  --syncconfig Kconfig
> make[1]: Nothing to be done for 'all'.
>    HOSTCC  scripts/dtc/dtc.o
>    HOSTCC  scripts/dtc/flattree.o
>    HOSTCC  scripts/dtc/fstree.o
>    HOSTCC  scripts/dtc/data.o
>    HOSTCC  scripts/dtc/livetree.o
>    HOSTCC  scripts/dtc/treesource.o
>    HOSTCC  scripts/dtc/srcpos.o
>    HOSTCC  scripts/dtc/checks.o
>    HOSTCC  scripts/dtc/util.o
>    LEX     scripts/dtc/dtc-lexer.lex.c
>    YACC    scripts/dtc/dtc-parser.tab.h
>    HOSTCC  scripts/dtc/dtc-lexer.lex.o
>    YACC    scripts/dtc/dtc-parser.tab.c
>    HOSTCC  scripts/dtc/dtc-parser.tab.o
>    HOSTLD  scripts/dtc/dtc
>    CC      scripts/mod/empty.o
>    MKELF   scripts/mod/elfconfig.h
>    HOSTCC  scripts/mod/modpost.o
>    CC      scripts/mod/devicetable-offsets.s
>    HOSTCC  scripts/mod/file2alias.o
>    HOSTCC  scripts/mod/sumversion.o
>    HOSTLD  scripts/mod/modpost
>    CC      kernel/bounds.s
>    CC      arch/x86/kernel/asm-offsets.s
>    CALL    scripts/checksyscalls.sh
>    DESCEND  objtool
>    CC      drivers/iio/chemical/bme680_spi.o
>
> Compiles without any issues.
Hum, weird it compiles actually :s
> Also, wondering when is 0x77 i2c address used, since I tested
> this on 3 different boards with 0x76(when SDO is connected to GND)
>
> And why do I connect SDO to ground everytime ?
> It is because if SDO pin is left floating then I2C address will be
> undefined as said in datasheet + I have observed this while testing.

Ah, thanks for the reminder, actually i have only tested with a floating

SDO, but i will probably use the GND instead even if i didn't had any

problem right now.

> Actallly, I don't understand what "VDIDO" is, as explained in the
> datasheet.
>
>
> Anyway, if the above compilation issue is not a problem, then
>
> 	Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
>
>
> Thanks
