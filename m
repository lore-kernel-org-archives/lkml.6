Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B495A223EE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B495A223EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeGFQlb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:41:31 -0400
Received: from foss.arm.com ([217.140.101.70]:39968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbeGFQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:41:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F5118A;
        Fri,  6 Jul 2018 09:41:30 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9D933F2EA;
        Fri,  6 Jul 2018 09:41:29 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 736731AE3105; Fri,  6 Jul 2018 17:42:10 +0100 (BST)
Date:   Fri, 6 Jul 2018 17:42:10 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCHv4 00/19] arm64: invoke syscalls with pt_regs
Message-ID: <20180706164210.GC27483@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:03:56PM +0100, Mark Rutland wrote:
> This series reworks arm64's syscall handling to minimize the propagation
> of user-controlled register values into speculated code paths. As with
> x86 [1], a wrapper is generated for each syscall, which extracts the
> argument from a struct pt_regs. During kernel entry from userspace,
> registers are zeroed.
> 
> The arm64 kernel code directly invokes some syscalls which the x86 code
> doesn't, so I've added ksys_* wrappers for these, following the x86
> example. The rest of the series is arm64-specific.
> 
> I've pushed the series out to my arm64/syscall-regs branch [2] on
> kernel.org.

Modulo the macro label nit in the ssbd code, this series looks fine to
me.

Catalin -- have you thrown this at LTP?

Will
