Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79553C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D172086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D172086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbeKGCPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:15:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:42018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389241AbeKGCPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:15:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7001DB71C;
        Tue,  6 Nov 2018 16:49:08 +0000 (UTC)
Date:   Tue, 6 Nov 2018 17:49:07 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Torsten Duwe <duwe@lst.de>
cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm64: implement live patching
In-Reply-To: <20181026142152.5F0D868C95@newverein.lst.de>
Message-ID: <alpine.LSU.2.21.1811061745440.30614@pobox.suse.cz>
References: <20181026142008.D922868C94@newverein.lst.de> <20181026142152.5F0D868C95@newverein.lst.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 26 Oct 2018, Torsten Duwe wrote:

> Based on ftrace with regs, do the usual thing.
> (see Documentation/livepatch/livepatch.txt)
> 
> Use task flag bit 6 to track patch transisiton state for the consistency
> model. Add it to the work mask so it gets cleared on all kernel exits to
> userland.
> 
> Tell livepatch regs->pc is the place to change the return address.
> Make sure the graph tracer call hook is only called on the final function
> entry in case regs->pc gets modified after an interception.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

It looks good now apart from arm64 asm part which should be reviewed by 
someone else.

However, could you summarize our analysis regarding post-module-load calls 
of apply_relocate_add() in the commit log, please? It is important for 
future reference.

Thanks,
Miroslav
