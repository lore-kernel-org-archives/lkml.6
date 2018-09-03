Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CD9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E8920868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5aoeOv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E8920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeICTCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:02:34 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44299 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeICTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:02:33 -0400
Received: by mail-qt0-f181.google.com with SMTP id k38-v6so780625qtk.11;
        Mon, 03 Sep 2018 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIJpQ2/7/Bxl3yv8ey/sS46SNy0nhZkBUnQ7/EnnyAA=;
        b=l5aoeOv7hVZ428cimtP4wyzFSPKN5WmYQ25s8FIkfd4xX+HA9T6DcDMOM96zoxbvHp
         Xbs6Vuy9UAe2SUCzac1VeoCFg67sxbvQ1PEmYGeCQdrXaha3wyXrCrbhcP2MgCLyLc0P
         9JwmaIe2PR0BpfNoBL5AQ25Qij7qQlicBIcPlRC1cMf0DJkZGCJne5C8SgggISDr4uH6
         DdOmZSOqjGOesqb/QrqnIJqhHTgD19rw8VsSJdYzhtjBazwwwSbcC9H16x9wxEzcMT5J
         ludlHePjCRHVJa1kpsxx2PfLzjecX2lxe8C6gt364F8lhWBV4NX3NYGvoRBvTrWuAi6O
         OSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIJpQ2/7/Bxl3yv8ey/sS46SNy0nhZkBUnQ7/EnnyAA=;
        b=JZgoilOO/pa27ciIEKRpk0+2Nr3qhs0ak6BeyYdNNy1FrrZ4pxlh87B1YLnkq5DLz+
         DlJUzTWccWzhm6pYptt+Q9HOT0FZQ0IeR+euC77UKyukjecRo7hbT75k4FnbYxV6+MYV
         21RGUxnguuhqa2jKxWnXKQd9gjEgf5JuDpLqanpAt5zvDIA1aW7+/gTYVElBCiKXfs/1
         xcpe5Kj8zj2MotWPX9ukZtJVV7R4D4LzaM4lcPpEx+7BwLAzV0iQc1tqltLySupMQRSF
         VUnPrSfHzINBS++7lyWglIqQXHVzYr5KrmxH7EvaXjzOp8CuhWeDi4YAif+AplwseQ87
         uT8Q==
X-Gm-Message-State: APzg51AWA9zXeU7tMlmVjZWb5xE1bPSJPgdR2xcjzrwsgo2AGbYEj962
        YyvAP+riBbsN6vTtS1i9iq03klaMt2DCPathC64=
X-Google-Smtp-Source: ANB0VdYWEj44kv/QEZozJCQ8pK5swwVTNCfjgsbD93SV2F8jinziA60FG/xxl81yOKVjliCtAMybnw8WdVH4UgMN05g=
X-Received: by 2002:a0c:e985:: with SMTP id z5-v6mr25946319qvn.136.1535985724616;
 Mon, 03 Sep 2018 07:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com> <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Sep 2018 17:41:53 +0300
Message-ID: <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Add data structures to track Enclave Page Cache (EPC) pages.  EPC is
> divided into multiple banks (1-N) of which addresses and sizes can be
> enumerated with CPUID by the OS.
>
> On NUMA systems a node can have at most bank. A bank can be at most part of
> two nodes. SGX supports both nodes with a single memory controller and also
> sub-cluster nodes with severals memory controllers on a single die.

> -#include <asm/sgx.h>
> -#include <asm/sgx_pr.h>
>  #include <linux/freezer.h>
>  #include <linux/highmem.h>
>  #include <linux/kthread.h>
> +#include <linux/pagemap.h>
>  #include <linux/ratelimit.h>
>  #include <linux/sched/signal.h>
> +#include <linux/shmem_fs.h>
>  #include <linux/slab.h>
> +#include <asm/sgx.h>
> +#include <asm/sgx_pr.h>

Squash issues?

> +       va = ioremap_cache(addr, size);
> +       if (!va)
> +               return -ENOMEM;

I'm not sure this is a right API. Do we operate with memory? Does it
have I/O side effects?
If no, memremap() would be better to use.

-- 
With Best Regards,
Andy Shevchenko
