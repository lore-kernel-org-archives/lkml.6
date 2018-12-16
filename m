Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F13AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153352086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kgHh8wKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbeLPPZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:25:27 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21905 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:25:27 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBGFPJj9002630;
        Mon, 17 Dec 2018 00:25:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBGFPJj9002630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544973919;
        bh=NJMyuHe0cC1L0jnTAllNCkL8kcf8wVDeEMIhL43uWmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kgHh8wKaZVNYZ5u8+JYO86DB6eRHRo34p04UMPP0lzx56JFb7/cjzPcttH5tg6pDm
         +7oIPN2K1l1hG2AO5oXIUDqGuip144LWh7yy67grRdZt2e80wjPGG4t1fw63+v1JIQ
         Lg7vxKCiGpv6I4QSOS9iaEtOFA2efQg/7/e2SwTiZQi/uw3hSITGoEaKYMHT9CDhgj
         1295/JssoGgBKYH8MiRdDbYYTnmMErBR6Lgz2u2TBO9K378zK0lxePYW6OPBaGgBQ3
         e+6juKAJ5sFIAtbT/pTn1GUczXAwETon3B4dr593N27Xgus2STzD4xs0fDttAuIONE
         wi4fiIwcKHUKw==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id d21so3610028uap.9;
        Sun, 16 Dec 2018 07:25:19 -0800 (PST)
X-Gm-Message-State: AA+aEWaLj4fnmJrXSDyP8z4mXf7j0o9LUKrzDA+68/bxEvOIWpbNu5nq
        8EVBG7eWDt8WgI9M3Rnd8chfsjDApgzrRe+scm0=
X-Google-Smtp-Source: AFSGD/UpqJ5qcveMiyn/F102qR5ecvbLb3dDzPTdcGSxUfo30coKipndWTGLE1xQ0JXRX2AtoZs6fhIaeMbEWg/WTXE=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr4788373uad.55.1544973918344;
 Sun, 16 Dec 2018 07:25:18 -0800 (PST)
MIME-Version: 1.0
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 17 Dec 2018 00:24:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATKMZiN=NdhXbCLwxkKtM34cetfV5Z9bw9t2KsxZc49zg@mail.gmail.com>
Message-ID: <CAK7LNATKMZiN=NdhXbCLwxkKtM34cetfV5Z9bw9t2KsxZc49zg@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: refactor Makefile.asm-generic
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 8:29 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>  - Use conventional $(MAKE) $(asm-generic)=<dir> style
>    for directory descending
>
>  - Remove unneeded FORCE since "all" is a phony target
>
>  - Remove unneeded "_dummy :=" assignment
>
>  - Skip $(shell mkdir ...) when headers exist in the directory
>
>  - Misc cleanups
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

1/3 applied to linux-kbuild.

I will send v2 for the rest in the series later.



-- 
Best Regards
Masahiro Yamada
