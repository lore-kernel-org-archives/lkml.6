Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EBAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4423823F1C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4423823F1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFVIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:41:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751187AbeFVIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:41:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 55D079BD0004F;
        Fri, 22 Jun 2018 16:41:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.219) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 16:39:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Hanjun Guo <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, <xuehuahu@hisilicon.com>
Subject: Supporting more IRQs than NR_IRQS + 8196 on ARM64 server
Message-ID: <5B2CB5C7.1020801@huawei.com>
Date:   Fri, 22 Jun 2018 16:39:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.219]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc
     Current system only supports (NR_IRQS + 8196) interrupts.  It's not 
enough on ARM64
server, on D06 we have several pcie devices and each device supports 256 
VMs and each
VM uses 64 interrupts. Can we set NR_IRQS to a bigger value to support 
more interrupts ?

Thanks,
Yang

