Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C8FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E2520850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E2520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLDTls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbeLDTls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:41:48 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951B52081C;
        Tue,  4 Dec 2018 19:41:47 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:41:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>, kernel-team@lge.com
Subject: Re: [PATCH 3/9] tools/lib/traceevent: Install trace-seq.h API
 header file
Message-ID: <20181204144145.116a2caf@vmware.local.home>
In-Reply-To: <20181204074739.GC16733@sejong>
References: <20181130154403.150474900@goodmis.org>
        <20181130154647.176265533@goodmis.org>
        <20181204074739.GC16733@sejong>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 16:47:39 +0900
Namhyung Kim <namhyung@kernel.org> wrote:


> > @@ -302,6 +302,7 @@ install_headers:
> >  	$(call QUIET_INSTALL, headers) \
> >  		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
> >  		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
> > +		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
> >  		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)  
> 
> Do you still wanna have 'traceevent' directory prefix?  I just
> sometimes feel a bit annoying to type it. ;-)

I'd still want the separate directory for it. I'll probably have a
ftrace.h file added to this for ftrace specific code in the future.

> 
> Or you can rename it something like 'tep' or 'libtep' - and hopefully
> having only single header file to include..
>

Hmm, I wonder if we should just call the directory "trace"?

-- Steve
