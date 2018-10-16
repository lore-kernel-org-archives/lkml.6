Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0C208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB0C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJPVAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbeJPVAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:00:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E2B53002E18;
        Tue, 16 Oct 2018 13:10:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 05C1550AD6;
        Tue, 16 Oct 2018 13:10:00 +0000 (UTC)
Date:   Tue, 16 Oct 2018 15:09:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jarod Wilson <jarod@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools/perf: fix use of alternatives to find JDIR
Message-ID: <20181016130959.GA6979@krava>
References: <20180906221812.11167-1-jarod@redhat.com>
 <20180910080546.GA31644@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910080546.GA31644@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 16 Oct 2018 13:10:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:05:46AM +0200, Jiri Olsa wrote:
> On Thu, Sep 06, 2018 at 06:18:12PM -0400, Jarod Wilson wrote:
> > When a build is run from something like a cron job, the user's $PATH is
> > rather minimal, of note, not including /usr/sbin in my own case. Because
> > of that, an automated rpm package build ultimately fails to find
> > libperf-jvmti.so, because somewhere within the build, this happens...
> > 
> > /bin/sh: alternatives: command not found
> > /bin/sh: alternatives: command not found
> > Makefile.config:849: No openjdk development package found, please install
> > JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> > 
> > ...and while the build continues, libperf-jvmti.so isn't built, and things
> > fall down when rpm tries to find all the %files specified. Exact same
> > system builds everything just fine when the job is launched from a login
> > shell instead of a cron job, since alternatives is in $PATH, so openjdk is
> > actually found.
> > 
> > The test required to get into this section of code actually specifies the
> > full path, as does a block just above it, so let's do that here too.
> > 
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> > CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > CC: Jiri Olsa <jolsa@redhat.com>
> > CC: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Arnaldo,
could you please pull in this one?

thanks,
jirka
