Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5195C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502AD2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6quGgV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502AD2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeHOW0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeHOW0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:26:40 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A9F2152C;
        Wed, 15 Aug 2018 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534361591;
        bh=VfT7UAzTeOfxVAnBgkfc7qO9sM9z/9EzxZeyHDexCUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6quGgV1LCKIbZ0/WWP2uCD4qe5LZ+rXFlXmYSuISCbPRAmQdS5n0fElVb/QXM/wK
         1K6gyz5xSJ4iFTqzLekpCy+qrbdP0W54MQEuGvIt6aEAZU+0yk5zoIdjCXEdkRXznn
         70gMOYw77ChH8zmJ4EAFBYQaSHPDP0hJCTdjUB3Y=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id F422C140A1C; Wed, 15 Aug 2018 16:33:01 -0300 (-03)
Date:   Wed, 15 Aug 2018 16:33:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: disable parallelism for 'make clean'
Message-ID: <20180815193301.GA5976@kernel.org>
References: <20180705131527.19749-1-linux@rasmusvillemoes.dk>
 <20180705134955.GB3686@krava>
 <25cef02d-e991-859b-3cc1-8fc81b8567fb@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25cef02d-e991-859b-3cc1-8fc81b8567fb@rasmusvillemoes.dk>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 15, 2018 at 09:30:39AM +0200, Rasmus Villemoes escreveu:
> On 2018-07-05 15:49, Jiri Olsa wrote:
> > On Thu, Jul 05, 2018 at 03:15:27PM +0200, Rasmus Villemoes wrote:
> 
> >> this only happens in combination with a O=... parameter. In any case, we
> >> don't lose much by explicitly disabling the parallelism for the clean
> >> target, and it makes automated builds much more reliable.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Was this picked up by anyone? I'm not seeing it in -next?

Thanks, applied.

- Arnaldo
