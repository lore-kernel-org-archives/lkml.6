Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E398C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2D920652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMagU5l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2D920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeICRhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:37:17 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34084 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeICRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:37:17 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so549792qth.1;
        Mon, 03 Sep 2018 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0V8QSyYdOfMgk0Y9vKYq1VwhAn8liy3cgF2o+j1qY4=;
        b=NMagU5l5FeIb20QqL7sjZaUsrBh90d68EAVUDF8mbZABEMAuHol5LbEntpBozhhUVx
         sFMfmEfzHGwteCuu7So5bLeDzm4dbdxrYG4ULkT1P+YP0ckBz5FU11ASZJEy4v6JbD2T
         YfGsWYrz/j1UkX6Tcm2yjweFkCs+EHdrdxYt6jUKIvoNx94TGC6bd9i0aSFxjc1Aq8G+
         KUrGzI3FBALxHbZ8KAQcv8t59u/kstdEgENSdtXpmoBAT677d5QH6KPAtjyQFHx/m/h0
         dIM/+gjQS71rQCLYc9RqkpahDAlnwNTBpQ9ydqTUJQXXKo+T7znhtRCVtsn8tgpcwR54
         ZHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0V8QSyYdOfMgk0Y9vKYq1VwhAn8liy3cgF2o+j1qY4=;
        b=T6IFdwawhv7UUmtvqpmkCnNJS4fJn9x1ZNt1fKFOCEvB59ijM+SopiS3mDprAokrIn
         cD4KY6aqYSknoxbZXX83seXV8ufZO5jDlX+X/vpsTZgm5Pia5IXGflWPnhUnW0Yr8vVY
         egSBOFgnk+FqGp+kL2Oj4aGdeBnDNPuBhYT95lHphsQxxNx7E5rzBwCIvRGKvschvXnN
         ZI8FO4m883rQPMPxBG6a55SuGj3PD1NWCiCzRTyHHK1Z1v3emfuC8KNAQ2eXk7mQ/1fe
         HMOxnHBGTImeHPPlB89Nl6nmTi2MmReQtsbIQg7dJysBoyYKSnB4hQiGtgZvUfR3eHJ0
         /I8w==
X-Gm-Message-State: APzg51CYhBbnKZX/VpHnrbfMRK28sgjoIS2E0cghmRxJawhnvAWmIrAs
        5BRuCZqvFHVq6NItJ4GHLiZjxfnU1QI0h1DEHAs=
X-Google-Smtp-Source: ANB0VdYI3cNmovU4KfJUOz0oiZ4yQrODmVcd7PKMaH0+N7ktQ9Xj3fd86T3SBaFHIM/JkRSoJ4ijHGT98S1zMU3KUwE=
X-Received: by 2002:ac8:16ec:: with SMTP id y41-v6mr26840545qtk.187.1535980628651;
 Mon, 03 Sep 2018 06:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-5-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-5-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Sep 2018 16:16:42 +0300
Message-ID: <CAHp75VchsQXGRrcrcB06w68PzUZb5NJLo2B_ZKf6ZLqyBbvWhA@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] x86/sgx: Architectural structures
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:57 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Add arch/x86/include/asm/sgx_arch.h, which contains definitions for the
> architectural data structures used by the CPU to implement the SGX.

> +/**
> + * enum sgx_encls_leaves - ENCLS leaf functions
> + * %ECREATE:   Create an enclave.
> + * %EADD:      Add a page to an enclave.
> + * %EINIT:     Launch an enclave.
> + * %EREMOVE:   Remove a page from an enclave.
> + * %EDBGRD:    Read a word from an enclve (peek).
> + * %EDBGWR:    Write a word to an enclave (poke).
> + * %EEXTEND:   Measure 256 bytes of an added enclave page.
> + * %ELDB:      Load a swapped page in blocked state.
> + * %ELDU:      Load a swapped page in unblocked state.
> + * %EBLOCK:    Change page state to blocked i.e. entering hardware threads
> + *             cannot access it and create new TLB entries.
> + * %EPA:       Create a Version Array (VA) page used to store isvsvn number
> + *             for a swapped EPC page.
> + * %EWB:       Swap an enclave page to the regular memory. Checks that all
> + *             threads have exited that were in the previous shoot-down
> + *             sequence.
> + * %ETRACK:    Start a new shoot down sequence. Used to together with EBLOCK
> + *             to make sure that a page is safe to swap.
> + */
> +enum sgx_encls_leaves {
> +       ECREATE = 0x0,
> +       EADD    = 0x1,
> +       EINIT   = 0x2,
> +       EREMOVE = 0x3,
> +       EDGBRD  = 0x4,
> +       EDGBWR  = 0x5,
> +       EEXTEND = 0x6,
> +       ELDB    = 0x7,
> +       ELDU    = 0x8,
> +       EBLOCK  = 0x9,
> +       EPA     = 0xA,
> +       EWB     = 0xB,
> +       ETRACK  = 0xC,
> +       EAUG    = 0xD,
> +       EMODPR  = 0xE,
> +       EMODT   = 0xF,
> +};

Hmm... This E prefix confuses me with (system wide) error codes. Has
it been discussed before? If so, can you point on the conclusion why
the current format is good?

> +enum sgx_miscselect {
> +       SGX_MISC_EXINFO         = 0x01,
> +};
> +
> +#define SGX_MISC_RESERVED_MASK 0xFFFFFFFFFFFFFFFEULL

Any idea why we are not using BIT_ULL() / BIT() and GENMASK_ULL() /
GENMASK() in the code?

> +enum sgx_attribute {
> +       SGX_ATTR_DEBUG          = 0x02,
> +       SGX_ATTR_MODE64BIT      = 0x04,
> +       SGX_ATTR_PROVISIONKEY   = 0x10,
> +       SGX_ATTR_EINITTOKENKEY  = 0x20,
> +};
> +
> +#define SGX_ATTR_RESERVED_MASK 0xFFFFFFFFFFFFFFC9ULL

Some times listing explicitly not-reserved bits might be better and
figuring out reserved mask is a simple ~ operation.

> +enum sgx_tcs_flags {
> +       SGX_TCS_DBGOPTIN        = 0x01,
> +};
> +
> +#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEULL

> +#define SGX_SECINFO_PERMISSION_MASK    0x0000000000000007ULL
> +#define SGX_SECINFO_PAGE_TYPE_MASK     0x000000000000FF00ULL
> +#define SGX_SECINFO_RESERVED_MASK      0xFFFFFFFFFFFF00F8ULL

So, something like

MASK1 GENMASK_ULL
MASK2 GENMASK_ULL
MASK3 ~(MASK1  | MASK2)

?

-- 
With Best Regards,
Andy Shevchenko
