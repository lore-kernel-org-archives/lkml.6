Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69082C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266FA2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266FA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeJASmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:42:55 -0400
Received: from foss.arm.com ([217.140.101.70]:47542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeJASmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:42:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C87018A;
        Mon,  1 Oct 2018 05:05:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC213F5A0;
        Mon,  1 Oct 2018 05:05:23 -0700 (PDT)
Date:   Mon, 1 Oct 2018 13:05:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, peter.maydell@linaro.org,
        cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        rkrcmar@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, dave.martin@arm.com,
        eric.auger@redhat.com, julien.grall@arm.com,
        James Morse <james.morse@arm.com>, pbonzini@redhat.com,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v6 04/18] arm64: Add a helper for PARange to physical
 shift conversion
Message-ID: <20181001120520.GA25071@arrakis.emea.arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
 <20180926163258.20218-5-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926163258.20218-5-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:32:40PM +0100, Suzuki K. Poulose wrote:
> On arm64, ID_AA64MMFR0_EL1.PARange encodes the maximum Physical
> Address range supported by the CPU. Add a helper to decode this
> to actual physical shift. If we hit an unallocated value, return
> the maximum range supported by the kernel.
> This will be used by KVM to set the VTCR_EL2.T0SZ, as it
> is about to move its place. Having this helper keeps the code
> movement cleaner.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
