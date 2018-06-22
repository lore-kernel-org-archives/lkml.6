Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD101C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18AD23FB2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18AD23FB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeFVKih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:38:37 -0400
Received: from foss.arm.com ([217.140.101.70]:33152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751325AbeFVKig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531FA1A9;
        Fri, 22 Jun 2018 03:38:36 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 688883F557;
        Fri, 22 Jun 2018 03:38:35 -0700 (PDT)
Subject: Re: Supporting more IRQs than NR_IRQS + 8196 on ARM64 server
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, xuehuahu@hisilicon.com
References: <5B2CB5C7.1020801@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d9fb69e1-6a25-a3a8-8073-c556f7ebcb92@arm.com>
Date:   Fri, 22 Jun 2018 11:38:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B2CB5C7.1020801@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On 22/06/18 09:39, Yang Yingliang wrote:
> Hi, Marc
> Current system only supports (NR_IRQS + 8196) interrupts. It's not 
> enough on ARM64 server, on D06 we have several pcie devices and each
> device supports 256 VMs and each VM uses 64 interrupts. Can we set> NR_IRQS to a bigger value to support more interrupts ?
You could, but it feels quite hackish, and not future proof at all. It
would unnecessarily affect smaller systems that do not need the overhead.

I'd rather we offer the architecture a way to buy into a more dynamic
scheme which wouldn't be limited by a bitmap, or at least made the
bitmap extensible.

I'll have a think about it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
