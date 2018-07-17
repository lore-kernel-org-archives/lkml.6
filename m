Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61946ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBCB206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPe8+GhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBCB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeGQTCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeGQTCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:02:48 -0400
Received: from jouet.infradead.org (179.176.5.34.dynamic.adsl.gvt.net.br [179.176.5.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01329206B8;
        Tue, 17 Jul 2018 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531852136;
        bh=2yke6q/16wEvx/reAPMPbcLo4dFPX0Xq6db6eBOckBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPe8+GhCdW3W9YBNtHsDsHQ4uFP65vjs6gBNzBb1ODl/U8ds+IM/ER7GUnKOhDXLN
         tBqk2yxMF4AnoCtnF6V7NkMZDGG+Ta1X0Xe9dGlADtTFn23Ac4iujZOTqBvXWbG63t
         QfwyjMf2r6eZ3ia/XN68HbGApBhkE+b5OwOdqUrM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CD84D14486C; Tue, 17 Jul 2018 15:28:52 -0300 (-03)
Date:   Tue, 17 Jul 2018 15:28:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sangwon Hong <qpakzk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf list: Document missing options
Message-ID: <20180717182852.GB3614@kernel.org>
References: <20180717110738.10779-1-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717110738.10779-1-qpakzk@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 17, 2018 at 08:07:38PM +0900, Sangwon Hong escreveu:
> Add the missing options --desc and --debug on the man page.

Please describe how you tested this, i.e. what difference makes using
this option you are describing?

I figured it doesn't change anything, since it is the default, so to
test if this makes any change one needs to compare the output of:

   perf list --no-desc

with the output of what you just documented, i.e.:

   perf list --desc

comparing what you added with not using any option shows no difference.

Thus we need to add this "(default)" to your patch, to avoid confusion:

+-d::
+--desc::
+Print extra event descriptions. (default)

I'm doing this, please consider adding this to any further work in this
area.
 
- Arnaldo

> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
> ---
>  tools/perf/Documentation/perf-list.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 14e13512c05f..1d3fb2846d2d 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -18,6 +18,10 @@ various perf commands with the -e option.
>  
>  OPTIONS
>  -------
> +-d::
> +--desc::
> +Print extra event descriptions.
> +
>  --no-desc::
>  Don't print descriptions.
>  
> @@ -25,11 +29,13 @@ Don't print descriptions.
>  --long-desc::
>  Print longer event descriptions.
>  
> +--debug::
> +Enable debugging output.
> +
>  --details::
>  Print how named events are resolved internally into perf events, and also
>  any extra expressions computed by perf stat.
>  
> -
>  [[EVENT_MODIFIERS]]
>  EVENT MODIFIERS
>  ---------------
> -- 
> 2.17.1
