Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79D20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qehjuPHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC79D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIEXXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeIEXXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:23:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DF72077C;
        Wed,  5 Sep 2018 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536173508;
        bh=ZUZ+PNISn0zdHof5Gt1rA2QooSEjQ59sw1yuJhz08gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qehjuPHI2CdEvypmXepoC0MCqdeHdg1RbnNfEKE4qGSSPnkE8auvEI/7K227h7bRx
         oEnWUvTNIC6kmqwmDU5wJe5DFvxr9LnXloOzRVmrYOHE/YhFYKsEwkCHT08iuzp9mZ
         N+ZfRNpwTZ9Lxa11b4GpI8ap5mzIJUnx2cB9JilI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 21373141FFC; Wed,  5 Sep 2018 15:51:41 -0300 (-03)
Date:   Wed, 5 Sep 2018 15:51:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180905185141.GA2700@kernel.org>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <20180905112851.GA29759@krava>
 <34e2f944-f5f3-094a-5997-899cea92d206@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e2f944-f5f3-094a-5997-899cea92d206@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 05, 2018 at 08:37:32PM +0300, Alexey Budankov escreveu:
> On 05.09.2018 14:28, Jiri Olsa wrote:
> > can't apply this version on Arnaldo's perf/core...
 
> my git remote -v
 
> origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (fetch)
> origin	git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (push)
 
> branch is perf/core, according to MAINTAINERS content.
 
> What is Arnaldo's perf/core? This one?
 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
 
> and branch is perf/core?

yes.

- Arnaldo
