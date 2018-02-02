Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeBBKyY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:54:24 -0500
Received: from mail02.prevas.se ([62.95.78.10]:40532 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeBBKyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:54:16 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GABABjQnRa/4cmS1NdHQEBBQELAYQ3c?=
 =?us-ascii?q?CiDZYsYjxUnmWAKJ4UUAoMOFQEBAQEBAQEBAgNogxNLWQEBAQEBASMCCGMBBSN?=
 =?us-ascii?q?WEAsOCgICJgICVwYBDQWKOQyuLYInhQCDdYF9AQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHYEPg1qFfQyCeYMvBIFPAQEegxcxgjQFpCSIGY1Xgh5nhT6LcUiNIooHgTw?=
 =?us-ascii?q?1JCWBKzOBFiMBgV88CYJMHIIHdwGJcII8AQEB?=
X-IPAS-Result: =?us-ascii?q?A2GABABjQnRa/4cmS1NdHQEBBQELAYQ3cCiDZYsYjxUnmWA?=
 =?us-ascii?q?KJ4UUAoMOFQEBAQEBAQEBAgNogxNLWQEBAQEBASMCCGMBBSNWEAsOCgICJgICV?=
 =?us-ascii?q?wYBDQWKOQyuLYInhQCDdYF9AQEBAQEBAQEBAQEBAQEBAQEBAQEBHYEPg1qFfQy?=
 =?us-ascii?q?CeYMvBIFPAQEegxcxgjQFpCSIGY1Xgh5nhT6LcUiNIooHgTw1JCWBKzOBFiMBg?=
 =?us-ascii?q?V88CYJMHIIHdwGJcII8AQEB?=
X-IronPort-AV: E=Sophos;i="5.46,448,1511823600";
   d="scan'208";a="3000532"
Date: Fri, 02 Feb 2018 11:51:35 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180202080027.36a7f102@endymion>
References: <20180201080805.8076-1-mnhu@prevas.dk> <20180202080027.36a7f102@endymion>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] firmware: dmi_scan: avoid printing error on non-efi systems
To: Jean Delvare <jdelvare@suse.de>,
        =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <mnhu@prevas.dk>
CC: linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin.hundeboll@prevas.dk>
Message-ID: <855AF486-1663-4F20-BEDF-30CA845ADD89@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w12AsSC3028358

Hi,

Yeah, you can add my

Acked-by: Martin Hundebøll <mnhu@prevas.dk>

Thanks,
Martin

On February 2, 2018 8:00:27 AM GMT+01:00, Jean Delvare <jdelvare@suse.de> wrote:
>Hi Martin,
>
>On Thu, 1 Feb 2018 09:08:05 +0100, Martin Hundebøll wrote:
>> dmi_init() rightfully checks if dmi is available at all, and errors
>out
>> if not. This leads to harmless errors being printed during boot on
>> non-efi systems, even when these are booted quietly.
>> 
>> Avoid this error-print by returning directly from dmi_init() if dmi
>> isn't available, instead of jumping to the err-label.
>> 
>> Signed-off-by: Martin Hundebøll <mnhu@prevas.dk>
>> ---
>>  drivers/firmware/dmi_scan.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/firmware/dmi_scan.c
>b/drivers/firmware/dmi_scan.c
>> index 783041964439..86c5e0625a08 100644
>> --- a/drivers/firmware/dmi_scan.c
>> +++ b/drivers/firmware/dmi_scan.c
>> @@ -715,10 +715,8 @@ static int __init dmi_init(void)
>>  	u8 *dmi_table;
>>  	int ret = -ENOMEM;
>>  
>> -	if (!dmi_available) {
>> -		ret = -ENODATA;
>> -		goto err;
>> -	}
>> +	if (!dmi_available)
>> +		return -ENODATA;
>>  
>>  	/*
>>  	 * Set up dmi directory at /sys/firmware/dmi. This entry should
>stay
>
>I already have a similar patch by Ard Biesheuvel in my dmi tree:
>
>http://jdelvare.nerim.net/devel/linux/jdelvare-dmi/firmware-dmi-handle-missing-dmi-data-gracefully.patch
>
>Does it work for you?
>
>I'll send a pull request to Linus later today.
>
>Thanks,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
