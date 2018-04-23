Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755483AbeDWOQg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755184AbeDWOQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:16:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2849B217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 11:16:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/9] perf stat: Keep the / modifier separator in fallback
Message-ID: <20180423141629.GB30324@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
 <20180423090823.32309-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423090823.32309-4-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 23, 2018 at 11:08:17AM +0200, Jiri Olsa escreveu:
> The perf stat fallback for EACCES error sets exclude_kernel
> for event and repeats the open. In addition, it also changes
> the name of the event to reflect that change by adding the
> 'u' modifier.
> 
> But it does not take into account the '/' separator, so the
> event name can end up mangled, like:
> (note the '/:' characters)
> 
>   $ perf stat -e cpu/cpu-cycles/ kill
>   ...
>              386,832      cpu/cpu-cycles/:u
> 
> Adding the code to check on the '/' separatos and set
> following event name:
> 
>   $ perf stat -e cpu/cpu-cycles/ kill
>   ...
>              388,548      cpu/cpu-cycles/u

Thanks, tested, reproduced and applied to perf/urgent

- Arnaldo
