Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05D3217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeLRHot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:44:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeLRHot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:44:49 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E75ADDC55678;
        Tue, 18 Dec 2018 15:44:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 15:44:42 +0800
Subject: Re: [PATCH v11 6/7] ACPI/IORT: Stub out ACS functions when CONFIG_PCI
 is not set
To:     Sinan Kaya <okaya@kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-7-okaya@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <af6afa64-27b5-3947-387c-5162f190dc3f@huawei.com>
Date:   Tue, 18 Dec 2018 15:44:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20181218025606.32668-7-okaya@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/18 10:56, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> A quick search reveals the following functions:
> 1. pci_request_acs()
> 2. pci_domain_nr()
> 3. pci_is_root_bus()
> 4. to_pci_dev()
> 
> Both pci_domain_nr() and pci_is_root_bus() are defined in linux/pci.h.
> pci_domain_nr() is a stub function when CONFIG_PCI is not set and
> pci_is_root_bus() just returns a reference to a structure member which
> is still valid without CONFIG_PCI set.
> 
> to_pci_dev() is a macro that expands to container_of.
> 
> pci_request_acs() is the only code that gets pulled in from drivers/pci/*.c

Actually we have pci_for_each_dma_alias() too which is from
drivers/pci/search.c without stub function in linux/pci.h, but I
didn't get the compile error at link time, I think the compiler
just do some optimization to remove the dead code because
dev_is_pci() is obvious false.

Thanks
Hanjun

