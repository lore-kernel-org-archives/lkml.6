Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0566KQkkGVvnXwAAmS7hNA
	; Thu, 07 Jun 2018 12:25:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A99416089E; Thu,  7 Jun 2018 12:25:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E7F2760115;
	Thu,  7 Jun 2018 12:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7F2760115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeFGMZr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:25:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53148 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932124AbeFGMZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:25:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 85F11350E14D6;
        Thu,  7 Jun 2018 20:25:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Thu, 7 Jun 2018
 20:25:35 +0800
Subject: Re: [PATCH v2] irqchip/gic-v3-its: fix ITS queue timeout
To: Marc Zyngier <marc.zyngier@arm.com>,
        Yang Yingliang <yangyingliang@huawei.com>
CC: <julien.thierry@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
 <86a7s89t13.wl-marc.zyngier@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <fc0393df-22d4-0334-91ce-8ddcdbf5ec21@huawei.com>
Date: Thu, 7 Jun 2018 20:25:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <86a7s89t13.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2018/6/6 17:13, Marc Zyngier wrote:
[...]
> 
> Wouldn't it be better to just return that the affinity setting request
> is impossible to satisfy? And more to the point, how comes we end-up
> in such a case?

The system is booted with a NUMA node has no memory attaching to it
(memory-less NUMA node), also with NR_CPUS less than CPUs presented
in MADT, so CPUs on this memory-less node are not brought up, and
this NUMA node will not be online too. But the ITS attaching to this NUMA
domain is still valid and represented via SRAT to ITS driver.

This is really the corner case which is triggered by the boot testing
when enabling our D06 boards, but it's a bug :)

Thanks
Hanjun
