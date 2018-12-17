Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB110206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BsEaL+HP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeLQLyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:54:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51450 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQLyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:54:43 -0500
Received: from zn.tnic (p200300EC2BC8CE0001731E093D136BFD.dip0.t-ipconnect.de [IPv6:2003:ec:2bc8:ce00:173:1e09:3d13:6bfd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 261091EC023A;
        Mon, 17 Dec 2018 12:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545047680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ov+79jOoilajc+Zs773s5jUTIblEM8XXhPUIAQ50G3U=;
        b=BsEaL+HPTSn9GogZJIjgxjD761yQg8wVCJeQmO2fa0mGHzfcBIJ75g0iDKJs6rzT6kSWhc
        zjBNhgEOtvPqkBXm8DF2aNAYBLreio0J23fXeCiAAx0VlWTINTBzvZ8Hj8zWtkWyBP5yfO
        +dMn0uoN9QUE3EXW+A+P8cMYK3aRpX4=
Date:   Mon, 17 Dec 2018 12:54:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2 v3] kdump,vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20181217115438.GB12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-1-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:16:15PM +0800, Lianbo Jiang wrote:
> This patchset did two things:
> a. add a new document for vmcoreinfo
> 
> This document lists some variables that export to vmcoreinfo, and briefly
> describles what these variables indicate. It should be instructive for
> many people who do not know the vmcoreinfo, and it would normalize the
> exported variable as a standard ABI between kernel and use-space.
> 
> b. export the value of sme mask to vmcoreinfo
> 
> For AMD machine with SME feature, makedumpfile tools need to know whether
> the crash kernel was encrypted or not. If SME is enabled in the first
> kernel, the crash kernel's page table(pgd/pud/pmd/pte) contains the
> memory encryption mask, so need to remove the sme mask to obtain the true
> physical address.
> 
> Changes since v1:
> 1. No need to export a kernel-internal mask to userspace, so copy the
> value of sme_me_mask to a local variable 'sme_mask' and write the value
> of sme_mask to vmcoreinfo.
> 2. Add comment for the code.
> 3. Improve the patch log.
> 4. Add the vmcoreinfo documentation.
> 
> Changes since v2:
> 1. Improve the vmcoreinfo document, add more descripts for these
> variables exported.
> 2. Fix spelling errors in the document.

Yes, it is starting to look better.

The last thing that's missing is a checkpatch.pl check which verifies
whether a new VMCOREINFO export is not being documented and warn if so.
But you can do that later.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
