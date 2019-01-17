Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790FDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B5A20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547743179;
	bh=HQwui1c11xreuPEX90Odi0MFNAxdNyiD9LfPIoSrSOI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=khQuaTecgF0HkjpB7d5ga45XytWoxN7aAvs+mAVfYSoQKb/El5d6WS1tt8Pks8dbB
	 V7Aigbj4PL1dCgQzrmka7gIrs2c4RuxSgxAlJ/7H+itJ420y6TB5eRdrrKtcth/IWC
	 m93nGedfG6XyenEM4F6jd2VOxAQJy3mlPLZumHaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfAQQjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfAQQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:39:37 -0500
Received: from [10.84.151.4] (unknown [167.220.149.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F6620851;
        Thu, 17 Jan 2019 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547743176;
        bh=HQwui1c11xreuPEX90Odi0MFNAxdNyiD9LfPIoSrSOI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I3uWbGzG1GMIqXl9ikmmnaUwa2yJsBik9gwQ3CgQH7PHwoKzV4B41TMcgwVuAll5l
         9CF2h90t/nke6nnvkp0bGJ3cA67QF//vtq186m0bSdXqqYHtNILfH/V8PCYLDhX4/U
         t2dDU59XNc8xJPh+XsVwbdQuUrl0+1koC14UgyuQ=
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
To:     Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <3ef1915c-f3c0-84ea-d35e-c26a16e8f818@kernel.org>
Date:   Thu, 17 Jan 2019 11:39:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117163722.GE5023@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 11:37 AM, Borislav Petkov wrote:
> On Thu, Jan 17, 2019 at 04:17:22PM +0000, Sinan Kaya wrote:
>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>> specified directly.
>>
>> PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
>> mentioned in the Kconfig.
>>
>> Add an explicit dependency here.
>>
>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   arch/x86/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 568f339595ed..0519da6f8ee4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -199,7 +199,7 @@ config X86
>>   	select IRQ_FORCED_THREADING
>>   	select NEED_SG_DMA_LENGTH
>>   	select PCI_DOMAINS			if PCI
>> -	select PCI_LOCKLESS_CONFIG
>> +	select PCI_LOCKLESS_CONFIG		if PCI
>>   	select PERF_EVENTS
>>   	select RTC_LIB
>>   	select RTC_MC146818_LIB
>> -- 
> 
> Are there any more arch/x86/ fixes for the 5d32a66541c4 fallout floating
> around?
> 
> If so, pls merge them all together into a single patch so that we're
> done with this once and for all.
> 
> Also, I see a lot of build failures when doing randconfig builds for the
> stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?
> 
> If not, I'd take 'em too in a single patch, if Darren and Andy are fine
> with it.

I'm only looking at PCI and ACPI related changes to be honest. The rest is
out of my expertise area.

I started a run of 1000 randconfig runs in the meantime. I'll collect the
results soon and follow up if there is something I can help.

> 
> Thx.
> 

