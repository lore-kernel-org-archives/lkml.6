Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2045C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B76820643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPfG09bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBYOqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:46:32 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:42664 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:46:31 -0500
Received: by mail-qt1-f172.google.com with SMTP id u7so1499249qtg.9;
        Mon, 25 Feb 2019 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5dhoUdY9LnkwoIMPX5g7+o1AWA9SAPB7CkmMWRR8kMg=;
        b=CPfG09bXEQnJyiMtektby+HOySG5cy5wMgky1+z1Sdq9DIOZ9WJyR6GIAhdWPBb/Ml
         wj4RdV3y1kWAvwp+0xFSnGB83w3dCa+XT7S0+TLSLdmlufbYDqLNDQ1SaD97YjMrjA0X
         jvlpTupt7M2QDyL98N5hyGJvYRUsFY7+KJnRS6TcKseNwz6HpyX0OD7J8yko5t1KH06Y
         ZQSEUy7sxmvEf5MwMUolKpLlIButMfoOEIg8VWf3xSdMbLd/hG/qV9OtSZG+fSc4DE5K
         pfApGpnssT6UWZn2YGOnE0UIlRjzmNkP01bVtNpYv/5xUX/cDFXsWXREZQBzHNtofpq0
         qGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5dhoUdY9LnkwoIMPX5g7+o1AWA9SAPB7CkmMWRR8kMg=;
        b=cshZLQWR/dUgz1dc/FVFhREkTjYGH+mivmyZebDdjxW5P2apo1H9GHHyayHVvFk2Wx
         WfLyGtkzWuHEd7CHfodBUb+AOM+BOuV5JADCxlGz/XdriA9sZRGPJMK4/JrlKKhaGeWw
         L5iz3A+Ak+QmWhCb8TR+e+luqoGW6zYgsHiPuYJ3S946IkNTLJkBZbjYzeBGR5kM4c1w
         xg3E8to/3RZ7FTvzMxvgld/wSz1pmWJABcu9N3Cy0F/yNaqRLcrUDQYm61UKsNi0XKYR
         UCnW9CuLMI4ih7Uwi9ptYpzqmJkH4FPxeyiRj1v0AseAzF1sj04UkYzi5YGAGOz078bP
         7nbg==
X-Gm-Message-State: AHQUAuafO3aRcx6okREqCI/lV8DrUnfZWT/9ncHEXDONTF5SsoZh7gF+
        A0qAncz/suQPGJwyOtWY07DeR0Rx
X-Google-Smtp-Source: AHgI3IZsAphirptGgl7UINDIHmJarsimEDpQakmpkk0YmS6kRGntuzeVwLyXzudpM+pQd/Thu1o5qg==
X-Received: by 2002:a0c:b059:: with SMTP id l25mr13864995qvc.23.1551105989911;
        Mon, 25 Feb 2019 06:46:29 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id 81sm5406584qkg.75.2019.02.25.06.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:46:28 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDBB34039C; Mon, 25 Feb 2019 11:46:25 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:46:25 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 11/15] perf script python: add Python3 support to
 stackcollapse.py
Message-ID: <20190225144625.GK31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-12-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-12-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:15PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the stackcollapse.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.

Applied
 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tools/perf/scripts/python/stackcollapse.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
> index 1697b5e18c96..5e703efaddcc 100755
> --- a/tools/perf/scripts/python/stackcollapse.py
> +++ b/tools/perf/scripts/python/stackcollapse.py
> @@ -19,6 +19,8 @@
>  # Written by Paolo Bonzini <pbonzini@redhat.com>
>  # Based on Brendan Gregg's stackcollapse-perf.pl script.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  from collections import defaultdict
> @@ -120,7 +122,6 @@ def process_event(param_dict):
>      lines[stack_string] = lines[stack_string] + 1
>  
>  def trace_end():
> -    list = lines.keys()
> -    list.sort()
> +    list = sorted(lines)
>      for stack in list:
> -        print "%s %d" % (stack, lines[stack])
> +        print("%s %d" % (stack, lines[stack]))
> -- 
> 2.20.1

-- 

- Arnaldo
