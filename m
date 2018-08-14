Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05ACC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045E21733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6045E21733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeHNCqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbeHNCqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:46:19 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDED21731;
        Tue, 14 Aug 2018 00:01:43 +0000 (UTC)
Date:   Mon, 13 Aug 2018 20:01:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180813200141.601a44e0@gandalf.local.home>
In-Reply-To: <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
        <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
        <20180809143827.GC22636@redhat.com>
        <20180810155813.49259913@gandalf.local.home>
        <CAPhsuW4ymZAxLdDOAz-rKkyb_POA3ibNW7+2G3BE5Mxtntyqsg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 23:14:01 -0700
Song Liu <liu.song.a23@gmail.com> wrote:

> On Fri, Aug 10, 2018 at 12:58 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 9 Aug 2018 16:38:28 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> >> I need to read this (hopefully final) version carefully. I'll try to do
> >> this before next Monday.
> >>  
> >
> > Monday may be the opening of the merge window (more likely Sunday). Do
> > you think this is good enough for pushing it in this late in the game,
> > or do you think we should wait another cycle?
> >
> > -- Steve  
> 
> We (Facebook) have use cases in production that would benefit from this work, so
> I would rather see this gets in sooner than later. After a brief
> review (I will more
> careful review before Monday), I think this set is not likely to break
> existing uprobes
> (those w/o ref_ctr). Therefore, I think it is safe to put it in this cycle.
> 

It's still going under review, and the merge window is now open. I'd
prefer that this waits till the next merge window.

-- Steve
