Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62343C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F4B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAVzk2AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F4B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbeK0Xdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbeK0Xds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:48 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D252151B;
        Tue, 27 Nov 2018 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322160;
        bh=N7YRh02qPxsApCI8l/0s++6SXXXdajdEdv9c8LjgYnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAVzk2AWSa/JKtB2fyqiGoKTU1Hm/LzynIbE3Zr3g+Kdq+pmAYbhQ8/QaD6QaIOjP
         zA0fqjpHtqT/NJ/5LxI/e/ID31/XOm7wH1+odWbkbTrg1opcs46cyXw4I6uqUVOz+o
         1wFVMtoKqr8Kgr49MgZDrA8VVmYmrwbZ45Qq+lRU=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 533A44111E; Mon, 26 Nov 2018 17:07:02 -0300 (-03)
Date:   Mon, 26 Nov 2018 17:07:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix perf_event_attr test failure
Message-ID: <20181126200702.GI18491@kernel.org>
References: <20181122140456.16817-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122140456.16817-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 22, 2018 at 04:04:56PM +0200, Adrian Hunter escreveu:
> Fix inconsistent use of tabs and spaces error:

Thanks, applied.

- Arnaldo
 
>   # perf test 16 -v
>   16: Setup struct perf_event_attr                          :
>   --- start ---
>   test child forked, pid 20224
>     File "/usr/libexec/perf-core/tests/attr.py", line 119
>       log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
>                                                                  ^
>   TabError: inconsistent use of tabs and spaces in indentation
>   test child finished with -1
>   ---- end ----
>   Setup struct perf_event_attr: FAILED!
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/tests/attr.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
> index ff9b60b99f52..44090a9a19f3 100644
> --- a/tools/perf/tests/attr.py
> +++ b/tools/perf/tests/attr.py
> @@ -116,7 +116,7 @@ class Event(dict):
>              if not self.has_key(t) or not other.has_key(t):
>                  continue
>              if not data_equal(self[t], other[t]):
> -		log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
> +                log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
>  
>  # Test file description needs to have following sections:
>  # [config]
> -- 
> 2.17.1

-- 

- Arnaldo
