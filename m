Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E0C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E64120661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544116192;
	bh=9o6aRwHBwxQ+vo2m88S2w40GqxLeZSNl3jYq9ZTXWxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MKOk7LhQpSCHxF7MkkyWFBLlCzWLMNk10N+Wa5R0E9REt18uvMb4Ahzns1TZ+QaOS
	 Fnk6LgoOnlqcAQZzT4Lvl7tLkin16B+fvEI+Co+sOCC+R6/SKY4x9oY7rnbBB8ix0k
	 ICS6TBJ1OL6omp8HCaFKBWfLzIIxwb7VF3TSbeGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E64120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLFRJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeLFRJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:09:50 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0788020878;
        Thu,  6 Dec 2018 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544116190;
        bh=9o6aRwHBwxQ+vo2m88S2w40GqxLeZSNl3jYq9ZTXWxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIQYmoaN5LhJfO7zeK9/zm3Bn4erl5AdKG33FYAZtaqeMcSL8EmDDRyRcFnGcn2A6
         SSSGYitIYz/PNtiJDhM/Tesg5Rppx+B3cbzOPUR6MQDxl2Rq88L9H//018J52b5LVK
         eqTTDe9Uwic+8AWQoPvnSipcHJN1YA4b270/hVdY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0EF34042C; Thu,  6 Dec 2018 14:09:47 -0300 (-03)
Date:   Thu, 6 Dec 2018 14:09:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sihyeon Jang <uneedsihyeon@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf util config : Modify size factor of snprintf
Message-ID: <20181206170947.GL19069@kernel.org>
References: <20181201154603.10093-1-uneedsihyeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201154603.10093-1-uneedsihyeon@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 02, 2018 at 12:46:03AM +0900, Sihyeon Jang escreveu:
> According to definition of snprintf, it gets size factor including null('\0') byte.
> So '-1' is not neccessary. Also it will be helpful unfied style with other cases. (eg. builtin-script.c)

Thanks, applied.

- Arnaldo
 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
> ---
>  tools/perf/util/config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 5ac157056cdf..bce980fa9f41 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -811,14 +811,14 @@ int config_error_nonbool(const char *var)
>  void set_buildid_dir(const char *dir)
>  {
>  	if (dir)
> -		scnprintf(buildid_dir, MAXPATHLEN-1, "%s", dir);
> +		scnprintf(buildid_dir, MAXPATHLEN, "%s", dir);
>  
>  	/* default to $HOME/.debug */
>  	if (buildid_dir[0] == '\0') {
>  		char *home = getenv("HOME");
>  
>  		if (home) {
> -			snprintf(buildid_dir, MAXPATHLEN-1, "%s/%s",
> +			snprintf(buildid_dir, MAXPATHLEN, "%s/%s",
>  				 home, DEBUG_CACHE_DIR);
>  		} else {
>  			strncpy(buildid_dir, DEBUG_CACHE_DIR, MAXPATHLEN-1);
> -- 
> 2.17.1

-- 

- Arnaldo
