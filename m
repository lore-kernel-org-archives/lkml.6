Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37396C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E306026081
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E306026081
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935080AbeFYTo1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:44:27 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43900 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934970AbeFYToZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:44:25 -0400
Received: by mail-ot0-f193.google.com with SMTP id i19-v6so16384443otk.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wR7Pg419wz8ma2AE6NIuyPqgHf9RdSw1q+f3YPr6bOs=;
        b=SbVoOWJFAnfcTpQ9X6hOCI9JggAPfs0WHWlmXZteSfHhdXTe2nR+NhMiVBre7f9I+i
         IDA3ixvR07HOmMfqg6TXDd1LKVK8zdSG+7DDnMNZSkWhl+bL21rmeXkCMoYHLecDdsKH
         rKvKTr/7EWvLn3X9w7PA34cAGi1Aj2qo+QKjRCAGuK6qcsyD5xe6so7qnKsmPGvU8ev5
         Z5VTXOvxQQwEvDIOGCghvirnxhqS5XITS0gZqdyVYplDC/nGexTFd/ngv0uuDRDjrTvL
         /cBN+oqgWzbtHsKh7g+6mHO0ypCHkgUVmLeMPE+7ubvL9EogFyKGrxNvClU81y8jfceQ
         Jb2w==
X-Gm-Message-State: APt69E1Bo/mrAXLLmWBtO/OONqJGGgcAUfgn0H8nPcigsje4rVpPAQ71
        lZgjcZ6kC6kFLb2LCGEZYu3kVQ==
X-Google-Smtp-Source: AAOMgpfALbhDbI7dssHUD89EK6AvdYkoxvrATmDwsVZxMt9jV+KoUjSH4UmjyCeI2VSTBubYbhfeXQ==
X-Received: by 2002:a9d:4044:: with SMTP id o4-v6mr7648295oti.283.1529955865355;
        Mon, 25 Jun 2018 12:44:25 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id u13-v6sm7045920oiv.18.2018.06.25.12.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:44:24 -0700 (PDT)
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
To:     Christoph von Recklinghausen <crecklin@redhat.com>,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
 <d110c9af-cb68-5a3c-bc70-0c7650edb0d4@redhat.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <cfd52ae6-6fea-1a5a-b2dd-4dfdd65acd15@redhat.com>
