Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB49C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D94A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D94A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLCNvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:51:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37760 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeLCNvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:51:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72581682;
        Mon,  3 Dec 2018 05:50:04 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B6E83F614;
        Mon,  3 Dec 2018 05:50:02 -0800 (PST)
Subject: Re: [PATCH v9 3/8] KVM: arm/arm64: Introduce helpers to manipulate
 page table entries
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     suzuki.poulose@arm.com, marc.zyngier@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        punitagrawal@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-4-punit.agrawal@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
Date:   Mon, 3 Dec 2018 19:20:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-4-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> Introduce helpers to abstract architectural handling of the conversion
> of pfn to page table entries and marking a PMD page table entry as a
> block entry.

Why is this necessary ? we would still need to access PMD, PUD as is
without any conversion. IOW KVM knows the breakdown of the page table
at various levels. Is this something required from generic KVM code ?
  
> 
> The helpers are introduced in preparation for supporting PUD hugepages
> at stage 2 - which are supported on arm64 but do not exist on arm.

Some of these patches (including the earlier two) are good on it's
own. Do we have still mention in commit message about the incoming PUD
enablement as the reason for these cleanup patches ?
