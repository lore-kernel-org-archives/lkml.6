Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2894BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D094B217AE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D094B217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934566AbeGCSv6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:51:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934488AbeGCSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:51:56 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faQOZ-00012g-TB; Tue, 03 Jul 2018 20:51:24 +0200
Date:   Tue, 3 Jul 2018 20:51:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 03/13] x86/sgx: add SGX definitions to msr-index.h
In-Reply-To: <20180703182118.15024-4-jarkko.sakkinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1807032049270.1816@nanos.tec.linutronix.de>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com> <20180703182118.15024-4-jarkko.sakkinen@linux.intel.com>
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

On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:

x86/msr: Add ....

> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> ENCLS and ENCLU are usable if and only if SGX_ENABLE is set and After
> SGX is activated the IA32_SGXLEPUBKEYHASHn MSRs are writable if
> SGX_LC_WR is set and the feature control is locked.
> 
> SGX related bits in IA32_FEATURE_CONTROL cannot be set before SGX is
> activated by the pre-boot firmware. SGX activation is triggered by
> setting bit 0 in the MSR 0x7a. Until SGX is activated, the LE hash MSRs
> are writable to allow pre-boot firmware to lock down the LE root key
> with a non-Intel value.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Haim Cohen <haim.cohen@intel.com>

Lacks SOB

> ---
>  arch/x86/include/asm/msr-index.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index fda2114197b3..a7355fb7344f 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -479,6 +479,8 @@
>  #define FEATURE_CONTROL_LOCKED				(1<<0)
>  #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
>  #define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
> +#define FEATURE_CONTROL_SGX_ENABLE                      (1<<18)

Tabs not spaces please. checkpatch.pl would have told you

> +#define FEATURE_CONTROL_SGX_LE_WR			(1<<17)

Thanks,

	tglx
