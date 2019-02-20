Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DDCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571292086D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712317;
	bh=wb1ZTf4Zk19KtTMbb07rA/mr3jm/msigDqKm+jgcaX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pVzEkcmKvA+4ujaiD57rWPfKTXffWdWn1t42XOl/uZz9UTgDoNsq+M0aDDjRNro8e
	 e5JhvZ4WhZmfyN7maHXwc2MyMx4CROof7fTReyRSacozos3Y2ZQOXIgk9i8AUiUcGw
	 wOy2oyBRxZMjsiWJawANcUeUk2BuhFzvSExn/hkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfBUBZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfBUBZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:25:15 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6F22089F;
        Thu, 21 Feb 2019 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712315;
        bh=wb1ZTf4Zk19KtTMbb07rA/mr3jm/msigDqKm+jgcaX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yo/4uQpWiJZWYXgzhr3hYRRC8XfwtkkC+jKHqQ/NqWtvVRV9VnftyxaC/dY2B3NqI
         X0rU+lqIeo8CTTojmQF8tbV5BXTkhlkqKbAY3/yYc9KWwu1YCsHaF/LPtsQI8maCXT
         efKmBlhsZm3yc7LaDYXNPxz//DeXwDFr0IvwUObQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34BF4410D5; Wed, 20 Feb 2019 16:23:03 -0300 (-03)
Date:   Wed, 20 Feb 2019 16:23:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 4/6] perf tools: Add missing new line into pr_debug call
Message-ID: <20190220192303.GD21275@kernel.org>
References: <20190220122800.864-1-jolsa@kernel.org>
 <20190220122800.864-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220122800.864-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 20, 2019 at 01:27:58PM +0100, Jiri Olsa escreveu:
> Adding missing new line into pr_debug call in
> perf_event__synthesize_bpf_events function,
> so the error message does not screw the verbose
> output.

Adding Song Liu to the CC list,

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-z9h6x8v1mef0iqsfx6m28nf2@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 62dda96b0096..028c8ec1f62a 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
>  				err = 0;
>  				break;
>  			}
> -			pr_debug("%s: can't get next program: %s%s",
> +			pr_debug("%s: can't get next program: %s%s\n",
>  				 __func__, strerror(errno),
>  				 errno == EINVAL ? " -- kernel too old?" : "");
>  			/* don't report error on old kernel or EPERM  */
> -- 
> 2.17.2

-- 

- Arnaldo
