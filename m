Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C68C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342920835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeJCQLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:11:37 -0400
Received: from foss.arm.com ([217.140.101.70]:48260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbeJCQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:11:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5439E7A9;
        Wed,  3 Oct 2018 02:24:04 -0700 (PDT)
Received: from [10.4.13.99] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413AA3F5B7;
        Wed,  3 Oct 2018 02:24:02 -0700 (PDT)
Subject: Re: [PATCH v5 08/27] irqchip/gic: Unify GIC priority definitions
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-9-git-send-email-julien.thierry@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <eb1b6e2a-cffc-adc7-d0ff-2ed21919ea80@arm.com>
Date:   Wed, 3 Oct 2018 10:24:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-9-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/18 16:51, Julien Thierry wrote:
> LPIs use the same priority value as other GIC interrupts.
> 
> Make the GIC default priority definition visible to ITS implementation
> and use this same definition for LPI priorities.
> 
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c       | 2 +-
>   include/linux/irqchip/arm-gic-common.h | 6 ++++++
>   include/linux/irqchip/arm-gic.h        | 5 -----
>   3 files changed, 7 insertions(+), 6 deletions(-)

I've cherry-picked this for 4.20, as this is a good cleanup.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
