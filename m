Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CFC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DA7208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA7208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJPICp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:02:45 -0400
Received: from ozlabs.org ([203.11.71.1]:43697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbeJPICo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:02:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Ywmn009Rz9s8F;
        Tue, 16 Oct 2018 11:15:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jannh@google.com, linux-mm@kvack.org, khalid.aziz@oracle.com,
        aarcange@redhat.com, fweimer@redhat.com, jhubbard@nvidia.com,
        willy@infradead.org, abdhalee@linux.vnet.ibm.com, joel@jms.id.au,
        keescook@chromium.org, jasone@google.com,
        davidtgoldblatt@gmail.com, trasz@freebsd.org, danielmicay@gmail.com
Subject: Re: [PATCH] selftests/vm: Add a test for MAP_FIXED_NOREPLACE
In-Reply-To: <20181015080724.GC18839@dhcp22.suse.cz>
References: <20181013133929.28653-1-mpe@ellerman.id.au> <20181015080724.GC18839@dhcp22.suse.cz>
Date:   Tue, 16 Oct 2018 11:15:04 +1100
Message-ID: <87va62lpbr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Sun 14-10-18 00:39:29, Michael Ellerman wrote:
>> Add a test for MAP_FIXED_NOREPLACE, based on some code originally by
>> Jann Horn. This would have caught the overlap bug reported by Daniel Micay.
>> 
>> I originally suggested to Michal that we create MAP_FIXED_NOREPLACE, but
>> instead of writing a selftest I spent my time bike-shedding whether it
>> should be called MAP_FIXED_SAFE/NOCLOBBER/WEAK/NEW .. mea culpa.
>
> You wer one of those to provide a useful feedback actually. So no reason
> to feel sorry. I should have been forced to write a test case instead.
> No idea why I haven't considered that myself actually. So I steal your
> culpa here.

Haha, plenty of culpa to go around :)

Yeah we should try to always have selftests for new flags and things
like this.

This one was a bit special because the original point of the new flag
was for the kernel to use internally, and we sort of forgot that we were
also adding a user-visible flag.

>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks for doing this!
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

cheers
