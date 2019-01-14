Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E37FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574DE206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfANP4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:56:40 -0500
Received: from foss.arm.com ([217.140.101.70]:36198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfANP4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:56:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D1D80D;
        Mon, 14 Jan 2019 07:56:40 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85113F70D;
        Mon, 14 Jan 2019 07:56:37 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:56:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        linux-arch@vger.kernel.org, daniel.thompson@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, joel@joelfernandes.org
Subject: Re: [PATCH v8 01/26] arm64: Fix HCR.TGE status for NMI contexts
Message-ID: <20190114155634.GB84430@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:07:19PM +0000, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime
> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).

Why would an NMI context need to access user space? (just curious what
breaks exactly without this patch; otherwise it looks fine)

-- 
Catalin
