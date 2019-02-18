Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2551C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6EF218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ESgw5T/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfBRHV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:21:56 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21849 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbfBRHV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:21:56 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x1I7LS4i014294;
        Mon, 18 Feb 2019 16:21:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1I7LS4i014294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550474489;
        bh=EFqsu5kq8IKOae+Xwksxc2hxBmo8o3hEkNaFC68ve0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ESgw5T/TBcOa6LnGuGo3qNSS9iwo4TXZLt1LHh81hlKWam3eDzgWiKwih0/KQT3xV
         cXzrmNOrpbf+efecsPz7kzp2sugHenxZ9r+7PjCIWTg7AB0Wv1+3DA3KiDz6ymexUZ
         mrYfkJTUXaPprFwr/SnsfA0W0UdjVRzErZA8fxnanOf5FCvcl/R0l4qjN/SGjv6sXg
         nnuXPD3NRhvf0526JReSQy5K0QM5eycow0WgNB0Dye/bSYfgXFRkmzZOiKyHiNTr0G
         0rnSwLlWrR1p/R9THUJoJEM0H9+vu8OWCuYMXrxzxc/M2vQyQOIpsp3EiazHEaEzs2
         MCjmKF4rQp4zQ==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id j3so5506397uap.3;
        Sun, 17 Feb 2019 23:21:29 -0800 (PST)
X-Gm-Message-State: AHQUAuaAfk/EtilsVeXrgJxtZ9IXADU9BFDYUqvll1x/k/gng80OUhY2
        ksv8chZdqAY6k8E69H8S4Ri9Zd9AW43ZeKPynRI=
X-Google-Smtp-Source: AHgI3Ib+T07tKbdDZhKstm6j3PUoSjoqt1MGcjEWaCqndR34OF7iXAwuDFxPAMaqEGyJjS9SC4FUBdX/jtrLoIdogg4=
X-Received: by 2002:ab0:648c:: with SMTP id p12mr6655199uam.93.1550474488067;
 Sun, 17 Feb 2019 23:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20190207123022.7961-1-2pi@mok.nu>
In-Reply-To: <20190207123022.7961-1-2pi@mok.nu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Feb 2019 16:20:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
Message-ID: <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
Subject: Re: [PATCH] modpost: file2alias: define size of alias
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattias,

On Thu, Feb 7, 2019 at 9:31 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> The size of the variable alias provided to do_entry functions are
> currently not readily available. Thus hindering do_entry functions to
> perform bounds checking.
>
> Define the macro ALIAS_SIZE containing the size of the variable alias.
>
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>


Sorry for late reply.

I can apply this to my kbuild tree shortly, but
it looks like a prerequisite for your
"platform/x86: wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()"


If you want all the patches to go through x86 platform-driver tree,
I am fine with that too.

Please let me know what you want.

Thanks.



-- 
Best Regards
Masahiro Yamada
