Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4CFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EAC2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdvJ6Pm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EAC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHaF2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:28:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHaF2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:28:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so4695065pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymVZdzsBc8ZLszmRk3skB4yM5dMs/LK8AwHiU42zu/4=;
        b=SdvJ6Pm5fBG2KMXR5QgRB2HHT85Ytnev0N7SdEW45K7JLukNn7M3ZpUTJRFczsXJw4
         cbYhU4vkXQaLB1sox3jCI4jf9LgG1wpm1/n8vsLXd1gGG/MbETvfmH1Q44nb9xNhgCXJ
         6MjdsRXzTZdvkfFg4sVXME06PVLyogzQ3MmfR9yiTh7i+SSHjp+6gF6aSwaiQTHTfEh7
         05S9nf/ag32WVXXJkn8s9Wl0KeLrPBjj7PlFTQ/GFptNh7yejAdYsO/02NVaqocrcd5+
         BoJhi/t/0jd6atEIk9filoeEL/ebPxzqMVPbRjgZuJ5MIl4JEsLg2MMjtPoGJiJp8Imi
         bWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymVZdzsBc8ZLszmRk3skB4yM5dMs/LK8AwHiU42zu/4=;
        b=h9zs0DOVCaFy32s9hs7YGK23hwellyQbwn60wg3EH3TykjneS0VgRSPduXaaCseXx8
         xIyUKQ5wV9Nif4f6bdBzmI5D8tWf64gLiQ2Kh/5Yq9Odi1ohxua4D2Q4i7QWMuou5Lyy
         udbKP7YNpSwcVIpvGh3wgUTPpTm8YX/DSQn0z3RS+h045bxKkdZFoFBOJTPRDrG/4sZy
         qUufVlGybHHrAmsYggOG+OIXbbhoPmCx+tJK8CggQrcUAu7mHHlkzJmDqUnhgMY4bdaU
         DtXMmrJHPQsxWx5X+Gn3U9r1C+ZIZZarvJx3ENFASo8YxiJskhunZcE9y+L1l83t0uZc
         ADzw==
X-Gm-Message-State: APzg51D9LGj9SnwZQeJiBK7OkMxbgCVnzQHL/diPEy8c5F86f/m/NA9V
        B5X1MH9MMZFW70g87Yl5bqE=
X-Google-Smtp-Source: ANB0VdZiWgkuFZhOz+GVet9DWfAXNLB6YLI6gQ3RKinTg1x0CzBiyv5x/8JesSeQx+86WDFkYqRIRg==
X-Received: by 2002:a63:24c:: with SMTP id 73-v6mr12586397pgc.252.1535678635354;
        Thu, 30 Aug 2018 18:23:55 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id g15-v6sm15955586pfg.98.2018.08.30.18.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:23:54 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:23:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/12] asm-generic/tlb: Track which levels of the page
 tables have been cleared
Message-ID: <20180831112348.55d3d2ec@roar.ozlabs.ibm.com>
In-Reply-To: <1535645747-9823-10-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
        <1535645747-9823-10-git-send-email-will.deacon@arm.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 17:15:43 +0100
Will Deacon <will.deacon@arm.com> wrote:

> It is common for architectures with hugepage support to require only a
> single TLB invalidation operation per hugepage during unmap(), rather than
> iterating through the mapping at a PAGE_SIZE increment. Currently,
> however, the level in the page table where the unmap() operation occurs
> is not stored in the mmu_gather structure, therefore forcing
> architectures to issue additional TLB invalidation operations or to give
> up and over-invalidate by e.g. invalidating the entire TLB.
> 
> Ideally, we could add an interval rbtree to the mmu_gather structure,
> which would allow us to associate the correct mapping granule with the
> various sub-mappings within the range being invalidated. However, this
> is costly in terms of book-keeping and memory management, so instead we
> approximate by keeping track of the page table levels that are cleared
> and provide a means to query the smallest granule required for invalidation.

Actually the generic patches are pretty simple, and they look okay to
me. powerpc *should* be able to switch to Peter's patch with a few
lines of code with unchanged functionality as far as I can see.

These flags we may use as well, but even if not if x86 and arm64 are
using it, it seems reasonable to go in generic code for now. For the
3 generic patches,

Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
