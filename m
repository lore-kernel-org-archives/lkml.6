Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54910C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80C20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nssjboNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D80C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbeGXR53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388746AbeGXR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5i/oM0jpesYxOf5RcEVM8UFHMpPLYpGQ23P31QmgjrQ=; b=nssjboNOchbVH669+X7nP3752r
        66PkosbEnXQZAMDUlSqxYLjXbVqdCzvcwoL5g6MezHnIbdxyv/FrxFILF99Np/r8XIKkJjrcxjlRK
        TTKmYn9t43w7cB7u+jEqfdIBaDIHvLggm8dIgDCTg7vbVvrQ0jUggXndb7733pDEkXy75+lPMPJrC
        WbeEHaF3iy4u2Pm91MAqYCVsr6oHIjeaCRmnKRqZJkYDxfMFscm13SFAzNffuBmT8cwKBAoQr6v68
        HvHceK6OgUTU4kxrWv2HKVXmwvi/AGopuYMP5PQJYpGr9w0oneeUsPMJScBBRplDhHAVIFO7xoAlS
        OBn43OAA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi0VX-0002Lz-BW; Tue, 24 Jul 2018 16:49:55 +0000
Subject: Re: [PATCH] arm64: enable RapidIO config options in Kconfig
To:     Will Deacon <will.deacon@arm.com>, Alexei Colin <acolin@isi.edu>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alex Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        John Paul Walters <jwalters@isi.edu>
References: <20180724134513.86796-1-acolin@isi.edu>
 <20180724151458.GE25412@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <71f6f129-4151-1603-10aa-9e600d6389ed@infradead.org>
Date:   Tue, 24 Jul 2018 09:49:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724151458.GE25412@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 08:14 AM, Will Deacon wrote:
> On Tue, Jul 24, 2018 at 09:45:14AM -0400, Alexei Colin wrote:
>> ARM64 SoCs with a PCI bus present the RapiodIO options; SoCs with
>> RapidIO IP blocks but without a PCI bus, need to select HAS_RAPIDIO in
>> Kconfig.platforms.
>>
>> HAS_RAPIDIO was chosen over HAVE_RAPIDIO to be consistent with
>> other architectures which already define this flag (powerpc).
>>
>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>> ---
>>
>> Tested that kernel builds with RapidIO subsystem and switch drivers and that
>> modules insert successfully in a custom Qemu hardware model.
>> Maintainers for RapidIO subsystem CCed.
>> Similar patch for ARM has been submitted.
>>
>>  arch/arm64/Kconfig | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 42c090cf0292..8dceaa5b674c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -293,6 +293,22 @@ config PCI_SYSCALL
>>  
>>  source "drivers/pci/Kconfig"
>>  
>> +config HAS_RAPIDIO
>> +	bool
>> +	default n
>> +
>> +config RAPIDIO
>> +	tristate "RapidIO support"
>> +	depends on HAS_RAPIDIO || PCI
>> +	help
>> +	  This feature enables support for RapidIO high-performance
>> +	  packet-switched interconnect.
>> +
>> +	  If you say Y here, the kernel will include drivers and
>> +	  infrastructure code to support RapidIO interconnect devices.
> 
> It feels a bit weird to push this help text into the arch Kconfig files,
> rather than just have them provide the HAS_RAPIDIO symbol, but if that's
> what everybody else is doing then I guess it's fine.

Both Arnd and Russell King asked for moving CONFIG_RAPIDIO to drivers/rapidio/Kconfig,
and I also think that would be better.

-- 
~Randy
