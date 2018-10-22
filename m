Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D1EECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9D42083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9D42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeJVR6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbeJVR6W (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97684CD4A8;
        Mon, 22 Oct 2018 09:40:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64DAD61B8D;
        Mon, 22 Oct 2018 09:40:34 +0000 (UTC)
Date:   Mon, 22 Oct 2018 11:40:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: allow extended console debug output
Message-ID: <20181022094033.GF2452@krava>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021191424.16183-1-milian.wolff@kdab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Oct 2018 09:40:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 09:14:23PM +0200, Milian Wolff wrote:
> The script tool isn't using a browser, yet use_browser
> wasn't set explicitly to zero. This in turn lead to confusing
> output such as:
> 
> ```
> $ perf script -vvv ...
> ...
> overlapping maps in /home/milian/foobar (disable tui for more info)
> ...
> ```
> 
> Explicitly set use_browser to 0 now, which gives us the extended
> debug information now in perf script as expected.
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4da5e32b9e03..bd468b90801b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
>  		exit(-1);
>  	}
>  
> -	if (!script_name)
> +	if (!script_name) {
>  		setup_pager();
> +		use_browser = 0;
> +	}
>  
>  	session = perf_session__new(&data, false, &script.tool);
>  	if (session == NULL)
> -- 
> 2.19.1
