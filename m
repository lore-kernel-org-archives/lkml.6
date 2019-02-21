Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A30C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3DD2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfBUH5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:57:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51128 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:57:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2339027D486
Subject: Re: [PATCH -next] platform/chrome: Fix Kconfig dependencies for
 wilco_ec
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        sfr@canb.auug.org.au
References: <20190220221128.48476-1-ncrews@chromium.org>
 <420e6e26-6270-e577-6bbc-3ebe884168b5@infradead.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <765ebb17-4523-d915-bdce-9ecde26836f0@collabora.com>
Date:   Thu, 21 Feb 2019 08:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <420e6e26-6270-e577-6bbc-3ebe884168b5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/2/19 0:09, Randy Dunlap wrote:
> On 2/20/19 2:11 PM, Nick Crews wrote:
>> In the initial version of the Wilco EC Driver, the
>> dependency order was wrong. It before was possible to
>> select CONFIG_WILCO_EC and CONFIG_CROS_EC_LPC without
>> having CONFIG_CROS_EC_LPC_MEC. This was wrong, since
>> WILCO_EC depends upon CONFIG CROS_EC_LPC_MEC, not the
>> other way around.
>>
>> Fixes: 1733c32834e5d1 ("platform/chrome: Add new driver for Wilco EC")
>> Signed-off-by: Nick Crews <ncrews@chromium.org>
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 

As this is [-next] material I squashed that commit and queued for 5.1

Thanks,
 Enric


> Thanks.
> 
>> ---
>>  drivers/platform/chrome/Kconfig          | 2 +-
>>  drivers/platform/chrome/wilco_ec/Kconfig | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
>> index 462eb9dfa4f2..b69561050868 100644
>> --- a/drivers/platform/chrome/Kconfig
>> +++ b/drivers/platform/chrome/Kconfig
>> @@ -95,7 +95,7 @@ config CROS_EC_LPC
>>  
>>  config CROS_EC_LPC_MEC
>>  	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
>> -	depends on CROS_EC_LPC || WILCO_EC
>> +	depends on CROS_EC_LPC
>>  	default n
>>  	help
>>  	  If you say Y here, a variant LPC protocol for the Microchip EC
>> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
>> index 20945a301ec6..c6bc4e8f3062 100644
>> --- a/drivers/platform/chrome/wilco_ec/Kconfig
>> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
>> @@ -1,7 +1,6 @@
>>  config WILCO_EC
>>  	tristate "ChromeOS Wilco Embedded Controller"
>> -	depends on ACPI && X86
>> -	select CROS_EC_LPC_MEC
>> +	depends on ACPI && X86 && CROS_EC_LPC_MEC
>>  	help
>>  	  If you say Y here, you get support for talking to the ChromeOS
>>  	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
>>
> 
> 
