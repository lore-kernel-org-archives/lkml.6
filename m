Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2185FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1236261C4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1236261C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeFYWQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752625AbeFYWQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:16:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F21261C3;
        Mon, 25 Jun 2018 22:16:39 +0000 (UTC)
Date:   Mon, 25 Jun 2018 18:16:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        joel@joelfernandes.org, Byungchul Park <byungchul.park@lge.com>,
        byungchul park <max.byungchul.park@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180625181638.7fb84df6@gandalf.local.home>
In-Reply-To: <CALCETrVD6CxY0gDcfNfy8rNK74UZKnVvBJfiK7pLbZLiqgEbOg@mail.gmail.com>
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
        <20180620164902.GW3593@linux.vnet.ibm.com>
        <20180622055659.GA255098@joelaf.mtv.corp.google.com>
        <20180622132843.GN3593@linux.vnet.ibm.com>
        <20180622181916.GA13628@joelaf.mtv.corp.google.com>
        <20180622143247.781028b1@gandalf.local.home>
        <20180622200548.GA114655@joelaf.mtv.corp.google.com>
        <20180625082824.GB21377@X58A-UD3R>
        <20180625163951.GA52646@joelaf.mtv.corp.google.com>
        <20180625162557.7140664c@gandalf.local.home>
        <20180625204708.GS3593@linux.vnet.ibm.com>
        <CALCETrVD6CxY0gDcfNfy8rNK74UZKnVvBJfiK7pLbZLiqgEbOg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 13:47:45 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> 
> As a straightforward example, NMI and MCE can nest inside each other.

But I'm not sure how stable the machine becomes when MCE's start
interrupting NMIs. Also, can MCE callbacks use RCU?

> IIRC we treat #DB somewhat NMI-ish-ly as well.

And #DB is something I think we finally said shouldn't be done in NMIs,
IIRC.

-- Steve
