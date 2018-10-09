Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A58DC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20934214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="riVlM849"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20934214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeJJFVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:21:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46317 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJFVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:21:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so1463763pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RY/1y0qF+ooxTkI2Ud710WZXEykzGF+8FFJR/0EVVlM=;
        b=riVlM849tHJ9aNkwmC/STFRvvd28hrwDuvDiPNAPCEdivVNe0cfhMonVUWrTjMiOfh
         00QMj7knctpBm1knrX8dxRrpR9lwcHWAHVM3h8n6yBQR+hsLn1p8QGGGQ/2sRbnNlh5D
         wZL/FcnuGpmYMT2tjYESDTeu4KvWEJL+9FGLj5NgeBkgCpTxsfAxeYokOlj+8pabLb1g
         QygnJyVbYVH+7QUTDsfUM/Tk6GcdwD9x1CP7iKS9v6xgJKUO4To+6jbgqZeFnvClYjQx
         63idfcSA9oOinBhH/OzbdxePe0FxTSIsr7DiB1Vq2lxU0AuFGiJ4Eq+zSeXkPdQffhYD
         0m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RY/1y0qF+ooxTkI2Ud710WZXEykzGF+8FFJR/0EVVlM=;
        b=qsl222uw7+HwjGksqWUIYQBJX83t5zKMj5LpacgaNqcg0URqFU7QpQeJiEBPo7rBWl
         QlUJmj6Btw2PEUVHW4gsD2GGdiewW1LaM6rrHJKf7C+8EIc40gIXxG9RWmvvjoP0cfwr
         WyE1XkP3VGP7iZWM6Oro1oIu3nx1q7QVU78QJat62flqf8fFRDS4dPyrkHngMONvULit
         LSTIHyH5l07459DX3SErVfpH4fNuU0hnOkU3siXMUNAqduAylBF563cx4i6ILSRKoKW7
         uM97fAgIKvGbHbE4c8elsh2Gcc2gDlRy0reU+MCO7+Jdv/NT6SK/mumOutdn/1oHC/YX
         3Fsw==
X-Gm-Message-State: ABuFfogsO7zS6HX30UY5Np0OG8lSWbZ/orGWT+yxHnD1v6VucN26rhx3
        eqfgaAxH5iGSA0UEDYNs2PEwHw==
X-Google-Smtp-Source: ACcGV61TSg9WC+OUJ5wV4aaSEktq8h16+fcjulxiu2BIZ/3Gp5v3c69e7A0kHtA/g8Om++HZdfu70g==
X-Received: by 2002:a63:b04f:: with SMTP id z15-v6mr25639953pgo.442.1539122548516;
        Tue, 09 Oct 2018 15:02:28 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id s13-v6sm29358232pfj.105.2018.10.09.15.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 15:02:27 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8EF8030002C; Wed, 10 Oct 2018 01:02:22 +0300 (+03)
Date:   Wed, 10 Oct 2018 01:02:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
References: <20181009201400.168705-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009201400.168705-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 01:14:00PM -0700, Joel Fernandes (Google) wrote:
> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
> 
> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> completion times drops from 160-250 millesconds to 380-400 microseconds.
> 
> Before:
> Total mremap time for 1GB data: 242321014 nanoseconds.
> Total mremap time for 1GB data: 196842467 nanoseconds.
> Total mremap time for 1GB data: 167051162 nanoseconds.
> 
> After:
> Total mremap time for 1GB data: 385781 nanoseconds.
> Total mremap time for 1GB data: 388959 nanoseconds.
> Total mremap time for 1GB data: 402813 nanoseconds.
> 
> Incase THP is enabled, the optimization is skipped. I also flush the
> tlb every time we do this optimization since I couldn't find a way to
> determine if the low-level PTEs are dirty. It is seen that the cost of
> doing so is not much compared the improvement, on both x86-64 and arm64.

Okay. That's interesting.

It makes me wounder why do we pass virtual address to pte_alloc() (and
pte_alloc_one() inside).

If an arch has real requirement to tight a page table to a virtual address
than the optimization cannot be used as it is. Per-arch should be fine
for this case, I guess.

If nobody uses the address we should just drop the argument as a
preparation to the patch.

Anyway, I think the optimization requires some groundwork before it can be
accepted. At least some explanation why it is safe to move page table from
one spot in virtual address space to another.

-- 
 Kirill A. Shutemov
