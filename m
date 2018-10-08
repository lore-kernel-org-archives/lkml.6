Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFDBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D791205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D791205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJHWeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:34:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:48112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeJHWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:34:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 08:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="76341890"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 08 Oct 2018 08:21:52 -0700
Received: from [10.252.30.144] (abudanko-mobl.ccr.corp.intel.com [10.252.30.144])
        by linux.intel.com (Postfix) with ESMTP id 006285801E6;
        Mon,  8 Oct 2018 08:21:49 -0700 (PDT)
Subject: Re: [PATCH v11 3/3]: perf record: extend trace writing to multi AIO
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <3c3d65dc-b2f6-b102-1805-a05ee6755653@linux.intel.com>
 <20181008105509.GH17270@krava>
 <4016811d-74ac-fffc-7dc9-1c7acaf228be@linux.intel.com>
 <20181008124538.GE18757@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e999d83f-5a2d-6e59-bc46-25b3516ed425@linux.intel.com>
Date:   Mon, 8 Oct 2018 18:21:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008124538.GE18757@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.10.2018 15:45, Jiri Olsa wrote:
<SNIP>
> 
> 'perf record --aio-cblocks=N' could imply '--aio',
> 
> I'd like to have simple/intuitive way to enable that,
> without studing the meaning of the cblocks argument
> 
>   # perf record --aio ...
> 
> means that I'm storing data via async writes,
> and using some reasonable default for cblocks

Semantically, --aio is equal to --aio-cblocks=default, as you said.
So, options duplication could be avoided by having some parsing 
callback using OPT_CALLBACK().

> 
> and later on we'd add 'perf record --threads'
> allowing threads based writers ;-)

Oh, I see. Cool.

Thanks,
Alexey

> 
> jirka
> 
