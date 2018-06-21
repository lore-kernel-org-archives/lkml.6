Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E61DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DAD208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2BSDepM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DAD208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeFUMzV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:55:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40814 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeFUMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:55:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id g18-v6so3090318wro.7;
        Thu, 21 Jun 2018 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VZYAUtzqbbG6bOaYWVMYMXjT/A3o+0zkhxP0BWhB238=;
        b=t2BSDepM8dV9kD242zYg/ib0uEA3k4vTmLc2kW2cvBaPnWY1y/G4FSoVccveP4t+f7
         CfSY2ydd5wpHhDa4V02Lfo05HogMWJlhG1rcuZ3XCnY7TDoepvo216iUxpYPRZOvGih6
         7j2qow8SWqbJMO+Eu0Tndpiy7bN8YqThkxRXRCnxP1+4+r67ZNQACd4W9ICPiNiqgSLJ
         Aha0m51IDLQSvQ0gbbQCUVBs6BgPVAEI14N3AonmI7+FDLwFGXvqA3N++MtFLgLDYZbO
         Hw+bWRFPelxrKnp8lnnDRolAtPjtwLVP/A7K3OmhfYTVgaghDdg0jiwbvbMZ4R8z4VJi
         a0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZYAUtzqbbG6bOaYWVMYMXjT/A3o+0zkhxP0BWhB238=;
        b=KLaQ5JE7un8wclbzoc143H/S81M0IgXIRu7mKByJXqjk3dMS02KNbcRbP4C3o/s81L
         cVldUy+YQHMjRYGAQ8jvVR1pO3juIgsjVsdvxmBVttpGGKhC8T1z+N89SplvOZ0uy5DI
         EFqgUftTzlw7PtvCEQZRQFnOmXFkS8qVmb3sHbe+Nw3WEpbJWE6akeesdahjbPeT0z+C
         afqfqqYuRpwW4r/ww9pvP71QRpViDlAiESiqZ3MZY9rdpsXT7HMw/8BTmF/KpZ+rzSs0
         Blbp53rHrEBKf48gSqKR0oXfWYs0UfuNEvGo0XVkWCZzaFd/Cl2JuwPoNd3ibahJQzUW
         urmw==
X-Gm-Message-State: APt69E0TAhZE6BaO1fPn51GPFgZHEBHdnrH5pkCk4+FyWCOCTyM7ZMOc
        VBL21Q9566/Q5/iHJwMDh8E=
X-Google-Smtp-Source: ADUXVKLqaONom1VsrYrbUjwfzwioOdxO+w8YRPdJpS67rcHiAzHhGhBjSFGvoeFIZRYIIBr6CNOkCw==
X-Received: by 2002:adf:88ca:: with SMTP id g10-v6mr19992056wrg.62.1529585715514;
        Thu, 21 Jun 2018 05:55:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v15-v6sm2193926wrq.37.2018.06.21.05.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 05:55:14 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:55:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>, Len Brown <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [PATCH v11 00/13] Intel SGX1 support
Message-ID: <20180621125511.GA4287@gmail.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

>  create mode 100644 drivers/platform/x86/intel_sgx/Kconfig
>  create mode 100644 drivers/platform/x86/intel_sgx/Makefile
>  create mode 100644 drivers/platform/x86/intel_sgx/le/Makefile
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/Makefile
>  create mode 120000 drivers/platform/x86/intel_sgx/le/enclave/aesni-intel_asm.S
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.c
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.h
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/encl_bootstrap.S
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/main.c
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/main.h
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/sgx_le.lds
>  create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/sgxsign.c
>  create mode 120000 drivers/platform/x86/intel_sgx/le/enclave/string.c
>  create mode 100644 drivers/platform/x86/intel_sgx/le/entry.S
>  create mode 100644 drivers/platform/x86/intel_sgx/le/include/sgx_asm.h
>  create mode 100644 drivers/platform/x86/intel_sgx/le/main.c
>  create mode 100644 drivers/platform/x86/intel_sgx/le/main.h
>  create mode 100644 drivers/platform/x86/intel_sgx/le/sgx_le_piggy.S
>  create mode 100644 drivers/platform/x86/intel_sgx/le/string.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx.h
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_encl.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_encl_page.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_fault.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_ioctl.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_le.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_le_proxy_piggy.S
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_main.c
>  create mode 100644 drivers/platform/x86/intel_sgx/sgx_vma.c

Just some quick feedback: these are core kernel functionality and should be in 
arch/x86/, not in drivers/platform/.

Thanks,

	Ingo
