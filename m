Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2+z7EvF+GVvBcAAAmS7hNA
	; Thu, 07 Jun 2018 18:53:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2ED0C608B8; Thu,  7 Jun 2018 18:53:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBB1jT7m"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A8A9960590;
	Thu,  7 Jun 2018 18:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8A9960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeFGSxR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932264AbeFGSxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:53:12 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6FB20895;
        Thu,  7 Jun 2018 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528397592;
        bh=THYrxVjExmuaQ+tQAoFKeee0aco41+apFLqM2PFWWok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBB1jT7mWpTbWFoGp/Caj2Hp0L6KPxSRWSBsXawbVLDYO/Cdr7ldsk1rJrxv6mMrJ
         lSQ3VJPUuJRbg/fxAmUhh0bIB8mjbKByXX9Xi2kdn6r4KLXRBrfTRwH/5ec28J3Gz2
         Rc+/sjARy7okDM3FEbjtx0PtFm4B7Y9sK2ccurMU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8FAEF1468B9; Thu,  7 Jun 2018 15:53:09 -0300 (-03)
Date: Thu, 7 Jun 2018 15:53:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 02/10] perf tools: Fix error index for pmu event parser
Message-ID: <20180607185309.GA17292@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-3-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 12:15:05AM +0200, Jiri Olsa escreveu:
> For events we provide specific error message we need to set
> error column index, PMU parser is missing that, adding it.
> 
> Before:
>   $ perf stat -e cycles,krava/cycles/ kill
>   event syntax error: 'cycles,krava/cycles/'
>                        \___ Cannot find PMU `krava'. Missing kernel support?
> 
> After:
>   $ perf stat -e cycles,krava/cycles/ kill
>   event syntax error: 'cycles,krava/cycles/'
>                               \___ Cannot find PMU `krava'. Missing kernel support?

Thanks, tested and applied.

- Arnaldo
