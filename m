Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AC2C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD292133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD292133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeIMAll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:41:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeIMAll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:41:41 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0Av3-00076X-45; Wed, 12 Sep 2018 21:35:21 +0200
Date:   Wed, 12 Sep 2018 21:35:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
In-Reply-To: <20180911135347.0af423f0@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1809122134290.1473@nanos.tec.linutronix.de>
References: <20180911135347.0af423f0@canb.auug.org.au>
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

On Tue, 11 Sep 2018, Stephen Rothwell wrote:
> After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
> produced this warning:
> 
> arch/x86/kernel/cpu/common.c: In function 'syscall_init':
> arch/x86/kernel/cpu/common.c:1534:6: warning: unused variable 'cpu' [-Wunused-variable]
>   int cpu = smp_processor_id();
>       ^~~
> 
> Introduced by commit
> 
>   86635715ee42 ("x86/pti/64: Remove the SYSCALL64 entry trampoline")

Hrmpf. My randconfigs seem not to be random enough. Fixed.

Thanks,

	tglx
