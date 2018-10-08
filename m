Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB9C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90922075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90922075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeJHWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeJHWZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92EFD8831F;
        Mon,  8 Oct 2018 15:13:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id E57E43091888;
        Mon,  8 Oct 2018 15:12:58 +0000 (UTC)
Date:   Mon, 8 Oct 2018 17:12:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
Message-ID: <20181008151258.GI18757@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
 <20181008105057.GD17270@krava>
 <f8ac7176-26a4-7114-3807-abdaffaa897c@linux.intel.com>
 <20181008123859.GD18757@krava>
 <cc781e40-c162-9581-9573-d994785c4cc1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc781e40-c162-9581-9573-d994785c4cc1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 08 Oct 2018 15:13:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:43:38PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 08.10.2018 15:38, Jiri Olsa wrote:
> > On Mon, Oct 08, 2018 at 03:03:18PM +0300, Alexey Budankov wrote:
> <SNIP>
> >>
> >> Well, let's go with stub functions design as opposite to pure 
> >> conditional compilation. However this may, probably, result in 
> >> unintended Perf tool binary size growth, even if NO_AIO is 
> >> defined during compilation.
> > 
> > hum, empty functions are be optimized out
> 
> Yes, but there will be references to stubs in else branch of 
> record__mmap_read_evlist() so I am not sure that *all* compilers 
> are smart enough to recognize and still optimize it out.

well, kernel is doing that and it seem to be fine,
so I wouldn't worry about it

jirka
