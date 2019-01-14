Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40BEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547485944;
	bh=pM7U6ma3LxUEGXybzQ+oyb4VyTdqvdmH/Rv/oXXhtVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MSDzvbykhA8Kp4Awt5Kd+07MAUd9KU0CrQmfD59AnRq4O0mvZrKHj+IwMdsWJj7lo
	 8S2PuA9GkfajuKhqLM15Ug0/QnGU6QFNFLuZfNEu42zPbaDD7ohiqHu8t26HGx3s7E
	 R8QrpiiyHEwqCj5VEnpZreSqaMddkWcVlJtNRN84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfANRMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfANRMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:12:23 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2756B2070B;
        Mon, 14 Jan 2019 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547485942;
        bh=pM7U6ma3LxUEGXybzQ+oyb4VyTdqvdmH/Rv/oXXhtVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KF4zv2mEoBrEsVePOixMkvVnbeK4t3bZuQngafOy7D6cKmsoPpafGcGUfTUj7CDkc
         5jYUF0WcKAET8FOCOappFnkEXX0KOk0+S6GEXJ+++ydfeeu/rthCT9DFvniAJMs46v
         mL0biMnse2UDt9EwBAetuud+9kMH2V3zF+4hUoCw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D721A41AB5; Mon, 14 Jan 2019 14:12:19 -0300 (-03)
Date:   Mon, 14 Jan 2019 14:12:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v7 perf, bpf-next 7/8] perf util: handle
 PERF_RECORD_BPF_EVENT
Message-ID: <20190114171219.GC11922@kernel.org>
References: <20190111001933.4153792-1-songliubraving@fb.com>
 <20190111001933.4153792-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111001933.4153792-8-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 04:19:32PM -0800, Song Liu escreveu:
> This patch adds basic handling of PERF_RECORD_BPF_EVENT.
> Tracking of PERF_RECORD_BPF_EVENT is OFF by default. Option --bpf-event
> is added to turn it on.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

Please add the following patch to your tree for the next revision:

commit 11860cb0ca8a5013c4b9dd8654dccf485ad7a61c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jan 14 12:19:34 2019 -0300

    perf top: Synthesize BPF events for pre-existing loaded BPF programs
    
    So that we can resolve symbols and map names.
    
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: kernel-team@fb.com
    Cc: netdev@vger.kernel.org
    Link: https://lkml.kernel.org/n/tip-h3loibff6htedj43q7uinon0@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f64e312db787..5a486d4de56e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -22,6 +22,7 @@
 #include "perf.h"
 
 #include "util/annotate.h"
+#include "util/bpf-event.h"
 #include "util/config.h"
 #include "util/color.h"
 #include "util/drv_configs.h"
@@ -1215,6 +1216,12 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
+	ret = perf_event__synthesize_bpf_events(&top->tool, perf_event__process,
+						&top->session->machines.host,
+						&top->record_opts);
+	if (ret < 0)
+		pr_warning("Couldn't synthesize bpf events.\n");
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false,
 				    top->nr_threads_synthesize);
