Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F41C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7B824B6A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 08:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0MKhfILg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7B824B6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeFWIL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 04:11:26 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17883 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeFWILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 04:11:23 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5N8BDLa031134;
        Sat, 23 Jun 2018 17:11:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5N8BDLa031134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529741473;
        bh=f5ZHFzGly4MlKLkdcUllGkxjb6RaQKpwTCFusVgXt2s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0MKhfILgI53ofHzJvr08WkiEe6XPA130FdlxWYqOXsRSoB3UlnuLkr4yuMUFBUoV/
         7Wh5asgCZzqphpiXzNvWwyLRYzMZ/ZBgud/m21QRiBMmxl7eWG8l+odgBFIp0iq0Ts
         AWAdWw35/NETuxDQuGSHwWNyl9nyLy10IONgIYtQPDVHZgOe5SeFVdbfJ5f73qmAur
         QvJgi8RSpjZm+JxeAgwlnnYsFFlgATCLDO6kWnGou8EwjAqKT/RqvvpZfSuxWpmGvN
         208itnMVkch/V0DoYReYH8LhgB5KddjgidqcJujJhrr5etSxTHpgCUq9x0B0ltBNlO
         UyAxIsbRbXJZQ==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id b134-v6so5194328vke.13;
        Sat, 23 Jun 2018 01:11:13 -0700 (PDT)
X-Gm-Message-State: APt69E37mpc7VobSulrhL1Kiq8jEtaFuPGwBF5NdyAngsalPF7/szMFq
        gzVsORSJFte5MFbOO841AIZyiMYec1Zciuuk3lo=
X-Google-Smtp-Source: ADUXVKJv5GeYVk7K6PR6rOrunevZW/tT48o+iPw+cMigOgp6+1Hb16xlxqgUUd8Np92c4eml0dY+v4rx63kCpPajnKk=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr2874956vkj.160.1529741472565;
 Sat, 23 Jun 2018 01:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 01:10:32
 -0700 (PDT)
In-Reply-To: <b2854ed6-073d-11b9-b344-571a0903995c@infradead.org>
References: <b2854ed6-073d-11b9-b344-571a0903995c@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Jun 2018 17:10:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9YQHJVXBevFG=ckkUVguakCwBuck8NO+rxoTi8o8GOA@mail.gmail.com>
Message-ID: <CAK7LNAT9YQHJVXBevFG=ckkUVguakCwBuck8NO+rxoTi8o8GOA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: document Kconfig source file comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-23 12:08 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> I saw this type of Kconfig construct on LKML:
>
> config SYMBOOL
>         #bool "prompt string"
>         default y
>
> and wondered what it does.  Then I wondered if '#' comments are
> even documented.  They aren't, so add a little doc for that.
>
> Ah, good.  kconfig says:
> arch/x86/Kconfig:2942:warning: config symbol defined without type
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---


Applied to linux-kbuild/fixes.  Thanks!


>  Documentation/kbuild/kconfig-language.txt |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- lnx-418-rc1.orig/Documentation/kbuild/kconfig-language.txt
> +++ lnx-418-rc1/Documentation/kbuild/kconfig-language.txt
> @@ -430,6 +430,12 @@ This sets the config program's title bar
>  to use it. It should be placed at the top of the configuration, before any
>  other statement.
>
> +'#' Kconfig source file comment:
> +
> +An unquoted '#' character anywhere in a source file line indicates
> +the beginning of a source file comment.  The remainder of that line
> +is a comment.
> +
>
>  Kconfig hints
>  -------------
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
