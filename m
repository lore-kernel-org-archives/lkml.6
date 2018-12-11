Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60571C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FF42084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FF42084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLKKcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:32:35 -0500
Received: from foss.arm.com ([217.140.101.70]:43828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbeLKKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:32:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 335451596;
        Tue, 11 Dec 2018 02:32:34 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C07333F6A8;
        Tue, 11 Dec 2018 02:32:33 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:32:32 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: Re: [PATCH v2 4/4] KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock
 a raw_spinlock
Message-ID: <20181211103232.GW30263@e113682-lin.lund.arm.com>
References: <1543256807-9768-1-git-send-email-julien.thierry@arm.com>
 <1543256807-9768-5-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543256807-9768-5-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:26:47PM +0000, Julien Thierry wrote:
> vgic_cpu->ap_list_lock must always be taken with interrupts disabled as
> it is used in interrupt context.
> 
> For configurations such as PREEMPT_RT_FULL, this means that it should
> be a raw_spinlock since RT spinlocks are interruptible.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>


Acked-by: Christoffer Dall <christoffer.dall@arm.com>
