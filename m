Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE429C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737992083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737992083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935417AbeFRRMg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:12:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932762AbeFRRMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 043651529;
        Mon, 18 Jun 2018 10:12:35 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3845C3F25D;
        Mon, 18 Jun 2018 10:12:33 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:12:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Cc:     will.deacon@arm.com, james.morse@arm.com, mark.rutland@arm.com,
        julien.thierry@arm.com, suzuki.poulose@arm.com,
        hoeun.ryu@gmail.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: make secondary_start_kernel() notrace
Message-ID: <20180618171230.tmqkyv4w62mt5diq@armageddon.cambridge.arm.com>
References: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 05:07:37PM +0800, Zhizhou Zhang wrote:
> We can't call function trace hook before setup percpu offset.
> When entering secondary_start_kernel(), percpu offset has not
> been initialized.  So this lead hotplug malfunction.
> Here is the flow to reproduce this bug:
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo function > /sys/kernel/debug/tracing/current_tracer
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>

Queued for 4.18. Thanks.

-- 
Catalin
