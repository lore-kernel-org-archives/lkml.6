Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA578C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8038A205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8038A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJDTaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJDTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:30:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97ED483F3C;
        Thu,  4 Oct 2018 12:36:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id E18042DE62;
        Thu,  4 Oct 2018 12:36:57 +0000 (UTC)
Date:   Thu, 4 Oct 2018 14:36:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf record: encode -k clockid frequency into Perf
 trace
Message-ID: <20181004123657.GD32371@krava>
References: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 04 Oct 2018 12:36:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:57:12PM +0300, Alexey Budankov wrote:
> 
> Store -k clockid frequency into Perf trace to enable timestamps 
> derived metrics conversion into wall clock time on reporting stage.
> 
> Below is the example of perf report output:
> 
> tools/perf/perf record -k raw -- ../../matrix/linux/matrix.gcc
> ...
> [ perf record: Captured and wrote 31.222 MB perf.data (818054 samples) ]
> 
> tools/perf/perf report --header
> # ========
> ...
> # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, clockid = 4
> ...
> # clockid frequency: 1000 MHz
> ...
> # ========
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
