Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8705C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1C420854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xV3qOu9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfAQD0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:26:18 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:43091 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfAQD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:26:17 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x0H3Q6vw002711
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 12:26:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0H3Q6vw002711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547695567;
        bh=ZhGTP/dZN/BDKdDBQsCFCzvYK3IhmjbwG6lQcl3uMTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xV3qOu9UVu7K0N5N0aOwwZdm/lFnYYG5ETvmCwPvcMPKfrrYvvYC6swiqG0O9mwlY
         5LWHoogQwYpA+2AOWS0s29Vr2IRN7o30gmydUaFWcOJ8Z9XxkvdjSKz3ysGV8PMyWL
         HBW2Y8aTLM5IQx0mOwfo7UkcldZZDyg9W/0on2pD+mvmT3CW+26FX+MUOKhczfpqlf
         /FQYziPNPys6HUIlea+4AXXO2h5HGH1A/mzyRYf5ueWbrmB/vM+66jeVayarTMkcaw
         1aCtn8POD8kT6o4yrqXaWu4RVhkW15KhDt38ba9ZSKaUdKD1k7bQEc2+qYyNzZAJR7
         9skTLlQvwsqRg==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id x1so5338232vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:26:06 -0800 (PST)
X-Gm-Message-State: AJcUukeNPbYKu4puYcmUfKTcwnObd7J1GXZ3CxnpbRNnxkbZcmT+vY9f
        QEGQda+LM/m8pHtNJe/pU18aie43B/M58I6qQcI=
X-Google-Smtp-Source: ALg8bN44/DJUBK4TTQM/o62vC1G/VMqYRYSgQlI/0aIl7L3fbNN4y4EwvFxZEjBUBbIibjvm0JQNTPyNQ60z+O9ecPs=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr5189380vsb.155.1547695565773;
 Wed, 16 Jan 2019 19:26:05 -0800 (PST)
MIME-Version: 1.0
References: <1544969781-14506-1-git-send-email-yamada.masahiro@socionext.com>
 <C2D7FE5348E1B147BCA15975FBA23075014641FC6F@US01WEMBX2.internal.synopsys.com>
 <CAK7LNATJVGVJi_S99zfEpKe+HYWpk+TkfT4gCFZVVTibyP=ThA@mail.gmail.com> <C2D7FE5348E1B147BCA15975FBA2307501464221E5@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501464221E5@US01WEMBX2.internal.synopsys.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 17 Jan 2019 12:25:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT99BNySdeUK=qhXnYSwry=8wADOd7KLjVUAdgQoKjeuA@mail.gmail.com>
Message-ID: <CAK7LNAT99BNySdeUK=qhXnYSwry=8wADOd7KLjVUAdgQoKjeuA@mail.gmail.com>
Subject: Re: [PATCH] arc: remove redundant kernel-space generic-y
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,


On Thu, Dec 20, 2018 at 4:52 AM Vineet Gupta <vineet.gupta1@synopsys.com> wrote:
>
> On 12/19/18 7:16 AM, Masahiro Yamada wrote:
> > Could you pick this up to your arc tree?
>
> Done, will push it in a day or so !
>
> Thx,
> -Vineet

This was not sent in the previous MW.
(Nor did I see ARC pull request.)

Is it aiming for v5.1-rc1 ?




-- 
Best Regards
Masahiro Yamada
