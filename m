Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA61C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA9D20875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA9D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeFTQMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754113AbeFTQL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:11:59 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05FC020836;
        Wed, 20 Jun 2018 16:11:57 +0000 (UTC)
Date:   Wed, 20 Jun 2018 12:11:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on
 in_nmi()
Message-ID: <20180620121156.4da98db2@gandalf.local.home>
In-Reply-To: <20180620155658.GU3593@linux.vnet.ibm.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
        <20180620145058.GP3593@linux.vnet.ibm.com>
        <20180620114335.7a314642@gandalf.local.home>
        <20180620155658.GU3593@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 08:56:58 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> OK, so in theory this change is safe from a tracing perspective.  But
> it does add conditionals to a fastpath.

Does it?

I see it replacing two conditions from both rcu_irq_enter/exit() with a
single one in rcu_nmi_enter/exit(). Sure it adds one to rcu_nmi_enter()
but that's a far less fast path than rcu_irq_enter(), which this patch
removes a conditional from.

-- Steve
