Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32C02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32C02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbeGQOy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:54:59 -0400
Received: from verein.lst.de ([213.95.11.211]:51658 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbeGQOy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:54:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BD5596FC87; Tue, 17 Jul 2018 16:24:37 +0200 (CEST)
Date:   Tue, 17 Jul 2018 16:24:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: waitqueue lockdep annotation V3
Message-ID: <20180717142437.GA20286@lst.de>
References: <20171214152344.6880-1-hch@lst.de> <20180712191753.fvk2qersdvhcoqzp@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712191753.fvk2qersdvhcoqzp@linux-r8p5>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:17:53PM -0700, Davidlohr Bueso wrote:
> On Thu, 14 Dec 2017, Christoph Hellwig wrote:
>
>> Hi all,
>>
>> this series adds a strategic lockdep_assert_held to __wake_up_common
>> to ensure callers really do hold the wait_queue_head lock when calling
>> the unlocked wake_up variants.  It turns out epoll did not do this
>> for a fairly common path (hit all the time by systemd during bootup),
>> so the second patch fixed this instance as well.
>
> I ran into these changes because of patch 1 getting rid of ep->lock. Is
> there any reason why this series was never picked up?

I'd love to see this merged, but I never heard back about it.
