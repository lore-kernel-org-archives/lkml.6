Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54401C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ABF20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12ABF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJ0BCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:02:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727457AbeJ0BCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:02:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08455B015;
        Fri, 26 Oct 2018 16:24:43 +0000 (UTC)
Date:   Fri, 26 Oct 2018 18:24:40 +0200
From:   Petr Tesarik <ptesarik@suse.cz>
To:     lijiang <lijiang@redhat.com>
Cc:     Boris Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org,
        mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to
 vmcoreinfo
Message-ID: <20181026182440.20a4b107@ezekiel.suse.cz>
In-Reply-To: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
References: <20181026093630.8520-1-lijiang@redhat.com>
        <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
        <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 20:32:11 +0800
lijiang <lijiang@redhat.com> wrote:

>[...]
> For AMD machine with the SME feature, the msr 'MSR_K8_SYSCFG' can examine
> whether SME is enabled in kernel, but the kexec is also userspace tool,
> it has no permission to access the msr.

But we need the MSR value from the panic kernel environment, not while
the production kernel is still running, right?

If so, then this reminds me that I have wanted for a long time to store
more of the hardware state in a vmcore NOTE after a kernel crash ...
control registers, MSRs and whatnot. Of course, this would be a
long-term project, but I wonder what other people think about it in
general.

Just my 2 cents,
Petr T

> Furthermore, i also tried to read the "/dev/cpu/cpu[number]/msr", but
> the value depends on BIOS's configuration. That is to say, if SME is
> set in BIOS, the value of msr is always 0xF40000 whatever the kernel
> commandline parameter is "mem_encrypt=on" or "mem_encrypt=off".
> 
> If i made a mistake, please help to point it out.
> 
> Thanks.
> Lianbo
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

