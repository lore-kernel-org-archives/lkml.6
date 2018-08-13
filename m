Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB71C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EB32174A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EB32174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeHMVip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:38:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729741AbeHMVip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:38:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DC5B40122B8;
        Mon, 13 Aug 2018 18:55:17 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 736101003200;
        Mon, 13 Aug 2018 18:55:16 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id F1AC6147; Mon, 13 Aug 2018 15:55:11 -0300 (BRT)
Date:   Mon, 13 Aug 2018 15:55:11 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: arm-spe: Fix uninitialized record error
 variable
Message-ID: <20180813185511.GA2146@redhat.com>
References: <20180810174512.52900813e57cbccf18ce99a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810174512.52900813e57cbccf18ce99a2@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 18:55:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 18:55:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'acme@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 10, 2018 at 05:45:12PM -0500, Kim Phillips escreveu:
> The auxtrace init variable 'err' was not being initialized, leading
> perf to abort early in an SPE record command when there was no explicit
> error, rather only based whatever memory contents were on the stack.
> Initialize it explicitly on getting an SPE successfully, the same way
> cs-etm does.
> 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> Hi Arnaldo, please apply to perf/urgent / stable series if at all
> possible.  Thank you.

In such cases the best thing is to have a "Fixes: ..." so that this gets
automatically picked by the stabe trees, I'll try to find out what was
the patch that introduced this problem.

- Arnaldo