Date:   Mon, 25 Jun 2018 12:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d110c9af-cb68-5a3c-bc70-0c7650edb0d4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:22 AM, Christoph von Recklinghausen wrote:
> Add correct address for linux-mm
> 
> On 06/25/2018 11:08 AM, Chris von Recklinghausen wrote:
>> Enabling HARDENED_USER_COPY causes measurable regressions in the
>> networking performances, up to 8% under UDP flood.
>>
>> A generic distro may want to enable HARDENED_USER_COPY in their default
>> kernel config, but at the same time, such distro may want to be able to
>> avoid the performance penalties in with the default configuration and
>> enable the stricter check on a per-boot basis.
>>
>> This change adds a config variable and a boot parameter to conditionally
>> enable HARDENED_USER_COPY at boot time, and switch HUC to off if
>> HUC_DEFAULT_OFF is set.
>>
>> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
>> ---
>>   .../admin-guide/kernel-parameters.rst         |  2 ++
>>   .../admin-guide/kernel-parameters.txt         |  3 ++
>>   include/linux/thread_info.h                   |  7 +++++
>>   mm/usercopy.c                                 | 28 +++++++++++++++++++
>>   security/Kconfig                              | 10 +++++++
>>   5 files changed, 50 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
>> index b8d0bc07ed0a..c3035038e3ae 100644
>> --- a/Documentation/admin-guide/kernel-parameters.rst
>> +++ b/Documentation/admin-guide/kernel-parameters.rst
>> @@ -100,6 +100,8 @@ parameter is applicable::
>>   	FB	The frame buffer device is enabled.
>>   	FTRACE	Function tracing enabled.
>>   	GCOV	GCOV profiling is enabled.
>> +	HUC	Hardened usercopy is enabled
>> +	HUCF	Hardened usercopy disabled at boot
>>   	HW	Appropriate hardware is enabled.
>>   	IA-64	IA-64 architecture is enabled.
>>   	IMA     Integrity measurement architecture is enabled.
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index efc7aa7a0670..cd3354bc14d3 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -816,6 +816,9 @@
>>   	disable=	[IPV6]
>>   			See Documentation/networking/ipv6.txt.
>>   
>> +	enable_hardened_usercopy [HUC,HUCF]
>> +			Enable hardened usercopy checks
>> +
>>   	disable_radix	[PPC]
>>   			Disable RADIX MMU mode on POWER9
>>   
>> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
>> index 8d8821b3689a..140a36cc1c2c 100644
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -109,12 +109,19 @@ static inline int arch_within_stack_frames(const void * const stack,
>>   #endif
>>   
>>   #ifdef CONFIG_HARDENED_USERCOPY
>> +#include <linux/jump_label.h>
>> +
>> +DECLARE_STATIC_KEY_FALSE(bypass_usercopy_checks);
>> +
>>   extern void __check_object_size(const void *ptr, unsigned long n,
>>   					bool to_user);
>>   
>>   static __always_inline void check_object_size(const void *ptr, unsigned long n,
>>   					      bool to_user)
>>   {
>> +	if (static_branch_likely(&bypass_usercopy_checks))
>> +		return;
>> +
>>   	if (!__builtin_constant_p(n))
>>   		__check_object_size(ptr, n, to_user);
>>   }
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> index e9e9325f7638..ce3996da1b2e 100644
>> --- a/mm/usercopy.c
>> +++ b/mm/usercopy.c
>> @@ -279,3 +279,31 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
>>   	check_kernel_text_object((const unsigned long)ptr, n, to_user);
>>   }
>>   EXPORT_SYMBOL(__check_object_size);
>> +
>> +DEFINE_STATIC_KEY_FALSE(bypass_usercopy_checks);
>> +EXPORT_SYMBOL(bypass_usercopy_checks);
>> +
>> +#ifdef CONFIG_HUC_DEFAULT_OFF
>> +#define HUC_DEFAULT false
>> +#else
>> +#define HUC_DEFAULT true
>> +#endif
>> +
>> +static bool enable_huc_atboot = HUC_DEFAULT;
>> +
>> +static int __init parse_enable_usercopy(char *str)
>> +{
>> +	enable_huc_atboot = true;
>> +	return 1;
>> +}
>> +
>> +static int __init set_enable_usercopy(void)
>> +{
>> +	if (enable_huc_atboot == false)
>> +		static_branch_enable(&bypass_usercopy_checks);
>> +	return 1;
>> +}
>> +
>> +__setup("enable_hardened_usercopy", parse_enable_usercopy);
>> +
>> +late_initcall(set_enable_usercopy);
>> diff --git a/security/Kconfig b/security/Kconfig
>> index c4302067a3ad..a6173897b85c 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -189,6 +189,16 @@ config HARDENED_USERCOPY_PAGESPAN
>>   	  been removed. This config is intended to be used only while
>>   	  trying to find such users.
>>   
>> +config HUC_DEFAULT_OFF
>> +	bool "allow CONFIG_HARDENED_USERCOPY to be configured but disabled"
>> +	depends on HARDENED_USERCOPY
>> +	help
>> +	  When CONFIG_HARDENED_USERCOPY is enabled, disable its
>> +	  functionality unless it is enabled via at boot time
>> +	  via the "enable_hardened_usercopy" boot parameter. This allows
>> +	  the functionality of hardened usercopy to be present but not
>> +	  impact performance unless it is needed.
>> +
>>   config FORTIFY_SOURCE
>>   	bool "Harden common str/mem functions against buffer overflows"
>>   	depends on ARCH_HAS_FORTIFY_SOURCE
> 
> 

This seems a bit backwards, I'd much rather see hardened user copy
default to on with the basic config option and then just have a command
line option to turn it off.

Thanks,
Laura
