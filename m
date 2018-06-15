Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 12340C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76C620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1iqejrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76C620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965388AbeFOArL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:47:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41827 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965218AbeFOArJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:47:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so3665395pgl.8;
        Thu, 14 Jun 2018 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZXlJWeIV+j6rvw5L6asJJGupCBG5qouf3Mu9N0MJu4=;
        b=e1iqejrR5cNTmC4HblFXPjXJAYDNsplV7K/8BiCTinFvOhlKRTRiPGPL578fYR11oy
         72bKSzkH/30pz8KP/k07OZVhPkAeGmKbvj3cp98H1kpdsCCXrlw7T6GpNeXe84fooMg+
         S6qBf1RXrSGFxel66X/pLnpV/FaIs18jwhU/Fm5WTnfu8Od8Vz7dZ+Mf63/qnd5aivH2
         kiK5SCjAv+48CbuXwHJqIG6Yezz/CFWKxeY3TeF3dfh2wJMPbsPavuf3sGHVfmMizaum
         RqHMgJQ9bJLCeFzoc7E9mD/cRApbRQ2MZRnslE82dWDrIkkQL+Sv5+Vk9Mmx5x0Dqcgy
         jkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZXlJWeIV+j6rvw5L6asJJGupCBG5qouf3Mu9N0MJu4=;
        b=Ehqji86AycnnIlogQy8OdYFYnuCr+amOMFN0ZbC/pO2i6cNlpgs7lEXL2/symV1VcX
         0w2n3wpGPZJnYm8iAY20DGRCpKmZdhz3tWG3ol7i6D62cTFovJhGSUS2uq5HBEkiulgX
         XoAzSBdprITr7/unA3PZltYITKPUU9lExNasVgw4ISP1zKx30Kx8yl2T+W6OIpYvbjuI
         NzX4ze7yxLfJc242Sn82uRAJOkpOG7mbh02q3MuyPBe2KGylc09opNjXUwoOdDYci3kP
         Al71LVUwVQx2SsPHROQQRqjMXQTaMC5AvurCEdooClpR/Oz9ETkKUH5EhmhWkyNaItxz
         i5IQ==
X-Gm-Message-State: APt69E1B3hn+Fa476TMNZ7Mz9GXhUbQ2WEVZaDz5P+AgtwRUEB5Fniar
        7w3DgjDunjwVF6plpzKWy04=
X-Google-Smtp-Source: ADUXVKL4z9SBx9+VqPo5nDP9UVzqyVhW1u4Z6yKu4jCrFGHN8vwLtmP5+C6SoFjgj69jkmcHTtN+7Q==
X-Received: by 2002:a62:c45a:: with SMTP id y87-v6mr11833913pff.190.1529023628977;
        Thu, 14 Jun 2018 17:47:08 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::5:3f9])
        by smtp.gmail.com with ESMTPSA id o77-v6sm13462849pfj.0.2018.06.14.17.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 17:47:08 -0700 (PDT)
Date:   Thu, 14 Jun 2018 17:47:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 2/3] bpfilter: include bpfilter_umh in assembly
 instead of using objcopy
Message-ID: <20180615004704.u5gofft7k6ehmhwi@ast-mbp.dhcp.thefacebook.com>
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
 <1528987172-19810-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528987172-19810-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:39:31PM +0900, Masahiro Yamada wrote:
> What we want here is to embed a user-space program into the kernel.
> Instead of the complex ELF magic, let's simply wrap it in the assembly
> with the '.incbin' directive.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Rebase
> 
>  net/bpfilter/Makefile            | 15 ++-------------
>  net/bpfilter/bpfilter_kern.c     | 11 +++++------
>  net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
>  3 files changed, 14 insertions(+), 19 deletions(-)
>  create mode 100644 net/bpfilter/bpfilter_umh_blob.S
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index e0bbe75..39c6980 100644
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
> -      $(OBJCOPY) -I binary -O `$(OBJDUMP) -f $<|grep format|cut -d' ' -f8` \
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
> index 0952257..6de3ae5 100644
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
> @@ -93,7 +90,9 @@ static int __init load_umh(void)
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
> +	.global bpfilter_umh_end
> +bpfilter_umh_end:

for some reason it doesn't work.
fork_usermode_blob() returns ENOEXEC
You should be able to test it simply running 'iptables -L'.
Without this patch you should see:
[   12.696937] bpfilter: Loaded bpfilter_umh pid 225
Started bpfilter

where first line comes from kernel module and second from umh.


