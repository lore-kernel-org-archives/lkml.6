Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C525D2409C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fN4AqZFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C525D2409C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbeGFCyb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:54:31 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:27056 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbeGFCy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:54:29 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w662sIa2020597;
        Fri, 6 Jul 2018 11:54:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w662sIa2020597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530845659;
        bh=OKoGptae13dIlNnjuro/OzSVhPB+Di4GKmriVgDAqHw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=fN4AqZFQ18HxSr8e29esHPW653PMzbbVTg0fa3OML+hWM458B93fMY73fpv4sfzj/
         WdqLIu2xUg2FfWBD0Iqw0xF4AVhWsgasXSkTLTm7ij/dJmPm6dxaPnLzfL02iA6SkA
         ZSziqtw+sdI9bCb9anC0kTXf3YQ9V3BBri+8yLpMgY0Qg4qlC1nONh9vwIs/pBSYQD
         shIlfMGipxU+M2ZABg7spWNJd9XP9u4gnwcW8dsNwpDHGH51/U6/9JqiLtJWZOc2ZL
         7hUS0jR37DdIBDFCHIR7NRJRbUrjqKLlYOYcePRK3uRDPAy1ih2VtJFwKb/W8vbDtW
         9QTy7vIc97xrA==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id u8-v6so6687767uao.4;
        Thu, 05 Jul 2018 19:54:19 -0700 (PDT)
X-Gm-Message-State: APt69E3/qjAEo8fv7G7D0m5mshNEwxdkOkCjiz6XMg5l/D/9x1T9vu0t
        u/IG1NjkExnEYTYpUdGSA+rIO9szuwNFLMQwRpY=
X-Google-Smtp-Source: AAOMgpeOMImVQV8LiO2XaecArqGb8Y2FhX0tAip831odVXXfqofgob38W8jWzH8TVq1a1exaj2/PtYw16sAyFV1n3SM=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr4711121uah.144.1530845658414;
 Thu, 05 Jul 2018 19:54:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 19:53:37 -0700 (PDT)
In-Reply-To: <0eb8bc34-a0e0-eea8-be62-8420bd82c717@infradead.org>
References: <0eb8bc34-a0e0-eea8-be62-8420bd82c717@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 11:53:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8V3WAfaA=iiWgKBPbGNOThsuPa70jZJ2W-oqrLbKiHQ@mail.gmail.com>
Message-ID: <CAK7LNAQ8V3WAfaA=iiWgKBPbGNOThsuPa70jZJ2W-oqrLbKiHQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: update user kconfig tools doc.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 7:49 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Update Documentation/kbuild/kconfig.txt, which mostly contains
> user help for using the kernel config tools.
>
> - Add mention of 'nconfig' embedded help text.
> - Make the section on new config symbols readable.
> - Correct how to find menuconfig search help.
> - Add section on 'nconfig' usage.
> - Mention that gconfig has multiple viewing modes/options.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---


Applied to linux-kbuild/kconfig.  Thanks!


-- 
Best Regards
Masahiro Yamada
