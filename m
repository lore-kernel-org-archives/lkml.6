Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A465C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA87C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8isgX3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfAQNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:10:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48596 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QZaKJui5uZuX+Q8JyioS4rCZrptBGQIieNrWNao7JB4=; b=A8isgX3SYpPCwBSurlFhyk3iF
        pXkeI8iSWttNxWPo/wBbCIFKnG96ys/d+0+K8bYySN6P8LCvS8YXTioMUHpO4BHIVzeRXmVOcRzS9
        rPRm9a51vTci8rk7YGo1o7yvitLotkjMek4Hv4MAvY4Frieu2hcIRLIr1pJkSa5GEMxxY+QhKvW4k
        1vM6iIbbZwkt+t9UZjEcuL3gdIwQnV6lS3p/M7Ug3X9pEgwtkwcJS197tUWzckSL5MtCdYqI3QAVD
        DOOEYfQtOKDnHbV69PxurhAk4BNWqcftYpMrX3fkBx2PZYkgPfLFesY1r/mYafp9g9genaUQHhOfC
        HpL0KvJmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk7RY-0001Z8-CR; Thu, 17 Jan 2019 13:10:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 716DC202647CE; Thu, 17 Jan 2019 14:10:44 +0100 (CET)
Date:   Thu, 17 Jan 2019 14:10:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v10 perf, bpf-next 9/9] bpf: add module name [bpf] to
 ksymbols for bpf programs
Message-ID: <20190117131044.GH10486@hirez.programming.kicks-ass.net>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-10-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116162931.1542429-10-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:29:31AM -0800, Song Liu wrote:
> With this patch, /proc/kallsyms will show BPF programs as
> 
>   <addr> t bpf_prog_<tag>_<name> [bpf]
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index f3a04994e063..14934afa9e68 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -494,7 +494,7 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
>  
>  static int get_ksymbol_bpf(struct kallsym_iter *iter)
>  {
> -	iter->module_name[0] = '\0';
> +	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
>  	iter->exported = 0;
>  	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
>  			       &iter->value, &iter->type,
> -- 
> 2.17.1
> 
