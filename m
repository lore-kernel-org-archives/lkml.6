Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710BDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183526650
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183526650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeFZIBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:01:08 -0400
Received: from foss.arm.com ([217.140.101.70]:40602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752164AbeFZIBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:01:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 239737A9;
        Tue, 26 Jun 2018 01:01:07 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58D4F3F5C0;
        Tue, 26 Jun 2018 01:01:06 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] PCI: shpchp: Manage SHPC unconditionally on
 non-ACPI systems
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152996758037.260522.6880919949506497973.stgit@bhelgaas-glaptop.roam.corp.google.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <557d863e-6ff9-b678-57a4-c26e4c5956f4@arm.com>
Date:   Tue, 26 Jun 2018 09:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152996758037.260522.6880919949506497973.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/18 23:59, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> If acpi_pci_find_root() returns NULL, it means there's no ACPI host bridge
> device (PNP0A03 or PNP0A08), and the OS is always allowed to manage the
> SHPC, so return success in that case.
> 
> This fixes a NULL pointer dereference when CONFIG_ACPI=y but the current
> hardware/firmware platform doesn't support ACPI.  In that case,
> acpi_get_hp_hw_control_from_firmware() is implemented but
> acpi_pci_find_root() returns NULL.
> 
> Fixes: 90cc0c3cc709 ("PCI: shpchp: Add shpchp_is_native()")
> Link: https://lkml.kernel.org/r/20180621164715.28160-1-marc.zyngier@arm.com
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for the quick turnaround!

	M.
-- 
Jazz is not dead. It just smells funny...
