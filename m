Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFADC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B678208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B678208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbeIXTdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:33:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730354AbeIXTdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:33:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC692317B7F57;
        Mon, 24 Sep 2018 21:31:00 +0800 (CST)
Received: from SHA150392835-N.china.huawei.com (10.45.48.175) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Mon, 24 Sep 2018 21:30:55 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <drjones@redhat.com>,
        <peter.maydell@linaro.org>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH 0/2] rename function name and enable 32bit vcpu events
Date:   Mon, 24 Sep 2018 21:29:58 +0800
Message-ID: <20180924133000.10244-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.11.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.48.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the kvm_arch_dev_ioctl_check_extension() to 
kvm_arch_vm_ioctl_check_extension, because the name
is not reasonable; 

Enable the 32 bit vcpu events support.

Dongjiu Geng (2):
  arm/arm64: KVM: rename function kvm_arch_dev_ioctl_check_extension()
  arm/arm64: KVM: share the check for vcpu events capability

 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 5 ++---
 virt/kvm/arm/arm.c                | 3 ++-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1


