Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbeDWOX0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755335AbeDWOXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:23:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E7121795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 11:23:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 5/9] perf tools: Disable write_backward for leader
 sampling group events
Message-ID: <20180423142319.GD30324@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
 <20180423090823.32309-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423090823.32309-6-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 23, 2018 at 11:08:19AM +0200, Jiri Olsa escreveu:
> .. and other related fields that do not need to be enabled
> for events that have sampling leader.
> 
> It fixes the perf top usage Ingo reported broken:
> 
>   # perf top -e '{cycles,msr/aperf/}:S'
> 
> The msr/aperf/ is configured for write_back sampling, which
> is not allowed by msr pmu, so it fails to create the event.
> 
> Adjusting related attr test.

Applied to perf/urgent.

- Arnaldo
