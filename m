Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533CD208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I28S2mks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533CD208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeHWHoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 03:44:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33936 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeHWHoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 03:44:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id u10-v6so193980pgr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LuNhplokyBQiUI1quGe5jRuLsqXcMx56VDItjcDHgs=;
        b=I28S2mks+vxQouQnYXZtRoy6Kqi+xgIvHVB/7KHQnOVhUobWB3noEkIygMjrrpTotY
         3CsrUViwocxkpWv8U//d6WVn8SQjbu2ISOBnpMibfcAnXJBHA9Rnu9nuCc7Gof7sNmCA
         sY09TMCIy4s+bKg2PsC9CDqU/jgh1YQNbKrsNv7+s+s2v3HHL+s+PXhD8HDHxV8GCyGi
         uMihXdlOYDGN69DD+LuYYnnQMnMqP9HNZ0llcl2PnXdoayMm7IqA71t++PTLj9jsYMTr
         oxWSeDAvDqZz2m8gDfopBVN70V/6krqdLV8fb/FE5Qg5S4QdpBlwo96n/COBhQ75DR7H
         ZW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LuNhplokyBQiUI1quGe5jRuLsqXcMx56VDItjcDHgs=;
        b=cEx4/hWvInsrmh4yAWPc5zHapmf9o4zLQQ5cvmMrWzOumX45AsLh8XzBo6X/+leEQ7
         TxfadOGZvXr1s32Kbj+1xIbv5F/QTqiBN44a72Qf2Et0r76+O1RWngILQhyLR9hhSnXA
         C56XZsaWjB50jzxZZOUWPVC3s9D5apD9uGktr0/RIhHAwOmQcHcJqC6Z/qxz10l5s5N3
         +QbZgh6yFaTtJ2XOHse3qe8M/v5MbDatcDFhmOEzd1Mb3KkWRgCnr5E59xR0/iFLxOl4
         SUGBA2GEqFz0cZWhaChNDyCvYEMHZmR6GP95wHp7doKl0sNGcVAp8NU3X7OpnpNoA5zN
         E4qA==
X-Gm-Message-State: AOUpUlGZmWia1yMlUCiTY9eiq/HhFtL0cbID9aYXw4V0BtZUdDqxmVJq
        CBunr7pqwa8ZvzHvLs1dC8A=
X-Google-Smtp-Source: AA+uWPwWdlvpLwBSHNK4OMQBsfV/p43A00L90+eA7Fv3qPbpj4yjtsbGhEJTs7aphb7x91ES4uKajQ==
X-Received: by 2002:a63:d56:: with SMTP id 22-v6mr23585354pgn.107.1534997810784;
        Wed, 22 Aug 2018 21:16:50 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id x65-v6sm4463912pfk.140.2018.08.22.21.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 21:16:50 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:16:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent
 condition
Message-ID: <20180823141642.38b53175@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.772017055@infradead.org>
        <20180823133103.30d6a16b@roar.ozlabs.ibm.com>
        <CA+55aFyY4fG8Hhds4ykSm5vUMdxbLdB7mYmC2pOPk8UKBXtpjA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 20:35:16 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 22, 2018 at 8:31 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> >
> > So that leaves speculative operations. I don't see where the problem is
> > with those either -- this shortcut needs to ensure there are no other
> > *non speculative* operations. mm_users is correct for that.  
> 
> No. Because mm_users doesn't contain any lazy tlb users.
> 
> And yes, those lazy tlbs are all kernel threads, but they can still
> speculatively load user addresses.

So?

If the arch does not shoot those all down after the user page tables
are removed then it's buggy regardless of this short cut.

The only real problem I could see would be if a page walk cache still
points to the freed table, then the table gets re-allocated and used
elsewhere, and meanwhile a speculative access tries to load an entry
from the page that is an invalid form of page table that might cause
a machine check or something. That would be (u)arch specific, but if
that's what we're concerned with here it's a different issue and needs
to be documented as such.

I'll have a look at powerpc and see if we can cope with it. If so, I'll
make it an arch specific opt-in short cut.

Thanks,
Nick
