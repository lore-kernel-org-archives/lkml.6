Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E464ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03192208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03192208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeGPNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:55:53 -0400
Received: from foss.arm.com ([217.140.101.70]:59848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeGPNzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:55:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A81718A;
        Mon, 16 Jul 2018 06:28:26 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1693F5A0;
        Mon, 16 Jul 2018 06:28:26 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] KVM: arm/arm64: Share common code in user_mem_abort()
References: <20180716110857.19310-1-punit.agrawal@arm.com>
        <20180716110857.19310-2-punit.agrawal@arm.com>
        <c28e1aa4-c0f1-8010-6a11-005e7f1db01c@arm.com>
Date:   Mon, 16 Jul 2018 14:28:24 +0100
In-Reply-To: <c28e1aa4-c0f1-8010-6a11-005e7f1db01c@arm.com> (Suzuki
        K. Poulose's message of "Mon, 16 Jul 2018 13:45:05 +0100")
Message-ID: <87r2k3mhs7.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:

> On 16/07/18 12:08, Punit Agrawal wrote:
>> The code for operations such as marking the pfn as dirty, and
>> dcache/icache maintenance during stage 2 fault handling is duplicated
>> between normal pages and PMD hugepages.
>>
>> Instead of creating another copy of the operations when we introduce
>> PUD hugepages, let's share them across the different pagesizes.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>
> Thanks for splitting the patch. It looks much simpler this way.
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for reviewing the patches.

Punit

> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
