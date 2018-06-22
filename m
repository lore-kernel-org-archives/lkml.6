Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CEBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3444243BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3444243BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeFVOcs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:32:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbeFVOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:32:47 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWN78-0006at-Tw; Fri, 22 Jun 2018 16:32:39 +0200
Date:   Fri, 22 Jun 2018 16:32:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] x86/segments/64: Rename PER_CPU segment to
 CPU_NUMBER
In-Reply-To: <1529536506-26237-6-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1806221631320.2402@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-6-git-send-email-chang.seok.bae@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Chang S. Bae wrote:
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 5b8b556..833e229 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -359,7 +359,10 @@ static void vgetcpu_cpu_init(void *arg)
>  	d.p = 1;		/* Present */
>  	d.d = 1;		/* 32-bit */
>  
> -	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PER_CPU, &d, DESCTYPE_S);
> +	write_gdt_entry(get_cpu_gdt_rw(cpu),
> +			GDT_ENTRY_CPU_NUMBER,
> +			&d,
> +			DESCTYPE_S);

There is no value in using 4 lines for something which fits in one.

Other than that.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
