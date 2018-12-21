Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7252190C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545396378;
	bh=APe+L7skTQcDmKppYb0jhRqW68QpmYd83miFL3Jx3wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h3CmMZjxrpVjCLK05vz+Ibcxv0B/oPVEC6ShzRYj7xtfEsAdWIukpUpCX/BrRiDyg
	 TeY5aPv2vvtPl8VWOv8722yIDXZ7+MyKnfflohqQfv5EitQy3wjvbMtKqM3FWvlN52
	 7M2fJBYGEQW26vMHlvXu5pM1zhLOOOhkMT8EuFNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbeLUMqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390384AbeLUMqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:46:15 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A64D92190C;
        Fri, 21 Dec 2018 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545396374;
        bh=APe+L7skTQcDmKppYb0jhRqW68QpmYd83miFL3Jx3wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opG31RPEukuA/kUmq0JbafLywJqgB2EYYfaTRjbm4JVKdPwYS2MFy7zzPPnY7denI
         NvP2JN7HoZN6wE1+LY4j3HsyWaY538Q107otfqKGcuTnVfVWRgRImrQPBx3+KO5w7O
         jUy2YuRAR69WoSPhd/HhMM5jVvTaCGQR529v86WE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 331BF403A8; Fri, 21 Dec 2018 09:46:11 -0300 (-03)
Date:   Fri, 21 Dec 2018 09:46:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf trace: use correct SECCOMP prefix spelling,
 "SECOMP_*" -> "SECCOMP_*"
Message-ID: <20181221124611.GA4210@kernel.org>
References: <20181221084809.6108-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221084809.6108-1-colin.king@canonical.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 21, 2018 at 08:48:09AM +0000, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The spelling of the SECCOMP is incorrect, fix these.

Thanks, applied.

- Arnaldo
 
> Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/perf/trace/beauty/seccomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
> index 4600c28a3cfe..637722e2796b 100644
> --- a/tools/perf/trace/beauty/seccomp.c
> +++ b/tools/perf/trace/beauty/seccomp.c
> @@ -9,7 +9,7 @@
>  static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
>  {
>  	bool show_prefix = arg->show_string_prefix;
> -	const char *prefix = "SECOMP_SET_MODE_";
> +	const char *prefix = "SECCOMP_SET_MODE_";
>  	int op = arg->val;
>  	size_t printed = 0;
>  
> @@ -34,7 +34,7 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
>  						   struct syscall_arg *arg)
>  {
>  	bool show_prefix = arg->show_string_prefix;
> -	const char *prefix = "SECOMP_FILTER_FLAG_";
> +	const char *prefix = "SECCOMP_FILTER_FLAG_";
>  	int printed = 0, flags = arg->val;
>  
>  #define	P_FLAG(n) \
> -- 
> 2.19.1

-- 

- Arnaldo
