Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85595C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9552075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9552075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIEUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:40:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbeIEUkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:40:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 451B48011059;
        Wed,  5 Sep 2018 16:09:22 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20B63B27BD;
        Wed,  5 Sep 2018 16:09:19 +0000 (UTC)
Date:   Wed, 5 Sep 2018 18:09:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] perf tools: Initialize perf_data_file fd field
Message-ID: <20180905160918.GB29759@krava>
References: <20180829201648.19588-1-jeremie.galarneau@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829201648.19588-1-jeremie.galarneau@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 16:09:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 05 Sep 2018 16:09:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:16:48PM -0400, Jérémie Galarneau wrote:
> Building the perf CTF converter fails with gcc 4.8.4
> on Ubuntu 14.04 with the following error:
> 
> error: missing initializer for field ‘fd’ of ‘struct perf_data_file’
> [-Werror=missing-field-initializers]
> 
> Per 4b838b0d and the ensuing discussion on the mailing
> list, it appears that this affects other distributions
> and gcc versions.
> 
> Signed-off-by: Jérémie Galarneau <jeremie.galarneau@efficios.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/perf/util/data-convert-bt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index abd38abf1d91..f75d4aa612c5 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  {
>  	struct perf_session *session;
>  	struct perf_data data = {
> -		.file.path = input,
> +		.file      = { .path = input, .fd = -1 },
>  		.mode      = PERF_DATA_MODE_READ,
>  		.force     = opts->force,
>  	};
> -- 
> 2.18.0
> 
