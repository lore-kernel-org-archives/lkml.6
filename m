Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429C7208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429C7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933849AbeGCPNs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:13:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933569AbeGCPJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8C537A9;
        Tue,  3 Jul 2018 08:09:48 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4193F5AD;
        Tue,  3 Jul 2018 08:09:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180511022751.9096-1-samuel@sholland.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
Date:   Tue, 3 Jul 2018 16:09:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180511022751.9096-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 03:27, Samuel Holland wrote:
> Hello,
> 
> Several people (including me) have experienced extremely large system
> clock jumps on their A64-based devices, apparently due to the
> architectural timer going backward, which is interpreted by Linux as
> the timer wrapping around after 2^56 cycles.
> 
> Investigation led to discovery of some obvious problems with this SoC's
> architectural timer, and this patch series introduces what I believe is
> the simplest workaround. More details are in the commit message for
> patch 1. Patch 2 simply enables the workaround in the device tree.

What's the deal with this series? There was a couple of nits to address,
and I was more or less expecting a v2.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
