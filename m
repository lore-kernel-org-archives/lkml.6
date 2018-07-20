Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4142D204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4142D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbeGTQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731035AbeGTQEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 754524078070;
        Fri, 20 Jul 2018 15:15:21 +0000 (UTC)
Received: from krava (ovpn-204-117.brq.redhat.com [10.40.204.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 850D61C5BF;
        Fri, 20 Jul 2018 15:15:19 +0000 (UTC)
Date:   Fri, 20 Jul 2018 17:15:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/4] perf tools: Fix check-headers.sh output file
 variables
Message-ID: <20180720151518.GC27176@krava>
References: <20180720110036.32251-1-jolsa@kernel.org>
 <20180720110036.32251-3-jolsa@kernel.org>
 <20180720145745.GB4329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720145745.GB4329@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 15:15:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 15:15:21 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:57:45AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 20, 2018 at 01:00:35PM +0200, Jiri Olsa escreveu:
> > The warning message in check_w function uses wrongly
> > the $file variable instead of $file1 and $file2.
> 
> Humm,
> 
> Before:
> 
> Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'
> 
> After:
> 
> Warning: Kernel ABI header at '../arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at '../../arch/powerpc/include/uapi/asm/unistd.h'
> 
> 
> The previous version is better, I can then just use:
> 
> diff -u tools/arch/powerpc/include/uapi/asm/unistd.h arch/powerpc/include/uapi/asm/unistd.h
> 
> and get what changed, with your change I have to go to tools/perf before
> doing that diff, which is an unnecessary extra step in at least my
> workflow.

so all paths output based in kernel tree root then, will change

jirka
