Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB61ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 23:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400202083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 23:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400202083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJVHsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 03:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeJVHsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 03:48:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B396AF40;
        Sun, 21 Oct 2018 23:32:06 +0000 (UTC)
Date:   Mon, 22 Oct 2018 01:32:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <20181021193827.GB26042@amd>
Message-ID: <nycvar.YFH.7.76.1810220130390.23511@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm> <20181021193827.GB26042@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2018, Pavel Machek wrote:

> Imagine JIT running evil code (flash, javascript). JIT will prevent evil 
> code from doing ptrace() (or maybe there is syscall filter in effect or 
> something like that), but if evil code can poison branch buffers and do 
> timings, security problem stays.

JITs sort of remove the traditional unix security domain boundary between 
mutually (un)trusted code (processess and threads), that's a more general 
problem, yes.

> Do we need prctl(I_DONT_RUN_EVIL_CODE)?

That's basically the level of fine-graining Tim's followup patchset 
(that's currently being discussed) is eventually going to achieve.

Thanks,

-- 
Jiri Kosina
SUSE Labs

