Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8128AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37238204EE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AsDPSSzS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AsDPSSzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37238204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933306AbeFLGrS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:47:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbeFLGrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:47:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC398601C3; Tue, 12 Jun 2018 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528786036;
        bh=xcv+fME8ppJ9Bsx7KBI4Q5uVnUdD5neWLgTe0WJKqv8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AsDPSSzSXj6E7t94v4k7uJOYBpGWc0EBnhBd0EYy+qx+DamyZPFoqoNQnJ8AKm0zT
         1/dJgESyhHxN1drHw7k2xwUBVcW2WMm/8hY8imxToZRJV/46n+Y6RNZhnDNEVgS2it
         k5Gla2jmNjbLBLja5qp5U4jWJJWDdPQcQYb5EtbA=
Received: from [10.204.79.109] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cpandya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DBCF602BD;
        Tue, 12 Jun 2018 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528786036;
        bh=xcv+fME8ppJ9Bsx7KBI4Q5uVnUdD5neWLgTe0WJKqv8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AsDPSSzSXj6E7t94v4k7uJOYBpGWc0EBnhBd0EYy+qx+DamyZPFoqoNQnJ8AKm0zT
         1/dJgESyhHxN1drHw7k2xwUBVcW2WMm/8hY8imxToZRJV/46n+Y6RNZhnDNEVgS2it
         k5Gla2jmNjbLBLja5qp5U4jWJJWDdPQcQYb5EtbA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DBCF602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v13 0/3] Fix issues with huge mapping in ioremap for ARM64
To:     Will Deacon <will.deacon@arm.com>, akpm@linux-foundation.org
Cc:     mark.rutland@arm.com, toshi.kani@hpe.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <20180606154520.GM6631@arm.com>
From:   Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <f04347b6-efec-ad62-3376-b03c27a41c89@codeaurora.org>
Date:   Tue, 12 Jun 2018 12:17:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606154520.GM6631@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 6/6/2018 9:15 PM, Will Deacon wrote:

[...]

> On Wed, Jun 06, 2018 at 12:31:18PM +0530, Chintan Pandya wrote:
>> This series of patches re-bring huge vmap back for arm64.
>>
>> Patch 1/3 has been taken by Toshi in his series of patches
>> by name "[PATCH v3 0/3] fix free pmd/pte page handlings on x86"
>> to avoid merge conflict with this series.
>>

[...]

> 
>>   arch/arm64/include/asm/tlbflush.h |  7 ++++++
>>   arch/arm64/mm/mmu.c               | 48 +++++++++++++++++++++++++++++++++++----
>>   arch/x86/mm/pgtable.c             |  8 ++++---
>>   include/asm-generic/pgtable.h     |  8 +++----
>>   lib/ioremap.c                     |  4 ++--
> 
> If you get an ack from the x86 folks, then I could take all of this via
> arm64. Alternatively, now that I've reviewed the series this could happily
> go via another tree (e.g. akpm).
> 

Would you be able to take a look at this series ?
- 1/3 has been reviewed by Will and Toshi (as it touches arm64 and x86).
- 2/3 & 3/3 are arm64 specific changes.

If you think to take these patches, great ! Otherwise, I will try to
reach-out to x86 folks for their ack.

> Thanks,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
