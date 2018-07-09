Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C51C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A98820862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A98820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeGIKkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:40:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56596 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754433AbeGIKkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:40:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F2F1682;
        Mon,  9 Jul 2018 03:40:45 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 055E23F318;
        Mon,  9 Jul 2018 03:40:43 -0700 (PDT)
Date:   Mon, 9 Jul 2018 11:40:41 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Yandong.Zhao" <yandong77520@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, zhaoyd@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Add preemption protection for
 kernel_neon_busy
Message-ID: <20180709104041.GC9486@e103592.cambridge.arm.com>
References: <1531125935-19999-1-git-send-email-yandong77520@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531125935-19999-1-git-send-email-yandong77520@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:45:35PM +0800, Yandong.Zhao wrote:
> From: Yandong Zhao <yandong77520@gmail.com>
> 
> may_use_simd() can be called in any case and access kernel_neon_busy,
> for example: BUG_ON(!may_use_simd()).  This patch ensures that
> migration will not occur during program access to kernel_neon_busy.
> 
> Signed-off-by: Yandong Zhao <yandong77520@gmail.com>

(Duplicate patch, see [1] for discussion.)

[...]

Cheers
---Dave

[1] [PATCH] arm64: neon: Do not access kernel_neon_busy with preemption enabled                                       http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/589259.html

