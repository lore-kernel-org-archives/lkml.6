Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB47C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6CB2473E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6CB2473E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeFVScv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933869AbeFVScu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:32:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25AEE2473E;
        Fri, 22 Jun 2018 18:32:49 +0000 (UTC)
Date:   Fri, 22 Jun 2018 14:32:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622143247.781028b1@gandalf.local.home>
In-Reply-To: <20180622181916.GA13628@joelaf.mtv.corp.google.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
        <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
        <20180620145814.GQ3593@linux.vnet.ibm.com>
        <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
        <20180620164902.GW3593@linux.vnet.ibm.com>
        <20180622055659.GA255098@joelaf.mtv.corp.google.com>
        <20180622132843.GN3593@linux.vnet.ibm.com>
        <20180622181916.GA13628@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 11:19:16 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> Sure. So in a later thread you mentioned "usermode helpers". I took a closer
> look at that subsystem, and it seems you can execute usermode helpers from
> atomic sections with help of UMH_NO_WAIT flag.
> 
> Then I checked where this flag is used and it turns out its from the
> mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
> called infact from an interrupt context (mce_notify_irq).
> 
> Is this the usecase you remember causing this weird transitions to userspace?

But this case still looks like it uses work queues, it just doesn't
wait for the result.

I'll have to look at the code from what it looked like back in 2011, to
see if there was an actual issue here back then.

-- Steve
