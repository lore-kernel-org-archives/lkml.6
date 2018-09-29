Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D2FC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F54320879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F54320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeI3A0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:26:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbeI3A0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:26:14 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g6JTh-0006Wn-KE; Sat, 29 Sep 2018 19:56:30 +0200
Date:   Sat, 29 Sep 2018 19:56:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, fenghua.yu@intel.com,
        tony.luck@intel.com, mingo@redhat.com, acme@kernel.org,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/6] perf and x86/intel_rdt: Fix lack of coordination
 with perf
In-Reply-To: <42c2b375-dbb9-11a3-8e2f-bec744e73b10@intel.com>
Message-ID: <alpine.DEB.2.21.1809291954310.1432@nanos.tec.linutronix.de>
References: <cover.1537377064.git.reinette.chatre@intel.com> <20180920141150.GY24124@hirez.programming.kicks-ass.net> <77383a1e-f343-7529-24cf-874f0999507d@intel.com> <alpine.DEB.2.21.1809272123440.8118@nanos.tec.linutronix.de> <20180928065830.GE3439@hirez.programming.kicks-ass.net>
 <42c2b375-dbb9-11a3-8e2f-bec744e73b10@intel.com>
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

Reinette,

On Sat, 29 Sep 2018, Reinette Chatre wrote:
> I interpreted Thomas and Peter's responses to mean that there are no
> objections for this to be included in v4.19 as a fix.
> 
> If I understand the tip branches correctly the core patch seems to be
> headed to v4.19 while the rest (excluding the final patch
> "x86/intel_rdt: Re-enable pseudo-lock measurements") are headed to v4.20.
> 
> Have you decided against including this into v4.19 or did I
> misunderstand the responses and/or branches?

I did not decide anything yet. It's not going into -rc6 as it's not yet
through next and the other standard testing.

I'm also looking at the other set of RDT fixes, which obviously want to go
as well. So not sure how to deal with all of that.

Thanks,

	tglx
