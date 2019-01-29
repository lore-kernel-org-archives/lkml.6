Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416A42177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548752511;
	bh=W4JokBxF+mRP/goL0QdH5nt6iAiBAQ/Dk5UwHfF/Stk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g9R0PW+vIMYJAgZ67ImxpAaFI3KtSjPaNNWhnncgoSDMetStjGPn0CV3B73cjhgFQ
	 ebKtcjqJIfIzsE+9U93vS/6hZ4X5+EbSR9tvBNPfNgtt5gR26tvLFPVJhxkxxQ0dFu
	 mdyix1tbIVFHx5duaghXcBIhrLVIDoxqmaoX/Zcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfA2JBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfA2JBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:01:49 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8E321473;
        Tue, 29 Jan 2019 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548752508;
        bh=W4JokBxF+mRP/goL0QdH5nt6iAiBAQ/Dk5UwHfF/Stk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR5PBUxmp3kw0a2ijKo2UitBkUqTgPECd8vpt8l1Ve6aZDPgh7zpsIqABhYmo7zri
         587WGl/eK+ItHSChV6ipvMQ7DwMuXJoSuRLkc/u+3yHW2AjstmfbN0elMsQA88x8y+
         hK7c9mcuKY22BaSNi6aObJmYkKMHYZu+ST5wtxuU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FF1F4034F; Tue, 29 Jan 2019 10:01:46 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:01:46 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: evsel-tp-sched: Fix bitwise operator
Message-ID: <20190129090146.GD4344@kernel.org>
References: <20190122233439.GA5868@embeddedor>
 <20190123083338.GK27625@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123083338.GK27625@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 23, 2019 at 09:33:38AM +0100, Jiri Olsa escreveu:
> On Tue, Jan 22, 2019 at 05:34:39PM -0600, Gustavo A. R. Silva wrote:
> > Notice that the use of the bitwise OR operator '|' always leads to
> > true in this particular case, which seems a bit suspicious due to
> > the context in which this expression is being used.
> > 
> > Fix this by using bitwise AND operator '&' instead.
> > 
> > This bug was detected with the help of Coccinelle.
> > 
> > Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> nice catch
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Argh, applied, and looking for an old brown paper bag...

- Arnaldo
