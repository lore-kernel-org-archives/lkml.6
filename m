Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cEBEO7HsGlvcCgAAmS7hNA
	; Fri, 08 Jun 2018 20:53:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C88D8607E4; Fri,  8 Jun 2018 20:53:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/Z7DruW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 31072607A4;
	Fri,  8 Jun 2018 20:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31072607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeFHUxC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:53:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40465 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeFHUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:53:00 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so8922265plo.7;
        Fri, 08 Jun 2018 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bqzJLKN2GQxJTIOq61RMJCzPRmz2NyxKqcr4VJzb0Ns=;
        b=d/Z7DruWPLBV8LNxCySf46BKPsV5QQanh/wONi7ekqHk0IAq48Lru3hh2j97ZyYaAU
         iszNfIGO1VKX2K5a2PYAA+lRsQ/HEnO23m30WAYmVMcU1hcXu6Uw+URq1i0m190rvxe3
         rOHPk2hPSBQOg6GCi6RJJXInJXv4kdQOFSgfylZVcUxU+7E1W/Dnx9E88FJDDbhk5hTG
         R0yYXC6ClQMql+3TQl2cY3nc2GI58Z6MrAB6lEpXFPwUiOIzeZzDPAa6rnPrfNYfavR8
         PCvQLLeislUZ1em9pRUbfH6pZssTemFGBcuKYqfRDYwU9exX1wYgW1EoCX6WmT7bcn6G
         NhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqzJLKN2GQxJTIOq61RMJCzPRmz2NyxKqcr4VJzb0Ns=;
        b=uQNmKjoMwDP7y8URg2f72gW5JoDFfNAP+s29LC7KMCfmHP75HF6UuF/UUg90aL/o3O
         h+bm69BSu681k+jt5sgaOa+dui97KgacoTc4/bbKQpyzVFKrByGh0unNYL8NTsF9nA4g
         WSJMqjPfCLPEl3q9X9icTE1EFO3QZSZrzcN9zBjUe6xG/3edgj8O3rg60dTfvvfVGifZ
         0XO6NFj1SP3Jl/4rX4rpwLojcjGatbvsBvEDUKpvk3mGxsWckM9Qu7u/b4aZ3zyUGmH8
         7OqwSshMCLZdKJk8CoIs5XLiT9LgA2L89XGo0fK/hVewTHA3cq+QnsQeCXvDtTPNx+Dc
         D9OA==
X-Gm-Message-State: APt69E307FH1gCXEgt9M/61yXrPUzPCKhjUSjAyaHPK41A51d74WntFy
        pquOcTQJHp3V4wZi7GbhfD4=
X-Google-Smtp-Source: ADUXVKKtbrf2/sasovIA9DVyDND5zoPeBcQPtP9wzKIgxt1GVfaGOEnAyZZ7oEpTWnA2RZG3ZmhoEA==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24-v6mr402311plo.250.1528491180359;
        Fri, 08 Jun 2018 13:53:00 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:bb0a])
        by smtp.gmail.com with ESMTPSA id g4-v6sm60999971pfg.38.2018.06.08.13.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:52:59 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:52:57 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 3/3] bpfilter: do not (ab)use host-program build rule
Message-ID: <20180608205256.cpniquglftmie5vl@ast-mbp.dhcp.thefacebook.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
 <1528477930-7342-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528477930-7342-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 02:12:10AM +0900, Masahiro Yamada wrote:
> It is an ugly hack to overwrite $(HOSTCC) with $(CC) to reuse the
> build rules from scripts/Makefile.host.  It should not be tedious
> to write a build rule for its own.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  net/bpfilter/Makefile                   | 17 +++++++++++------
>  net/bpfilter/{main.c => bpfilter_umh.c} |  0
>  2 files changed, 11 insertions(+), 6 deletions(-)
>  rename net/bpfilter/{main.c => bpfilter_umh.c} (100%)
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index 39c6980..6571b30 100644
> --- a/net/bpfilter/Makefile
> +++ b/net/bpfilter/Makefile
> @@ -3,18 +3,23 @@
>  # Makefile for the Linux BPFILTER layer.
>  #
>  
> -hostprogs-y := bpfilter_umh
> -bpfilter_umh-objs := main.o
> -HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
> -HOSTCC := $(CC)

that is a hack indeed. I don't like it either, but see below.

> -
>  ifeq ($(CONFIG_BPFILTER_UMH), y)
>  # builtin bpfilter_umh should be compiled with -static
>  # since rootfs isn't mounted at the time of __init
>  # function is called and do_execv won't find elf interpreter
> -HOSTLDFLAGS += -static
> +STATIC := -static
>  endif
>  
> +quiet_cmd_cc_user = CC      $@
> +      cmd_cc_user = $(CC) -Wall -Wmissing-prototypes -O2 -std=gnu89 \
> +		    -I$(srctree) -I$(srctree)/tools/include/ \
> +		    -I$(srctree)/tools/include/uapi $(STATIC) -o $@ $<
> +
> +$(obj)/bpfilter_umh: $(src)/bpfilter_umh.c FORCE
> +	$(call if_changed,cc_user)

Does this scale?
Please see two top patches here:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/log/?h=ipt_bpf
that add more meat to bpfilter and a lot more files.
Recompiling all of them at once isn't nice either.
This Makefile needs different .c -> .o rules for bpfilter_kern.c files
that get compiled into kernel module and for the rest of umh files:
main.c ctor.c init.c gen.c etc
that need to be compiled .c -> .o differently.
I don't see how to do it without ugly hacks in Makefile.
In that sense HOSTCC = CC hack looked the least ugly to me that's
why I went with it.
Better ideas?
