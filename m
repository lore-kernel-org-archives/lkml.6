Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8B620850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546955121;
	bh=MYvgozdhCt/91yRELP+2rpQZFOOFJgHUGniaY79EBRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CH9oM6Okfz1gZp6eKQNmsGLcntjx8v+nl9vNITrq97uWnYPikKJz6YvxPR/zHEtLo
	 X+oASbCcXcNp2chZtbbiJXmSswgGm5U0SDaJTj40YrZt80ia4D2rrTBYGNRsQr9Opw
	 IBDgmTHJPVn+SmHBSCfU+8vgY5m5a9GJLgZwXKWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfAHNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfAHNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:45:20 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A3B206BB;
        Tue,  8 Jan 2019 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546955119;
        bh=MYvgozdhCt/91yRELP+2rpQZFOOFJgHUGniaY79EBRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOi0jsF0u/8hJNeFZeaNunEAgSuXdFNv/m4WH0mK9W9bqOYEyuB4Y46kxkXjFakhf
         rHVa0Rrb6u+IyjoFYilkRkbrbRJ7rz02AbA1mhLbwC2UTgJqHCShZOIYkD2e2r0r1P
         cn9UbY2F0ev8jcsX7T46BGz9QylKuMyt5JUhZ+kM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E18A40355; Tue,  8 Jan 2019 10:45:17 -0300 (-03)
Date:   Tue, 8 Jan 2019 10:45:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/6] tools/lib/traceevent: Some more library updates
Message-ID: <20190108134517.GE28965@kernel.org>
References: <20181201040807.154099010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201040807.154099010@goodmis.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 30, 2018 at 11:08:07PM -0500, Steven Rostedt escreveu:
> Arnaldo and Jiri,
> 
> Here's another set of patches to get us closer to having a legitimate
> standalone library for libtraceevent. There's still a lot of man pages
> to come, but I need to continue reviewing them.

Thanks, applied.

- Arnaldo
 
> Please pull this tree (based on current tip/perf/core) or apply
> the patches.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> tip/perf/core
> 
> Head SHA1: 5b2e18a71601544c4ae95e9ed1f953f3883714f5
> 
> 
> Tzvetomir Stoyanov (6):
>       tools/lib/traceevent: Initialize host_bigendian at tep_handle allocation
>       tools/lib/traceevent: Rename struct cmdline to struct tep_cmdline
>       tools/lib/traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs
>       tools/lib/traceevent: Changed return logic of tep_register_event_handler() API
>       tools/lib/traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()
>       tools/lib/traceevent: Remove tep_data_event_from_type() API
> 
> ----
>  tools/lib/traceevent/event-parse-api.c   |  4 +--
>  tools/lib/traceevent/event-parse-local.h |  4 +--
>  tools/lib/traceevent/event-parse.c       | 62 +++++++++++++++-----------------
>  tools/lib/traceevent/event-parse.h       | 16 +++++----
>  tools/lib/traceevent/plugin_kvm.c        |  2 +-
>  tools/lib/traceevent/trace-seq.c         | 17 ++++++---
>  6 files changed, 56 insertions(+), 49 deletions(-)

-- 

- Arnaldo
