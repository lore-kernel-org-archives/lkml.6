Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2389C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D4720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D4720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKAWZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeKAWZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:25:44 -0400
Received: from vmware.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116012081B;
        Thu,  1 Nov 2018 13:22:45 +0000 (UTC)
Date:   Thu, 1 Nov 2018 09:22:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kretprobe: produce sane stack traces
Message-ID: <20181101092244.2ad82f18@vmware.local.home>
In-Reply-To: <20181101104948.bc7wk453bfryhhk7@yavin>
References: <20181026132210.12569-1-cyphar@cyphar.com>
        <20181030101206.2e5998ca3c75496c91ba5b09@kernel.org>
        <20181031090317.4e211fdd@vmware.local.home>
        <20181031133912.3j5tryq2vyhkdn4d@yavin>
        <20181101191347.74eadff4a5d1fab2d79d7efe@kernel.org>
        <20181101104948.bc7wk453bfryhhk7@yavin>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 21:49:48 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:


> > > Should I continue working on this patchset?  
> > 
> > Yes, until we finally introduce Steven's algorithm on all arch (yeah, we still
> > have some archs which don't support graph-tracer but supports kprobes),
> > I think your patch is the best fix for this issue.  

Agreed.

> 
> Thanks, I just sent a v3.

Thanks. Hopefully I can take a look at it today or tomorrow. I'm still
trying to get home (sitting at yet another airport as I write this).

> 
> Though, even with Steven's hooking of kprobes I think you'd still need
> to stash away the stack trace somewhere (or am I misunderstanding the
> proposal?).

I'll start working on it and then we can see what is needed when there
is actual code. I need to probably change the func graph generic
interface which will require changes in all the archs that support
function graph tracer.

-- Steve

