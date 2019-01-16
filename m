Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819AC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5324620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npfpjItl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbfAPW0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:26:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33008 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfAPW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:26:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so4886122qkj.0;
        Wed, 16 Jan 2019 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Mwdillh1TNW10mWzPVCrqTZGEvKdbRUq2mwaNx6PZ5c=;
        b=npfpjItl8aC+JNlyZqpA7w62aHVZnE1Hz0r8Ee0s3WXigjKu0bne/cE6ioo8hkT85L
         jOwcwnmWYqn1xLJLsM0U73PkVGugjieWeGKy4xqgiuRM3mqmYkrl2r6jDfYxDyBf+76U
         nQxuJK63D90w98TyyIzcWFcTdLL5u96xflH0oobK0KwobeqdaKHkbYSlpr3jj4t3gvax
         Ac3432CaSGH6WxJd9YT8zJjab+zhMSsfX+pa2aj3Rq0ylcSvcoIylFMqFXtxI9Odc297
         g+SZK8896AhhmqLEMeZR1q2z+HbAWsTIuGOsR83yAKIRDKrMmbtDIbReppnxzEKq8Ojh
         kauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Mwdillh1TNW10mWzPVCrqTZGEvKdbRUq2mwaNx6PZ5c=;
        b=UKuhAwOUFCObaQ/pBU+UwO8ddwhk1fFjb0P9F4AXJROIDEpwIqk/A6KflXamd/NlWz
         f2BIJkRjnZK6cE9So06LXzsjpJzrJ3R2FuJkperYc9jCXDYQ56prnSydAD5mHtJj6hv1
         VhwqiFXAoB1KfS3+OdqOOV6QfcgaZ3OSBLeKvEWJfy1i4gaOFkW3WiMiSPE/R5NrlH0J
         EmgYCwEsu5izgSlbBajCtFDEqhgM7l6tCNen9dt0Yh3QUFDFKOz+LjVtyOAroyAhnCLo
         jvFAwvsh0HhMrUY4kYG8//iPjaGyTz+xAGTaoKH6f5/prG0t2YDaUkgXE9kZ4rZmEAah
         tnmg==
X-Gm-Message-State: AJcUukfG4I10R9XKsxLoF+FIo/4EzF4SaDZYjH7o1W82rJvzJYHUsP+X
        KsVw4XAEErvOgxUNADDKNak=
X-Google-Smtp-Source: ALg8bN4Rx8A0U5u+JCi0WPm/MS3j47qeI6SAHl/x4+sHrVXzMbKQ+ekgQbmWY98+cBYhTGGPL2jAxA==
X-Received: by 2002:a37:ef07:: with SMTP id j7mr8515610qkk.35.1547677594366;
        Wed, 16 Jan 2019 14:26:34 -0800 (PST)
Received: from [192.168.10.187] ([192.222.243.37])
        by smtp.gmail.com with ESMTPSA id p14sm24590352qkl.18.2019.01.16.14.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 14:26:33 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
 <20190112094226.GA910@himanshu-Vostro-3559>
 <2522efda-2762-01a6-7597-38c086779b74@gmail.com>
 <20190115184117.GA10186@himanshu-Vostro-3559>
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Message-ID: <34cd2fc4-3ce3-7ada-de7b-2954c905dc21@gmail.com>
Date:   Wed, 16 Jan 2019 17:31:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115184117.GA10186@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr-classic
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Himanshu,

