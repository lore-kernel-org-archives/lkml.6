Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D29FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38483214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfAJJz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:55:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfAJJz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:55:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBA9EC0669AB;
        Thu, 10 Jan 2019 09:55:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id EF4705C6C1;
        Thu, 10 Jan 2019 09:55:25 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:55:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] perf thread-stack: x86 retpolines
Message-ID: <20190110095525.GC25764@krava>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109091835.5570-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 09:55:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:18:29AM +0200, Adrian Hunter wrote:
> Hi
> 
> Here are some patches to improve the exported call graph, primarily to deal
> with x86 retpolines.
> 
> 
> Adrian Hunter (6):
>       perf tools: Fix split_kallsyms_for_kcore for trampoline symbols
>       perf thread-stack: Tidy thread_stack__push_cp() usage
>       perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
>       perf thread-stack: Represent jmps to the start of a different symbol
>       perf thread-stack: Improve thread_stack__no_call_return()
>       perf thread-stack: Hide x86 retpolines

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/scripts/python/export-to-postgresql.py |   2 +-
>  tools/perf/scripts/python/export-to-sqlite.py     |   2 +-
>  tools/perf/util/symbol.c                          |   2 +
>  tools/perf/util/thread-stack.c                    | 235 ++++++++++++++++++----
>  tools/perf/util/thread-stack.h                    |   3 +
>  5 files changed, 208 insertions(+), 36 deletions(-)
> 
> 
> Regards
> Adrian
