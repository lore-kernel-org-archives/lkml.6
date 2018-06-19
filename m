Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E299620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E299620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938017AbeFSNMb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937989AbeFSNM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:12:26 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95AC208A1;
        Tue, 19 Jun 2018 13:12:24 +0000 (UTC)
Date:   Tue, 19 Jun 2018 09:12:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH 2/2] rcutorture: Fix rcu_barrier successes counter
Message-ID: <20180619091223.702f05d6@gandalf.local.home>
In-Reply-To: <20180619073115.GA241700@joelaf.mtv.corp.google.com>
References: <20180619062215.221564-1-joel@joelfernandes.org>
        <20180619062215.221564-2-joel@joelfernandes.org>
        <20180619073115.GA241700@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 00:31:15 -0700
Joel Fernandes <joelaf@google.com> wrote:

> Hi Paul,
> Think some more about this counter, I think you mean 'successes' as in
> 'successful attempts' than 'successful test' ? If so, then perhaps you can
> drop this patch. It wasn't clear to me what the 'successes' meant so I may
> have been a bit misled into changing its meaning. If on the other hand, it
> means 'successful test', then yes this patch would be Ok then. thanks! -Joel
>  

In either case, it sounds like a comment should be added to clarify
what n_barrier_successes actually means ;-)

-- Steve
