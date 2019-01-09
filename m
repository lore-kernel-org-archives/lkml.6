Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774E2146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfAIClD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:41:03 -0500
Received: from [223.203.96.18] ([223.203.96.18]:26737 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbfAIClD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:41:03 -0500
X-Greylist: delayed 767 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 21:40:58 EST
X-ASG-Debug-ID: 1547000888-107606139f166630001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id FDmrA4wCbZPDmTB3 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 09 Jan 2019 10:28:08 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 10:28:01 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 9 Jan 2019 10:28:01 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
Thread-Topic: [PATCH v2] ACPI / tables: table override from built-in initrd
X-ASG-Orig-Subj: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
Thread-Index: AQHUlpcx3RZcoqMsIkiCDzlptVMvNQ==
Date:   Wed, 9 Jan 2019 02:28:00 +0000
Message-ID: <dc56c63fba6c410b9fd35a4ebe11ce07@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1545112965-2692-1-git-send-email-shunyong.yang@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1547000888
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 3721
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4999 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65356
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,

Gentle ping for this patch.

Thanks.
Shunyong.

On 2018/12/18 14:02, Yang, Shunyong wrote:
> In some scenario, we need to build initrd with kernel in a single image.
> This can simplify system deployment process by downloading the whole system
> once, such as in IC verification.
> 
> This patch adds support to override ACPI tables from built-in initrd.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
> v2: change "upgrade" to "override" as it's more accurate
> ---
>  Documentation/acpi/initrd_table_override.txt |  4 ++++
>  drivers/acpi/Kconfig                         | 10 ++++++++++
>  drivers/acpi/tables.c                        | 12 ++++++++++--
>  include/linux/initrd.h                       |  3 +++
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
> index eb651a6aa285..324d5fb90a22 100644
> --- a/Documentation/acpi/initrd_table_override.txt
> +++ b/Documentation/acpi/initrd_table_override.txt
> @@ -14,6 +14,10 @@ upgrade the ACPI execution environment that is defined by the ACPI tables
>  via upgrading the ACPI tables provided by the BIOS with an instrumented,
>  modified, more recent version one, or installing brand new ACPI tables.
>  
> +When building initrd with kernel in a single image, option
> +ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
> +purpose.
> +
>  For a full list of ACPI tables that can be upgraded/installed, take a look
>  at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
>  drivers/acpi/tables.c.
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7cea769c37df..3b362a1c7685 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -357,6 +357,16 @@ config ACPI_TABLE_UPGRADE
>  	  initrd, therefore it's safe to say Y.
>  	  See Documentation/acpi/initrd_table_override.txt for details
>  
> +config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
> +	bool "Override ACPI tables from built-in initrd"
> +	depends on ACPI_TABLE_UPGRADE
> +	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
> +	def_bool n
> +	help
> +	  This option provides functionality to override arbitrary ACPI tables
> +	  from built-in uncompressed initrd.
> +	  See Documentation/acpi/initrd_table_override.txt for details
> +
>  config ACPI_DEBUG
>  	bool "Debug Statements"
>  	help
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 61203eebf3a1..f6a2c5ebabcd 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>  
>  void __init acpi_table_upgrade(void)
>  {
> -	void *data = (void *)initrd_start;
> -	size_t size = initrd_end - initrd_start;
> +	void *data;
> +	size_t size;
>  	int sig, no, table_nr = 0, total_offset = 0;
>  	long offset = 0;
>  	struct acpi_table_header *table;
>  	char cpio_path[32] = "kernel/firmware/acpi/";
>  	struct cpio_data file;
>  
> +	if (IS_ENABLED(CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD)) {
> +		data = __initramfs_start;
> +		size = __initramfs_size;
> +	} else {
> +		data = (void *)initrd_start;
> +		size = initrd_end - initrd_start;
> +	}
> +
>  	if (data == NULL || size == 0)
>  		return;
>  
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index 84b423044088..02d94aae54c7 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -22,3 +22,6 @@
>  extern void free_initrd_mem(unsigned long, unsigned long);
>  
>  extern unsigned int real_root_dev;
> +
> +extern char __initramfs_start[];
> +extern unsigned long __initramfs_size;
> 

