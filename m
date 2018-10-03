Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0888C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D4720835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D4720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeJCRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:47:05 -0400
Received: from foss.arm.com ([217.140.101.70]:49588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeJCRrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:47:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 692DA18A;
        Wed,  3 Oct 2018 03:59:12 -0700 (PDT)
Received: from localhost (e105922-lin.Emea.Arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DC23F5A0;
        Wed,  3 Oct 2018 03:59:11 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, will.deacon@arm.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/9] KVM: arm/arm64: Ensure only THP is candidate for adjustment
References: <20181001155443.23032-1-punit.agrawal@arm.com>
        <20181001155443.23032-2-punit.agrawal@arm.com>
        <0809a9d0-d256-c23a-c3cc-0b2be33aecff@arm.com>
Date:   Wed, 03 Oct 2018 11:59:10 +0100
In-Reply-To: <0809a9d0-d256-c23a-c3cc-0b2be33aecff@arm.com> (Marc Zyngier's
        message of "Wed, 3 Oct 2018 11:50:38 +0100")
Message-ID: <87tvm3i9dt.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> On 01/10/18 16:54, Punit Agrawal wrote:
>> PageTransCompoundMap() returns true for hugetlbfs and THP
>> hugepages. This behaviour incorrectly leads to stage 2 faults for
>> unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
>> treated as THP faults.
>>
>> Tighten the check to filter out hugetlbfs pages. This also leads to
>> consistently mapping all unsupported hugepage sizes as PTE level
>> entries at stage 2.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: stable@vger.kernel.org # v4.13+
>
> FWIW, I've cherry-picked that single patch from the series and queued
> it for 4.20.

Thanks for picking up the fix.
