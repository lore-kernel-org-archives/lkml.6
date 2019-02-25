Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991C120842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBYM5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:57:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfBYM5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:57:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47DFD30842B1;
        Mon, 25 Feb 2019 12:57:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E531600C8;
        Mon, 25 Feb 2019 12:57:33 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:57:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 09/11] perf tools report: Support builtin perf script in
 scripts menu
Message-ID: <20190225125732.GA29870@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-10-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190224153722.27020-10-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 25 Feb 2019 12:57:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:20AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The scripts menu traditionally only showed custom perf scripts.
> 
> Allow to run standard perf script with useful default options too.
> 
> - Normal perf script
> - perf script with assembler (needs xed installed)
> - perf script with source code output (needs debuginfo)
> - perf script with custom arguments
> 
> Then we automatically select the right options to
> display the information in the perf.data file.
> 
> For example with -b display branch contexts.
> 
> It's not easily possible to check for xed's existence
> in advance.  perf script usually gives sensible error messages when
> it's not available.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>


cannot compile this one:

ui/browsers/scripts.c: In function ‘script_browse’:
ui/browsers/scripts.c:118:35: error: ‘%s’ directive writing up to 1023 bytes into a region of size 248 [-Werror=format-overflow=]
   sprintf(script_name, "%s script %s", perf, script_args);
                                   ^~         ~~~~~~~~~~~
In file included from /usr/include/stdio.h:862,
                 from ui/browsers/../../util/color.h:5,
                 from ui/browsers/../../util/sort.h:8,
                 from ui/browsers/scripts.c:6:
/usr/include/bits/stdio2.h:33:10: note: ‘__builtin___sprintf_chk’ output 9 or more bytes (assuming 1032) into a destination of size 256
   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       __bos (__s), __fmt, __va_arg_pack ());

[jolsa@krava perf]$ gcc --version
gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)


jirka
