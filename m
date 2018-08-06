Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C14C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD31921A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/EiOO46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD31921A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbeHFUn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbeHFUn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:43:29 -0400
Received: from jouet.infradead.org (unknown [177.79.80.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72D921A52;
        Mon,  6 Aug 2018 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533580389;
        bh=NwelHjuxFWnNmmOt2Az/xKyNZHYpWLHScV/CBpSYjIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/EiOO46uQjfV7Kj8Zb0ozyAI3/tMEDElgoDnlby+S3iASkHP+wKUdMGA1ZhyVDJ5
         JSsLOQDKLPDAQdxUsjRajcPioun5eEjtuOEzYG3VzsmFnQtDdR9DQv3ej3ozS0OSoS
         Mq26VwEGd7Xkg85aATMrG1c4zlve5Y6BbtCJ0jF4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 129F4140A1C; Mon,  6 Aug 2018 15:33:06 -0300 (-03)
Date:   Mon, 6 Aug 2018 15:33:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 19/20] perf annotate: Add --percent-type option
Message-ID: <20180806183306.GE22917@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-20-jolsa@kernel.org>
 <20180806134912.GB6983@danjae.aot.lge.com>
 <20180806142625.GC16446@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806142625.GC16446@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 06, 2018 at 04:26:25PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 06, 2018 at 10:49:12PM +0900, Namhyung Kim wrote:
> > On Sat, Aug 04, 2018 at 03:05:20PM +0200, Jiri Olsa wrote:
> > > The local/global keywords set if the percentage is computed
> > > in the scope of the function (local) or the whole data (global).

> > > The period/hits keywords set the base the percentage is computed
> > > on - the samples period or the number of samples (hits).

> > What about adding "period" as an alias to "local-period" (and same for
> > "hits" as well)?

> I dont mind that.. will add to v2 if there are no objections

Please add this on top of this, I'm finishing processing this now.

- Arnaldo
