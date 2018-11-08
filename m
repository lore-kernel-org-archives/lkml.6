Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA67EC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5112133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5112133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKHUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:53:47 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43483 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:53:47 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKiKS-0005Zs-9V; Thu, 08 Nov 2018 12:18:28 +0100
Date:   Thu, 8 Nov 2018 12:18:23 +0100 (CET)
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
Subject: Re: [Patch v4 07/18] x86/smt: Convert cpu_smt_control check to
 cpu_smt_enabled static key
In-Reply-To: <488c98ae-9d73-6d42-712b-8d8c031ebf8a@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811081216460.1549@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <55b8a35095d778d257c7b22d86e45eace6905ae5.1540923609.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811031928010.3160@nanos.tec.linutronix.de>
 <488c98ae-9d73-6d42-712b-8d8c031ebf8a@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Wed, 7 Nov 2018, Tim Chen wrote:
> On 11/03/2018 11:29 AM, Thomas Gleixner wrote:
> > Tim,
> > 
> > On Tue, 30 Oct 2018, Tim Chen wrote:
> > 
> >> Change the SMT code paths check from using cpu_smt_control to
> >> cpu_smt_enabled static key.  This saves a branching check.
> > 
> > and adds extra size to the kernel for the patching. The only reason why it
> > would make sense for kvm is that then the EXPORT of cpu_smt_control can go
> > away, which takes more space than the patch data.
> > 
> 
> Should I just drop this patch then and only replace
> sched_smt_present with cpu_smt_enabled?

You have to decide which of the exports to drop. No strong opinion.

Thanks,

	tglx
