Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A6C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07A42089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07A42089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJBW0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeJBW0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:26:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B8468EB54;
        Tue,  2 Oct 2018 15:42:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id 695F05D756;
        Tue,  2 Oct 2018 15:42:35 +0000 (UTC)
Date:   Tue, 2 Oct 2018 17:42:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 2/2] perf record: Support weak groups
Message-ID: <20181002154234.GD6357@krava>
References: <20181001195927.14211-1-andi@firstfloor.org>
 <20181001195927.14211-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001195927.14211-2-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 02 Oct 2018 15:42:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:59:27PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Implement a weak group fallback for perf record, similar to the existing perf stat support.
> This allows to use groups that might be longer than the available counters without
> failing.
> 
> Before:
> 
> $ perf record  -e '{cycles,cache-misses,cache-references,cpu_clk_unhalted.thread,cycles,cycles,cycles}' -a sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> After:
> 
> $ ./perf record  -e '{cycles,cache-misses,cache-references,cpu_clk_unhalted.thread,cycles,cycles,cycles}:W' -a sleep 1
> WARNING: No sample_id_all support, falling back to unordered processing
> [ perf record: Woken up 3 times to write data ]
> [ perf record: Captured and wrote 8.136 MB perf.data (134069 samples) ]
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
