Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD666C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8040920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544650267;
	bh=IzU4C7hwtpB79X018bRlj3tYM3RkoY8fk0y73qP7/yY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2F8ql4JXqpx/dbiTfqarh7TbO40eixM8wau/W7iGjvLR1dsLuAcknd/lqjVEhHDkD
	 Xe8pUKuHRRqgbTmVhVCtttE49xsDqBq3mD2x8+jnMNvESnr421vTxtSaxrsmXG7f6Q
	 MLXC1rNihpzA/Q8lWZYYl4wUTPigOHFXZRsCcuDQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8040920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeLLVbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLVbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:31:05 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128A12084E;
        Wed, 12 Dec 2018 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544650265;
        bh=IzU4C7hwtpB79X018bRlj3tYM3RkoY8fk0y73qP7/yY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JqDN1+/K0mkV2TGYjs/y1DiEJS6hj+E5hmR8gjCOVT5i2aJf70msmwOK/GzuxGAhW
         z3RfVLoAHi8/8BHpGCDOoEPMs8ZI5vP2YwXiq8mhtuEq1iGlWaKJv3rM37rJxyfeIL
         F6FmyJXSbBoIf7Cy/qg0g0HrVT15v//02Jbdbg8s=
Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
 <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
 <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C556C0D@ORSMSX122.amr.corp.intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <1cf7a2ce-0e1b-c329-a891-0cc9ae030f1b@kernel.org>
Date:   Wed, 12 Dec 2018 16:31:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C556C0D@ORSMSX122.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 4:16 PM, Schmauss, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rafael@kernel.org]
>> Sent: Wednesday, December 12, 2018 1:07 PM
>> To: okaya@kernel.org; Schmauss, Erik <erik.schmauss@intel.com>
>> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Moore, Robert
>> <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
>> Len Brown <lenb@kernel.org>; devel@acpica.org; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
>> CONFIG_PCI is unset
>>
>> On Wed, Dec 12, 2018 at 8:34 PM Sinan Kaya <okaya@kernel.org> wrote:
>>>
>>> On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
>>>>> ++ b/drivers/acpi/acpica/achware.h
>>>>> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
>>>>> acpi_gpe_xrupt_info *gpe_xrupt_info,
>>>> CONFIG_PCI is a Linux-ism. We should stay with the OS-independent
>>>> nature of ACPICA. Please use ACPI_PCI_CONFIGURED and put it above
>> the comment like so:
>>>>
>>>> #ifdef ACPI_PCI_CONFIGURED
>>>
>>> Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned
>> nothing.
>>>
>>> git grep ACPI_PCI_CONFIGURED
>>>
>>> @Rafael,
>>>
>>> How do you want to handle this?
>>
>> I think what Eric suggested is effectively to introduce a new ACPICA symbol.
>> Erik?
> 
> Yes, that's correct and you can add something like
> 
> #ifdef CONFIG_PCI
> #define ACPI_PCI_CONFIGURED
> #endif
> 
> in include/linux/platform/aclinux.h to enable it.
> 

OK. Let me rework this and test.
