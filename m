Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F82C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B152098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B152098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJCWBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:01:34 -0400
Received: from foss.arm.com ([217.140.101.70]:52768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbeJCWBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:01:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07D237A9;
        Wed,  3 Oct 2018 08:12:46 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.emea.arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4C23F5A0;
        Wed,  3 Oct 2018 08:12:43 -0700 (PDT)
Date:   Wed, 3 Oct 2018 16:12:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        joel@joelfernandes.org
Subject: Re: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
Message-ID: <20181003151240.GE12998@arrakis.emea.arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:51:15PM +0100, Julien Thierry wrote:
> For EL0 entries requiring bp_hardening, daif status is kept at
> DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
> are enabled through local_irq_enable().
> 
> Before using local_irq_* functions, daifflags should be properly restored
> to a state where IRQs are enabled.
> 
> Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
