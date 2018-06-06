Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZEQRLstrGFvxfQAAmS7hNA
	; Wed, 06 Jun 2018 23:18:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9D770608B8; Wed,  6 Jun 2018 23:18:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="WnVThfxK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1ABB8607E4;
	Wed,  6 Jun 2018 23:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ABB8607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFFXSd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:18:33 -0400
Received: from one.firstfloor.org ([193.170.194.197]:42390 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeFFXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:18:31 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2018 19:18:31 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 43C7586897; Thu,  7 Jun 2018 01:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1528326619;
        bh=lZE/h/QyE9RRJ+CpBm0gwuWPPWRMlhvf59REC+HsWTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnVThfxKgMwOQy1D2QsQWOFlBqZMsh4B8J/PPAGDqRPYipSEI4K5JMN9FQPuvVAHW
         du3li48YEi5ysyMqqa3bgiWJIgvsFjnVkzz3w9Sq+pMXpohdP+BsQjHb2FM5EzwK4c
         X3skt5q1cFiUzao+HGw2+jb3sOFhSjp/ZBD4UTeQ=
Date: Wed, 6 Jun 2018 16:10:18 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC 00/10] perf: Add cputime events/metrics
Message-ID: <20180606231016.o3u3u3nduoq7227e@two.firstfloor.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I had some issues with IDLE counter being miscounted due to stopping
> of the idle tick. I tried to solve it in this patch (it's part of the
> patchset):
>   perf/cputime: Don't stop idle tick if there's live cputime event
> 
> but I'm pretty sure it's wrong and there's better solution.

At least on intel we already have hardware counters for different idle
states. You just would need to add them and convert to the same
unit.

But of course it's still useful when this is not available.

> My current plan is now to read those counters in perf top/record/report
> to show (at least) the idle percentage for the current profile.

It's useful. Thanks for working on it. I was thinking about doing
something similar for some time.

-Andi
