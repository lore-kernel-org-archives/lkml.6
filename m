Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B019C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332EE27AF1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332EE27AF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeF2GKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:10:49 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42810 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeF2GKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:10:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1BF0660A0E28;
        Fri, 29 Jun 2018 08:10:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OPTQj9jdWP4S; Fri, 29 Jun 2018 08:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D319960A0738;
        Fri, 29 Jun 2018 08:10:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8gimCMr7EGBn; Fri, 29 Jun 2018 08:10:45 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B36D860A04C9;
        Fri, 29 Jun 2018 08:10:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Jefferson Carpenter <jeffersoncarpenter2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>
Subject: Re: Memory zeroed when made available to user process
Date:   Fri, 29 Jun 2018 08:10:45 +0200
Message-ID: <8169843.ZtXGbniY5N@blindfold>
In-Reply-To: <c1cda925-72bd-5937-a73d-617fd6f50c8e@gmail.com>
References: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com> <2634793.Cb5OrAPIO5@blindfold> <c1cda925-72bd-5937-a73d-617fd6f50c8e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 29. Juni 2018, 02:52:16 CEST schrieb Jefferson Carpenter:
> On 6/27/2018 1:18 PM, Richard Weinberger wrote:
> > Am Mittwoch, 27. Juni 2018, 15:12:48 CEST schrieb Michal Hocko:
> >> On Wed 27-06-18 13:29:05, Richard Weinberger wrote:
> >>> On Wed, Jun 27, 2018 at 11:34 AM, Jefferson Carpenter
> >>> <jeffersoncarpenter2@gmail.com> wrote:
> >>>> Is there a way for a user process to mark memory as 'sensitive' or
> >>>> 'non-sensitive' when it is allocated?  That could allow it not to have to be
> >>>> zeroed before being allocated to another process.
> >>>
> >>> Isn't this what we have Meltdown and Spectre for? ;-)
> >>>
> >>> No, memory from the kernel is always zeroed.
> >>> libc offers malloc() and calloc() for this purpose.
> 
> Interesting.  Let's say
> 
> Process 1:
> free(use_memory(malloc(1024)));
> 
> Then Process 2:
> malloc(1024);
> 
> The physical RAM used to service Process 2's malloc call has to be 
> zeroed to prevent it from leaking data from Process 1.  However, if 
> Process 1 could mark that memory as non-sensitive, then it would not 
> have to be zeroed, saving the time it takes to do that.  However, this 
> would require at least a bit per memory page, so maybe it's not worth it.

Is this really a measurable overhead on your system?
Do you have numbers?

Thanks,
//richard
