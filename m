Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8t+0JBS8G1vRGAAAmS7hNA
	; Sat, 09 Jun 2018 11:37:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7C9B0607A4; Sat,  9 Jun 2018 11:37:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="coUHMR3q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 467EF6032D;
	Sat,  9 Jun 2018 11:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 467EF6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeFILhw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 07:37:52 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:33655 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeFILhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 07:37:50 -0400
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com [209.85.217.180]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w59BbbaV019129;
        Sat, 9 Jun 2018 20:37:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w59BbbaV019129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528544258;
        bh=1nyHRSUyl1WDsBKbPwAyFI8GEivpfbQhxiu5fnhBuYs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=coUHMR3qjW8iBPGcvAgWjUd0/zYlf9tBwo+XD+9GEW1n+hUCYHemCmSoQGnTQVv6P
         YLngU6HFr/R/FNkfxIl/JwYY7pK1Kfr6t4a4jaWB2GNhRbHPj/nFVAduoxRhteUL4G
         nsCfeafAQfLTM7Ke6lsNII1T8WkqntBNTtgxC5EHfh1bXGIZT0PBG+m/BdToq/NKAE
         JVoSOcKDHsddqgsNnL4nwTdPMWCvtprh92SwvLu7ggD8ZOsHSAKXcTFujnP3quNZys
         40irT/kHHvUBgd3Tim4heE1IJB0S1iLDI8AxwuDGMOQDvWLM4eCuGV8/hPMUiQ79Re
         yIQfAn3LoymUQ==
X-Nifty-SrcIP: [209.85.217.180]
Received: by mail-ua0-f180.google.com with SMTP id k14-v6so10580222uao.12;
        Sat, 09 Jun 2018 04:37:38 -0700 (PDT)
X-Gm-Message-State: APt69E2wtTeBpOdBAHO6DQ75eGZFkrU8x9Rlq+oWOn5qKfWOW2878lIi
        ZviNhtIiDAsd0bC3vOFtqTpWWjb7owMUuRZvYg0=
X-Google-Smtp-Source: ADUXVKLOo+0cV3JFFffiB98EM3SEgG4bMqOEQG3CwZkpmOec2E/rczVDq4SrJg+Zs/98/KBjrAw8CzNN7Wvr6yoZwpw=
X-Received: by 2002:ab0:1048:: with SMTP id g8-v6mr6258937uab.52.1528544257099;
 Sat, 09 Jun 2018 04:37:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 04:36:56 -0700 (PDT)
In-Reply-To: <CAMuHMdX7oyxQKyc-DTXKG+o0SA_eJhKEFznn3bPxD0Gi=sA01A@mail.gmail.com>
References: <1528417303-14842-1-git-send-email-yamada.masahiro@socionext.com> <CAMuHMdX7oyxQKyc-DTXKG+o0SA_eJhKEFznn3bPxD0Gi=sA01A@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 9 Jun 2018 20:36:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYmFiCgB8jxOxKtPxjMeVqgXOspE+72B4=uLmuLSyyjw@mail.gmail.com>
Message-ID: <CAK7LNATYmFiCgB8jxOxKtPxjMeVqgXOspE+72B4=uLmuLSyyjw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix endless syncconfig in case arch Makefile sets CROSS_COMPILE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-08 17:20 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Fri, Jun 8, 2018 at 2:21 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Commit 21c54b774744 ("kconfig: show compiler version text in the top
>> comment") was intended to detect the compiler upgrade, but Geert
>> reported a breakage on the m68k build.
>>
>> The compiler upgrade is detected by the change of the environment
>> variable, CC_VERSION_TEXT, which contains the first line of the output
>> from $(CC) --version.  Currently, this works well when CROSS_COMPILE
>> is given via the environment variable or the Make command line.
>>
>> However, some architectures such as m68k can specify CROSS_COMPILE
>> from arch/$(SRCARCH)/Makefile as well.  In this case, "make ARCH=m68k"
>> ends up with endless syncconfig loop.
>>
>>   $ make ARCH=m68k defconfig
>>   *** Default configuration is based on 'multi_defconfig'
>>   #
>>   # configuration written to .config
>>   #
>>   $ make ARCH=m68k
>>   scripts/kconfig/conf  --syncconfig Kconfig
>>   scripts/kconfig/conf  --syncconfig Kconfig
>>   scripts/kconfig/conf  --syncconfig Kconfig
>>   scripts/kconfig/conf  --syncconfig Kconfig
>
> [...]
>
>> Fixes: 21c54b774744 ("kconfig: show compiler version text in the top comment")
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thanks for fixing this quickly!
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>


Applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
