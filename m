Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2863C65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830A52147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830A52147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJFTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:13:27 -0400
Received: from ozlabs.org ([203.11.71.1]:59651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbeJFTN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:13:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42S56l6S2Gz9s1x;
        Sat,  6 Oct 2018 22:10:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: linux-next: build failure after merge of the akpm tree
In-Reply-To: <20181005224606.2372fece@canb.auug.org.au>
References: <20181005161406.73ef8727@canb.auug.org.au> <87d0sok3dm.fsf@concordia.ellerman.id.au> <20181005224606.2372fece@canb.auug.org.au>
Date:   Sat, 06 Oct 2018 22:10:23 +1000
Message-ID: <874ldzjmxc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi Michael,
>
> On Fri, 05 Oct 2018 22:02:45 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Ah fudge, what are the chances we add a new include of bootmem.h just as
>> Mike's removing bootmem.
>
> In my experience, it was almost certain ... almost every API removal
> conflicts with new added uses.  :-)

I suppose. Though the last time we added a new include of bootmem.h was
2015, and that should have actually been memblock.h.

>> I could just apply that to my tree. memblock.h is where early_memtest() is
>> actually defined anyway.
>
> However min_low_pfn and max_low_pfn are defined in bootmem.h until
> after it is removed.

OK. I guess I'll leave it for Andrew to squash in to the series.

cheers
