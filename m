Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529AB2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529AB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeICLpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:45:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37792 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeICLpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:45:46 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UQQZD72kjTmQ; Mon,  3 Sep 2018 09:26:36 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2DAD1EC00E5;
        Mon,  3 Sep 2018 09:26:28 +0200 (CEST)
Date:   Mon, 3 Sep 2018 09:27:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/kvm: Enable MCE injection in the guest v2
Message-ID: <20180903072735.GB10249@zn.tnic>
References: <20180628173808.25885-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628173808.25885-1-bp@alien8.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On Thu, Jun 28, 2018 at 07:38:06PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi all,
> 
> here's v2, dropping patch 3 and incorporating hopefully all of Radim's
> feedback.
> 
> Thx.
> 
> v1 cover letter:
> 
> there's this mce-inject.ko module in the kernel which allows for
> injecting real MCEs and thus test the MCE handling code.
> 
> It is doubly useful to be able to inject same MCEs in a guest so that
> testing of the MCE handling code can happen even easier/faster. In order
> to be able to do that on an AMD guest, we need to emulate some bits
> and pieces like the HWCR[McStatusWrEn] bit which allows writes to the
> MCi_STATUS registers without a #GP.
> 
> The below does that and with it I'm able to properly inject MCEs in said
> guest.
> 
> Borislav Petkov (2):
>   kvm/x86: Move MSR_K7_HWCR to svm.c
>   x86/kvm: Implement MSR_HWCR support
> 
>  arch/x86/kvm/svm.c | 20 ++++++++++++++++++++
>  arch/x86/kvm/x86.c | 46 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 51 insertions(+), 15 deletions(-)
> 
> -- 
> 2.17.0.582.gccdcbd54c
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
