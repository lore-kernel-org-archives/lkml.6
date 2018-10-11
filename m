Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C701FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840552098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840552098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJKS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:26:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbeJKS0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:26:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75CEE277BC777;
        Thu, 11 Oct 2018 19:00:01 +0800 (CST)
Received: from localhost.localdomain (10.143.28.90) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Thu, 11 Oct 2018 18:59:55 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <suzuki.poulose@arm.com>, <peter.maydell@linaro.org>,
        <drjones@redhat.com>, <james.morse@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
CC:     <gengdongjiu@huawei.com>
Subject: [PATCH v3 0/2] rename function name and enable 32bit vcpu events
Date:   Thu, 11 Oct 2018 15:07:33 -0400
Message-ID: <1539284855-4035-1-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the kvm_arch_dev_ioctl_check_extension() to 
kvm_arch_vm_ioctl_check_extension, because the name
is not reasonable; 

Enable the 32 bit vcpu events support.

Change since v2:
1. Address Suzuki's comments to update the patch commit messages

change since v1:
1. Update patch commit messages.

Dongjiu Geng (2):
  arm/arm64: KVM: rename function kvm_arch_dev_ioctl_check_extension()
  arm/arm64: KVM: enable 32 bits kvm vcpu events support

 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 5 ++---
 virt/kvm/arm/arm.c                | 3 ++-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1

