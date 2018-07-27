Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67773C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC0C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jm4WcPna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC0C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbeG0Cwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:52:39 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45315 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbeG0Cwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:52:38 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w6R1X0q6019353;
        Fri, 27 Jul 2018 10:33:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w6R1X0q6019353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532655181;
        bh=4N3+Ux2GTbpmO6X7Yk7XOCofTSSqZE2QZrCnDILokj4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jm4WcPnaJv8l4TH/dMLL78VALrwDjEJM0HjQlQXgkjbx0WI6gGMb8l7TC0y+xhgSQ
         Z0usFRalepy9FT63S9zYFUT1tyevXYOsLal2Lp4zmyIMADVlvd1pzYhE4uzmm4jAGb
         EE1w69IHuRsLHnw8xPUJjsT8+tjmCBFcjsXQYB9hoclGlLygy4eddjHsDRQG1BU+QK
         fESf03OnYTFmhrVDwateKnegn9/sH/Z26yyMiXf3yTZGZhPSMOdhnL1rs2AtyelO09
         HB/NoVJgPPY5IsL3Q++Xnr4P/Qxb7i8k86JnssxjVYfXlVD/IgDYXwUwf0Vwq7/sNu
         5+mOaYyi4LJRQ==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id o82-v6so1731686vko.8;
        Thu, 26 Jul 2018 18:33:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlEEzx8MQ26sp6YGw71xfNEzssOjtFyAiZUVibJEy58SOObKrI2B
        RzlY5HWT1kH0wS1CgyQsIxSnkQIkcsDmhWElX7I=
X-Google-Smtp-Source: AAOMgpc/kEZ0obK+h8fMOGOJkqqXAC8gXsSvbhRSzFuGyykJq0fwZ+bjpR2rpH/XDHh7EYVlpwlxpEAgxYZZzCxPYXk=
X-Received: by 2002:a1f:420d:: with SMTP id p13-v6mr2745586vka.10.1532655179917;
 Thu, 26 Jul 2018 18:32:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 18:32:19
 -0700 (PDT)
In-Reply-To: <20180726172143.GA9836@lst.de>
References: <20180724175646.3621-1-hch@lst.de> <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
 <20180726172143.GA9836@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 27 Jul 2018 10:32:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASd0YCj4wwmT9-6GYiBz=wDoXkmQW2F_5XjbCzS9-weUw@mail.gmail.com>
Message-ID: <CAK7LNASd0YCj4wwmT9-6GYiBz=wDoXkmQW2F_5XjbCzS9-weUw@mail.gmail.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org, linux-arch@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-27 2:21 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> On Wed, Jul 25, 2018 at 01:30:24PM +0900, Masahiro Yamada wrote:
>> Could you check the difference of CONFIG_PREEMPT_COUNT, please?
>>
>>
>> For alpha, hexagon, um,
>> CONFIG_PREEMPT_COUNT was previously never enabled
>> because kernel/Kconfig.preempt was not included.
>>
>> Now, CONFIG_PREEMPT_COUNT can be enabled
>> if it is select'ed by someone.
>>
>> I guess this change will be OK, but
>> I'd like you and Randy to double-check it just in case.
>
> It might be fine, but with this little fix folded in we should be
> safer:
>
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index cd1655122ec0..1321a4a7a677 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -57,4 +57,5 @@ config PREEMPT
>  endchoice
>
>  config PREEMPT_COUNT
> -       bool
> \ No newline at end of file
> +       depends on !ARCH_NO_PREEMPT
> +       bool
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



This will just add a new unmet dependency warning.
CONFIG_PREEMPT_COUNT will be still selected.


$ make ARCH=alpha allyesconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allyesconfig Kconfig

WARNING: unmet direct dependencies detected for PREEMPT_COUNT
  Depends on [n]: !ARCH_NO_PREEMPT [=y]
  Selected by [y]:
  - DEBUG_ATOMIC_SLEEP [=y] && DEBUG_KERNEL [=y]
#
# configuration written to .config
#






-- 
Best Regards
Masahiro Yamada