On 1/15/19 1:41 PM, Himanshu Jha wrote:
> ...
> himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
> scripts/kconfig/conf  --syncconfig Kconfig
> make[1]: Nothing to be done for 'all'.
>     HOSTCC  scripts/dtc/dtc.o
>     HOSTCC  scripts/dtc/flattree.o
>     HOSTCC  scripts/dtc/fstree.o
>     HOSTCC  scripts/dtc/data.o
>     HOSTCC  scripts/dtc/livetree.o
>     HOSTCC  scripts/dtc/treesource.o
>     HOSTCC  scripts/dtc/srcpos.o
>     HOSTCC  scripts/dtc/checks.o
>     HOSTCC  scripts/dtc/util.o
>     LEX     scripts/dtc/dtc-lexer.lex.c
>     YACC    scripts/dtc/dtc-parser.tab.h
>     HOSTCC  scripts/dtc/dtc-lexer.lex.o
>     YACC    scripts/dtc/dtc-parser.tab.c
>     HOSTCC  scripts/dtc/dtc-parser.tab.o
>     HOSTLD  scripts/dtc/dtc
>     CC      scripts/mod/empty.o
>     MKELF   scripts/mod/elfconfig.h
>     HOSTCC  scripts/mod/modpost.o
>     CC      scripts/mod/devicetable-offsets.s
>     HOSTCC  scripts/mod/file2alias.o
>     HOSTCC  scripts/mod/sumversion.o
>     HOSTLD  scripts/mod/modpost
>     CC      kernel/bounds.s
>     CC      arch/x86/kernel/asm-offsets.s
>     CALL    scripts/checksyscalls.sh
>     DESCEND  objtool
>     CC      drivers/iio/chemical/bme680_spi.o
>
> Compiles without any issues.
>> Hum, weird it compiles actually :s
> I think this behavior is observed due to:
>
> include/linux/module.h +212
>
> #ifdef MODULE
>   /* Creates an alias so file2alias.c can find device table. */
>   #define MODULE_DEVICE_TABLE(type, name)                                 \
>   extern typeof(name) __mod_##type##__##name##_device_table               \
>     __attribute__ ((unused, alias(__stringify(name))))
>   #else  /* !MODULE */
>   #define MODULE_DEVICE_TABLE(type, name)
>   #endif
>
> So, when we build the driver as a module[M] then macro expansion
> takes place giving us the compiler warning.
>
> OTOH, if the driver is built as builtin[*] then marco expands
> to nothing or simply goes away. And `;' completes the struct
> declaration while silencing the warning.
>
>   static const struct of_device_id bme680_of_spi_match[] = {
>           { .compatible = "bosch,bme680", },
>           {},
>   }
>   MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
>
> converts to:
>
>   static const struct of_device_id bme680_of_spi_match[] = {
>           { .compatible = "bosch,bme680", },
>           {},
>   }
> 					     ;
> 					    ^^^	
>
> Amazing!
> Correct me if I'm wrong somewhere, took me 2 hours to figure
> that out :D

Ahah, nice!

Thanks a lot for the explanation!

> Also, I some additional interesting observations:
>
> When buitin[*] ->  no symbol tables in the RO segment of object file
>
> himanshu@himanshu-Vostro-3559:~/linux-next$ nm drivers/iio/chemical/bme680_spi.o
> 0000000000000000 d __addressable_bme680_spi_driver_init130
> 00000000000001a0 r bme680_acpi_match
>                   U bme680_core_probe
> 0000000000000000 r bme680_of_spi_match
> 00000000000000a0 d bme680_regmap_bus
>                   U bme680_regmap_config
> 0000000000000000 t bme680_regmap_spi_read
> 0000000000000010 t bme680_regmap_spi_write
> 0000000000000000 d bme680_spi_driver
> 0000000000000000 t bme680_spi_driver_exit
> 0000000000000000 t bme680_spi_driver_init
> 00000000000001e0 r bme680_spi_id
> 0000000000000070 t bme680_spi_probe
>                   U _dev_err
>                   U __devm_regmap_init
>                   U driver_unregister
> 0000000000000000 d __exitcall_bme680_spi_driver_exit
> 0000000000000000 t __initcall_bme680_spi_driver_init6
>                   U regmap_read
>                   U regmap_update_bits_base
>                   U regmap_write
>                   U spi_get_device_id
>                   U __spi_register_driver
>                   U spi_setup
>                   U spi_write_then_read
>                   U __stack_chk_fail
>
>
> While when [M] -> we can see the symbol tables in the RO segment
>
> himanshu@himanshu-Vostro-3559:~/linux-next$ nm drivers/iio/chemical/bme680_spi.o
> 00000000000001a0 r bme680_acpi_match
>                   U bme680_core_probe
> 0000000000000000 r bme680_of_spi_match
> 00000000000000a0 d bme680_regmap_bus
>                   U bme680_regmap_config
> 0000000000000000 t bme680_regmap_spi_read
> 0000000000000010 t bme680_regmap_spi_write
> 0000000000000000 d bme680_spi_driver
> 0000000000000000 t bme680_spi_driver_exit
> 0000000000000000 t bme680_spi_driver_init
> 00000000000001e0 r bme680_spi_id
> 0000000000000070 t bme680_spi_probe
> 0000000000000000 T cleanup_module
>                   U _dev_err
>                   U __devm_regmap_init
>                   U driver_unregister
> 0000000000000000 T init_module
> 00000000000001a0 R __mod_acpi__bme680_acpi_match_device_table   <---
> 0000000000000000 R __mod_of__bme680_of_spi_match_device_table   <---
> 00000000000001e0 R __mod_spi__bme680_spi_id_device_table        <---
>                   U regmap_read
>                   U regmap_update_bits_base
>                   U regmap_write
>                   U spi_get_device_id
>                   U __spi_register_driver
>                   U spi_setup
>                   U spi_write_then_read
>                   U __stack_chk_fail
>                   U __this_module
> 0000000000000033 r __UNIQUE_ID_author38
> 000000000000000f r __UNIQUE_ID_description39
> 0000000000000000 r __UNIQUE_ID_license40
>
>
> Thanks!
Thanks to you :)
