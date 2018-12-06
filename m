Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF01C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DBE20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DBE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeLFKaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:30:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbeLFKaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:30:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1231F308429A;
        Thu,  6 Dec 2018 10:30:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A9D06012C;
        Thu,  6 Dec 2018 10:30:03 +0000 (UTC)
Date:   Thu, 6 Dec 2018 11:30:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206103002.GC27838@krava>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206080910.GD4234@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206080910.GD4234@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 06 Dec 2018 10:30:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:09:10AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
> > Adding support to specify 'block' bool in struct perf_event_attr
> 
> NAK for having _Bool in structures.

oops, will change.. if there's ever another version ;-)

jirka
