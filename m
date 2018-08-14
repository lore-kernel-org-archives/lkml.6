Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C216EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBC4216E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBC4216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeHNVXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeHNVXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:23:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E90216E4;
        Tue, 14 Aug 2018 18:34:53 +0000 (UTC)
Date:   Tue, 14 Aug 2018 14:34:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Message-ID: <20180814143451.0ee99bf8@gandalf.local.home>
In-Reply-To: <20180814174443.GG24813@linux.vnet.ibm.com>
References: <20180814162448.GA20414@linux.vnet.ibm.com>
        <20180814124945.5cf1753f@gandalf.local.home>
        <20180814170618.GA24813@linux.vnet.ibm.com>
        <20180814132453.093a4921@gandalf.local.home>
        <20180814174443.GG24813@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 10:44:43 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > If I recall correctly, this subterfuge suppresses compiler complaints
> > > about initializing an unsigned long with a negative number.  :-/  
> > 
> > Did you try:
> > 
> > 	.srcu_gp_seq_needed = -1UL,
> > 
> > ?  
> 
> Works for my compiler, not sure what set of complaints pushed me in that
> direction.

I've used -1UL for unsigned long initializations for pretty much my
entire programming career. I've never had any issues with it.

-- Steve
