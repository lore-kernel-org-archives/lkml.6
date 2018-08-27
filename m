Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892E72084A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqo9Vhex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892E72084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeH0IaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 04:30:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44332 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0IaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 04:30:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so3576351plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9zs9GxhW1Rxy2KhsA14hqezNZbyMTJWiNJnnCu/aCc=;
        b=Iqo9VhexSFlBn7u0VqzVLQ+TeqdHFHUzml8YgcC586qDK7YwpCspSIfZP7pqpOjKes
         5NskrSSrdKJM8xYCffTVZlhEMgYKNo37A5Wmw7Ues17SeNmGPQfEjyZvP3sQvN3fybeY
         BCbbQbzrOCXGDV3ZFpGxCWhjHPQtqZhC6bNT7iUhLyXMk4OLeaosy6GAwRU8ba+ceErc
         SZ2EAERrBwaMNaT5T2CkrRdrKHIV3fc0Sj32jlP370b3m2ejqxBb3LResbaaWJcdeFSO
         o2m33onP5UAITp68q61Cd4/cGBmK1/a3YukTLgTKSkVJkv0QU7bMp34mMWTLzgQ4d1WW
         ainA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9zs9GxhW1Rxy2KhsA14hqezNZbyMTJWiNJnnCu/aCc=;
        b=fXgP/gy/Za7G51sGGFvCFTrJwPrZv6wAdkjuNmZjgsNEfeZ6oHPN4jAWfT9quPFoS6
         Ij/dKZ245ecevWGJ6HoL7YIRWrm3TVZrIujsXZKE0htFy9MBDp4l5AqqdAGc35VCkxSd
         OScK7ZLF0HbBNChrfy9S4O+i5Ok0p+bUZbqL3VRQkKRY4t009YW3BB3PFnuWXHMpTq25
         M2mk+0EOjeWRinhPqkUcukrT4IZQxJspm1ZR9zCbtupWakR3x/fYgzH6jZvUDDg4GrLh
         xw/RoP7HeqqYCYaMb81tT9+f2OIfq8c5hx8SVVlKd37c5IwLdnXkOj4j1ypeRMaCEkul
         sXqg==
X-Gm-Message-State: APzg51DeFSfBKcmzuavnj7+JSWFkp98eNuZ7yPS8mrCPHa02ejgvZi8N
        4kc5T/YV3mH/cimmdTnUqyU=
X-Google-Smtp-Source: ANB0VdbEYsTfX2rZtJUAgz5TZbRCOrp4KxCl2Pyo43gJ24sh9O8M2fvBFexXr7Kudz7xwUnEjLEmLw==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3-v6mr11405869plk.246.1535345107095;
        Sun, 26 Aug 2018 21:45:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id e131-v6sm19420180pfg.152.2018.08.26.21.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 21:45:06 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:44:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 08/11] asm-generic/tlb: Track freeing of page-table
 directories in struct mmu_gather
Message-ID: <20180827144457.3f4036e3@roar.ozlabs.ibm.com>
In-Reply-To: <1535125966-7666-9-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
        <1535125966-7666-9-git-send-email-will.deacon@arm.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 16:52:43 +0100
Will Deacon <will.deacon@arm.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Some architectures require different TLB invalidation instructions
> depending on whether it is only the last-level of page table being
> changed, or whether there are also changes to the intermediate
> (directory) entries higher up the tree.
> 
> Add a new bit to the flags bitfield in struct mmu_gather so that the
> architecture code can operate accordingly if it's the intermediate
> levels being invalidated.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

powerpc should be able to move right over to using this rather
than keeping the bit in need_flush_all.

powerpc may be able to use the unmap granule thing to improve
its page size dependent flushes, but it might prefer to go
a different way and track start-end for different page sizes.
I wonder how much of that stuff should go into generic code,
and whether it should instead go into a struct arch_mmu_gather.

Thanks,
Nick
