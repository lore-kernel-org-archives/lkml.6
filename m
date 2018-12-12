Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2BBC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30F82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30F82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeLLB5R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:57:17 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:52068 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbeLLB5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:57:17 -0500
X-ASG-Debug-ID: 1544579829-093b7e7c620ed80001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id sAxWFrXJVVLomn2Z (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 12 Dec 2018 09:57:09 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 09:56:16 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 12 Dec 2018 09:56:16 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     "robert.moore@intel.com" <robert.moore@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name
 support
Thread-Topic: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name
 support
X-ASG-Orig-Subj: Re: [PATCH 1/1] ACPI / tables: add DSDT AmlCode new declaration name
 support
Thread-Index: AQHUez4zTADh8jmnV0K3KPJRZ7/oPA==
Date:   Wed, 12 Dec 2018 01:56:15 +0000
Message-ID: <af65cc4b4b404f15b063429215eb7b68@HXTBJIDCEMVIW02.hxtcorp.net>
References: <254f789dee7773b938db7a204ca8800db10e4588.1542105349.git.dongsheng.wang@hxt-semitech.com>
 <f5908f1f727c41dfa90038d27734f67f@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.50.13]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1544579829
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.3756 1.0000 -0.0681
X-Barracuda-Spam-Score: -0.07
X-Barracuda-Spam-Status: No, SCORE=-0.07 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63625
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Any comments about this patch?

Cheers
Dongsheng

On 2018/11/23 16:12, Wang, Dongsheng wrote:
> Hello Robert,
>
> Do you have any comments about this patch?
> Thanks.
>
>
> Cheers
> Dongsheng
>
> On 2018/11/13 18:46, Wang, Dongsheng wrote:
>> The new naming rule is added in acpica version 20180427.
>> So the dsdt aml code name changes from "AmlCode" to "dsdt_aml_code".
>>
>> The patch that introduces naming rules is:
>> https://github.com/acpica/acpica/commit/f9a88a4c1cd020b6a5475d63b29626852a0b5f37
>>
>> Tested:
>> ACPICA release version 20180427+.
>> ARM64: QCOM QDF2400
>> GCC: 4.8.5 20150623
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>>  drivers/acpi/Kconfig  |  2 +-
>>  drivers/acpi/tables.c | 10 ++++++++--
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 9705fc986da9..15ab53a52fdc 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -336,7 +336,7 @@ config ACPI_CUSTOM_DSDT_FILE
>>  	  See Documentation/acpi/dsdt-override.txt
>>  
>>  	  Enter the full path name to the file which includes the AmlCode
>> -	  declaration.
>> +	  or dsdt_aml_code declaration.
>>  
>>  	  If unsure, don't enter a file name.
>>  
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index a3d012b08fc5..297020bbaade 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -713,6 +713,9 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
>>  					  table_length);
>>  }
>>  
>> +static void *amlcode __attribute__ ((weakref("AmlCode")));
>> +static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
>> +
>>  acpi_status
>>  acpi_os_table_override(struct acpi_table_header *existing_table,
>>  		       struct acpi_table_header **new_table)
>> @@ -723,8 +726,11 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
>>  	*new_table = NULL;
>>  
>>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
>> -	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
>> -		*new_table = (struct acpi_table_header *)AmlCode;
>> +	if (!strncmp(existing_table->signature, "DSDT", 4)) {
>> +		*new_table = (struct acpi_table_header *)&amlcode;
>> +		if (!(*new_table))
>> +			*new_table = (struct acpi_table_header *)&dsdt_amlcode;
>> +	}
>>  #endif
>>  	if (*new_table != NULL)
>>  		acpi_table_taint(existing_table);
>
>

