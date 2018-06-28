Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C0D26E35
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C0D26E35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeF1FbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:31:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45196 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeF1FbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:31:19 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29056C3A;
        Thu, 28 Jun 2018 05:31:19 +0000 (UTC)
Date:   Wed, 27 Jun 2018 22:31:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang\, Ying" <ying.huang@intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one
 piece
Message-Id: <20180627223118.dd2f52d87f53e7e002ed0153@linux-foundation.org>
In-Reply-To: <87r2krfpi2.fsf@yhuang-dev.intel.com>
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
        <87r2krfpi2.fsf@yhuang-dev.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 13:29:09 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Fri, 22 Jun 2018 11:51:30 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> >
> >> This is the final step of THP (Transparent Huge Page) swap
> >> optimization.  After the first and second step, the splitting huge
> >> page is delayed from almost the first step of swapout to after swapout
> >> has been finished.  In this step, we avoid splitting THP for swapout
> >> and swapout/swapin the THP in one piece.
> >
> > It's a tremendously good performance improvement.  It's also a
> > tremendously large patchset :(
> >
> > And it depends upon your
> > mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch and
> > mm-fix-race-between-swapoff-and-mincore.patch, the first of which has
> > been floating about since February without adequate review.
> >
> > I'll give this patchset a spin in -mm to see what happens and will come
> > back later to take a closer look.  But the best I can do at this time
> > is to hopefully cc some possible reviewers :)
> 
> Thanks a lot for your help!  Hope more people can review it!

I took it out of -mm again, temporarily.  Due to a huge tangle with the
xarray conversions in linux-next.

