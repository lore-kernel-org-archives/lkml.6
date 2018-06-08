Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +8fvJDbrGlvCeAAAmS7hNA
	; Fri, 08 Jun 2018 20:47:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BCB55608BF; Fri,  8 Jun 2018 20:47:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExX82/wz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1B7FB602FC;
	Fri,  8 Jun 2018 20:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B7FB602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeFHUrd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:47:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44776 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeFHUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:47:32 -0400
Received: by mail-pg0-f67.google.com with SMTP id p21-v6so6902478pgd.11;
        Fri, 08 Jun 2018 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qt8n2vghXnMjhnxJLNI8Q8Otv+XFfc0NrBUKNfDM1uE=;
        b=ExX82/wzNAQQ7CmeYZll5SMilh2amavgzVh8H69cF1xz/pUgA6jseGbdkVKBnpx4/Y
         3n6kr1SqqVtxtnrbZzaPL0sPmfJ+M6WsF/9WV+Gg4x3pbyPY3LdrUMcfbcu4JgQ0uvpv
         580/o5Y/9GOWvjGqpLsMvS8ghjTvlDw7Y/NbZkd1WiaucEifzj1nT8R1HbRLqDLeKchT
         oNpLw5yU+X1HjJvK6GXa7ZmZEUc3enLzSWGVgRIoAad1AiJBWwMzafzVWY7BBobCOlTW
         GcKqw8OI6YUalr/Pw2mgj/kocOl8r0xhV+xZF/V6pSZNQ49lyz8Clk4v+xMQ8K8H73na
         c4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qt8n2vghXnMjhnxJLNI8Q8Otv+XFfc0NrBUKNfDM1uE=;
        b=Q/tB3uAaZTldPbbaiPOFo3MnXJ2qBySjM0GajPpejMIldIeOAHQo8YI1kdunGo/xbi
         fKpT6k8siEIOR+WZW17GTJBl3liBfwE3nS7tW+eXX/FMs2bVPZBF9QtJ553qlYPlzj7X
         KGnLBZvho1M08NWd5m/gbY6oWNqHzwAbBdMKvCElZbXYbU4129kUWbDTzsUE9EyODAiT
         1uk+ZrnZnFvltdTIjIIYpKzCULnEsHZJ5289Qc2LX7nDjbPD+NB2GPdaipQz1u7RgbLs
         T8H9SMG/YWcRutmCnA+8sDEnP6FTaWq3gFNMz9tJl0F6sYlqwqGBPKADTpZ2LjYpFXJ0
         ecPQ==
X-Gm-Message-State: APt69E0TZkIUGTGERdz3Z6u13z2ub/dWbT38UBdNNN2iK2KlXVlaGUht
        QSNWpu40pI6ny5mPeBqfRBDrrCOI
X-Google-Smtp-Source: ADUXVKJEyirNYNPYKZoMgd05GakUsFo87d9f75U1XAqEVkO0OmsoBm2Br+m4/w3LhODgXeXc5JfRfA==
X-Received: by 2002:a62:2281:: with SMTP id p1-v6mr7503968pfj.53.1528490851731;
        Fri, 08 Jun 2018 13:47:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:bb0a])
        by smtp.gmail.com with ESMTPSA id h17-v6sm88584553pfn.80.2018.06.08.13.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:47:30 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:47:28 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 2/3] bpfilter: include bpfilter_umh in assembly instead
 of using objcopy
Message-ID: <20180608204727.jggtai5iro7ao34v@ast-mbp.dhcp.thefacebook.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
 <1528477930-7342-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528477930-7342-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 02:12:09AM +0900, Masahiro Yamada wrote:
> Do not use the troublesome ELF magic.  What is happening here is to
> embed a user-space program into the kernel.  Simply wrap it in the
> assembly with the '.incbin' directive.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  net/bpfilter/Makefile            | 15 ++-------------
>  net/bpfilter/bpfilter_kern.c     | 11 +++++------
>  net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
>  3 files changed, 14 insertions(+), 19 deletions(-)
>  create mode 100644 net/bpfilter/bpfilter_umh_blob.S
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index aafa720..39c6980 100644
> --- a/net/bpfilter/Makefile
> +++ b/net/bpfilter/Makefile
> @@ -15,18 +15,7 @@ ifeq ($(CONFIG_BPFILTER_UMH), y)
>  HOSTLDFLAGS += -static
>  endif
>  
> -# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> -# inside bpfilter_umh.o elf file referenced by
> -# _binary_net_bpfilter_bpfilter_umh_start symbol
> -# which bpfilter_kern.c passes further into umh blob loader at run-time
> -quiet_cmd_copy_umh = GEN $@
> -      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> -      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
> -      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> -      --rename-section .data=.init.rodata $< $@
> -
> -$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
> -	$(call cmd,copy_umh)
> +$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
>  
>  obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
> -bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
> +bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> index b13d058..fcc1a7c 100644
> --- a/net/bpfilter/bpfilter_kern.c
> +++ b/net/bpfilter/bpfilter_kern.c
> @@ -10,11 +10,8 @@
>  #include <linux/file.h>
>  #include "msgfmt.h"
>  
> -#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
> -#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
> -
> -extern char UMH_start;
> -extern char UMH_end;
> +extern char bpfilter_umh_start;
> +extern char bpfilter_umh_end;
>  
>  static struct umh_info info;
>  /* since ip_getsockopt() can run in parallel, serialize access to umh */
> @@ -89,7 +86,9 @@ static int __init load_umh(void)
>  	int err;
>  
>  	/* fork usermode process */
> -	err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
> +	err = fork_usermode_blob(&bpfilter_umh_end,
> +				 &bpfilter_umh_end - &bpfilter_umh_start,
> +				 &info);
>  	if (err)
>  		return err;
>  	pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
> diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
> new file mode 100644
> index 0000000..40311d1
> --- /dev/null
> +++ b/net/bpfilter/bpfilter_umh_blob.S
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +	.section .init.rodata, "a"
> +	.global bpfilter_umh_start
> +bpfilter_umh_start:
> +	.incbin "net/bpfilter/bpfilter_umh"

Interesting. I think this is good idea. Looks cleaner than objcopy magic.
btw CONFIG_OUTPUT_FORMAT already fixed by
commit 8d97ca6b6755 ("bpfilter: fix OUTPUT_FORMAT") in net tree.
Could you please rebase on top of that tree?
