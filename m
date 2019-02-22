Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8532075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBVMXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:23:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVMXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:23:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A799882EA;
        Fri, 22 Feb 2019 12:23:43 +0000 (UTC)
Received: from krava (ovpn-204-251.brq.redhat.com [10.40.204.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id 31C7160C80;
        Fri, 22 Feb 2019 12:23:39 +0000 (UTC)
Date:   Fri, 22 Feb 2019 13:23:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 04/17] perf data: Fail check_backup in case of error
Message-ID: <20190222122336.GD3940@krava>
References: <20190221094145.9151-1-jolsa@kernel.org>
 <20190221094145.9151-5-jolsa@kernel.org>
 <20190221222330.GD16922@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221222330.GD16922@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 22 Feb 2019 12:23:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:23:30PM -0800, Andi Kleen wrote:
> On Thu, Feb 21, 2019 at 10:41:32AM +0100, Jiri Olsa wrote:
> > And display the error message from removing
> > the old data file:
> > 
> >   $ perf record ls
> >   Can't remove old data: Permission denied (perf.data.old)
> >   Perf session creation failed.
> > 
> > Not sure how to make fail the rename (after we successfully
> > remove the destination file/dir) to show the message,
> > anyway let's have it there.
> 
> The use of rm_rf is really scary. So I simple command line typo could turn
> this into rm -rf / ? 
> 
> Please add some sanity checks to not remove multiple levels,
> and only remove files which look like they are generated
> by perf.

right, will do

jirka
