Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0067C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7102D2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7102D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIFMs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:48:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIFMs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEBB940241EA;
        Thu,  6 Sep 2018 08:14:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id 65AABD93DF;
        Thu,  6 Sep 2018 08:14:39 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:14:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180906081438.GB8248@krava>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <20180905112851.GA29759@krava>
 <34e2f944-f5f3-094a-5997-899cea92d206@linux.intel.com>
 <20180905185141.GA2700@kernel.org>
 <7d0d0d1e-4a9d-dc8d-343e-8a3a2d76870c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0d0d1e-4a9d-dc8d-343e-8a3a2d76870c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 08:14:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 08:14:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:03:17AM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 05.09.2018 21:51, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 05, 2018 at 08:37:32PM +0300, Alexey Budankov escreveu:
> >> On 05.09.2018 14:28, Jiri Olsa wrote:
> >>> can't apply this version on Arnaldo's perf/core...
> >  
> >> my git remote -v
> >  
> >> origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (fetch)
> >> origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (push)
> >  
> >> branch is perf/core, according to MAINTAINERS content.
> >  
> >> What is Arnaldo's perf/core? This one?
> >  
> >> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> >  
> >> and branch is perf/core?
> > 
> > yes.
> 
> Is this the actual one for the tool development? Am I missing something?

yep, Arnaldo takes all and pushes his perf/core to Ingo
it's better to always rebase to it

thanks,
jirka
