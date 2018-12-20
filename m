Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99357C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715E4218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbeLTVNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:13:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53536 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389821AbeLTVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:13:12 -0500
Received: from 89-77-194-223.dynamic.chello.pl (89.77.194.223) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id c121bcdb6100cf83; Thu, 20 Dec 2018 22:13:10 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <doug.smythies@gmail.com>
Cc:     srinivas.pandruvada@linux.intel.com, dsmythies@telus.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Fix non root execution for post processing a trace file.
Date:   Thu, 20 Dec 2018 22:12:43 +0100
Message-ID: <2125443.RSXZyCm5gN@aspire.rjw.lan>
In-Reply-To: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
References: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 18, 2018 8:34:04 AM CET Doug Smythies wrote:
> This script is supposed to be allowed to run with regular user privileges
> if a previously captured trace is being post processed.
> 
> Commit fbe313884d7ddd73ce457473cbdf3763f5b1d3da
> tools/power/x86/intel_pstate_tracer: Free the trace buffer memory
> introduced a bug that breaks that option.
> 
> Commit 35459105deb26430653a7299a86bc66fb4dd5773
> tools/power/x86/intel_pstate_tracer: Add optional setting of trace buffer memory allocation
> moved the code but kept the bug.
> 
> This patch fixes the issue.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
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
> 

Applied, thanks!


