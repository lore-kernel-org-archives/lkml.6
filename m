Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC0EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF697218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfBKNUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:20:47 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfBKNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:20:46 -0500
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtBVi-0005Zt-AG; Mon, 11 Feb 2019 14:20:34 +0100
Date:   Mon, 11 Feb 2019 14:20:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v8 1/3] x86/fpu: track AVX-512 usage of tasks
In-Reply-To: <20190117183822.31333-1-aubrey.li@intel.com>
Message-ID: <alpine.DEB.2.21.1902111419300.3197@nanos.tec.linutronix.de>
References: <20190117183822.31333-1-aubrey.li@intel.com>
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

On Fri, 18 Jan 2019, Aubrey Li wrote:

> User space tools which do automated task placement need information
> about AVX-512 usage of tasks, because AVX-512 usage could cause core
> turbo frequency drop and impact the running task on the sibling CPU.
> 
> The XSAVE hardware structure has bits that indicate when valid state
> is present in registers unique to AVX-512 use.  Use these bits to
> indicate when AVX-512 has been in use and add per-task AVX-512 state
> timestamp tracking to context switch.
> 
> Well-written AVX-512 applications are expected to clear the AVX-512
> state when not actively using AVX-512 registers, so the tracking
> mechanism is imprecise and can theoretically miss AVX-512 usage during
> context switch. But it has been measured to be precise enough to be
> useful under real-world workloads like tensorflow and linpack.
> 
> If higher precision is required, suggest user space tools to use the
> PMU-based mechanisms in combination.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
