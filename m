Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2351C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC11D21527
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC11D21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeHIMGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbeHIMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:06:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D78FFAB99;
        Thu,  9 Aug 2018 09:41:56 +0000 (UTC)
Date:   Thu, 9 Aug 2018 11:41:54 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20180809094154.v6aj7fpsenkcmo47@suse.de>
References: <20180809092420.094e8722@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809092420.094e8722@canb.auug.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Aug 09, 2018 at 09:24:20AM +1000, Stephen Rothwell wrote:
> Invalid absolute R_X86_64_32S relocation: __end_rodata_aligned
> /kisskb/src/arch/x86/boot/compressed/Makefile:127: recipe for target 'arch/x86/boot/compressed/vmlinux.relocs' failed
> 
> Caused by commit
> 
>   39d668e04eda ("x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit")

Thanks for the report! I only built the source with gcc-4.8 and gcc-7.3,
so I didn't catch this earlier. I have a fix now and will send it as a
separate reply in this thread.


Thanks,

	Joerg

