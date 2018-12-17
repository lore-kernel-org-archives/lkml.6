Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09A5217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeLQJSW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:18:22 -0500
Received: from [38.106.11.25] ([38.106.11.25]:39542 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731839AbeLQJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:18:22 -0500
X-ASG-Debug-ID: 1545038297-107606139f09ef0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net (localhost [10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id thCvZeGtrCs26qU5 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 17 Dec 2018 17:18:17 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Dec 2018 17:17:22 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Mon, 17 Dec 2018 17:17:22 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
Thread-Topic: [PATCH] ACPI / tables: table upgrade from built-in initrd
X-ASG-Orig-Subj: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
Thread-Index: AQHUla75pLHf4djd9EmmRCWXKkRMKA==
Date:   Mon, 17 Dec 2018 09:17:21 +0000
Message-ID: <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
References: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <CAJZ5v0gnmnP1UUisS-4L=gzu3KHbbK8y4Wh_4dqfgmm775=ZkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1545038297
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 3238
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4928 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63926
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,
  I think "override" is more accurate. I just follow the existing
description of "ACPI_TABLE_UPGRADE" in drivers/acpi/Kconfig.
  Should I change all upgrade/UPGRADE to "override/OVERRIDE" in this patch?

Thanks.
Shunyong.

On 2018/12/17 17:03, Rafael J. Wysocki wrote:
> On Mon, Dec 17, 2018 at 3:40 AM Shunyong Yang
> <shunyong.yang@hxt-semitech.com> wrote:
>>
>> In some scenario, we need to build initrd with kernel in a single image.
>> This can simplify system deployment process by downloading the whole system
>> once, such as in IC verification.
>>
>> This patch adds support to upgrade ACPI tables from built-in initrd.
> 
> What do you mean by "upgrade"?
> 
>>
>> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
>> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
>> ---
>>  drivers/acpi/Kconfig   |  9 +++++++++
>>  drivers/acpi/tables.c  | 12 ++++++++++--
>>  include/linux/initrd.h |  3 +++
>>  3 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 7cea769c37df..30976496fe77 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -357,6 +357,15 @@ config ACPI_TABLE_UPGRADE
>>           initrd, therefore it's safe to say Y.
>>           See Documentation/acpi/initrd_table_override.txt for details
>>
>> +config ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD
>> +       bool "Upgrade ACPI tables from built-in initrd"
>> +       depends on ACPI_TABLE_UPGRADE
>> +       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
>> +       def_bool n
>> +       help
>> +         This option provides functionality to upgrade arbitrary ACPI tables
>> +         from built-in uncompressed initrd.
>> +
>>  config ACPI_DEBUG
>>         bool "Debug Statements"
>>         help
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 61203eebf3a1..88e3a34443da 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>>
>>  void __init acpi_table_upgrade(void)
>>  {
>> -       void *data = (void *)initrd_start;
>> -       size_t size = initrd_end - initrd_start;
>> +       void *data;
>> +       size_t size;
>>         int sig, no, table_nr = 0, total_offset = 0;
>>         long offset = 0;
>>         struct acpi_table_header *table;
>>         char cpio_path[32] = "kernel/firmware/acpi/";
>>         struct cpio_data file;
>>
>> +       if (IS_ENABLED(CONFIG_ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD)) {
>> +               data = __initramfs_start;
>> +               size = __initramfs_size;
>> +       } else {
>> +               data = (void *)initrd_start;
>> +               size = initrd_end - initrd_start;
>> +       }
>> +
>>         if (data == NULL || size == 0)
>>                 return;
>>
>> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
>> index 84b423044088..02d94aae54c7 100644
>> --- a/include/linux/initrd.h
>> +++ b/include/linux/initrd.h
>> @@ -22,3 +22,6 @@
>>  extern void free_initrd_mem(unsigned long, unsigned long);
>>
>>  extern unsigned int real_root_dev;
>> +
>> +extern char __initramfs_start[];
>> +extern unsigned long __initramfs_size;
>> --
>> 1.8.3.1
>>
> 

