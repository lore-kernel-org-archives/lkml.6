Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8BEC4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED85A20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Weby2QMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED85A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeICTWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:22:24 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36795 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeICTWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:22:24 -0400
Received: by mail-qt0-f176.google.com with SMTP id t5-v6so883703qtn.3;
        Mon, 03 Sep 2018 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k6gclSInS2Xfft2jU2vh+G5dKtdzJLj0qsf8YjpAPs=;
        b=Weby2QMJgfAWQW/Z0F7Duw80l3lnF3WbnSvkprOtezxxyfwBeFPrR05lF3YmMV3jQB
         koJc88hjnUm54nc3SDCHlUSk+AJOuRQd10D5pf6BVhkafaO881SZGRshv/vllZLeTdnC
         X23rxgCAzvIr+qlksT0J5lbzywbQHtq8UXSGof054OH/SPw6Lak5h02H47AbwIn7u6z1
         O39usiwtyGx89Oo0EQLnZG8+paTXnpISNVvjYvXX63awVvelIvrYVGxOAgYmPaVDyvEG
         a7n8k3K/Z7ovb4aXF2hSYw4PgAF1aYCj9SYag8R3+f1cdDDumj3/g1Aor+dfbkA52V4Y
         1pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k6gclSInS2Xfft2jU2vh+G5dKtdzJLj0qsf8YjpAPs=;
        b=J4oiu8vDElZyiQpsSf+kFXv19fyvd+OWa5WQg+AiCMQa7Md6Wo7UkidzopvCq+ZRQf
         7q/q5Um1XgyND2svweo1VdUU4zh1+zZPN5O1BcLPMBaAkmXfuIcY36TM8DsxEx+cx7WH
         CbUmsaEdlaIg203JOutKQkRm1xz3IOKiPEX4I4ll11bjJeX97MQZU7bgSqn5IJdq21vl
         D6cafNsc6thIb9QY+x11KYZSfxOT2LYaTrAAmUgFabgsqUUKu9yF1BcfOcerG8McAYDG
         YODareNMM7oegzIq+0KtYcywDiqdg2DLaB47ESu66ovtFgPy4HjiyrdToWj/45k9ZMO2
         99HQ==
X-Gm-Message-State: APzg51BDvx0c0fR6NEtfF9y19t34rOndz2MXV/7u+eX6aOsGDtHnWHR9
        NLnMnP9/jTeH7FTMk/Ll9AgPdcC4mW2Njk4rYk8=
X-Google-Smtp-Source: ANB0VdYh83WOj3poDhnrBHW0VhaEI7bW/GbDQKZ1w/+4qYHRebvQavxwD6iecbYO3T5pEtviugRfZ3ZsU7l2NikK5XI=
X-Received: by 2002:a0c:e985:: with SMTP id z5-v6mr26014450qvn.136.1535986909645;
 Mon, 03 Sep 2018 08:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-9-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-9-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Sep 2018 18:01:26 +0300
Message-ID: <CAHp75VdHmfx70=4jZnGZcgk5HTegDtizo7Uauk_bH43RpDXCfg@mail.gmail.com>
Subject: Re: [PATCH v13 08/13] x86/sgx: Add wrappers for ENCLS leaf functions
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, serge.ayoun@intel.com,
        suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Add wrappers for Intel(R) SGX ENCLS opcode leaf functions except
> ENCLS(EINIT). ENCLS invokes privileged functions for managing (creation,
> initialization and swapping) and debugging enclaves.

> +#define ENCLS_FAULT_FLAG 0x40000000UL
> +#define ENCLS_FAULT_FLAG_ASM "$0x40000000"

Hmm... Why it can't have same name?

See, how _AC() macro is defined and being used.

> +#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)

If result of macro is assigned to some variable and (r) by some reason
is 32-bit type
and you compile as 64-bit object, compiler will warn here.
Please, check this is not the case in any of use of this macro.
Otherwise you need a type casting, like

foo = bar & (u32)~BAR;

(or using typeof() might work)

-- 
With Best Regards,
Andy Shevchenko
