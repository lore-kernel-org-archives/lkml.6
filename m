Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F61C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64E8214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeLSQzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:55:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:53872 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbeLSQzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:55:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 08:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="102930524"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2018 08:55:00 -0800
Message-ID: <1159108890c3350e9478833f7564e0400b5c887e.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Fix non root
 execution for post processing a trace file.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <doug.smythies@gmail.com>, rjw@rjwysocki.net
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Wed, 19 Dec 2018 08:55:00 -0800
In-Reply-To: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
References: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 23:34 -0800, Doug Smythies wrote:
> This script is supposed to be allowed to run with regular user
> privileges
> if a previously captured trace is being post processed.
> 
> Commit fbe313884d7ddd73ce457473cbdf3763f5b1d3da
> tools/power/x86/intel_pstate_tracer: Free the trace buffer memory
> introduced a bug that breaks that option.
> 
> Commit 35459105deb26430653a7299a86bc66fb4dd5773
> tools/power/x86/intel_pstate_tracer: Add optional setting of trace
> buffer memory allocation
> moved the code but kept the bug.
> 
> This patch fixes the issue.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git
> a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index 84e2b64..2fa3c57 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -585,9 +585,9 @@ current_max_cpu = 0
>  
>  read_trace_data(filename)
>  
> -clear_trace_file()
> -# Free the memory
>  if interval:
> +    clear_trace_file()
> +    # Free the memory
>      free_trace_buffer()
>  
>  if graph_data_present == False:

