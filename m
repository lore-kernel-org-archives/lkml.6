Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA04C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6323F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6323F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeGaLRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:17:47 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:58969 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729987AbeGaLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:17:46 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 31 Jul 2018 18:38:16 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 31 Jul 2018 18:38:16 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 31 Jul 2018 18:38:09 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        ying.huang@intel.com, mingo@kernel.org, jiangshanlai@gmail.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, len.brown@intel.com, glider@google.com,
        peter@hurleysoftware.com, aik@ozlabs.ru
Subject: Re: [QUESTION] llist: Comment releasing 'must delete' restriction
 before traversing
Message-ID: <20180731093809.GC12241@X58A-UD3R>
References: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
 <20180731085257.GR2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731085257.GR2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:52:57AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 31, 2018 at 09:58:36AM +0900, Byungchul Park wrote:
> > In restrictive cases like only addtions happen but never deletion, can't
> > we safely traverse a llist? I believe llist can be more useful if we can
> > release the restriction. Can't we?
> 
> Yes you can, but I'm not sure it makes much sense to confuse the
> comments with this.
> 
> This really ends up in the 'you had better know what you're doing'
> category.

Partially agree with you. But why not add more explanation?

If you think the comment confuse us, then it's ok to keep it itself.

Thanks.
