Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D9CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829F3208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829F3208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeGaHE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:04:27 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:50872 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726917AbeGaHE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:04:27 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 31 Jul 2018 14:25:58 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 31 Jul 2018 14:25:58 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 31 Jul 2018 14:25:51 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org, mingo@kernel.org, jiangshanlai@gmail.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, len.brown@intel.com, glider@google.com,
        peter@hurleysoftware.com, aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Message-ID: <20180731052551.GA12241@X58A-UD3R>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
 <87d0v4mbgx.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0v4mbgx.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:37:50AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul.park@lge.com> writes:
> 
> > Hello folks,
> >
> > I'm careful in saying.. and curious about..
> >
> > In restrictive cases like only addtions happen but never deletion, can't
> > we safely traverse a llist? I believe llist can be more useful if we can
> > release the restriction. Can't we?
> >
> > If yes, we may add another function traversing starting from a head. Or
> > just use existing funtion with head->first.
> >
> > Thank a lot for your answers in advance :)
> 
> What's the use case?  I don't know how it is useful that items are never
> deleted from the llist.
> 
> Some other locks could be used to provide mutual exclusive between
> 
> - llist add, llist traverse

Hello Huang,

In my use case, I only do adding and traversing on a llist.

> 
> and
> 
> - llist delete

Of course, I will use a lock when deletion is needed.

So.. in the case only adding into and traversing a llist is needed,
can't we safely traverse a llist in the way I thought? Or am I missing
something?

Thank you.

> Is this your use case?
> 
> Best Regards,
> Huang, Ying
