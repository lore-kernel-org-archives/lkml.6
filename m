Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A2FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9130B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wVAwQQIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9130B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeH3V5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeH3V5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:57:46 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C1520658;
        Thu, 30 Aug 2018 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535651669;
        bh=G31ShcMSO1UmARTVncAYk0UyzorAP1SibgjfrqHyReY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wVAwQQIzhhpkBQbDeXWrwph8tmQXtF3Nr0uLXoOfSC+30+sxa+jgJYE9Eo7poR9o4
         /2a9MrjeHPvMRUb6PxPne93jMNncMYl6VRECXNxEoecRZRebpHHf96rcjXOW1lw/ii
         co9ja+RcZYM07tizutuMHKWKsYhhfuDi4ZjWRM9I=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 39BE4141C3F; Thu, 30 Aug 2018 14:54:18 -0300 (-03)
Date:   Thu, 30 Aug 2018 14:54:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 00/43] perf stat: Make some of the stat code generic
Message-ID: <20180830175418.GC6097@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 30, 2018 at 08:32:09AM +0200, Jiri Olsa escreveu:
> hi,
> while going for the ability to store/display stat data
> in perf record/top I ended up with bunch of generic
> patches that make some of the stat functions standalone
> and simplify/reduce the builtin-stat.c code.
> 
> This patchset mostly separates the display functions
> into separate object, plus several other functions.
> 
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes

Thanks, applied,

- Arnaldo
