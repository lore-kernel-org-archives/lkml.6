Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979DFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D76620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FLXl+biI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bufX6o3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D76620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeKGGrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:47:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49252 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeKGGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:47:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B9D36085F; Tue,  6 Nov 2018 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541539236;
        bh=v+JzbERcHzgwYhyMSXAvsfQFTZwk7pUD5I6M05tTOYI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FLXl+biIvcwR9KPjgxv9Y1JFlsNNU5ifDKWlW/klE9+26D0TdHFurJPdliYAHV80f
         dM6/6//Ik0f87YtOSw/YZ17Wy/nQ96d66onhNsUfeimb8Tqpku3hSba9+5sU0uK62f
         CQi6ijE8Edj/VC/83cfTVxbngB0+lOj68CzkpRps=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8234B601DA;
        Tue,  6 Nov 2018 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541539235;
        bh=v+JzbERcHzgwYhyMSXAvsfQFTZwk7pUD5I6M05tTOYI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bufX6o3/ImTC5oBYM2Mtf281aKyf4rDVe7VNA58avYarjm5XgNYzQOgoVNBXJ6e/u
         aR2eO9/ivBY5+TXheC0dl8Mdk7ZQ2acyEtDZ6CjzOluav7AoZXJ803EvVGLSAXo0eA
         Otgi9yrtXxnj2IKYv9/0gp+gNCsRjzXrkFCh2u5M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8234B601DA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 6 Nov 2018 13:20:33 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     John Stultz <john.stultz@linaro.org>
cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Todd Kjos <tkjos@android.com>,
        Arve Hjonnevag <arve@android.com>,
        linaro-mm-sig@lists.linaro.org,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>
Subject: Re: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <CALAqxLXzVna9BG8OJhTtTjcSiy4VbJ27nBOv4fKXoMnzc4xBgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1811061314240.16463@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com> <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com> <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com> <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <CALAqxLXzVna9BG8OJhTtTjcSiy4VbJ27nBOv4fKXoMnzc4xBgw@mail.gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, John Stultz wrote:

> On Thu, Nov 1, 2018 at 3:15 PM, Liam Mark <lmark@codeaurora.org> wrote:
> > Based on the suggestions from Laura I created a first draft for a change
> > which will attempt to ensure that uncached mappings are only applied to
> > ION memory who's cache lines have been cleaned.
> > It does this by providing cached mappings (for uncached ION allocations)
> > until the ION buffer is dma mapped and successfully cleaned, then it drops
> > the userspace mappings and when pages are accessed they are faulted back
> > in and uncached mappings are created.
> >
> > This change has the following potential disadvantages:
> > - It assumes that userpace clients won't attempt to access the buffer
> > while it is being mapped as we are removing the userpspace mappings at
> > this point (though it is okay for them to have it mapped)
> > - It assumes that kernel clients won't hold a kernel mapping to the buffer
> > (ie dma_buf_kmap) while it is being dma-mapped. What should we do if there
> > is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> > - There may be a performance penalty as a result of having to fault in the
> > pages after removing the userspace mappings.
> >
> > It passes basic testing involving reading writing and reading from
> > uncached system heap allocations before and after dma mapping.
> >
> > Please let me know if this is heading in the right direction and if there
> > are any concerns.
> >
> > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> 
> 
> Thanks for sending this out! I gave this a whirl on my HiKey960. Seems
> to work ok, but I'm not sure if the board's usage benefits much from
> your changes.
> 

Thanks for testing this.
I didn't expect this patch to improve performance but I was worried it
might hurt performance.

I don't know how many uncached ION allocations Hikey960 makes, or how it
uses uncached allocations.

It is possible that Hikey960 doesn't make much usage of uncached buffers,
or if it does it may not attempt to mmap them before dma mapping them,
so it is possible this change isn't getting exercised very much in the
test you ran.

I will need to look into how best to exercise this patch on Hikey960.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
