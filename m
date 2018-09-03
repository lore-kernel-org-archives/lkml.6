Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657F9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960520869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9l362xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0960520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeICSOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:14:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40573 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeICSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:14:08 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so1083680oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xcTXqcMU+HhceDa3bRTyo6Qhz1Qk0LRrqzAUw1Yzlo=;
        b=c9l362xFRM4hVRFS0zCaTBxKUBkASO5UGyj3ZlaB53F0aRZ+ajsl9vghD4romCf1Zk
         sPvUktca+8TUYWeVpT3kUixv3sWATbQf7QL68jxeH6vgGI7X37R0VTfpTL3fs4eZR4b4
         p3lRHHUkt1kUGZs4lfJQKoyzTJoTMdSP2KI9h9UHQKNkusc3qRJr/fHlWS6nPeC8nQDm
         9ygT2QI0TKM3W6OYSdUrT2NEtlBzQgz3q3Ql6kEpj7f3xtQuRHdxCDeitEIjRV136K0L
         tlTSAcPa0B1f6cMAOkgaYHLl85av4EF9uu731UPAQ3/dK803nh6u2+1rcCQ6KlaebU0u
         PzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xcTXqcMU+HhceDa3bRTyo6Qhz1Qk0LRrqzAUw1Yzlo=;
        b=pevoukIJlBwV+5bMSOZr8sGDpqL6xPkMTIqnblGPwZAiKlNkCUkMsXnjueJZyw2ErJ
         EP6mjR7kQ5YFR5c/2jAE05G5j5iPotqSSrRxwJ5WVhte+I9BLdWYuo7bD1klTP5Kk5td
         0cFcNlJIOi3NMc06p5o/u4cmdPFM7VGNrGugXzxm0tVoEhqZEgpnmIqqd/r9P/v51PAx
         j82oaVdAWWPFtSryEkJFGZmVakZ4IBVO2FmMx0h/QMi27tCEz3MwQ1FkZiiOVmezZdlC
         af3PMeJXTKF+Fx8rGjMMwCdgQ/VABLst7G5wpzD2faFP9K5gG15mRFPjdg9/SqcXqbXL
         BwcA==
X-Gm-Message-State: APzg51CdiVJPAhBlk0+lwFOKJgvktJTtC6D+u3xVgfdyz2SgLa2UITVE
        C/EddhnsFyzzdFFaGcV+8gkLFHXddhz/v3x4OKRLlw==
X-Google-Smtp-Source: ANB0VdYfu4tmgVcB8ch/mfJwN0Ss66WvVbSOUu5dMMXDqs6StIYUt99rZzHQL2e7hL3biloFGQ7uM4QoMawBo3vgmvs=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr18958055oie.68.1535982830640;
 Mon, 03 Sep 2018 06:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Sep 2018 15:53:24 +0200
Message-ID: <CAG48ez2_EgP_-FcLV0g=EU2KuKEwFAmZufjGevMX4j--fJ_0+w@mail.gmail.com>
Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
To:     jarkko.sakkinen@linux.intel.com
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        serge.ayoun@intel.com, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 3:33 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Add a function to perform ENCLS(EINIT), which initializes an enclave,
> which can be used by a driver for running enclaves and VMMs.
>
> Writing the LE hash MSRs is extraordinarily expensive, e.g. 3-4x slower
> than normal MSRs, so we use a per-cpu cache to track the last known value
> of the MSRs to avoid unnecessarily writing the MSRs with the current value.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
[...]
> +/**
> + * sgx_einit - initialize an enclave
> + * @sigstruct:         a pointer to the SIGSTRUCT
> + * @token:             a pointer to the EINITTOKEN
> + * @secs_page:         a pointer to the SECS EPC page
> + * @lepubkeyhash:      the desired value for IA32_SGXLEPUBKEYHASHx MSRs
> + *
> + * Try to perform EINIT operation. If the MSRs are writable, they are updated
> + * according to @lepubkeyhash.
> + *
> + * Return:
> + *   0 on success,
> + *   -errno on failure
> + *   SGX error code if EINIT fails
> + */
> +int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
> +             struct sgx_epc_page *secs_page, u64 lepubkeyhash[4])
> +{
> +       struct sgx_lepubkeyhash __percpu *cache;
> +       bool cache_valid;
> +       int i, ret;
> +
> +       if (!sgx_lc_enabled)
> +               return __einit(sigstruct, token, sgx_epc_addr(secs_page));
> +
> +       cache = per_cpu(sgx_lepubkeyhash_cache, smp_processor_id());

At this point, preemption must be off, because smp_processor_id() is
called; I don't think it is off here? If you have hardware/emulation
on which you can test this, you may want to test your patches with
DEBUG_PREEMPT enabled.

> +       if (!cache) {
> +               cache = kzalloc(sizeof(struct sgx_lepubkeyhash), GFP_KERNEL);

But then here you do a GFP_KERNEL allocation, which can sleep.

Also: After "cache" has been allocated in this branch, when do you
store the reference to it? As far as I can tell, you never write to
sgx_lepubkeyhash_cache, and the allocation just leaks.

> +               if (!cache)
> +                       return -ENOMEM;
> +       }
> +
> +       cache_valid = cache->pm_cnt == sgx_pm_cnt;

The cache should probably not be treated as valid if it has just been
created and only contains zeroes, right?

> +       cache->pm_cnt = sgx_pm_cnt;

Can sgx_pm_cnt be modified concurrently? If so, please use at least
READ_ONCE() to document that and prevent the compiler from doing weird
stuff.

> +       preempt_disable();

And here you turn off preemption, but it should already have been off?

> +       for (i = 0; i < 4; i++) {
> +               if (cache_valid && lepubkeyhash[i] == cache->msrs[i])
> +                       continue;
> +
> +               wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
> +               cache->msrs[i] = lepubkeyhash[i];
> +       }
> +       ret = __einit(sigstruct, token, sgx_epc_addr(secs_page));
> +       preempt_enable();
> +       return ret;
> +}
> +EXPORT_SYMBOL(sgx_einit);
> +
