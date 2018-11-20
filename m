Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C0AC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D8520831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D8520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbeKUDRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:17:36 -0500
Received: from foss.arm.com ([217.140.101.70]:55854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeKUDRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:17:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63ADE1DC8;
        Tue, 20 Nov 2018 08:47:32 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178723F5AF;
        Tue, 20 Nov 2018 08:47:30 -0800 (PST)
Subject: Re: WARN_ON after gic_reserve_range
To:     Jan Glauber <Jan.Glauber@cavium.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20181120162305.GA2088@hc>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <e00f8604-216c-f427-fbb1-6ddffb073411@arm.com>
Date:   Tue, 20 Nov 2018 16:47:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120162305.GA2088@hc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Ard]

Hi Jan,

On 20/11/2018 16:23, Jan Glauber wrote:
> Hi Marc,
> 
> with 4.20-rc3 I see two WARN_ON's firing on a ThunderX2 system that come from
> commit 3fb68faee867 (irqchip/gic-v3-its: Register LPI tables with EFI config table).
> 
> Global efi_memreserve_root is NULL as it will only be set when early initcalls are
> running, but from the backtrace the WARN_ON's are running even earlier (init_IRQ).
> 
> Am I the only one seeing this?

You're not the only one, and this is due to 63eb322d89 ("efi: Permit
calling efi_mem_reserve_persistent() from atomic context"). Reverting
this commit is not really an option though (even if it gets rid of the
warning and allows kexec to work).

Ard and me are looking into it.

Thanks,

	M.

> 
> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x36c/0x608
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3-jang+ #69
> [    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : its_init+0x36c/0x608
> [    0.000000] lr : its_init+0x368/0x608
> [    0.000000] sp : ffff000008e53c60
> [    0.000000] x29: ffff000008e53c60 x28: ffff7dfffe6807a4 
> [    0.000000] x27: 0000000000000001 x26: ffff80267b4c2100 
> [    0.000000] x25: ffff000008ffe930 x24: ffff000008e5d9c8 
> [    0.000000] x23: ffff80267bc10300 x22: ffff000008e5d9c8 
> [    0.000000] x21: ffff000008e59000 x20: ffff000008f12000 
> [    0.000000] x19: ffff000008ffe000 x18: ffffffffffffffff 
> [    0.000000] x17: 0000000000000009 x16: 0000000000000000 
> [    0.000000] x15: ffff000008e59648 x14: ffff000088fa616f 
> [    0.000000] x13: ffff000008fa617d x12: ffff000008e7e000 
> [    0.000000] x11: ffff000008e53900 x10: ffff000008e59eb0 
> [    0.000000] x9 : ffff000008e3e018 x8 : ffff00000875ac58 
> [    0.000000] x7 : 206f6e203a746e65 x6 : 000000000000018c 
> [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000 
> [    0.000000] x3 : 0000000000000001 x2 : 4f419eae5e0eb800 
> [    0.000000] x1 : 0000000000000000 x0 : 00000000ffffffed 
> [    0.000000] Call trace:
> [    0.000000]  its_init+0x36c/0x608
> [    0.000000]  gic_init_bases+0x288/0x300
> [    0.000000]  gic_acpi_init+0x124/0x248
> [    0.000000]  acpi_match_madt+0x4c/0x88
> [    0.000000]  acpi_table_parse_entries_array+0x134/0x220
> [    0.000000]  acpi_table_parse_entries+0x70/0x98
> [    0.000000]  acpi_table_parse_madt+0x40/0x50
> [    0.000000]  __acpi_probe_device_table+0x88/0xe4
> [    0.000000]  irqchip_init+0x38/0x40
> [    0.000000]  init_IRQ+0xcc/0x100
> [    0.000000]  start_kernel+0x2fc/0x490
> [    0.000000] ---[ end trace 41868d15bb5cf8f6 ]---
> 
> --Jan
> 


-- 
Jazz is not dead. It just smells funny...
