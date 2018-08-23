Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C3DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B95208B7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B95208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeHWR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:29:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbeHWR33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B57840216F6;
        Thu, 23 Aug 2018 13:59:39 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BE8610D18DF;
        Thu, 23 Aug 2018 13:59:38 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 48BC6142; Thu, 23 Aug 2018 10:59:35 -0300 (BRT)
Date:   Thu, 23 Aug 2018 10:59:35 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>,
        y.karadz@gmail.com, tz.stoyanov@gmail.com, tglx@linutronix.de,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] tools lib traceevent: Rename various pevent
 get/set/is APIs
Message-ID: <20180823135935.GA2077@redhat.com>
References: <20180808180703.114110715@goodmis.org>
 <tip-413af01c8d9d5d688df3244401cbddfe98bafe2a@git.kernel.org>
 <20180822103612.2b41102a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822103612.2b41102a@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 23 Aug 2018 13:59:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 23 Aug 2018 13:59:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'acme@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 22, 2018 at 10:36:12AM -0400, Steven Rostedt escreveu:
> On Sat, 18 Aug 2018 04:53:45 -0700
> "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com> wrote:
> 
> > Commit-ID:  413af01c8d9d5d688df3244401cbddfe98bafe2a
> > Gitweb:     https://git.kernel.org/tip/413af01c8d9d5d688df3244401cbddfe98bafe2a
> > Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > AuthorDate: Wed, 8 Aug 2018 14:03:06 -0400
> > Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
> > CommitDate: Mon, 13 Aug 2018 15:35:02 -0300
> > 
> > tools lib traceevent: Rename various pevent get/set/is APIs
> > 
> > In order to make libtraceevent into a proper library, variables, data
> > structures and functions require a unique prefix to prevent name space
> > conflicts. That prefix will be "tep_" and not "pevent_". This changes
> > APIs: pevent_pid_is_registered, pevent_get_cpus, pevent_set_cpus,
> > pevent_is_file_bigendian, pevent_is_host_bigendian, pevent_is_latency_format,
> > pevent_set_latency_format
> > 
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
> > Cc: linux-trace-devel@vger.kernel.org
> > Link: http://lkml.kernel.org/r/20180808180703.114110715@goodmis.org
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Hi Arnaldo,
> 
> I'm curious to why the "(VMware)" part of my Signed-off-by was stripped
> off on all these patches? It's required that is added to denote that my
> work is done on my company time, otherwise I will have to use my vmware
> email address which I really don't want to do.

I'll make sure it is kept, fixing my scripts,

Thanks,

- Arnaldo
