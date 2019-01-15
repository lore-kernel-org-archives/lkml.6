Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CD2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC9320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iODOvuAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbfAOSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:41:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43699 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfAOSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:41:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so1707672pfk.10;
        Tue, 15 Jan 2019 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1gNo1y+dIxdHxK499SDgABwOKeUfhKYaZKkqSCe+rf4=;
        b=iODOvuAu3JkhXkG6MXxTyFvyVHwfFVnHU2l70XnVe7pBdNhWkLeFtQIwqNmPkqSPeX
         0q9LtUlF1oUFIB9KykYBP4AycK2D5Q0+O03MkfpJ8+vnWhv9D/bXgJllM9nbh6EhfRzT
         tAbdnhlkbwfSNDP3Yt9i6OJwdUicuUM6eLoJ/TzU0eLIOtgr3fv5escB8850S1adnFHQ
         Dxx2hRpNzh7rrW3/y3WTLlxw9PH8TS/lT6dTU+ugdWBAkN+pvt/C4Fc2uoN5MdbsLH58
         vSUugz2yuYHyvnfOXIkRxV/RXbj/8taGld/7aUVHFnSFBOC6sjJEEZGbj9vvZY84Gi4K
         zSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1gNo1y+dIxdHxK499SDgABwOKeUfhKYaZKkqSCe+rf4=;
        b=Rrhi2KFaHPsMyK2frjMPbytI0QX3phK6AETU2c4yLchmpwJhTcNnbTm0JeAjOe/Vz6
         2bm9/XL1Y/guJWuQhDAlYTqWBgUh1PDqvh1o5XfkszupsukfXj6pfGKIlb1OS2+5yGGD
         pigY0lSlbvaX2gqSgoDC7vcviVlrsLcsfDjfTBr1BwaMF2fWaZAYIoE50IRrk0yTR/Lc
         XysPAhn6R6fh4ravnK3anZreBz3O6+XBkPTT0IC3ZTlDn+bkER4d8D3bcnKGzEtV0RoO
         V6vAya154uxhMDLR2BkamdJb1bT5rPzhHtZ9/CVLZGkun9Yl8XPb4/kxR1kteoSOsZKH
         WP8g==
X-Gm-Message-State: AJcUukdoaPPFXTWcDLVfD7Fls8FlLHLC0BLi0HZdFJVVVuPpCmzIRZ1j
        muTb56CcgrXP1V53TIpyEicC5j5e
X-Google-Smtp-Source: ALg8bN6AqONSSSKg1Z9wV0aTMghGW72YRnCBZzQd1Z/d1EjHYb6YCmlnCffPMXmOlJVBxAZdVVQGUw==
X-Received: by 2002:a65:4ccb:: with SMTP id n11mr5061245pgt.257.1547577685189;
        Tue, 15 Jan 2019 10:41:25 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id l5sm3909299pgp.82.2019.01.15.10.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:41:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 00:11:17 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     sebastien bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
Message-ID: <20190115184117.GA10186@himanshu-Vostro-3559>
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
 <20190112094226.GA910@himanshu-Vostro-3559>
 <2522efda-2762-01a6-7597-38c086779b74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2522efda-2762-01a6-7597-38c086779b74@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastien,

On Mon, Jan 14, 2019 at 03:00:41PM -0500, sebastien bourdelin wrote:
> Hi,
> 
> On 1/12/19 4:42 AM, Himanshu Jha wrote:
> > On Fri, Jan 11, 2019 at 03:53:58PM -0500, Sebastien Bourdelin wrote:
> > > This commit allow the driver to work with device-tree.
> > > 
> > > Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> > > ---
> > I get the following compilation failure:
> > 
> > Below I have `allyesconfig` except 'BME680' configure as [M]
> > in case you wish to reproduce.
> > 
> > himanshu@himanshu-Vostro-3559:~/linux-next$ grep -i -w 'CONFIG_BME680\|CONFIG_ACPI\|CONFIG_OF' .config
> > CONFIG_ACPI=y
> > CONFIG_OF=y
> > CONFIG_BME680=m
> > himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
> > make[1]: Nothing to be done for 'all'.
> >    CALL    scripts/checksyscalls.sh
> >    DESCEND  objtool
> >    CC [M]  drivers/iio/chemical/bme680_spi.o
> > In file included from ./include/linux/acpi.h:41:0,
> >                   from drivers/iio/chemical/bme680_spi.c:7:
> > ./include/linux/module.h:213:1: error: expected ‘,’ or ‘;’ before ‘extern’
> >   extern typeof(name) __mod_##type##__##name##_device_table  \
> >   ^
> > drivers/iio/chemical/bme680_spi.c:119:1: note: in expansion of macro ‘MODULE_DEVICE_TABLE’
> >   MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
> >   ^~~~~~~~~~~~~~~~~~~
> > scripts/Makefile.build:291: recipe for target 'drivers/iio/chemical/bme680_spi.o' failed
> > make[1]: *** [drivers/iio/chemical/bme680_spi.o] Error 1
> > Makefile:1741: recipe for target 'drivers/iio/chemical/bme680_spi.o' failed
> > make: *** [drivers/iio/chemical/bme680_spi.o] Error 2
> Thanks for the test, this is bad, i will fix that!
> > BUT if:
> > 
> > himanshu@himanshu-Vostro-3559:~/linux-next$ make allyesconfig
> > scripts/kconfig/conf  --allyesconfig Kconfig
> > #
> > # configuration written to .config
> > #
> > 
> > himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
> > scripts/kconfig/conf  --syncconfig Kconfig
> > make[1]: Nothing to be done for 'all'.
> >    HOSTCC  scripts/dtc/dtc.o
> >    HOSTCC  scripts/dtc/flattree.o
> >    HOSTCC  scripts/dtc/fstree.o
> >    HOSTCC  scripts/dtc/data.o
> >    HOSTCC  scripts/dtc/livetree.o
> >    HOSTCC  scripts/dtc/treesource.o
> >    HOSTCC  scripts/dtc/srcpos.o
> >    HOSTCC  scripts/dtc/checks.o
> >    HOSTCC  scripts/dtc/util.o
> >    LEX     scripts/dtc/dtc-lexer.lex.c
> >    YACC    scripts/dtc/dtc-parser.tab.h
> >    HOSTCC  scripts/dtc/dtc-lexer.lex.o
> >    YACC    scripts/dtc/dtc-parser.tab.c
> >    HOSTCC  scripts/dtc/dtc-parser.tab.o
> >    HOSTLD  scripts/dtc/dtc
> >    CC      scripts/mod/empty.o
> >    MKELF   scripts/mod/elfconfig.h
> >    HOSTCC  scripts/mod/modpost.o
> >    CC      scripts/mod/devicetable-offsets.s
> >    HOSTCC  scripts/mod/file2alias.o
> >    HOSTCC  scripts/mod/sumversion.o
> >    HOSTLD  scripts/mod/modpost
> >    CC      kernel/bounds.s
> >    CC      arch/x86/kernel/asm-offsets.s
> >    CALL    scripts/checksyscalls.sh
> >    DESCEND  objtool
> >    CC      drivers/iio/chemical/bme680_spi.o
> > 
> > Compiles without any issues.
> Hum, weird it compiles actually :s

