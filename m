Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF21C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2612E21D09
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2612E21D09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967555AbeF1R3X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:29:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967499AbeF1R3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:29:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6CE318A;
        Thu, 28 Jun 2018 10:29:21 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40683F318;
        Thu, 28 Jun 2018 10:29:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-3-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <d910258e-b332-36f3-4024-ed9ab48af278@arm.com>
Date:   Thu, 28 Jun 2018 18:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 19/06/18 07:44, AKASHI Takahiro wrote:
> Under the current implementation, UEFI memory map will be mapped and made
> available in virtual mappings only if runtime services are enabled.

> But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
> to create mappings of ACPI tables using memory attributes described in
> UEFI memory map.
> 
> So, as a first step, arm_enter_runtime_services() will be modified
> so that UEFI memory map will be always accessible.
> 
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables

For what its worth:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
