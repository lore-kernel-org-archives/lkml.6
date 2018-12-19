Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56995C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB96218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LHUDZGZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeLSO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:59:50 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50823 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeLSO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:59:48 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wBJExgsI005775;
        Wed, 19 Dec 2018 23:59:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wBJExgsI005775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545231583;
        bh=oEyUaPRgoOB5/8i/zNyaTV3hiVewFWSWNsRx2RayK7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LHUDZGZDt3HJpB460baizFQdy+PkwOTA8FdLH0x/Ts0CHUV+GwmDwiZJBv/9AueSf
         rVVSPLgkbc6JR5Tr4+O5LsB4I2HmCxl//b27PqOJ41I1sx4BfMWfKNmPoT0usS1Ued
         86HVwB8hukZg44kz81EaStH2AhtMfQd/7VRCsGg+ACQDkz/SHT3eZQW9MO57yeyP3b
         nUa06aMAzfhYVM5+paPWFtxGgQiarwLX7xCSmdOmwj2pnn3xzCItrp5djSE68YMwOt
         Kvdvfsgdeu6CFT1WdwIqUc11I3Yp2k2rmgVcCsaUncIxQF3nHdqJEKdQcA6lZHf7vB
         pbmm7+pouK33g==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id x1so12386489vsc.10;
        Wed, 19 Dec 2018 06:59:43 -0800 (PST)
X-Gm-Message-State: AA+aEWbH11o0k++HA/aOnpq6lbsyAN5kUcwAPRevGV1/MsIRGFGGony2
        /Ill1TW02S0o9XzyxKOQU751VKne4LrLpshMudg=
X-Google-Smtp-Source: AFSGD/WlXGX0E+JpbfMdBvcAjMEit+ipXLxaalp+G9cBKAZ5gK1+VOg3XtfI6HU9SeP1Qold8lZlTarARj9HoxnAgmw=
X-Received: by 2002:a67:385a:: with SMTP id f87mr10388847vsa.179.1545231582289;
 Wed, 19 Dec 2018 06:59:42 -0800 (PST)
MIME-Version: 1.0
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Dec 2018 23:59:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQigp+cnH18w6iYKjix3oZtOOjOF=e1RKiJPdBFr3TwPw@mail.gmail.com>
Message-ID: <CAK7LNAQigp+cnH18w6iYKjix3oZtOOjOF=e1RKiJPdBFr3TwPw@mail.gmail.com>
Subject: Re: [PATCH 00/27] kconfig: remove all reduce/shift conflicts,
 refactor lexer, fix various issues
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 8:04 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>
> When I tryed to change something, I was often hit by annoying
> shift/reduce conflicts in the parser.
>
> The lexer and parser are too cluttered.
>
> So, I decided to clean-up now.
>
>   - Fix all shift/reduce conflicts in the parser
>
>   - Rewrite the lexer. The linear keyword search was removed.
>     The number of states descreased from 6 to 4.
>
>   - Fix various subtle issues
>
>
>
> Masahiro Yamada (27):
>   kconfig: fix file name and line number of warn_ignored_character()
>   kconfig: fix memory leak when EOF is encountered in quotation
>   kconfig: require T_EOL to reduce visible statement
>   kconfig: remove unneeded pattern matching to whitespaces
>   kconfig: refactor pattern matching in STRING state
>   kconfig: fix ambiguous grammar in terms of new lines
>   kconfig: clean up EOF handling in the lexer
>   kconfig: warn no new line at end of file
>   kconfig: remove grammatically ambiguous "unexpected option" diagnostic
>   kconfig: remove grammatically ambiguous option_error
>   kconfig: remove redundant if_block rule
>   kconfig: remove redundant menu_block rule
>   kconfig: loosen the order of "visible" and "depends on" in menu entry
>   kconfig: rename depends_list to comment_option_list
>   kconfig: remove redundant token defines
>   kconfig: use distinct tokens for type and default properties
>   kconfig: refactor scanning and parsing "option" properties
>   kconfig: use specific tokens instead of T_ASSIGN for assignments
>   kconfig: use T_WORD instead of T_VARIABLE for variables
>   microblaze: surround string default in Kconfig with double quotes
>   treewide: surround file paths in Kconfig files with double quotes
>   kconfig: ban the use of '.' and '/' in unquoted words
>   kconfig: refactor end token rules
>   kconfig: stop associating kconf_id with yylval
>   kconfig: switch to ASSIGN_VAL state in the second lexer
>   kconfig: update current_pos in the second lexer
>   kconfig: remove keyword lookup table entirely


Series, applied to kbuild/kconfig.


-- 
Best Regards
Masahiro Yamada
