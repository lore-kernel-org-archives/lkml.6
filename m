Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAFBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52182083C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OmuZhbpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52182083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965404AbeFZDpS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:45:18 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:65113 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965355AbeFZDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:45:17 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5Q3j6Q3024721;
        Tue, 26 Jun 2018 12:45:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5Q3j6Q3024721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529984707;
        bh=Efr7k6qAYbUotOyhcFh47XAVztCKrSASKKyFo/P4LxI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OmuZhbpV0GZNmhVmUyIwMi89n1ToOeOCkFxRgfbT9IMOvF5MUCyJGRMeV1iVIW5qP
         sa7DbuOKpo6Eumj7CanVH7+BEvCYb/G8Pyo+DHRRl/RpXWFsImHSg+Ad/vTfDJ7KYa
         5iR1ahQlWyItyqEZHZyyoCBgCm3532faXO+haTsMyXEvThUzgac1S5DWxwCSY1nzBc
         OWxKfY5l2cs4FjQd+yF2oyWCxyRz+WHGYLaX9uO5hkrd1PbTemLr0adXtT7WcXaBRf
         zVaA2SfTSsXFiciG73DGPRCoZhFT/+IxNjsB0hZ8EoBKKcxHVanqSgEoSBsJ21Nb4R
         iXIsBvllQXmGQ==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id z16-v6so10020830uaz.10;
        Mon, 25 Jun 2018 20:45:07 -0700 (PDT)
X-Gm-Message-State: APt69E07Qnq+SiVgve8skVQryUhKsgJL+MiGaJo1Rw3HjKyqLho+ixSt
        cXCCDsoJKF2B54myBQAk78Wn9hCLmnKn1kJgprY=
X-Google-Smtp-Source: AAOMgpfc/UZRI8JLiITFFEJLhCd4xznxXEiKy42t7Wfmddl307ZqzSm1fCc/Bw/aqe7uPSB4FYaolzrEFsrIq0Q3rTo=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr2900822ual.141.1529984706338;
 Mon, 25 Jun 2018 20:45:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 20:44:25
 -0700 (PDT)
In-Reply-To: <20180615004704.u5gofft7k6ehmhwi@ast-mbp.dhcp.thefacebook.com>
References: <1528987172-19810-1-git-send-email-yamada.masahiro@socionext.com>
 <1528987172-19810-3-git-send-email-yamada.masahiro@socionext.com> <20180615004704.u5gofft7k6ehmhwi@ast-mbp.dhcp.thefacebook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Jun 2018 12:44:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKOz1zccBrX2vgqA7Wu5c397W=GkAj1AMR+r56UybXeg@mail.gmail.com>
Message-ID: <CAK7LNAQKOz1zccBrX2vgqA7Wu5c397W=GkAj1AMR+r56UybXeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bpfilter: include bpfilter_umh in assembly instead
 of using objcopy
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,


2018-06-15 9:47 GMT+09:00 Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> On Thu, Jun 14, 2018 at 11:39:31PM +0900, Masahiro Yamada wrote:
>> What we want here is to embed a user-space program into the kernel.
>> Instead of the complex ELF magic, let's simply wrap it in the assembly
>> with the '.incbin' directive.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - Rebase
>>
>>  net/bpfilter/Makefile            | 15 ++-------------
>>  net/bpfilter/bpfilter_kern.c     | 11 +++++------
>>  net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
>>  3 files changed, 14 insertions(+), 19 deletions(-)
>>  create mode 100644 net/bpfilter/bpfilter_umh_blob.S
>>
>> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
>> index e0bbe75..39c6980 100644
>> --- a/net/bpfilter/Makefile
>> +++ b/net/bpfilter/Makefile
>> @@ -15,18 +15,7 @@ ifeq ($(CONFIG_BPFILTER_UMH), y)
>>  HOSTLDFLAGS += -static
>>  endif
>>
>> -# a bit of elf magic to convert bpfilter_umh binary into a binary blob
>> -# inside bpfilter_umh.o elf file referenced by
>> -# _binary_net_bpfilter_bpfilter_umh_start symbol
>> -# which bpfilter_kern.c passes further into umh blob loader at run-time
>> -quiet_cmd_copy_umh = GEN $@
>> -      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
>> -      $(OBJCOPY) -I binary -O `$(OBJDUMP) -f $<|grep format|cut -d' ' -f8` \
>> -      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
>> -      --rename-section .data=.init.rodata $< $@
>> -
>> -$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
>> -     $(call cmd,copy_umh)
>> +$(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
>>
>>  obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
>> -bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
>> +bpfilter-objs += bpfilter_kern.o bpfilter_umh_blob.o
>> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
>> index 0952257..6de3ae5 100644
>> --- a/net/bpfilter/bpfilter_kern.c
>> +++ b/net/bpfilter/bpfilter_kern.c
>> @@ -10,11 +10,8 @@
>>  #include <linux/file.h>
>>  #include "msgfmt.h"
>>
>> -#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
>> -#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
>> -
>> -extern char UMH_start;
>> -extern char UMH_end;
>> +extern char bpfilter_umh_start;
>> +extern char bpfilter_umh_end;
>>
>>  static struct umh_info info;
>>  /* since ip_getsockopt() can run in parallel, serialize access to umh */
>> @@ -93,7 +90,9 @@ static int __init load_umh(void)
>>       int err;
>>
>>       /* fork usermode process */
>> -     err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
>> +     err = fork_usermode_blob(&bpfilter_umh_end,
>> +                              &bpfilter_umh_end - &bpfilter_umh_start,
>> +                              &info);
>>       if (err)
>>               return err;
>>       pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
>> diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
>> new file mode 100644
>> index 0000000..40311d1
>> --- /dev/null
>> +++ b/net/bpfilter/bpfilter_umh_blob.S
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +     .section .init.rodata, "a"
>> +     .global bpfilter_umh_start
>> +bpfilter_umh_start:
>> +     .incbin "net/bpfilter/bpfilter_umh"
>> +     .global bpfilter_umh_end
>> +bpfilter_umh_end:
>
> for some reason it doesn't work.
> fork_usermode_blob() returns ENOEXEC
> You should be able to test it simply running 'iptables -L'.
> Without this patch you should see:
> [   12.696937] bpfilter: Loaded bpfilter_umh pid 225
> Started bpfilter
>
> where first line comes from kernel module and second from umh.


Sorry for the late reply.

Unfortunately, I will be busy for a while.

I will come back eventually
to check it out, but I cannot tell when.


Somebody else sent a patch equivalent to 1/3, so it is fine.

3/3 can go independently, so it will send it as a separate patch for now.





-- 
Best Regards
Masahiro Yamada
