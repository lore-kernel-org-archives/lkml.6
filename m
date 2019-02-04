Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A67FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150EB214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549290651;
	bh=Z/CjPJdiAgvr6lTQw/BCf4z95Mgcf5VYY+9OmD1RWsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JUmPM2C4v67HAjJUkZGw6TF3Vc6k3jhWOp6oCLEnUd0hIv0dJzh+3iNWeUdPw7bWH
	 785Ik7ZMY0uY5NwSiS0eBCWE0/Z3atrUqPRH8zEYAElMsDfBtQdDYroR9q6tEUZiL1
	 nix8GL4K3vNfEwMpfkk0iIMsWZujghlmNqznD+Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfBDOat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfBDOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:30:49 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490742083B;
        Mon,  4 Feb 2019 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549290648;
        bh=Z/CjPJdiAgvr6lTQw/BCf4z95Mgcf5VYY+9OmD1RWsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ed9G9Fv8UOOLAjmVltKQczxK57iAg+xaMRRjVY1ulJyBdHkjzjhlMcI89JgLNld1k
         SC4XJTj+Bh/0RDKaRSXtmOq64xAw9Q4QdUkPy008sT7t4DDh0O5gFvp8eW00znviHi
         KV+jjGzgz8AVbq+swbXvBhtDPLkUyVReC2JSSdWg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5B804034F; Mon,  4 Feb 2019 11:30:45 -0300 (-03)
Date:   Mon, 4 Feb 2019 11:30:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 0/3] perf tools: Move ipc_symbol computation to resort
Message-ID: <20190204143045.GD5593@kernel.org>
References: <20190204141808.23031-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204141808.23031-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 04, 2019 at 03:18:05PM +0100, Jiri Olsa escreveu:
> hi,
> currently the we make annotation for ipc column during the
> entry display, already outside the progress bar scope, so
> it appears like perf report is stuck.
> 
> You can see that on following example (with perf.data big enough):
>      $ perf record -b ...
>      $ perf report -s symbol
> 
> The report TUI code will appear stuck when scrolling down,
> because annotation are computed at that time. For --stdio,
> the output will be displayed noticeably more slowly, than
> with the fix.
> 
> There's no functional change, I'm just moving the annotation
> retrieval to the resort phase, so all the data are ready for

Thanks, applied.

- Arnaldo
