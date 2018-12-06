Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B7CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142E20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544113744;
	bh=bGd4KhxCSa8pGVe5YJ9fBJ6q8AOdrQl3RWYTF7S5kIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MNBMyvR2qLSsG8hWdWIEf2QM1g+5MhUr/379bmrJZ4wJ6cwcJV7L3UUDVsARW1gLc
	 4HCfqBi3+T19QRN6U5VieVRAZfeGpxoaLjTkrkuV57GS4h//bxHhD9f4DLVijJLIzH
	 TjzNMgCggvHy4fQHPvnHJsctCOIY8pSC7JgZ9oTo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F142E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLFQ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:29:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:29:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so1692743wmd.2;
        Thu, 06 Dec 2018 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xec3AbRr1ewYH1eTRNN7gm8e8fciqeRvXelwkD9Wghk=;
        b=JJRgsAn4nIzv2GrnZSfxKeOfOg4wFt/aonskIS7bCRbaG4ODIpCdkjSVMSdLmSYCH1
         viBWw+Uq52N6CtKXPw6+zBQTL64EIOCIOgYpIxCyBiqcyq9qFtBKSRJOzPiv2vLAPjen
         IkWOhXeWUyGrBZ988n84ye+GcIpkTsbcEyoqLlMEj7rctcvDCzToubqSB2yp7q2HK4m7
         9QXTTE8zRa1X3axlxK5cyMiPEj3PN3KoryA27EzY5u3yW43dbGwMkh8kSrDt/0jKgTAf
         UQaZcWOt+BAdJk0U/2LGUIF7plP+tDRXa4amiiR2ck3jUuuj4VYpmiAcdW9O3Zlb3MkM
         pnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Xec3AbRr1ewYH1eTRNN7gm8e8fciqeRvXelwkD9Wghk=;
        b=GhZchcywbjr6lWXzS2HqHcwCgdjmuBn7hvOitigfo6cIzSk93lB4OPpTeFofBSKZW7
         BWykT7UlFKj8cVNAbtLrciToIb30wRDN1ap/muqMAWDMAqiKcNqSX4LuRDRSUnm71PLs
         eJ1vrPrNhlpB7ovn/dA/tg3hzd9dW2JdKeQyZIkRj3oLRK/RsupdcUlx0QYR40ZpSg6Y
         q4camhEm2WmjNIlb9BhoLv5eg6yDch87Lzpu9tfwuPaumo8DlNZlY0u8JTOZLKM7iFBC
         YVNUlhs7YLKCbCDf6WmAS+6oCFFw4GUsSk8LNhYq1oDECcHJS5OlKZ1XdVVjI4IsDqB0
         yRfA==
X-Gm-Message-State: AA+aEWZbG0PAqSCxRZB61oprxRtdVLf6SQXvMdHZzRlwenGT0otXg+L0
        lsRBjbzSNyupKJL8UneeCbw=
X-Google-Smtp-Source: AFSGD/UfNOSLjk5ZpLeUWpO0IgdYLw3Tivbmh8k3XJ4kNhvc6RFFR5MLAxzK2J0kQ93zvG7utfApwg==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr19618478wma.91.1544113740403;
        Thu, 06 Dec 2018 08:29:00 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 14sm1966746wmv.36.2018.12.06.08.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:28:59 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:28:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7 08/14] x86/ftrace: Use text_poke_*() infrastructure
Message-ID: <20181206162857.GA119243@gmail.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-9-namit@vmware.com>
 <25B84F01-DB4C-4957-9703-769CCC9794BB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25B84F01-DB4C-4957-9703-769CCC9794BB@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> > On Dec 4, 2018, at 5:34 PM, Nadav Amit <namit@vmware.com> wrote:
> > 
> > A following patch is going to make module allocated memory
> > non-executable. This requires to modify ftrace and make the memory
> > executable again after it is configured.
> > 
> > In addition, this patch makes ftrace use the general text poking
> > infrastructure instead ftrace's homegrown text patching. This provides
> > the advantages of having slightly "safer" code patching and avoiding
> > races with module removal or other mechanisms that patch the kernel
> > code.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > ---
> > arch/x86/kernel/ftrace.c | 74 +++++++++++++---------------------------
> > 1 file changed, 23 insertions(+), 51 deletions(-)
> 
> Steven Rostedt pointed that using text_poke() instead of
> probe_kernel_write() would introduce considerable overheads. Running:
> 
>   # time { echo function > current_tracer; } 
> 
> takes 0.24s without this patch and 0.7s with. I don’t know whether to
> consider it “so bad”. Obviously we can introduce a batching mechanism and/or
> do some micro-optimization (the latter will not buy us much though).

This should definitely not regress, so can we try the batching approach?

Thanks,

	Ingo
