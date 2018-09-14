Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A0C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C27720882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="G03ixKR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C27720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeINNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:52:12 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:33715 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeINNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:52:10 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8E8cGOt014090
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 17:38:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8E8cGOt014090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536914297;
        bh=W9kH1r4dI2qL7+BSgGCVuVls7FtkCeqULWrmPBCnICI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=G03ixKR0iQEcfkdFYbXQrTWLTEDTz6SbmiBTmykUrrBKbP0tSJ6AcRWsMn/kSkyxi
         5WA3onWW+HzqwFoo+Cm0tllXLYDPR6w3dnNTtDSsVTkba05235mijO1Nulofq7CVvK
         KAKT5+bBTTk7FIS8F+aaQ4GXbdAy15AJP2thY+LN6kSnSDjEjE0bphrY8lw+p7TyuR
         7CJPAIU5fQ9Bafd3sN+JJp6qPt3kCqjXmi7boUbDFx84Qp2IGYUEs4IztEuBgiy7vm
         nEFqVYSfEXd+IhCmEIeGe+ohqdZ29hDWn0V6uiZBPN/YrJOUsHMlB6XwMLBBTvF79/
         I84onoy/IgSBA==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id s17-v6so1378469vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:38:17 -0700 (PDT)
X-Gm-Message-State: APzg51DtPQWSLgx5UbW91uArIJ9hkwGh0xEQmTM3PM5LKMLL1aG4vXG7
        zMQ+kx1UeDOc5Wv8+xWuCjxT0y1VfcCDQ6pR89Y=
X-Google-Smtp-Source: ANB0VdZT4asU30aS0cu1bBBps1DwFvN7xqwHApQyokmrhuoiKNXLFK1QuLtfiL1m9a97uGdC5hSUf55riehBbJrjc/g=
X-Received: by 2002:a1f:328a:: with SMTP id y132-v6mr2752080vky.84.1536914296319;
 Fri, 14 Sep 2018 01:38:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 01:37:35
 -0700 (PDT)
In-Reply-To: <20180913102946.41a43d88@xhacker.debian>
References: <CAK7LNASWfncdHRkRs=tq=TRaM+KUbb8bcMHMs8LiCgZzuFKCAg@mail.gmail.com>
 <20180913102946.41a43d88@xhacker.debian>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Sep 2018 17:37:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7ahOdnp1CGoKkpN6gg3aKr11vPR-GN9mv=VrwRCt--A@mail.gmail.com>
Message-ID: <CAK7LNAR7ahOdnp1CGoKkpN6gg3aKr11vPR-GN9mv=VrwRCt--A@mail.gmail.com>
Subject: Re: [Question] vendor-specific cpu enable-method
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-09-13 11:29 GMT+09:00 Jisheng Zhang <Jisheng.Zhang@synaptics.com>:
> On Thu, 13 Sep 2018 10:23:35 +0900 Masahiro Yamada wrote:
>
>> Hello.
>>
>>
>> Sorry if I am asking a stupid question.
>>
>>
>> For arm64, there are only 2 cpu methods, psci and spin-table.
>>
>> Why do we still allow vendor-specific methods upstreamed
>> for arm 32bit ports?
>>
>> To me, it looks like SoC vendors continue inventing
>> different (but similar) ways to do the same thing.
>>
>> It is a historical reason for old platforms.
>>
>> However, if I look at Documentation/devicetree/bindings/arm/cpus.txt
>> enable-method properties are still increasing.
>>
>>
>> psci is available in arch/arm/kernel/psci_smp.c,
>> but not all SoCs support the security extension.
>> Is there a simpler one like spin-table available for arm32?
>
> Per my understanding, spin-table is similar as the "pen" based
> solution in arm32, both can't reliably support kexec, suspend etc...

Right.  spin-table is based on pen-based implementation,
and just a back-up plan in case psci is not available for some reasons.


>>
>> If we force generic methods like psci or spin-table
>> for new platforms, we can stop proliferated smp code.
>> (Of course, we are just shifting the complexity
>> from the kernel to firmware.)
>
> psci is good but not all SoCs support secure extensions. spin-table
> can't support kexec, suspend. Except prefer psci for news SoCs
> with secure extensions, no better solutions AFAIK.

OK, psci is preferred if it is available.

Otherwise, ... vendor specific code.


Thanks.


-- 
Best Regards
Masahiro Yamada
