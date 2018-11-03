Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B187C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045332081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045332081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeKDDc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:32:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60396 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKDDc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:32:28 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJ0Wo-00079n-MC; Sat, 03 Nov 2018 19:20:10 +0100
Date:   Sat, 3 Nov 2018 19:20:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v4 08/18] sched: Deprecate sched_smt_present and use
 cpu_smt_enabled static key
In-Reply-To: <a3035781690278fdea781f4d718917985994e0af.1540923609.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811031914470.3160@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <a3035781690278fdea781f4d718917985994e0af.1540923609.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Tue, 30 Oct 2018, Tim Chen wrote:

> The cpu_smt_enabled static key serves identical purpose as cpu_smt_enabled

That doesn't make any sense.

> to enable SMT specific code.
> 
> This patch replaces sched_smt_present in the scheduler with
> cpu_smt_enabled and deprecate sched_smt_present.

It's not deprecating it, it's replacing and removing it and thereby
breaking all architectures which select SCHED_SMT except x86.

Thanks,

	tglx
