Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356EAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01D3208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns07fOg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01D3208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH0MkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:40:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42106 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:40:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so3869386plq.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWes9+yJLXyfzJUDs2NfoF21GwyqsRsJkXY5CoeM5XU=;
        b=Ns07fOg+HF/utfgtFo2+qmlRzkqRBUv8uUHcuWAfjT9RnZ0xRzkqCYr7o8ypqOyun2
         mEnchh6UNv7KLHFRLig2//vEuaTxZ57qvZEnXLsUrsK6ZuEaIgZ66VZxwuczYHuJh053
         4xlmwE/3avxdk0YVwRuSJKWtmMXVeX4MD868F7PD8eC4Mw6FtPGzQVkui0mf21RGQ+7Y
         N9AWyXgmcsqehOmd7ec3EQo/k2jg4KMO92RczPsi4HiN8eH/+SKIiFqWNMVEHj2jfK/R
         jUhvJHJaGXJLVuQ2fn6WWmJsV8uFZQcrLC1uueisbF9GOQ+HBuruFjyk8QXF1a4wo1hk
         QZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWes9+yJLXyfzJUDs2NfoF21GwyqsRsJkXY5CoeM5XU=;
        b=kiEA2JPHJLMOMqQFwNXmlDgM1rc72o1bFU1HRABT3Y11r1Eb9n2NrW0l4SSdPbrcT3
         1Lx5nwXMreH9PW1G26DquV4iVez1NgDn3ZdHxttuwNt6K3qJOtslst9L6BDkFvx/QXOd
         zD4oZzeMVR5VpGyD5VL0rpa6NizAyupxEYnv/QImQFmTnfICpOTXpZuJ5ry+n7oY7T8r
         uy6pbjNi3Plt8uCFN9kBY+yV6Vdpq5PCTsHx9i8rmQO4gDH4FukXl2HmV67Wu4Y7r4PJ
         YdRIrzzB9sB4WNeHWL9duHsX+4x9Y2cHPGjF8WTbfnjBI08QrQPklYQ/av++xe1TePkU
         zZ8Q==
X-Gm-Message-State: APzg51CE1z5znXIr+/rRoJcC4Mn3thpuhyv9YcmPsnC3kZ5epbSxo8tz
        9qntKuwW0ty+CXvf679px9M=
X-Google-Smtp-Source: ANB0VdYlD2M+TAEHeFKMNWYxGxU6yfuJn8oHVgbPDqO2tQHUY0GARGXDxdWvLMkHRMfCQD7KGjLMiw==
X-Received: by 2002:a17:902:7884:: with SMTP id q4-v6mr12142747pll.174.1535360055707;
        Mon, 27 Aug 2018 01:54:15 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id x23-v6sm19691368pff.9.2018.08.27.01.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 01:54:15 -0700 (PDT)
Date:   Mon, 27 Aug 2018 18:54:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180827185403.7b46fae4@roar.ozlabs.ibm.com>
In-Reply-To: <20180827082045.GA24124@hirez.programming.kicks-ass.net>
References: <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
        <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
        <20180823133958.GA1496@brain-police>
        <20180824084717.GK24124@hirez.programming.kicks-ass.net>
        <20180824113214.GK24142@hirez.programming.kicks-ass.net>
        <20180824113953.GL24142@hirez.programming.kicks-ass.net>
        <20180827150008.13bce08f@roar.ozlabs.ibm.com>
        <20180827074701.GW24124@hirez.programming.kicks-ass.net>
        <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
        <4ef8a2aa44db971340b0bcc4f73d639455dd4282.camel@kernel.crashing.org>
        <20180827082045.GA24124@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 10:20:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 27, 2018 at 06:09:50PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Sadly our architecture requires a precise match between the page size
> > specified in the tlbie instruction and the entry in the TLB or it won't
> > be flushed.  
> 
> Argh.. OK I see. That is rather unfortunate and does seem to require
> something along the lines of tlb_remove_check_page_size_change().

Or we can do better with some more of our own data in mmu_gather,
but things that probably few or no other architectures want. I've
held off trying to put any crap in generic code because there's
other lower hanging fruit still, but I'd really rather just give
archs the ability to put their own data in there. I don't really
see a downside to it (divergence of course, but the existing
proliferation of code is much harder to follow than some data that
would be maintained and used purely by the arch, and beats having
to implement entirely your own mmu_gather).

Thanks,
Nick
