Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36866C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3720823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gUwxljFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJaAus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:50:48 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:19077 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeJaAur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:50:47 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9UFuMqW026337;
        Wed, 31 Oct 2018 00:56:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9UFuMqW026337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540914983;
        bh=jzZcS7etN+9x9BZTEl4qlAh1O4mZWC9RS/EkRP1BI7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gUwxljFNiks1Gw51BRN2TvR8IAgJsAWZRso7rkEhZrabCak1KEPIRHnbYwCVoUZ4c
         CYd4IPHY9elWt83vG95K+EcbKrJpNQ4hliP0GW4lkqVk+mNXvB/OF17b8xdNjnBjU4
         +KMf6N4Lfm3SNZJKVqEGzzbLaL5xmEGivJTWlM9uVlaE9lvfmFZRNj0zEYTVjENQlY
         NX5ekooiWLaTfwaOAPHBXlKeDiEs3ptEbNMgHZJpo+/pix9PYCygDnbiq9G5+wowgM
         csj1xiYwJGCyKNGuRNVoLLqivIGDLeQ/+zM62Uk/SrNvK8Tjo7dx3IdNjv4xbdbKCM
         3BNgTGUSjFMeA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id 124so7986215vsp.12;
        Tue, 30 Oct 2018 08:56:22 -0700 (PDT)
X-Gm-Message-State: AGRZ1gItLco93xHIReF5XptBucySbVaiOR6E4y37myKiXF6vZuXLqrMV
        NW6z9MdlOztb8R+vhXIlGovvX6aUGTxGXasdLWY=
X-Google-Smtp-Source: AJdET5drtPIyn5Z14mAewBtEZizcuAaYDsdLF3Jq2sO6cjQerfJ6xMsb9smjVMxJK9mZ1/Ra+RMgBgCv+0PbtT6VgQE=
X-Received: by 2002:a67:6101:: with SMTP id v1mr8456635vsb.54.1540914981635;
 Tue, 30 Oct 2018 08:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540827688-15999-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 31 Oct 2018 00:55:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWpRns6f5ULkfyijgo-0s+G9+9GA4rPb6phOEEAiu9cg@mail.gmail.com>
Message-ID: <CAK7LNATWpRns6f5ULkfyijgo-0s+G9+9GA4rPb6phOEEAiu9cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove oldnoconfig target
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:42 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As commit 312ee68752fa ("kconfig: announce removal of oldnoconfig if
> used") announced, it is time for the removal.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.




-- 
Best Regards
Masahiro Yamada
