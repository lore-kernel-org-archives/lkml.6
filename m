Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AIKaGmzuG1tJQQAAmS7hNA
	; Sat, 09 Jun 2018 15:14:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F0492608BA; Sat,  9 Jun 2018 15:14:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I+m+bv9R"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4184D602FC;
	Sat,  9 Jun 2018 15:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4184D602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeFIPOn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:14:43 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:36294 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeFIPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:14:41 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w59FEPE0004434;
        Sun, 10 Jun 2018 00:14:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w59FEPE0004434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528557266;
        bh=JtqmXgZmGQLWc20JtKxl1L4gRS/HUDsWmU986FQ4TNA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=I+m+bv9RSDayd8rtLzURZjwEoO/3vUorv/CskKYP+cbCgy1M5U6+sXUngd84xNn3b
         2m/M6hedHMIaeg8bpsJRzvJ+iPwJXoQ5JWrSItbTO8G/P2rFUWBHnt6X1g5DZ0CxXc
         Ah7plgbNSQBWYjYsKbaVS/grO0sd6OvcysaeUHY534mtLkyeISCsZXS750Kk47RDQh
         fgFedLisvoYn0pzjwEgiYdr7kj9NiL1M33Po0CmB2/J4bK4vVbN+66D3dzFJ6lIjay
         Hc/jZ/OQcxTIybwudnAOWSTmf/CKrG5I7vonGB/BTvoJsoOSO7q3KchMttMXLj+et3
         qvYXYusW8CXuQ==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id e8-v6so10805129uam.13;
        Sat, 09 Jun 2018 08:14:25 -0700 (PDT)
X-Gm-Message-State: APt69E126atr34nhgt/Uewucvs9st1v5+TUmgPnvZIRRjaaBhX6R5Utu
        X6+EgZjc5bSAPyq/pLT4erivWOtm/VoAaLO9qXU=
X-Google-Smtp-Source: ADUXVKJ+LK+hTxfPOp/CyKLzvWmwHPTZU5fVu0gZ8/QsSll6xUNFiw6pmvH8VT2dmdqytNnTosSnMJfMsfsC73GHDLA=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr1152708uae.140.1528557264453;
 Sat, 09 Jun 2018 08:14:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 08:13:43 -0700 (PDT)
In-Reply-To: <20180608205256.cpniquglftmie5vl@ast-mbp.dhcp.thefacebook.com>
References: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
 <1528477930-7342-4-git-send-email-yamada.masahiro@socionext.com> <20180608205256.cpniquglftmie5vl@ast-mbp.dhcp.thefacebook.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 10 Jun 2018 00:13:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjAKbVW4-STxTOmrfDzJLaJz9Yu_T_1C=T-0x3p4fmoA@mail.gmail.com>
Message-ID: <CAK7LNATjAKbVW4-STxTOmrfDzJLaJz9Yu_T_1C=T-0x3p4fmoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] bpfilter: do not (ab)use host-program build rule
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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

2018-06-09 5:52 GMT+09:00 Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> On Sat, Jun 09, 2018 at 02:12:10AM +0900, Masahiro Yamada wrote:
>> It is an ugly hack to overwrite $(HOSTCC) with $(CC) to reuse the
>> build rules from scripts/Makefile.host.  It should not be tedious
>> to write a build rule for its own.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  net/bpfilter/Makefile                   | 17 +++++++++++------
>>  net/bpfilter/{main.c => bpfilter_umh.c} |  0
>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>  rename net/bpfilter/{main.c => bpfilter_umh.c} (100%)
>>
>> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
>> index 39c6980..6571b30 100644
>> --- a/net/bpfilter/Makefile
>> +++ b/net/bpfilter/Makefile
>> @@ -3,18 +3,23 @@
>>  # Makefile for the Linux BPFILTER layer.
>>  #
>>
>> -hostprogs-y := bpfilter_umh
>> -bpfilter_umh-objs := main.o
>> -HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
>> -HOSTCC := $(CC)
>
> that is a hack indeed. I don't like it either, but see below.
>
>> -
>>  ifeq ($(CONFIG_BPFILTER_UMH), y)
>>  # builtin bpfilter_umh should be compiled with -static
>>  # since rootfs isn't mounted at the time of __init
>>  # function is called and do_execv won't find elf interpreter
>> -HOSTLDFLAGS += -static
>> +STATIC := -static
>>  endif
>>
>> +quiet_cmd_cc_user = CC      $@
>> +      cmd_cc_user = $(CC) -Wall -Wmissing-prototypes -O2 -std=gnu89 \
>> +                 -I$(srctree) -I$(srctree)/tools/include/ \
>> +                 -I$(srctree)/tools/include/uapi $(STATIC) -o $@ $<
>> +
>> +$(obj)/bpfilter_umh: $(src)/bpfilter_umh.c FORCE
>> +     $(call if_changed,cc_user)
>
> Does this scale?
> Please see two top patches here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/log/?h=ipt_bpf
> that add more meat to bpfilter and a lot more files.

Oh, I just thought main.c was the only user-program file.

> Recompiling all of them at once isn't nice either.

Indeed.

It should be able to compile .c -> .o separately.

> This Makefile needs different .c -> .o rules for bpfilter_kern.c files
> that get compiled into kernel module and for the rest of umh files:
> main.c ctor.c init.c gen.c etc
> that need to be compiled .c -> .o differently.
> I don't see how to do it without ugly hacks in Makefile.
> In that sense HOSTCC = CC hack looked the least ugly to me that's
> why I went with it.
> Better ideas?


I will think about it after your patches land.

I will drop this for now.


-- 
Best Regards
Masahiro Yamada
