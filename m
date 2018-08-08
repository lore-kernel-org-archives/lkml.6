Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD60C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A0221708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iiymlVvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A0221708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHHDmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:42:33 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37503 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeHHDmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:42:33 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w781P8kB015634;
        Wed, 8 Aug 2018 10:25:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w781P8kB015634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533691508;
        bh=8/qKZ2z38WBeYTMV+Dh4nO2NCizOFtpnDL3dtU2SZ1k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iiymlVvTVByqqE10elrEWupsZ0+wtQkAniBysTBFEJTtc+YxNWgNMIFDCp4RRuHLC
         RJVQFVahIfiDXQO5LHZdeNf1kfsBiZuaASsiJ4pLOcCJtMrrzXlRJYLseFmcvvuDGU
         DkDMp3S6TxRcxbfXHbDHHUyIAgjZ06SW826WaG9xgtYI7b46CXYn+zHKMvHke1094Y
         xnShGYvFjPt/BGeWjgKqIngAvVKRM6YooHs3J6evQhSm5C0g/s1VQpP0Lias6DV5ZU
         2SHO0auWCb3JRfVaTDRPggJUcEn8bDxTc4RD7LzSSyQe7bJK9P2tBQQsb3qDTgglzJ
         J5q7ErSiK2iPw==
X-Nifty-SrcIP: [209.85.217.179]
Received: by mail-ua0-f179.google.com with SMTP id k8-v6so595170uaq.12;
        Tue, 07 Aug 2018 18:25:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlEqFZgD8y9Jo7JlYyYhuCFrZbXS3swxHp5AEtvHpqFYGsbm96oj
        CW28kaWTlM+Lcw1gFivx0nRuAwHGQ2+xyHbrbPE=
X-Google-Smtp-Source: AA+uWPzWV2xvF8CCbxUlrCtbS8rQJWJuckSu+Y+LtNGNu7APYCA7220UpauKzAe4NWxFLDbsZ0SsUAtSMlL6fdT/E7M=
X-Received: by 2002:a1f:968f:: with SMTP id y137-v6mr512943vkd.55.1533691507406;
 Tue, 07 Aug 2018 18:25:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 18:24:27 -0700 (PDT)
In-Reply-To: <1901723.5RX4ofS7Gn@blindfold>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com> <1901723.5RX4ofS7Gn@blindfold>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 8 Aug 2018 10:24:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZ0HQEeVaxrHSms0R37TE3UK-=up0Bfh_rcxEi7SWS_g@mail.gmail.com>
Message-ID: <CAK7LNATZ0HQEeVaxrHSms0R37TE3UK-=up0Bfh_rcxEi7SWS_g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Kbuild: fix and clean-up arch/um/Makefile
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-07 5:54 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Am Samstag, 4. August 2018, 06:47:00 CEST schrieb Masahiro Yamada:
>>
>> 1/3 fixes the build failure reported by Randy.
>> (I may have seen a similar report before, but I cannot recall it.)
>>
>> 2/3 and 3/3 clean-up the Makefile a bit more.
>>
>> I'd like to apply this series to kbuild tree.
>> Ack from UML folks are appreciated.
>
> Nice to see this fixed, Masahiro! :-)
>
> Acked-by: Richard Weinberger <richard@nod.at>
>


Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
