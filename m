Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A7BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1B2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIJM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:58:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbeIJM6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BE334074474;
        Mon, 10 Sep 2018 08:05:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 11A5710073BD;
        Mon, 10 Sep 2018 08:05:47 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:05:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jarod Wilson <jarod@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools/perf: fix use of alternatives to find JDIR
Message-ID: <20180910080546.GA31644@krava>
References: <20180906221812.11167-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906221812.11167-1-jarod@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 08:05:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 08:05:50 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:18:12PM -0400, Jarod Wilson wrote:
> When a build is run from something like a cron job, the user's $PATH is
> rather minimal, of note, not including /usr/sbin in my own case. Because
> of that, an automated rpm package build ultimately fails to find
> libperf-jvmti.so, because somewhere within the build, this happens...
> 
> /bin/sh: alternatives: command not found
> /bin/sh: alternatives: command not found
> Makefile.config:849: No openjdk development package found, please install
> JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> 
> ...and while the build continues, libperf-jvmti.so isn't built, and things
> fall down when rpm tries to find all the %files specified. Exact same
> system builds everything just fine when the job is launched from a login
> shell instead of a cron job, since alternatives is in $PATH, so openjdk is
> actually found.
> 
> The test required to get into this section of code actually specifies the
> full path, as does a block just above it, so let's do that here too.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@redhat.com>
> CC: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
