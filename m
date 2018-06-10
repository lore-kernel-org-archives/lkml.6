Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8/AHE/i3HFuHSgAAmS7hNA
	; Sun, 10 Jun 2018 05:32:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 33FF360795; Sun, 10 Jun 2018 05:32:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2OuMiWyr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9D1A5602FC;
	Sun, 10 Jun 2018 05:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D1A5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFJFch (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932086AbeFJFcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:32:35 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A696A208AD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 05:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528608755;
        bh=+J5x0eICSCLh2R1EzuQmwIt2G+wxvbQvWCYGLBeq5yg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2OuMiWyr3RarJeBBxJlivlu/bKKa/bNUdkfQTLLpB4RcVFpu3x8aFEejZTNhX93mP
         niOeTRSM/pKPBGqdbjC7Grl+Evli/pDnOl23MnsMDd8Y+5eNarycjjzvtnJB4SzfuD
         eW4/6O5ViOD/YbNeHRWiSHeQmh8pjpRMrXXptEdU=
Received: by mail-wm0-f47.google.com with SMTP id r15-v6so9289421wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 22:32:34 -0700 (PDT)
X-Gm-Message-State: APt69E26qHAh1MQWf/zXh0/0PsqZ0mgykkmUj6O0w9XCwzfYoufvfCIn
        EM7QyffoJACGB/pgfbXDtpj1YCRjfH/RIMwZWhtmlw==
X-Google-Smtp-Source: ADUXVKJWEnt2SfGYs0oNdezAX2vQwRz4ngA0uVg9TrpAoBV2IG9o3ZeYW4baDUig8h5egNfzvRIGcZgDmyrt6aCL7T4=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr5467743wma.21.1528608753151;
 Sat, 09 Jun 2018 22:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com> <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 9 Jun 2018 22:32:21 -0700
X-Gmail-Original-Message-ID: <CALCETrVUGubKSS00aH5JJoc0vNkqLGPqCoaG2br2yn5cxWXz-Q@mail.gmail.com>
Message-ID: <CALCETrVUGubKSS00aH5JJoc0vNkqLGPqCoaG2br2yn5cxWXz-Q@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 09/13] x86, sgx: basic routines
 for enclave page cache
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 10:22 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> SGX has a set of data structures to maintain information about the enclaves
> and their security properties. BIOS reserves a fixed size region of
> physical memory for these structures by setting Processor Reserved Memory
> Range Registers (PRMRR). This memory area is called Enclave Page Cache
> (EPC).
>

> +/**
> + * sgx_einit - EINIT an enclave with the appropriate LE pubkey hash
> + * @sigstruct:         a pointer to the enclave's sigstruct
> + * @token:             a pointer to the enclave's EINIT token
> + * @secs_page:         a pointer to the enclave's SECS EPC page
> + * @le_pubkey_hash:    the desired LE pubkey hash for EINIT
> + */
> +int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
> +             struct sgx_epc_page *secs_page, u64 le_pubkey_hash[4])
> +{
> +       u64 __percpu *cache;
> +       void *secs;
> +       int i, ret;
> +
> +       secs = sgx_get_page(secs_page);
> +
> +       if (!sgx_lc_enabled) {

I'm confused.  What does this code path do?  It kind of looks like the
driver will load and just malfunction if we don't have write access to
the MSRs.  What is the intended behavior?

> +               ret = __einit(sigstruct, token, secs);
> +               goto out;
> +       }
> +
> +       cache = per_cpu(sgx_le_pubkey_hash_cache, smp_processor_id());
> +
> +       preempt_disable();
> +       for (i = 0; i < 4; i++) {
> +               if (le_pubkey_hash[i] == cache[i])
> +                       continue;
> +
> +               wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, le_pubkey_hash[i]);
> +               cache[i] = le_pubkey_hash[i];
> +       }
> +       ret = __einit(sigstruct, token, secs);
> +       preempt_enable();
> +
> +out:
> +       sgx_put_page(secs);
> +       return ret;
> +}
> +EXPORT_SYMBOL(sgx_einit);
> +
