Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE42C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC9C208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdOH/ZmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC9C208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbeHAUTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:19:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46054 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbeHAUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:19:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so9185801pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iVO74wCV0EWaGwHK362LJP9PGuz2nnGv1IDmpsU7ky0=;
        b=VdOH/ZmZTfj5hOGhhlnrJJx6fcRM20urlTukUW4NLlSK/Ab0DZFA2LMk2HlSt5/DpK
         EHpabzHQ4arIwj3BNxAe676TxnQ3r6ggOdM73bxo7OI6b5I0ukJfzBRy2ScSngprE4Ge
         Rrtv9G3vw2foFlqbD8Jr8W993yEF4d1at4TOUAtRSTdcJ7FCmabdBEfUZnGQjgNo4fPO
         typS8p+TObZHNmdCEnV1WOTyL2+4pBvcz63Gg299TLazCOoxbv/M+dTafA7PCvRxHZ0K
         PUOY1y1/jBfD1N1eFnRhCZ4Qac3d4UEYELkmed0Ud6K8U6Win6cdBtQ9BUVZgkqDBIQ9
         eyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iVO74wCV0EWaGwHK362LJP9PGuz2nnGv1IDmpsU7ky0=;
        b=c5brmgy1Avaw2KMorE78wAJU/6fLyvMLNY1nl+JaQmHQi9e5wlgNDcX0D3vcD25wCS
         n8ombLJKj6V37tkeY00ZSrgQ2603dxYJ8BIDIp1mnoYZhMF+fdWpnRSvnzEo7vBH/GNp
         0jLug1JOCnoG7cF/hTFKJbdeYWvG1OIksNvXN4PijUm/3E1gG2CrO6F3bQ1WHnFhK/Hx
         hUo7CTkndDMqt8l0PQl61vXNMmiV2u14cftnvDnIMwv1LNXGMOgQlPWoBBuRusZPs4Nb
         0sinh8SHgQeVy2ITebQ2s9UGXcxYqMN3OZ2jADZ4NZ30x9zCkO3r/9I3D27KovnofMPq
         xtBQ==
X-Gm-Message-State: AOUpUlEAJX4sPzW7KM8h/TI0uH/qBten3HsOptPx3b+qEIP0Xa400wXz
        cBoj4NF0Ine8UDkHBYJNj7Q+tw==
X-Google-Smtp-Source: AAOMgpc6iy0QNVFzUg3xJiy+vGs+Bv9c53UWo9tbHFJoWzz8ij3SruXoArWO/KM2nIHR3feY3UYmGA==
X-Received: by 2002:a17:902:1121:: with SMTP id d30-v6mr26186445pla.247.1533148322061;
        Wed, 01 Aug 2018 11:32:02 -0700 (PDT)
Received: from [100.112.75.99] ([104.133.8.99])
        by smtp.gmail.com with ESMTPSA id 77-v6sm22281821pga.40.2018.08.01.11.32.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 11:32:00 -0700 (PDT)
Date:   Wed, 1 Aug 2018 11:31:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Tony Luck <tony.luck@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Subject: Re: Linux 4.18-rc7
In-Reply-To: <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1808011042090.14313@eggly.anvils>
References: <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com> <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com> <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com> <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com> <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com> <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk> <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Linus Torvalds wrote:
> 
> Anyway, the upshot of all this is that I think I know what the ia64
> problem was, and John sent the patch for the ashmem case, and I'm
> going to hold off reverting that vma_is_anonymous() false-positives
> commit after all.

I'd better send deletion of zap_pmd_range()'s VM_BUG_ON_VMA(): below
(but I've no proprietorial interest, if you prefer to do your own).

John's patch is good, and originally I thought it was safe from that
VM_BUG_ON_VMA(), because the /dev/ashmem fd exposed to the user is
disconnected from the vm_file in the vma, and madvise(,,MADV_REMOVE)
insists on VM_SHARED. But afterwards read John's earlier mail,
drawing attention to the vfs_fallocate() in there: I may be wrong,
and I don't know if Android has THP in the config anyway, but it looks
to me like an unmap_mapping_range() from ashmem's vfs_fallocate()
could hit precisely the VM_BUG_ON_VMA(), once it's vma_is_anonymous().

(I'm not familiar with ashmem, and I certainly don't understand the
role of MAP_PRIVATE ashmem mappings - hole-punch's zap_pte_range()
should end up leaving any anon pages in place; but the presence of
the BUG is requiring us all to understand too much too quickly.)


[PATCH] mm: delete historical BUG from zap_pmd_range()

Delete the old VM_BUG_ON_VMA() from zap_pmd_range(), which asserted
that mmap_sem must be held when splitting an "anonymous" vma there.
Whether that's still strictly true nowadays is not entirely clear,
but the danger of sometimes crashing on the BUG is now fairly clear.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/memory.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- 4.18-rc7/mm/memory.c	2018-06-16 18:48:22.041173422 -0700
+++ linux/mm/memory.c	2018-08-01 11:01:21.397286507 -0700
@@ -1417,11 +1417,9 @@ static inline unsigned long zap_pmd_rang
 	do {
 		next = pmd_addr_end(addr, end);
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
-				VM_BUG_ON_VMA(vma_is_anonymous(vma) &&
-				    !rwsem_is_locked(&tlb->mm->mmap_sem), vma);
+			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
-			} else if (zap_huge_pmd(tlb, vma, pmd, addr))
+			else if (zap_huge_pmd(tlb, vma, pmd, addr))
 				goto next;
 			/* fall through */
 		}
