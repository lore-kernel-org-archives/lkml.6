Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E26FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196B1208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196B1208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeJAVmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:42:09 -0400
Received: from verein.lst.de ([213.95.11.211]:38167 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbeJAVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:42:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 9625F68BC7; Mon,  1 Oct 2018 17:03:53 +0200 (CEST)
Date:   Mon, 1 Oct 2018 17:03:53 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 1/4] DYNAMIC_FTRACE configurable with and without
 REGS
Message-ID: <20181001150353.GA2634@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141643.331EE68BC7@newverein.lst.de> <CAKv+Gu-ZtJ-BpfPWU=soDCb2+dAd81p8OtaarWhmTe+Fk6A8ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-ZtJ-BpfPWU=soDCb2+dAd81p8OtaarWhmTe+Fk6A8ig@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:52:27PM +0200, Ard Biesheuvel wrote:
> 
> I guess we now have Kbuild/Kconfig support for this, no? I mean, we
> can now show/hide options depending on the capabilities of the
> toolchain.

Config options depending on flags availability?

> I am not saying it would be a better approach, though - I'd rather
> have a warning than have things silently disabled, but other people
> may think differently.

Even then this switch has to be enabled, no matter who or what sets it.
Note that this patch leaves everything as-is. Only arm64 users with
"old" compilers would need to take action.

	Torsten

