Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7E72145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9G8Ahwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7E72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeLACfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbeLACfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:35:05 -0500
Received: from quaco.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E761C20868;
        Fri, 30 Nov 2018 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543591525;
        bh=YnUhBgI7GmanGOODiaoIpAmmhmxpm5Ko5iOH8ys2vis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9G8AhwjwEEiizz3+hNfJalx4X7mbb2IWZG29y8mxiyUPac+5Zop5GJlrms7tx8NQ
         P5ehws4opYws0Yb7T5XirgTq+NVZA+l5cYHIua6PkypFttUkm2BD9+F9LdU9q8SV4O
         86nE5YWZsktiPbbeoXJrFN0sQs5HfE4GyK/ZxhsI=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 9B6E440358; Fri, 30 Nov 2018 12:25:21 -0300 (-03)
Date:   Fri, 30 Nov 2018 12:25:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     leo.yan@linaro.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] perf evsel: Correct clock unit to nanosecond
Message-ID: <20181130152521.GA10748@kernel.org>
References: <1543572365-11706-1-git-send-email-leo.yan@linaro.org>
 <20181130102154.GA3617@krava>
 <20181130142140.GB11833@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130142140.GB11833@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 30, 2018 at 10:21:40PM +0800, leo.yan@linaro.org escreveu:
> On Fri, Nov 30, 2018 at 11:21:54AM +0100, Jiri Olsa wrote:
> > On Fri, Nov 30, 2018 at 06:06:05PM +0800, Leo Yan wrote:
> > > Since commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> > > function"), the cpu and task clock unit has been changed from
> > > nanosecond value to millisecond value.  This introduces confusion for
> > > CPU run time statistics, we can see in below flow the clock value is
> > > scaled from nanosecond value to millisecond value; but this is
> > > contradiction with statistics type 'STAT_NSECS', which always takes
> > > clock as nanosecond unit.
> 
> [...]
> 
> > there was fix for this recently, could you please check
> > if it's working for you:
> >   6e269c85dcea perf stat: Fix shadow stats for clock events
> 
> Ah, I missed this patch ...
> 
> Yeah, I tested this patch and can confirm this patch fixes
> this issue.

My fault, new notebook update process got in the way causing
acme/perf/core to pile up, a perf/core pull req is about to be sent to
Ingo now tho :-)

- Arnaldo
