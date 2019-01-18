Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43734C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1BE20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NwdUTf7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfARQKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:10:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33722 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HZ9qWuMFoqsHC+kBQ6LZRGT7fQPeNSw5ZvnMf2yU0lo=; b=NwdUTf7PbwQo2Gt2vxydKLoPi
        J29G41OtRo5opF2t60wdpZyj1NIck2/XcPaHKVK2WrFcqbVdc4u5k5v9QFHAUk2/0Uxd+me6JaRcw
        2yXcLkYSwb9+AiODpbGRCu3Cgs5Ba2n63DUo4l92Ao8xMgjFXbtvOOJ5Cq4O3PjVFd5BA7UBX8s/V
        vXV+IXAh4V+DQeRzdbGn/m0I58KXanqglho2shPjC39uQwMi+FH7iZWIQbbDZzoKsXY7AT3bIouFg
        GZs2H/03C5UAt05K0R5Qb4zd5daRGyNz9UhmgLBIHW1R4DxWZUmrX4EhlybxA0E7uAGPBDTTpisDF
        79uCGZHyg==;
Received: from [89.200.44.227] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkWiJ-00043V-5Z; Fri, 18 Jan 2019 16:09:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EBF0983826; Fri, 18 Jan 2019 17:03:12 +0100 (CET)
Date:   Fri, 18 Jan 2019 17:03:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/5] sched refcount_t conversions
Message-ID: <20190118160312.GF14054@worktop.programming.kicks-ass.net>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:27:25PM +0200, Elena Reshetova wrote:
> Elena Reshetova (5):
>   sched: convert sighand_struct.count to refcount_t
>   sched: convert signal_struct.sigcnt to refcount_t

These should really be seen by Oleg (bounced) and I'll await his reply.

>   sched: convert numa_group.refcount to refcount_t
>   sched/task_struct: convert task_struct.usage to refcount_t
>   sched/task_struct: convert task_struct.stack_refcount to refcount_t

Those are ok and I'll queue them.
