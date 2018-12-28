Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BBEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97F62148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546000763;
	bh=b06aWJFhgC1tGMduHasfG+YmL0w3YK7WrH2olc5JCfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kh005XAJKTaVBw+W400SyTYNILqZh7tAQDb/t2Jm9yeq8qbMh+JPgsu+qXSV7MUM4
	 U28+ucJFtjubT9STfHWDMBOIneoeIsliiIZFP6FxvIM7qWsM8NsBblgRgD7mCIoQIg
	 ZI4Fqph434e4XlyU68hmjVG8ocXzQBwY6rtluGBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeL1MjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbeL1MjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:39:21 -0500
Received: from quaco.ghostprotocols.net (unknown [177.159.8.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C453B2146F;
        Fri, 28 Dec 2018 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546000761;
        bh=b06aWJFhgC1tGMduHasfG+YmL0w3YK7WrH2olc5JCfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFmRuCs50LZv7umiUXNpcClHPdRvWndHqRWQvxqC+Hr79bP6A9YNMJ3aeYnIiEAJw
         ll2lJHj9ghtQUFnwI/Wn0lVJvN8w7/Orw8/VZOeSj6GAg+VfMi4G07txkYaA8RImlg
         8uvcBbhJAlDjlfcqJBephnoNx4gsJ8RW6uVNL3bU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4474640F61; Fri, 28 Dec 2018 09:39:18 -0300 (-03)
Date:   Fri, 28 Dec 2018 09:39:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH 2/2] perf c2c: Increase the HITM ratio limit for
 displayed cachelines
Message-ID: <20181228123918.GE25753@kernel.org>
References: <20181228101820.28010-1-jolsa@kernel.org>
 <20181228101820.28010-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228101820.28010-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 28, 2018 at 11:18:20AM +0100, Jiri Olsa escreveu:
> The cachelines being reported go down to 0.05%.  hat makes for very
> long output files. Raising that to 0.1%.  The user can always specify
> --show-all if they want all the cachelines.

Thanks, applied.

- Arnaldo
 
> Suggested-by: Joe Mario <jmario@redhat.com>
> Link: http://lkml.kernel.org/n/tip-uwxpd36jutygit56mycanwma@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-c2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 321687f8f373..30584cb44fb7 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1878,7 +1878,7 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
>  	return hpp_list__parse(&c2c_hists->list, output, sort);
>  }
>  
> -#define DISPLAY_LINE_LIMIT  0.0005
> +#define DISPLAY_LINE_LIMIT  0.001
>  
>  static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
>  {
> -- 
> 2.17.2

-- 

- Arnaldo
