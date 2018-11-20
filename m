Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB2C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E362206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E362206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeKUAtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:49:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeKUAtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:49:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64D89EBD;
        Tue, 20 Nov 2018 06:20:02 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3593F5A0;
        Tue, 20 Nov 2018 06:20:01 -0800 (PST)
Date:   Tue, 20 Nov 2018 15:20:00 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH 0/4] KVM: arm/arm64: vgic: Use raw_spinlock for locks
 taken in IRQ context
Message-ID: <20181120142000.GB11162@e113682-lin.lund.arm.com>
References: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542647279-46609-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:07:55PM +0000, Julien Thierry wrote:
> While testing KVM running on PREEMPT_RT, starting guest could simply
> freeze the machine. This is because we are using spinlocks for VGIC
> locks, which is invalid in the VGIC case since the locks must be take
> with interrupts disabled.
> 
> The solution is to use raw_spinlock instead of spinlocks.
> 
> Replacing those locks also highlighted an issue where we attempt to
> cond_resched with interrupts disabled.
> 
> Patch 1 fixes the cond_resched issue.

I don't agree with this fix without seeing a more thorough analysis.

> Patch 2-4 replace the VGIC spinlocks with raw_spinlocks
> 

For these:

Acked-by: Christoffer Dall <christoffer.dall@arm.com>



Thanks,

    Christoffer
