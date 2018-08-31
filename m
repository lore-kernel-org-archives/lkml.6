Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA2F20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="03k5c5RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA2F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeHaSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:54:33 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49753 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeHaSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:54:33 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7VEkdUt005204;
        Fri, 31 Aug 2018 23:46:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7VEkdUt005204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535726800;
        bh=+1D6tLSi6dwxMlSKQs+4lK9phPzVgQ4IMW9jmf3Qmlc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=03k5c5RAh/6KnIOsUTqdMmpjEPIHthnWY+LNCSo3IQiAy/QveRVftg+99oHh9ymqt
         B8Pe8d5GbMZ6eN+A/PBS35gfKWHG798EBMq+mcaNayRQl6SVoc+6hE2BBPl0Fuojwq
         Qlm4ASKMByvMO1Zt1mLnEQCJx8KmXWB5mVnKz4CU4+/Xu36wW2iqF493BhTgv5laiK
         62NvhyY5SxYNe548EdLxngVdicxUYNQtXBdQZd5uDaIYtF2KZZlIrXmSj7w2LTmvZG
         BensQVBtAvsVkgx6tHB/1vBFSVz8qXd1Cg4GdglFKaJ5ScTvfy0XqegJDAXSHvahlT
         OavJTssRMT4bQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id m26-v6so8360231uap.2;
        Fri, 31 Aug 2018 07:46:39 -0700 (PDT)
X-Gm-Message-State: APzg51CuRF305gYql9nnmggWjMT5kTiTyz7HwMHRQiPoH7vWzMf3VwjX
        s4NtCyT79p0ytGs0VNe5aCGA5yyvWiDDoPFpx7I=
X-Google-Smtp-Source: ANB0VdZdvLKUqKPIK0wFLSZwN5aQdTOcy22y44J71LyIIQbS3ERu6U5UvQvZ9byJv5Nk8SYQWHB3sjfwQYibqH26bkM=
X-Received: by 2002:ab0:30ea:: with SMTP id d10-v6mr9886387uam.58.1535726798724;
 Fri, 31 Aug 2018 07:46:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5155:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 07:45:58
 -0700 (PDT)
In-Reply-To: <1535620722-14689-1-git-send-email-lukas.bulwahn@gmail.com>
References: <1535620722-14689-1-git-send-email-lukas.bulwahn@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 31 Aug 2018 23:45:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDm+=55UvLKp3ox_a64WU=W55=2ftAQ7MmMxA5E-bXkw@mail.gmail.com>
Message-ID: <CAK7LNAQDm+=55UvLKp3ox_a64WU=W55=2ftAQ7MmMxA5E-bXkw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove a spurious self-assignment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-30 18:18 GMT+09:00 Lukas Bulwahn <lukas.bulwahn@gmail.com>:
> The self assignment was probably introduced by an automated code
> refactoring in
> commit 694c49a7c01c ("kconfig: drop localization support").
>
> The issue was identified by a self-assign warning when running
> make menuconfig with clang.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to linux-kbuild/fixes. Thanks!


>  scripts/kconfig/mconf.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 83b5836..143c05f 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -490,7 +490,6 @@ static void build_conf(struct menu *menu)
>                         switch (prop->type) {
>                         case P_MENU:
>                                 child_count++;
> -                               prompt = prompt;
>                                 if (single_menu_mode) {
>                                         item_make("%s%*c%s",
>                                                   menu->data ? "-->" : "++>",
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
