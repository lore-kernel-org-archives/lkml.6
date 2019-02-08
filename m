Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4B9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4432020844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfBHQRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:17:06 -0500
Received: from foss.arm.com ([217.140.101.70]:53554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfBHQRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:17:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 591BEA78;
        Fri,  8 Feb 2019 08:17:04 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 001FE3F719;
        Fri,  8 Feb 2019 08:17:01 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:16:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190208161658.GB232749@arrakis.emea.arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
 <20190208043543.GA5040@archlinux-ryzen>
 <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:36:48AM +0000, Julien Thierry wrote:
> From e839dec632bbf440efe8314751138ba46324078c Mon Sep 17 00:00:00 2001
> From: Julien Thierry <julien.thierry@arm.com>
> Date: Fri, 8 Feb 2019 09:21:58 +0000
> Subject: [PATCH] arm64: irqflags: Fix clang build warnings
> 
> Clang complains when passing asm operands that are smaller than the
> registers they are mapped to:
> 
> arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not
> 	match register size specified by the constraint and modifier
> 	[-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQON)
> 
> Fix it by casting the affected input operands to a type of the correct
> size.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Applied. Thanks.

-- 
Catalin
