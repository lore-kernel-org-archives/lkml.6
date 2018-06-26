Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DE6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E77268D1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E77268D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934559AbeFZKVa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:21:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFZKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:21:29 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXl5s-0006sJ-F5; Tue, 26 Jun 2018 12:21:04 +0200
Date:   Tue, 26 Jun 2018 12:21:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: linux-next: manual merge of the nvdimm tree with the tip tree
In-Reply-To: <20180626121853.0b4ce17c@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1806261217140.2204@nanos.tec.linutronix.de>
References: <20180626121853.0b4ce17c@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Stephen Rothwell wrote:
> Today's linux-next merge of the nvdimm tree got a conflict in:
> 
>   arch/x86/kernel/cpu/mcheck/mce.c
> 
> between commit:
> 
>   d3d6923cd1ae ("x86/mce: Carve out the crashing_cpu check")
> 
> from the tip tree and commit:
> 
>   f6785eac562b ("x86/memory_failure: Introduce {set,clear}_mce_nospec()")
> 
> from the nvdimm tree.

Dan, we have rules how to deal with that stuff and there is no excuse for
you to collect random patches and apply them as you see fit. Stop this
please.

MCE/RAS patches have a well established and working route and if something
in your tree really depends on this, which I'm not seeing at all, then
there are well documented and established procedures to do that.

Thanks,

	tglx
