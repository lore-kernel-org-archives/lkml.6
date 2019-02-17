Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33E921773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfBQXFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:05:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBQXFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:05:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6BE11219CD;
        Sun, 17 Feb 2019 23:05:43 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3BF641024978;
        Sun, 17 Feb 2019 23:05:41 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:05:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 08/11] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190217230540.GD7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-9-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-9-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 17 Feb 2019 23:05:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:51PM -0800, Song Liu wrote:

SNIP

>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 0785c91b4c3a..ba51d8e43c53 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -40,6 +40,7 @@ enum {
>  	HEADER_MEM_TOPOLOGY,
>  	HEADER_CLOCKID,
>  	HEADER_BPF_PROG_INFO,
> +	HEADER_BTF,

hu, could we maybe prefix all the bpf related features with BPF_ ?

jirka

>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> -- 
> 2.17.1
> 
