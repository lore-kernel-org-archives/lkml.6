Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8A4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D681219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D681219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHFKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:25:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeHFKZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:25:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D4C18A;
        Mon,  6 Aug 2018 01:17:41 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 954F23F5D0;
        Mon,  6 Aug 2018 01:17:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180718154205.13704-1-bigeasy@linutronix.de>
 <20180718154205.13704-2-bigeasy@linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <86fdf639-32c7-5657-d8ae-f8dbf681f399@arm.com>
Date:   Mon, 6 Aug 2018 09:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718154205.13704-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/18 16:42, Sebastian Andrzej Siewior wrote:
> The its_lock lock is held while a new device is added to the list and
> during setup while the CPU is booted. Even on -RT the CPU-bootup is
> performed with disabled interrupts.
> 
> Make its_lock a raw_spin_lock_t.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to irq/irqchip-next.

Thanks,
	
	M.
-- 
Jazz is not dead. It just smells funny...
