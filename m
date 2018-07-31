Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899DCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8D9208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8D9208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeGaLAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:00:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729485AbeGaLAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:00:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37AE4402315B;
        Tue, 31 Jul 2018 09:21:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62BC52142F20;
        Tue, 31 Jul 2018 09:21:29 +0000 (UTC)
Date:   Tue, 31 Jul 2018 11:21:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC] perf annotate: option to report global percentage
Message-ID: <20180731092128.GA17617@krava>
References: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
 <20180719082539.GB18667@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719082539.GB18667@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 31 Jul 2018 09:21:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 31 Jul 2018 09:21:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:25:39AM +0200, Jiri Olsa wrote:
> On Wed, Jul 18, 2018 at 02:55:14PM -0700, Stephane Eranian wrote:
> > Hi Jiri,
> > 
> > As far as I know, once you go into annotate mode, via perf report TUI
> > mode, the percentage you see per instruction is relative to the
> > function. I would like the option to display the total percentage,
> > i..e, the importance of the instruction for the entire run. Right now,
> > if I want that, I need to do function_percentage * insn_percentage by
> > hand. This is not convenient. Having a key toggle would be very
> > useful, worst case a cmdline option.
> > 
> > What do you think?
> 
> hi,
> that should be simple to add, we already have the 'F' in the
> main browser window to toggle among full/filtered scale
> 
> I'll try to add something similar for annotation window

sry for delay, I was out last week

I put something together and pushed it in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/annotate_percent

there's the 'p' key to switch between local and global period
I haven't added any command line option for stdio yet

I'll have more testing and post later but any feedback
now would be great

thanks,
jirka
