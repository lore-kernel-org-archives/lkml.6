Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49AB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfBSOFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:05:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBSOFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:05:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E38FC00734E;
        Tue, 19 Feb 2019 14:05:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 66E0D60C1D;
        Tue, 19 Feb 2019 14:05:01 +0000 (UTC)
Date:   Tue, 19 Feb 2019 15:04:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: fix documentation of the Flags section in perf.data
Message-ID: <20190219140459.GE6435@krava>
References: <20190217232246.GB26460@krava>
 <20190218141846.2995-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218141846.2995-1-jonas.rabenstein@studium.uni-erlangen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 14:05:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 03:18:46PM +0100, Jonas Rabenstein wrote:
> According to the current documentation the flags section is placed after
> the file header itself but the code assumes to find the flags section
> after the data section. This change updates the documentation to that
> assumption.

missing your Signed-off-by

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/Documentation/perf.data-file-format.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 5f9a3924830b..593ef49b273c 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -43,11 +43,10 @@ struct perf_file_section {
>  
>  Flags section:
>  
> -The header is followed by different optional headers, described by the bits set
> -in flags. Only headers for which the bit is set are included. Each header
> -consists of a perf_file_section located after the initial header.
> -The respective perf_file_section points to the data of the additional
> -header and defines its size.
> +For each of the optional features a perf_file_section it placed after the data
> +section if the feature bit is set in the perf_header flags bitset. The
> +respective perf_file_section points to the data of the additional header and
> +defines its size.
>  
>  Some headers consist of strings, which are defined like this:
>  
> -- 
> 2.19.2
> 
