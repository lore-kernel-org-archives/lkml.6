Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA8D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfBYMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:55:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYMz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:55:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5798B3082B56;
        Mon, 25 Feb 2019 12:55:58 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E504600C8;
        Mon, 25 Feb 2019 12:55:56 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:55:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 07/11] perf tools report: Support running scripts for
 current time range
Message-ID: <20190225125555.GF19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-8-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190224153722.27020-8-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 25 Feb 2019 12:55:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:18AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When using the time sort key, add new context menus to run
> scripts for only the currently selected time range. Compute
> the correct range for the selection add pass it as the --time option to
> perf script.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

getting compilation error:

  CC       ui/browsers/hists.o
ui/browsers/hists.c: In function ‘perf_evsel__hists_browse’:
ui/browsers/hists.c:2565:8: error: ‘%s’ directive output may be truncated writing up to 63 bytes into a region of size between 28 and 91 [-Werror=format-truncation=]
   n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from ui/browsers/hists.c:5:
/usr/include/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 10 and 136 bytes into a destination of size 100
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[jolsa@krava perf]$ gcc --version
gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)

jirka
