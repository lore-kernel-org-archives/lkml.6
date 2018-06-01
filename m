Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeFAOle (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:41:34 -0400
Received: from foss.arm.com ([217.140.101.70]:52982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeFAOld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:41:33 -0400
Subject: Re: [PATCHv2 11/19] arm64: don't reload GPRs after apply_ssbd
To: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
References: <20180601112441.37810-1-mark.rutland@arm.com>
 <20180601112441.37810-12-mark.rutland@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <57f6f0ca-8256-d642-fd59-034b989dc5c8@arm.com>
Date: Fri, 1 Jun 2018 15:41:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601112441.37810-12-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/18 12:24, Mark Rutland wrote:
> Now that all of the syscall logic works on the saved pt_regs, apply_ssbd
> can safely corrupt x0-x3 in the entry paths, and we no longer need to
> restore them. So let's remotve the logic doing so.

remove*

> 
> With that logic gone, we can fold the branch target into the macro, so
> that callers need not deal with this. GAS provides \@, which provides a
> unique value per macro invocation, which we can use to create a unique
> label.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
