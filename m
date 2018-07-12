Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05501ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F6B208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F6B208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbeGLT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:28:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbeGLT2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:28:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3684AD90;
        Thu, 12 Jul 2018 19:17:59 +0000 (UTC)
Date:   Thu, 12 Jul 2018 12:17:53 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: waitqueue lockdep annotation V3
Message-ID: <20180712191753.fvk2qersdvhcoqzp@linux-r8p5>
References: <20171214152344.6880-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171214152344.6880-1-hch@lst.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2017, Christoph Hellwig wrote:

>Hi all,
>
>this series adds a strategic lockdep_assert_held to __wake_up_common
>to ensure callers really do hold the wait_queue_head lock when calling
>the unlocked wake_up variants.  It turns out epoll did not do this
>for a fairly common path (hit all the time by systemd during bootup),
>so the second patch fixed this instance as well.

I ran into these changes because of patch 1 getting rid of ep->lock. Is
there any reason why this series was never picked up?

Thanks,
Davidlohr
