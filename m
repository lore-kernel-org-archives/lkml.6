Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8E6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9712081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9712081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeKHGKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:10:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:9319 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKHGKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:10:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 12:38:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="84123342"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2018 12:38:16 -0800
Subject: Re: [PATCHv10 3/8] firmware: add Intel Stratix10 service layer driver
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@intel.com
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-4-git-send-email-richard.gong@linux.intel.com>
 <595b853f-6a8c-d608-e716-95ef1c84d0b9@infradead.org>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <f266e76a-6222-252e-dc79-c13044602a98@linux.intel.com>
Date:   Wed, 7 Nov 2018 14:47:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <595b853f-6a8c-d608-e716-95ef1c84d0b9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 11/6/18 11:03 AM, Randy Dunlap wrote:
> On 11/6/18 8:52 AM, richard.gong@linux.intel.com wrote:
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 7273e50..b6813bc 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -216,6 +216,18 @@ config FW_CFG_SYSFS_CMDLINE
>>   	  WARNING: Using incorrect parameters (base address in particular)
>>   	  may crash your system.
>>   
>> +config INTEL_STRATIX10_SERVICE
>> +       tristate "Intel Stratix10 Service Layer"
>> +       depends on HAVE_ARM_SMCCC
>> +       default n
>> +       help
>> +        Intel Stratix10 service layer runs at privileged exception level,
>> +	interfaces with the service providers (FPGA manager is one of them) and
>> +	manages secure monitor call to communicate with secure monitor software
>> +	at secure monitor exception level.
>> +
>> +        Say Y here if you want Stratix10 service layer support.
> 
> from Documentation/process/coding-style.rst:
> 
> Lines under a ``config`` definition are indented with one tab,
> while help text is indented an additional two spaces.
> 
>

I will correct that in the next submission.

> thanks.
> 

Regards,
Richard
