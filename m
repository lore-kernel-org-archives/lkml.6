Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76662C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449623F39
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mdRFdW/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449623F39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGEGFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:05:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:65161 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeGEGFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:05:06 -0400
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com [209.85.217.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6564m3A002246;
        Thu, 5 Jul 2018 15:04:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6564m3A002246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530770689;
        bh=HJn9wVkQwOp0iGla8XDUcgAby1kex8k3zmmrxBOJ3Xs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mdRFdW/UhKXKQqtSYOTOYiCwRa1UALZvnx+oHDrMU/BoU/lzXc5CcrdcKd8iKrUCW
         yQb2bKn340cfjddX8G/DIrE9JXPlBT0BJDXjmW805MTkGAwattqpjRcKVCmripNOc0
         TXrY4C76eQoSEcp+6dkPRxblUohiu0N5FQJJ1L1RWgBybyPTtgvfaYXrBjQYYZeExH
         UzlHhveRdo/vVqKQ2oAF1fjXB4g2eK65R2iag4WJd6bg8vIaVLjJiS+KlneL74uXq2
         RcSuQCpyKBCfeeYgcD+Eu6YJSHyRTXtU0VrVz7U5pw8Hj4hMqiZ8sXl0Zl7e2wG5An
         IQsD5FIrAuwvg==
X-Nifty-SrcIP: [209.85.217.178]
Received: by mail-ua0-f178.google.com with SMTP id 59-v6so4700747uas.5;
        Wed, 04 Jul 2018 23:04:48 -0700 (PDT)
X-Gm-Message-State: APt69E1jgekk+Bo83CcVjAUQ2K4Uzh3GnskDW8bj6mH2u3QFoAktONjd
        /sTbIPdfKEWxtvJjwAA6b8cgym0XZwfMVatjzbg=
X-Google-Smtp-Source: AAOMgpfoI5mjJRDXLOhn1pVGcMz1zB3vcuWLdOb1S6/K6JrIOQ++CCFEiEUbh4dfo3hcJ+PA/0XxYrXaChWznaQpaYs=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2721119uaf.199.1530770687743;
 Wed, 04 Jul 2018 23:04:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 23:04:07 -0700 (PDT)
In-Reply-To: <7f7dfd3d-6d4b-fc64-956b-1defc5c5a7c3@infradead.org>
References: <20180702144711.22111-1-hch@lst.de> <20180702144711.22111-2-hch@lst.de>
 <43b9a29d-27fc-1b6e-6f90-9187749bf338@infradead.org> <7f7dfd3d-6d4b-fc64-956b-1defc5c5a7c3@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 5 Jul 2018 15:04:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASspaTidLtkfnip5rfmEOdt4uw94kzN=obo_1VM-q80=A@mail.gmail.com>
Message-ID: <CAK7LNASspaTidLtkfnip5rfmEOdt4uw94kzN=obo_1VM-q80=A@mail.gmail.com>
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from top-level Kconfig
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-03 5:50 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 07/02/18 13:41, Randy Dunlap wrote:
>
>> --- linux-next-20180702.orig/init/Kconfig
>> +++ linux-next-20180702/init/Kconfig
>> @@ -1717,6 +1717,12 @@ config PROFILING
>>  config TRACEPOINTS
>>       bool
>>
>> +# Note:  arch/$(SRCARCH)/Kconfig needs to be before arch/Kconfig
>> +# so that each $ARCH can specify its values for CONFIG_PGTABLE_LEVELS
>> +# before the default value is found in arch/Kconfig.
>> +
>> +source "arch/$(SRCARCH)/Kconfig"
>> +
>>  source "arch/Kconfig"
>>
>>  endmenu              # General setup
>>
>
> except that the endmenu should be moved up a few lines so that the
> Processor type and features menu is not part of the General setup menu.
>
> v2 patch is below.
>
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Present "General setup" before "Processor type and features".
> This is done by sourcing arch/$(SRCARCH)/Kconfig before arch/Kconfig
> inside init/Kconfig.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: move General setup's endmenu before the $ARCH Kconfigs.
>
>  Kconfig      |    2 --
>  init/Kconfig |   10 ++++++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> --- linux-next-20180702.orig/Kconfig
> +++ linux-next-20180702/Kconfig
> @@ -9,8 +9,6 @@ comment "Compiler: $(CC_VERSION_TEXT)"
>
>  source "scripts/Kconfig.include"
>
> -source "arch/$(SRCARCH)/Kconfig"
> -
>  source "init/Kconfig"
>
>  source "kernel/Kconfig.freezer"
> --- linux-next-20180702.orig/init/Kconfig
> +++ linux-next-20180702/init/Kconfig
> @@ -1717,10 +1717,16 @@ config PROFILING
>  config TRACEPOINTS
>         bool
>
> -source "arch/Kconfig"
> -
>  endmenu                # General setup
>
> +# Note:  arch/$(SRCARCH)/Kconfig needs to be before arch/Kconfig
> +# so that each $ARCH can specify its values for CONFIG_PGTABLE_LEVELS
> +# before the default value is found in arch/Kconfig.


Is it possible to explain it in a little more generic way?


...
so that arch/$(SRCARCH)/Kconfig can override the default values
in arch/Kconfig.


I am not a native speaker.
Please reword it so that it sounds more natural.


Thanks.






> +source "arch/$(SRCARCH)/Kconfig"
> +
> +source "arch/Kconfig"
> +
>  config RT_MUTEXES
>         bool
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
