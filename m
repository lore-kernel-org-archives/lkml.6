Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0610C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FDA21990
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FDA21990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeHFPq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:46:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbeHFPq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20D127C6A9;
        Mon,  6 Aug 2018 13:37:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 58CEA2166BA0;
        Mon,  6 Aug 2018 13:37:48 +0000 (UTC)
Date:   Mon, 6 Aug 2018 15:37:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 2/2] perf/hw_breakpoint: Modify breakpoint even if the
 new attr has disabled set
Message-ID: <20180806133747.GB7463@krava>
References: <20180806101241.6444-1-jolsa@kernel.org>
 <20180806101241.6444-3-jolsa@kernel.org>
 <20180806124839.GC7840@redhat.com>
 <20180806130730.GD7840@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806130730.GD7840@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 13:37:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 13:37:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:07:31PM +0200, Oleg Nesterov wrote:
> On 08/06, Oleg Nesterov wrote:
> >
> > But, with or without this fix, shouldn't we set .disabled = 1 if modify_() fails?
> > IIUC this doesn't matter, bp->attr.disabled is not really used anyway, but looks a
> > bit confusing.
> 
> I am looking at another caller perf_event_modify_breakpoint(). It too doesn't set
> attr.disabled = 1 on failure, it does _perf_event_enable() instead so attr.disabled
> should be correct.
> 
> But this looks wrong. If modify_user_hw_breakpoint_check() paths fails after
> arch_validate_hwbkpt_settings() was called, then we can not simply restore

hum, arch_validate_hwbkpt_settings was removed recently.. r u checking the last sources?

jirka
