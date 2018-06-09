Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Xr+rBxjMG1siTQAAmS7hNA
	; Sat, 09 Jun 2018 12:46:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9B066074D; Sat,  9 Jun 2018 12:46:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ceob0gCH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3C0386032D;
	Sat,  9 Jun 2018 12:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C0386032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeFIMqM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:46:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49441 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeFIMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:46:10 -0400
X-Greylist: delayed 70390 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 08:46:10 EDT
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w59Ck6kZ017100;
        Sat, 9 Jun 2018 21:46:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w59Ck6kZ017100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528548367;
        bh=E43f0R/DydyzQIiVUE1Z/omN2mAugsNkbM744NYn5BA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ceob0gCHhBnQhxMCXWru9N1nCdmOare8jWHxqqNyQvbWdQJ8KhK6jQXiTMof6ONVP
         WCSYCIB8bcSJykQQRWt//g8UiWZ8Womfhymt0TQj9McNmBrrRf4ga25SDKu6sTMxiP
         EncBlYXPirEQF2zP0Sg28DkLlkbUgmgZhmvfEf8h5CmWe2pXlaWJ5bdJyrV2mRU2oH
         pTQL/rUBEMBRlBPHFKmgkxzBJpk7mNf9sxE1GrI1UgqSlM32orf5mzuz/9Am4mACB5
         51RwQds6Vge0qHgboZWX/NAo12PErD6UDsHUKJRY/ff/cjxik6EZ0jC47nAj8/Q3iX
         W8XeeYoBI9PRg==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id l64-v6so2243058vkl.12;
        Sat, 09 Jun 2018 05:46:06 -0700 (PDT)
X-Gm-Message-State: APt69E0bLlZAOZPYJnhxxcYOS4YHL/1e/1B5yKvNC7D4tv+xEfAXw8wp
        AmNNJuRYK1Getu8ntR1FjTzQmZEcSVbl8tLNpT0=
X-Google-Smtp-Source: ADUXVKKQI4frtCmNDY0Yt6//UTzzC3WypcBLDe5sXA45KeFmROQI9J+uTBOghQRhEb50IPqfABK28m66rvjTGXUZR3o=
X-Received: by 2002:a1f:ac07:: with SMTP id v7-v6mr6177097vke.11.1528548365911;
 Sat, 09 Jun 2018 05:46:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 05:45:23 -0700 (PDT)
In-Reply-To: <20180608204727.jggtai5iro7ao34v@ast-mbp.dhcp.thefacebook.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
 <1528477930-7342-3-git-send-email-yamada.masahiro@socionext.com> <20180608204727.jggtai5iro7ao34v@ast-mbp.dhcp.thefacebook.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 9 Jun 2018 21:45:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKp7u5hSC-3DRMJTsPAWCSt0f1yNNbPUv5odayMiH+_Q@mail.gmail.com>
Message-ID: <CAK7LNARKp7u5hSC-3DRMJTsPAWCSt0f1yNNbPUv5odayMiH+_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpfilter: include bpfilter_umh in assembly instead of
 using objcopy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-09 5:47 GMT+09:00 Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> On Sat, Jun 09, 2018 at 02:12:09AM +0900, Masahiro Yamada wrote:
>> Do not use the troublesome ELF magic.  What is happening here is to
>> embed a user-space program into the kernel.  Simply wrap it in the
>> assembly with the '.incbin' directive.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  net/bpfilter/Makefile            | 15 ++-------------
>>  net/bpfilter/bpfilter_kern.c     | 11 +++++------
>>  net/bpfilter/bpfilter_umh_blob.S |  7 +++++++
>>  3 files changed, 14 insertions(+), 19 deletions(-)
>>  create mode 100644 net/bpfilter/bpfilter_umh_blob.S
>>
>> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
>> index aafa720..39c6980 100644
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
>> -      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
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
>> index b13d058..fcc1a7c 100644
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
>> @@ -89,7 +86,9 @@ static int __init load_umh(void)
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
>
> Interesting. I think this is good idea. Looks cleaner than objcopy magic.
> btw CONFIG_OUTPUT_FORMAT already fixed by
> commit 8d97ca6b6755 ("bpfilter: fix OUTPUT_FORMAT") in net tree.
> Could you please rebase on top of that tree?
>


OK, I will rebase it.

BTW, I only compile-tested this patch.
Could you check if it really works?



-- 
Best Regards
Masahiro Yamada
