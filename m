Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58876C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D3E206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D3E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLCOEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:04:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38004 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeLCOEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:04:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499F61682;
        Mon,  3 Dec 2018 06:03:14 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FA363F614;
        Mon,  3 Dec 2018 06:03:12 -0800 (PST)
Subject: Re: [PATCH v9 3/8] KVM: arm/arm64: Introduce helpers to manipulate
 page table entries
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, punitagrawal@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-4-punit.agrawal@arm.com>
 <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a57e690e-0b93-faf4-9d90-9ba0cc388936@arm.com>
Date:   Mon, 3 Dec 2018 14:03:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 03/12/2018 13:50, Anshuman Khandual wrote:
> 
> 
> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
>> Introduce helpers to abstract architectural handling of the conversion
>> of pfn to page table entries and marking a PMD page table entry as a
>> block entry.
> 
> Why is this necessary ? we would still need to access PMD, PUD as is
> without any conversion. IOW KVM knows the breakdown of the page table
> at various levels. Is this something required from generic KVM code ?

The KVM MMU code is shared for arm32 and arm64. Hence we need arch specific
helpers to hide how we deal with the levels. e.g, PUD never exists for
arm32.

>    
>>
>> The helpers are introduced in preparation for supporting PUD hugepages
>> at stage 2 - which are supported on arm64 but do not exist on arm.
> 
> Some of these patches (including the earlier two) are good on it's
> own. Do we have still mention in commit message about the incoming PUD
> enablement as the reason for these cleanup patches ?
> 

Cheers
Suzuki
