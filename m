Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30533C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A5120645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb+qSzyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A5120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeIDUbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:31:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42538 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:31:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id g13-v6so2757585qki.9;
        Tue, 04 Sep 2018 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLU3lGxnz2rK+Q9Y8ng5fb8dv1R8pDi4V7PCZ74rhUo=;
        b=Tb+qSzyxCB2x9KzxSjc9TcRaLKpIfjXwp9I8FWfqx8IEfmbsG7APJWPRFQYvQJxn+c
         VPKAe+K3aEDbjh45FnRYfXDjITLsGm0Q1NtGKRlhqCgTMamlR47igUoA8NCA2NcLdutt
         CG7ZytWjaK73hE0xe2RcrC0Q1CTzLJ3zIUt88HAGJaIlgHBMfYmGAA2e0DZo/tC92Z+K
         jggPuPJI5RV5C1CwggXCHFRB7GjzxSSlbuIX4fcAhd6SjEy9ccFfUnI4NMLYz6LaGGbv
         O7XhW/ZiQ/6P/sv0zk5kchtC1JPL3tvd9Mpd7HPLez0LBCnuG91akVN1gRyUOrppDkx5
         BbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLU3lGxnz2rK+Q9Y8ng5fb8dv1R8pDi4V7PCZ74rhUo=;
        b=BegK6Mx2npQWtUvHgWhJVsEi0BP6yWMYers7zUaJxB5jD9iP9GyElOiPK9ht32Uokm
         QCNsgg+tD1GCLQXmWE1wgeaUdykpJAyzFtB01yFgOrlxTVTZy4mdS6TGyi/4eFjAPUA6
         jcj0Kl4xX0ztEXz/Zp9kEx9o5Ru/UrFUpIK4SAUUuDQ4N67LTFK3yxEh2CUC7m0adOUP
         1gHxwsKVH0SZc0+DuykAeVyYimoZernOJGtCCeVJMwa04DQNKjqOXzSPsHa3+ZWo/m7J
         32PZ3YEHZk2aPfNUPO2HlQKzOW6WOXOHxbD92uWO/wIsmaN3zp+ihkGnJmmmROK6US44
         v1ww==
X-Gm-Message-State: APzg51AVVXvBSEVLZShBE/9uCj7dVtOpY3YtI6GIL3joAeQ8w5zYqi67
        jUeNm2hr3OqbixXabduY2eaFZZKDvTDIGcptKfc=
X-Google-Smtp-Source: ANB0VdYR0BuD9TSgV4yAJ8aKaCBRTsUtqPRdfhxFg/xyMnZ2KZvVeXfP5glZeLJ3HP9WoAqOnjXxoedb1hvNbX45wcA=
X-Received: by 2002:a37:4c0e:: with SMTP id z14-v6mr29191691qka.233.1536077120575;
 Tue, 04 Sep 2018 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-11-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Sep 2018 19:05:09 +0300
Message-ID: <CAHp75VfKdb6fj6EqghEuQazVqGUNJ=FLk+ka+5PyX795-1T-MA@mail.gmail.com>
Subject: Re: [PATCH v13 10/13] x86/sgx: Add sgx_einit() for initializing enclaves
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        serge.ayoun@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
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

> +int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
> +             struct sgx_epc_page *secs_page, u64 lepubkeyhash[4]);

This [4] doesn't make any sense in a C when used in function call
parameter list.

> +/* The cache for the last known values of IA32_SGXLEPUBKEYHASHx MSRs for each
> + * CPU. The entries are initialized when they are first used by sgx_einit().
> + */
> +struct sgx_lepubkeyhash {
> +       u64 msrs[4];

4 is MAGIC.

> +       u64 pm_cnt;
> +};

> +int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
> +             struct sgx_epc_page *secs_page, u64 lepubkeyhash[4])

Same two comments about [4].

> +{

> +       cache = per_cpu(sgx_lepubkeyhash_cache, smp_processor_id());

> +       if (!cache) {

How often it's being expected to happen?

> +               cache = kzalloc(sizeof(struct sgx_lepubkeyhash), GFP_KERNEL);
> +               if (!cache)
> +                       return -ENOMEM;
> +       }

> +       for (i = 0; i < 4; i++) {

Same MAGIC?

> +       }

> +}

-- 
With Best Regards,
Andy Shevchenko
