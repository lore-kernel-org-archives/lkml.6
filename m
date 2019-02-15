Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A122192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfBOO1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:27:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfBOO1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F36231487F2;
        Fri, 15 Feb 2019 14:27:54 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-32.phx2.redhat.com [10.3.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D64C610C7;
        Fri, 15 Feb 2019 14:27:54 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id ED0E855D2; Fri, 15 Feb 2019 12:27:49 -0200 (BRST)
Date:   Fri, 15 Feb 2019 12:27:49 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 perf,bpf 09/11] perf-top: add option --bpf-event
Message-ID: <20190215142749.GD5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190215000010.2590505-1-songliubraving@fb.com>
 <20190215000010.2590505-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215000010.2590505-8-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 15 Feb 2019 14:27:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 04:00:10PM -0800, Song Liu escreveu:
> bpf events are only tracked when opts->bpf_event is enabled. This patch
> adds command line flag to enable this for perf-top.

Shouldn't this start as enabled and we just provide a way to disable it
for testing purposes? Normally perf top works system wide, and then we
want to get info about BPF events, I think.

- Arnaldo
 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/builtin-top.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 27d8d42e0a4d..5271d7211b9c 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1492,6 +1492,7 @@ int cmd_top(int argc, const char **argv)
>  		    "Display raw encoding of assembly instructions (default)"),
>  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>  		    "Enable kernel symbol demangling"),
> +	OPT_BOOLEAN(0, "bpf-event", &opts->bpf_event, "record bpf events"),
>  	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
>  		    "objdump binary to use for disassembly and annotations"),
>  	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
> -- 
> 2.17.1
