Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE6AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3407521473
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfARQnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:43:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfARQne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:43:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888D980D;
        Fri, 18 Jan 2019 08:43:34 -0800 (PST)
Received: from localhost (unknown [10.1.28.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BB783F7BE;
        Fri, 18 Jan 2019 08:43:34 -0800 (PST)
Received: from cmarinas by localhost with local (Exim 4.89)
        (envelope-from <catalin.marinas@arm.com>)
        id 1gkXEy-00030U-5S; Fri, 18 Jan 2019 16:43:32 +0000
Date:   Fri, 18 Jan 2019 16:43:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        joel@joelfernandes.org
Subject: Re: [PATCH v8 13/26] arm64: daifflags: Include PMR in daifflags
 restore operations
Message-ID: <20190118164331.7l67555y3pcm37p6@localhost>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-14-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546956464-48825-14-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 02:07:31PM +0000, Julien Thierry wrote:
> The addition of PMR should not bypass the semantics of daifflags.
> 
> When DA_F are set, I bit is also set as no interrupts (even of higher
> priority) is allowed.
> 
> When DA_F are cleared, I bit is cleared and interrupt enabling/disabling
> goes through ICC_PMR_EL1.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
