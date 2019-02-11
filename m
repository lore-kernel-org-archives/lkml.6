Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA381C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2FA222A0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549905977;
	bh=g8TjAtGRH6B7E/gDyHjzZCK8XMiIGVhDMsBxNtLfKq8=;
	h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=fEW1rtX+3NrS5mJIM5Tb4u+Ygb6Hhtmg4Xk0ioByM8fCeuXvef2KjM8cZhPRJsIj0
	 j69ik5SQkIwwYtu8jL8Do9+kme5rcnbJBdVyRiIRlz9FSW2ynaDmIjdG/MwHDmBsvB
	 0Ye1lQLfAPLL82CA8Gx0yO2QwY7fXIxA1uJU82is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfBKR0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfBKR0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:26:15 -0500
Received: from localhost (unknown [23.100.24.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE83222A0;
        Mon, 11 Feb 2019 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549905975;
        bh=g8TjAtGRH6B7E/gDyHjzZCK8XMiIGVhDMsBxNtLfKq8=;
        h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
         From;
        b=odu+uQ+kFy9/F1AlsVkAMU/9WCh8vNYkzDqkONtlnzfm3fSR1Fen95JxgecxstiGj
         pDYp5OTPSa/2tgJ8aUnbQNcc7khbJJnQiji1Nha3HGj+umJ2YyJzFBF/l0X9apDAoQ
         dLz+pBCF6GnZBvck+2PdggxY5TRPCOX0roLKN2ok=
Date:   Mon, 11 Feb 2019 17:26:14 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
To:     Jann Horn <jannh@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, stable@kernel.org
Cc:     stable@kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
In-Reply-To: <1549562945-5503-1-git-send-email-pbonzini@redhat.com>
References: <1549562945-5503-1-git-send-email-pbonzini@redhat.com>
Message-Id: <20190211172614.CBE83222A0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 852b6d57dc7f kvm: add device control API.

The bot has tested the following trees: v4.20.7, v4.19.20, v4.14.98, v4.9.155, v4.4.173, v3.18.134.

v4.20.7: Build OK!
v4.19.20: Build OK!
v4.14.98: Build OK!
v4.9.155: Build OK!
v4.4.173: Failed to apply! Possible dependencies:
    023e9fddc361 ("KVM: PPC: Move xics_debugfs_init out of create")
    0919e84c0fc1 ("KVM: arm/arm64: vgic-new: Add IRQ sync/flush framework")
    140b086dd197 ("KVM: arm/arm64: vgic-new: Add GICv2 world switch backend")
    2b0cda878965 ("KVM: arm/arm64: vgic-new: Add CTLR, TYPER and IIDR handlers")
    4493b1c4866a ("KVM: arm/arm64: vgic-new: Add MMIO handling framework")
    59529f69f504 ("KVM: arm/arm64: vgic-new: Add GICv3 world switch backend")
    5e6431da8f3a ("KVM: arm/arm64: vgic-new: vgic_init: implement vgic_create")
    64a959d66e47 ("KVM: arm/arm64: vgic-new: Add acccessor to new struct vgic_irq instance")
    81eeb95ddbab ("KVM: arm/arm64: vgic-new: Implement virtual IRQ injection")
    90eee56c5f90 ("KVM: arm/arm64: vgic-new: Implement kvm_vgic_vcpu_pending_irq")
    a28ebea2adc4 ("KVM: Protect device ops->create and list_add with kvm->lock")
    b18b57787f5e ("KVM: arm/arm64: vgic-new: Add data structure definitions")
    c7da6fa43cb1 ("arm/arm64: KVM: Detect vGIC presence at runtime")
    c86c772191d7 ("KVM: arm/arm64: vgic-new: vgic_kvm_device: KVM device ops registration")
    e2c1f9abff83 ("KVM: arm/arm64: vgic-new: vgic_kvm_device: implement kvm_vgic_addr")
    ed9b8cefa916 ("KVM: arm/arm64: vgic-new: Add GICv3 MMIO handling framework")
    fb848db39661 ("KVM: arm/arm64: vgic-new: Add GICv2 MMIO handling framework")
    fca256026bb0 ("KVM: arm/arm64: vgic-new: vgic_kvm_device: KVM_DEV_ARM_VGIC_GRP_NR_IRQS")
    fd59ed3be17e ("KVM: arm/arm64: vgic-new: Add GICv3 CTLR, IIDR, TYPER handlers")

v3.18.134: Failed to apply! Possible dependencies:
    023e9fddc361 ("KVM: PPC: Move xics_debugfs_init out of create")
    05bc8aafe664 ("arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones")
    174178fed338 ("KVM: arm/arm64: add irqfd support")
    1d916229e348 ("arm/arm64: KVM: split GICv2 specific emulation code from vgic.c")
    3caa2d8c3b2d ("arm/arm64: KVM: make the maximum number of vCPUs a per-VM value")
    59892136c40d ("arm/arm64: KVM: pass down user space provided GIC type into vGIC code")
    662d9715840a ("arm/arm64: KVM: Kill CONFIG_KVM_ARM_{VGIC,TIMER}")
    832158125d2e ("arm/arm64: KVM: add vgic.h header file")
    83fe27ea5311 ("rcu: Make SRCU optional by using CONFIG_SRCU")
    96415257a1bd ("arm/arm64: KVM: refactor vgic_handle_mmio() function")
    a28ebea2adc4 ("KVM: Protect device ops->create and list_add with kvm->lock")
    b26e5fdac43c ("arm/arm64: KVM: introduce per-VM ops")
    c7da6fa43cb1 ("arm/arm64: KVM: Detect vGIC presence at runtime")
    d44758c0dfc5 ("KVM: arm/arm64: enable KVM_CAP_IOEVENTFD")
    d97f683d0f4b ("arm/arm64: KVM: refactor MMIO accessors")


How should we proceed with this patch?

--
Thanks,
Sasha