I think this behavior is observed due to:

include/linux/module.h +212

#ifdef MODULE
 /* Creates an alias so file2alias.c can find device table. */
 #define MODULE_DEVICE_TABLE(type, name)                                 \
 extern typeof(name) __mod_##type##__##name##_device_table               \
   __attribute__ ((unused, alias(__stringify(name))))
 #else  /* !MODULE */
 #define MODULE_DEVICE_TABLE(type, name)
 #endif

So, when we build the driver as a module[M] then macro expansion
takes place giving us the compiler warning.

OTOH, if the driver is built as builtin[*] then marco expands
to nothing or simply goes away. And `;' completes the struct
declaration while silencing the warning.

 static const struct of_device_id bme680_of_spi_match[] = {
         { .compatible = "bosch,bme680", },
         {},
 }
 MODULE_DEVICE_TABLE(of, bme680_of_spi_match);

converts to:

 static const struct of_device_id bme680_of_spi_match[] = {
         { .compatible = "bosch,bme680", },
         {},
 }
					     ;
					    ^^^	

Amazing!
Correct me if I'm wrong somewhere, took me 2 hours to figure
that out :D

Also, I some additional interesting observations:

When buitin[*] ->  no symbol tables in the RO segment of object file

himanshu@himanshu-Vostro-3559:~/linux-next$ nm drivers/iio/chemical/bme680_spi.o
0000000000000000 d __addressable_bme680_spi_driver_init130
00000000000001a0 r bme680_acpi_match
                 U bme680_core_probe
0000000000000000 r bme680_of_spi_match
00000000000000a0 d bme680_regmap_bus
                 U bme680_regmap_config
0000000000000000 t bme680_regmap_spi_read
0000000000000010 t bme680_regmap_spi_write
0000000000000000 d bme680_spi_driver
0000000000000000 t bme680_spi_driver_exit
0000000000000000 t bme680_spi_driver_init
00000000000001e0 r bme680_spi_id
0000000000000070 t bme680_spi_probe
                 U _dev_err
                 U __devm_regmap_init
                 U driver_unregister
0000000000000000 d __exitcall_bme680_spi_driver_exit
0000000000000000 t __initcall_bme680_spi_driver_init6
                 U regmap_read
                 U regmap_update_bits_base
                 U regmap_write
                 U spi_get_device_id
                 U __spi_register_driver
                 U spi_setup
                 U spi_write_then_read
                 U __stack_chk_fail


While when [M] -> we can see the symbol tables in the RO segment

himanshu@himanshu-Vostro-3559:~/linux-next$ nm drivers/iio/chemical/bme680_spi.o
00000000000001a0 r bme680_acpi_match
                 U bme680_core_probe
0000000000000000 r bme680_of_spi_match
00000000000000a0 d bme680_regmap_bus
                 U bme680_regmap_config
0000000000000000 t bme680_regmap_spi_read
0000000000000010 t bme680_regmap_spi_write
0000000000000000 d bme680_spi_driver
0000000000000000 t bme680_spi_driver_exit
0000000000000000 t bme680_spi_driver_init
00000000000001e0 r bme680_spi_id
0000000000000070 t bme680_spi_probe
0000000000000000 T cleanup_module
                 U _dev_err
                 U __devm_regmap_init
                 U driver_unregister
0000000000000000 T init_module
00000000000001a0 R __mod_acpi__bme680_acpi_match_device_table   <---
0000000000000000 R __mod_of__bme680_of_spi_match_device_table   <---
00000000000001e0 R __mod_spi__bme680_spi_id_device_table        <---
                 U regmap_read
                 U regmap_update_bits_base
                 U regmap_write
                 U spi_get_device_id
                 U __spi_register_driver
                 U spi_setup
                 U spi_write_then_read
                 U __stack_chk_fail
                 U __this_module
0000000000000033 r __UNIQUE_ID_author38
000000000000000f r __UNIQUE_ID_description39
0000000000000000 r __UNIQUE_ID_license40


Thanks!
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
