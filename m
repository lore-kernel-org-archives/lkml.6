Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056AC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE2E2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVj6E578"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfALJmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 04:42:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39027 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 04:42:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so7366916pgl.6;
        Sat, 12 Jan 2019 01:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X1nWV4nBzlRo77/xlbjpztD7qUJA/hTJMXekGf8rO3M=;
        b=fVj6E578g6OPv+K0qvR9DJatp+zMDOtYwl9amt3nykdmlugNae95tpFO4y5yW/vPHL
         6IOZtC7hZy+UuFRXB7ubaRiGIeU05yfdql1Wfp6aL2WEtsT5s9wkMp7W2BYp8k17bb9v
         g3uN95VAAlohZ1QXRUYHaKZb0JTlU5MNotjSC9H7HR8ezIp0351SvHOfM7XtdeycdLzQ
         /Rrv9nRPormG5Vp5lr86XxfX/pYUPRjLCZUJqEPTYPeU0vJmAm8oT1QVzEYtDfFhtQUf
         9NbPLlF4ZqrxRmk0We2NB9cqcxkWu70gNO5fdHjrL7K1jcn7JI82fX9jSrigQHb404Ev
         /azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X1nWV4nBzlRo77/xlbjpztD7qUJA/hTJMXekGf8rO3M=;
        b=MBrLB4aDwLX7BTewAOD8btio0R3WuhCPbyna0sJ4u196tqmkP7sHl9U0KhX0gt1bl1
         L9sFaSIfCyJ1V9ejY9yqXJjak8vddJ0H7qRpbbdRBOHNDQlf8L3RWLJ/BHiCTYTGBwSL
         9FvLjOHd7AVhlen5kYER9yi3w5V7JZIDSMKArE0OUo6l0Xe7YAG+j9ZfGT1mSSwzcyYt
         VpfLEQGMeoBCV52QiyNsmd3wIW0BU59HN9UZ9j2gP42p2SadpkHKBucWU6Go/mjWrxov
         lQotg5pSSzF31quAe49+9AQOFgtAubMK7z2NVtF48L0DMENstIwiUXwyBBro62X3HwuZ
         yYSg==
X-Gm-Message-State: AJcUuked0rTpNSFwIUdrGMoAIrp+Z56NE5Zp6uZs3ZdgyvNelJ+anPpH
        VjXT9H1L0b353W5OXIFh7ew=
X-Google-Smtp-Source: ALg8bN6M+NminiLHRX1zNCXF1QAstOt5vuyLyP9SL47/MMORZ2/k+Oex+6VXbp7cCJHPxVdQQMTnVA==
X-Received: by 2002:a63:f615:: with SMTP id m21mr16682707pgh.428.1547286155648;
        Sat, 12 Jan 2019 01:42:35 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id m67sm112806550pfm.73.2019.01.12.01.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 01:42:34 -0800 (PST)
Date:   Sat, 12 Jan 2019 15:12:26 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
Message-ID: <20190112094226.GA910@himanshu-Vostro-3559>
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:53:58PM -0500, Sebastien Bourdelin wrote:
> This commit allow the driver to work with device-tree.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> ---

I get the following compilation failure:

Below I have `allyesconfig` except 'BME680' configure as [M]
in case you wish to reproduce.

himanshu@himanshu-Vostro-3559:~/linux-next$ grep -i -w 'CONFIG_BME680\|CONFIG_ACPI\|CONFIG_OF' .config
CONFIG_ACPI=y
CONFIG_OF=y
CONFIG_BME680=m
himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
make[1]: Nothing to be done for 'all'.
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC [M]  drivers/iio/chemical/bme680_spi.o
In file included from ./include/linux/acpi.h:41:0,
                 from drivers/iio/chemical/bme680_spi.c:7:
./include/linux/module.h:213:1: error: expected ‘,’ or ‘;’ before ‘extern’
 extern typeof(name) __mod_##type##__##name##_device_table  \
 ^
drivers/iio/chemical/bme680_spi.c:119:1: note: in expansion of macro ‘MODULE_DEVICE_TABLE’
 MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
 ^~~~~~~~~~~~~~~~~~~
scripts/Makefile.build:291: recipe for target 'drivers/iio/chemical/bme680_spi.o' failed
make[1]: *** [drivers/iio/chemical/bme680_spi.o] Error 1
Makefile:1741: recipe for target 'drivers/iio/chemical/bme680_spi.o' failed
make: *** [drivers/iio/chemical/bme680_spi.o] Error 2

BUT if:

himanshu@himanshu-Vostro-3559:~/linux-next$ make allyesconfig
scripts/kconfig/conf  --allyesconfig Kconfig
#
# configuration written to .config
#

himanshu@himanshu-Vostro-3559:~/linux-next$ sudo make drivers/iio/chemical/bme680_spi.o
scripts/kconfig/conf  --syncconfig Kconfig
make[1]: Nothing to be done for 'all'.
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/dtc
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CC      arch/x86/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      drivers/iio/chemical/bme680_spi.o

Compiles without any issues. 

Also, wondering when is 0x77 i2c address used, since I tested
this on 3 different boards with 0x76(when SDO is connected to GND)

And why do I connect SDO to ground everytime ?
It is because if SDO pin is left floating then I2C address will be
undefined as said in datasheet + I have observed this while testing.

Actallly, I don't understand what "VDIDO" is, as explained in the
datasheet.


Anyway, if the above compilation issue is not a problem, then

	Acked-by: Himanshu Jha <himanshujha199640@gmail.com>


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
