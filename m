Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A625ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B562A20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gdRiZW8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B562A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeISMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:36:00 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30279 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeISMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:35:59 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w8J6xLiK027918;
        Wed, 19 Sep 2018 15:59:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w8J6xLiK027918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537340362;
        bh=id8yPXMo+ETBUJQnEzMg1bKHIFz83rIEAW21OgVUE0U=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gdRiZW8X/4nx6I/dqpbUQF1YVMncWXzoINSyPrG/d5HV95DxhoAEeKWpUZT/UwyQl
         ohUlNSgiqpYdpZlSRAk3QTnCdY7Yxayc5bQ1ZOtZmOKSzyitIN3z3g4Wq+HUp4It3j
         y4/Gp+vnGRm8/idG3MVe5GUEMPspNgegvp4fUXMs4XstZVjc3nzB+9TIyqbPMMmSnt
         s7UYdJ12+4x57DwNnpnsZEs3xFPgJhAM86GI8cAy37nobPFToCb5ZDs31jKWlwmrTT
         WkuJsd9qLT5eMAn5Ug3ibPCDU3G36gaYqOXYdS/JrFcAMtAaYpFOQJGzPeWnE10So3
         2QuHshNcLebow==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id b78-v6so914921vka.12;
        Tue, 18 Sep 2018 23:59:22 -0700 (PDT)
X-Gm-Message-State: APzg51C33zNP5sa7Ra0+DZKTH40zIz+zuVxpbOSKmFX0I3I/vfc+TdaZ
        B3iQUzrN1yRKx5dXms7YKrZVujqrjiFaE0wC+X0=
X-Google-Smtp-Source: ANB0VdYyLVZxoOZ4TZvNWSdfhd+gXvmplItM4oYsUOtAp/Gd+qAo8pQ/OqFwsObXkR91J3SFCGRx2sS7b22e1kpPCf8=
X-Received: by 2002:a1f:5d03:: with SMTP id r3-v6mr1883831vkb.64.1537340361141;
 Tue, 18 Sep 2018 23:59:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 23:58:40
 -0700 (PDT)
In-Reply-To: <2024081.XhWFmWp6tJ@blindfold>
References: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com> <2024081.XhWFmWp6tJ@blindfold>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Sep 2018 15:58:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrOhJpkUf=zxvwcbf8oWTAhKiWxemweHz8QPT55H+R-g@mail.gmail.com>
Message-ID: <CAK7LNAQrOhJpkUf=zxvwcbf8oWTAhKiWxemweHz8QPT55H+R-g@mail.gmail.com>
Subject: Re: [PATCH] samples: disable CONFIG_SAMPLES for UML
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-09-18 17:21 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Am Dienstag, 18. September 2018, 05:58:33 CEST schrieb Masahiro Yamada:
>> Some samples require headers installation, so commit 3fca1700c4c3
>> ("kbuild: make samples really depend on headers_install") added
>> such dependency in the top Makefile.  However, UML fails to build
>> with CONFIG_SAMPLES=y because UML does not support headers_install.
>>
>> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
>> Reported-by: Kees Cook <keescook@chromium.org>
>> Cc: David Howells <dhowells@redhat.com>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Is there anything UML can do better?
> Not sure whether an arch like is supposed to install headers at all,
> I guess no. :)

I just thought suppressing CONFIG_SAMPLES was a big hammer.

We could install host-arch headers for UML if we like,
but I am not sure whether is is sensible...

Wait for comments in case somebody has a better solution.





-- 
Best Regards
Masahiro Yamada
