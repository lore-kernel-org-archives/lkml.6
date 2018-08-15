Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2329DC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A82215F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A82215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeHOQih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:38:37 -0400
Received: from verein.lst.de ([213.95.11.211]:45219 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbeHOQih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:38:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 3C9B768E82; Wed, 15 Aug 2018 15:47:10 +0200 (CEST)
Date:   Wed, 15 Aug 2018 15:47:10 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: implement ftrace with regs
Message-ID: <20180815134710.GA27854@lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de> <20180810160223.D360D68C76@newverein.lst.de> <2b5c1092-2cc0-00ec-ba3d-341dc61452b4@arm.com> <20180813220315.6e8dfc9c@vmware.local.home> <a19d9e23-3dfa-ba9b-a177-cdc0d1035964@arm.com> <20180814120433.1f5e8da1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814120433.1f5e8da1@gandalf.local.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[working on V2 with your feedback]

On Tue, Aug 14, 2018 at 12:04:33PM -0400, Steven Rostedt wrote:
> On Tue, 14 Aug 2018 09:33:52 +0100
> Julien Thierry <julien.thierry@arm.com> wrote:
> > >> Shouldn't this be an error? The option -fpatchable-function-entry has
> > >> been added to the CC_FLAGS_FTRACE, so any call to the compiler is gonna
> > >> break anyway. Or am I missing something?  

This should be the case.

> OK, I see what you mean. If the resulting build wont boot, then yes
> this should be an error and not a warning.

No, there won't be a binary because the first gcc invocation with
CC_FLAGS_FTRACE will error out.

The alternatives are a makefile-warning followed by a gcc-error or just
a makefile-error. The makefile warning or error should hint at the causing
config option, that's the key point. Beyond that I don't have any preference.

	Torsten
