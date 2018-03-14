Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeCNTAV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeCNTAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:00:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9002077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 14 Mar 2018 16:00:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf tests: fix out of bounds access on array fd
 when cnt is 100
Message-ID: <20180314190016.GF27335@kernel.org>
References: <20180314173354.11250-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314173354.11250-1-colin.king@canonical.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 14, 2018 at 05:33:54PM +0000, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when cnt is 100 an array bounds overflow occurs on the assignment
> of fd[cnt]. Fix this by performing the bounds check on cnt before writing
> to fd.
> 
> Detected by cppcheck:
> tools/perf/tests/bp_account.c:115: (warning) Either the condition
> 'cnt==100' is redundant or the array 'fd[100]' is accessed at index 100,
> which is out of bounds.
> 
> Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")

Thanks, applied.

- Arnaldo
