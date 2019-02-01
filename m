Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C913920823
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="op4vJuKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfBAEW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:22:59 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31115 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBAEW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:22:59 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x114MpsO027386;
        Fri, 1 Feb 2019 13:22:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x114MpsO027386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548994972;
        bh=ALJHBS5NvZ13EYKoLf2EVjvHW9S3mxaSiqtzxngifpw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=op4vJuKP+wfvNeyPZrQ6eWuwZoClqwoeoEJw9xoFjNQ6/O+See0k1Dmlz6QAnxg6m
         /Tbwr5O4ZLrvwYWXABkobCA3VsxDznMOUQjDzkm1kQ6erXzJhvEHBd77/4qD4bM6O0
         s6SJY6ow7XZahcJ9yZ20ojlE6F96BpXPV8cnNCPCOUewzSQyGWuvZyJjADI4AQPxit
         svpvg09dEdwVvKZmrdbrcEcHdN3R1nyz1/rPj4HESXkI9LDTcasYbjApteo1wFIguN
         lQjh0+fUSuZje0uW0sLc8YiJQ9GAGjAdJThza1SrRfuD2ZBRiME1yGhOII+ElYcAER
         5htiEU3Au8Gmw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id x28so3380320vsh.12;
        Thu, 31 Jan 2019 20:22:51 -0800 (PST)
X-Gm-Message-State: AJcUukcGxxrx+umMJYtOF2Ep4RA50V/bjT0jHnSA7NC6BoLr65dSx2w9
        0Cu+aeFDdpLFexyOd7fuFZ8uNm9gF29f8ewNTkM=
X-Google-Smtp-Source: ALg8bN7t9uDIY/ghWVNGpCWS8gZMnv/u8EIUxw3oXNOJLQC7dh/rewcoYNpYkgkoVcGKwARRB48ofjguWPde3LgTF6c=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr15739923vsd.155.1548994970479;
 Thu, 31 Jan 2019 20:22:50 -0800 (PST)
MIME-Version: 1.0
References: <1548326850-13660-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548326850-13660-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Feb 2019 13:22:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmrNRqLWZXLZ27cF7yvSF6QsyuLhyVJFJf0e9Ubp44tg@mail.gmail.com>
Message-ID: <CAK7LNATmrNRqLWZXLZ27cF7yvSF6QsyuLhyVJFJf0e9Ubp44tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: rename zconf.l to lexer.l
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 7:48 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Use a more logcal name.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Both, applied to linux-kbuild/kconfig.






-- 
Best Regards
Masahiro Yamada
