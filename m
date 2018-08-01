Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB875C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDAC208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDAC208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbeHAKhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:37:40 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:60989 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbeHAKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:37:40 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 1 Aug 2018 17:52:57 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 1 Aug 2018 17:52:56 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 1 Aug 2018 17:52:48 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org, mingo@kernel.org, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        len.brown@intel.com, glider@google.com, peter@hurleysoftware.com,
        aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Message-ID: <20180801085248.GA21343@X58A-UD3R>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
 <20180731043042.GJ24813@linux.vnet.ibm.com>
 <20180731092950.GB12241@X58A-UD3R>
 <878t5qabgx.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t5qabgx.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 01:43:10PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul.park@lge.com> writes:
> 
> > I think rcu list also works well. But I decided to use llist because
> > llist is simpler and has one less pointer.
> >
> > Just to be sure, let me explain my use case more:
> >
> >    1. Introduced a global list where single linked list is sufficient.
> >    2. All operations I need is to add items and traverse the list.
> >    3. Ensure the operations always happen within irq-disabled section.
> >    4. I'm considering CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG properly.
> >    5. The list can be accessed by every CPU concurrently.
> >
> 
> Can you provide more information about where is your use case?  Is it a
> kernel driver?  Then it is better to submit the patch together with its
> user.
> 
> And I have the similar concern as Steven Rostedt.  That is, if you are
> the only user forever, it's not necessary to change the common code.

I'm sorry the patch is too complicated and premature to share at the
moment so I don't know how to extract only what you're asking me for.

Thanks anyway. The common code doesn't have to be changed then.

> Best Regards,
> Huang, Ying
