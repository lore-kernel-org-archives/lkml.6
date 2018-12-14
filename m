Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2723BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E534920866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E534920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeLNJrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:47:15 -0500
Received: from verein.lst.de ([213.95.11.211]:46142 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeLNJrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:47:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 192B468DDD; Fri, 14 Dec 2018 10:47:14 +0100 (CET)
Date:   Fri, 14 Dec 2018 10:47:14 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        julien.thierry@arm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        mingo@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, takahiro.akashi@linaro.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v5] arm64: implement ftrace with regs
Message-ID: <20181214094714.GA30043@lst.de>
References: <20181130162015.83FE767357@newverein.lst.de> <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGdYn46uQWfoDmRjk1OFj9fYXYbC669Ar=oVtnx141HcMFr8w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:01:38PM +0530, Amit Daniel Kachhap wrote:
> On Fri, Nov 30, 2018 at 9:53 PM Torsten Duwe <duwe@lst.de> wrote:
> 
> Hi Torsten,
> 
> I was testing your patch and it seems to work fine for function trace. However
> function graph trace seems broken. Is it work in progress ? or I am
> missing something.

What did you base your tests on, you didn't specify?
OTOH neither did I ;-) I precluded all addressees had the full picture.

Precisely, I basically start with 4.19, but 4.20-rc shouldn't make a
difference. BUT...

> > [Changes from v4]
> >
> > * include Ard's feedback and pending changes:
> >   - ADR/ADRP veneers
> >   - ftrace_trampolines[2]
> >   - add a .req for fp, just in case
" [PATCH 1/2] arm64/insn: add support for emitting ADR/ADRP instructions "
<20181122084646.3247-2-ard.biesheuvel@linaro.org> et.al, esp:
Git-commit: bdb85cd1d20669dfae813555dddb745ad09323ba

> >   - comment on the pt_regs.stackframe[2] mapping
> > * include Mark's ftrace cleanup
> >   - GLOBAL()
> >   - prepare_ftrace_return(pc, &lr, fp)
> >
" [PATCH 1/6] linkage: add generic GLOBAL() macro "
<20181115224203.24847-2-mark.rutland@arm.com> et.al., esp:
Git-commit: 7dc48bf96aa0fc8aa5b38cc3e5c36ac03171e680

change the API this patch set relies on. AFAIU they are on their way into
mainline so I updated v5 accordingly. If you don't have these, just use v4;
the other changes are only for compatibility and cosmetics.

HTH,
	Torsten

