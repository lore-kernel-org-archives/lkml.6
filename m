Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AE620878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AE620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeLERWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:22:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLERWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:22:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58469307CDD4;
        Wed,  5 Dec 2018 17:22:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 95DA684F0;
        Wed,  5 Dec 2018 17:22:42 +0000 (UTC)
Date:   Wed, 5 Dec 2018 18:22:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>, kernel-team@lge.com
Subject: Re: [PATCH 3/9] tools/lib/traceevent: Install trace-seq.h API header
 file
Message-ID: <20181205172241.GC3836@krava>
References: <20181130154403.150474900@goodmis.org>
 <20181130154647.176265533@goodmis.org>
 <20181204074739.GC16733@sejong>
 <20181204144145.116a2caf@vmware.local.home>
 <20181205122517.GG2950@krava>
 <20181205120334.60d0478e@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205120334.60d0478e@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 05 Dec 2018 17:22:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:03:34PM -0500, Steven Rostedt wrote:
> On Wed, 5 Dec 2018 13:25:17 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > On Tue, Dec 04, 2018 at 02:41:45PM -0500, Steven Rostedt wrote:
> > > On Tue, 4 Dec 2018 16:47:39 +0900
> > > Namhyung Kim <namhyung@kernel.org> wrote:
> > > 
> > >   
> > > > > @@ -302,6 +302,7 @@ install_headers:
> > > > >  	$(call QUIET_INSTALL, headers) \
> > > > >  		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
> > > > >  		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
> > > > > +		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
> > > > >  		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)    
> > > > 
> > > > Do you still wanna have 'traceevent' directory prefix?  I just
> > > > sometimes feel a bit annoying to type it. ;-)  
> > > 
> > > I'd still want the separate directory for it. I'll probably have a
> > > ftrace.h file added to this for ftrace specific code in the future.
> > >   
> > > > 
> > > > Or you can rename it something like 'tep' or 'libtep' - and hopefully
> > > > having only single header file to include..
> > > >  
> > > 
> > > Hmm, I wonder if we should just call the directory "trace"?  
> > 
> > hum, I think it should match the library name, like 'include/tep/'
> 
> I was hoping to add other headers in this directly, like ftrace.h and
> perf.h ;-)

those are headers from trace-cmd?

I guess we could have some common 'trace' related directory,
but I think we should have some rules for placing files in
there to avoid mayhem ;-)

but I'd prefer to go with package related directories under include

> > also we should change the plugin installation directory
> > 
> > [jolsa@krava traceevent]$ rpm -ql perf | grep traceevent
> > /usr/lib64/traceevent
> > /usr/lib64/traceevent/plugins
> > /usr/lib64/traceevent/plugins/plugin_cfg80211.so
> > /usr/lib64/traceevent/plugins/plugin_function.so
> > /usr/lib64/traceevent/plugins/plugin_hrtimer.so
> > /usr/lib64/traceevent/plugins/plugin_jbd2.so
> > /usr/lib64/traceevent/plugins/plugin_kmem.so
> > /usr/lib64/traceevent/plugins/plugin_kvm.so
> > /usr/lib64/traceevent/plugins/plugin_mac80211.so
> > /usr/lib64/traceevent/plugins/plugin_sched_switch.so
> > /usr/lib64/traceevent/plugins/plugin_scsi.so
> > /usr/lib64/traceevent/plugins/plugin_xen.so
> 
> Change it to tep?

yes, that makes sense to me

jirka
