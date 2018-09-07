Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA0DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A8B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7uBJ4wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A8B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeIGSkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbeIGSkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:40:00 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481342086C;
        Fri,  7 Sep 2018 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536328734;
        bh=MfTug/iTVVYLYrBOImjYweSW9EABMIC911TalAFi2uQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h7uBJ4wx0ayV/c+11F5HXpDHD6hgcP6P4Un86ZYk3RHERag8iF9YOroQ0WCslbm+h
         g5+gABZJgZ3NGMRTDMaTnOumd4LnR0E98qC7QxGNsihvwMzvhxK74yj2eSMALGgaQf
         1pww8+2mV4xOPKCZjGh9jhUrryZdFT26qg/HbVww=
Received: by mail-qt0-f180.google.com with SMTP id d4-v6so16242003qtn.13;
        Fri, 07 Sep 2018 06:58:54 -0700 (PDT)
X-Gm-Message-State: APzg51DHGUicmjtlJbCiv+QrBDOZf0UJaXYMflu9YH+c3tSHfFZRCpbY
        0L9+4otZekSR2/XoeZbUp2/yjkfY4limgldk6g==
X-Google-Smtp-Source: ANB0VdalvyQXxwaC+S6OUE6+dSkOs304rHHwRJDWYU/ib2PUO4NwrV37UF2DoOendwOr+RfXlJClGhhb87zeV1YWLb8=
X-Received: by 2002:ad4:414b:: with SMTP id z11-v6mr5899881qvp.77.1536328733418;
 Fri, 07 Sep 2018 06:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
In-Reply-To: <CAHTX3d+BFKM-jFo8Ww_dXwAzsDVoWqE==erfwVTeijHfh8kkOw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Sep 2018 08:58:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvLoekvxcaBMxrboJzqS=NyB69NHLShos+LhETj7zNwQ@mail.gmail.com>
Message-ID: <CAL_JsqLvLoekvxcaBMxrboJzqS=NyB69NHLShos+LhETj7zNwQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] DT cpu node iterator
To:     Michal Simek <monstr@monstr.eu>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <lftan@altera.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Simon Horman <horms@verge.net.au>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, vitb@kernel.crashing.org,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, linux-clk <linux-clk@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        SH-Linux <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 7:54 AM Michal Simek <monstr@monstr.eu> wrote:
>
> Hi Rob,
>
> 2018-09-05 21:37 GMT+02:00 Rob Herring <robh@kernel.org>:
>>
>> This series adds an iterator for cpu nodes and converts users over to use
>> it or of_get_cpu_node in some cases. This allows us to remove the
>> dependency on device_type property for cpu nodes though removing that
>> from DTS files will have to wait for some time. In some cases, this makes
>> the DT search more strict by only looking in /cpus child nodes rather
>> than any node with the device_type == cpu. The iterator also honors the
>> status property which is often forgotten.
>>
>> I've only tested on ARM under QEMU and compiled powerpc.
>
>
>
> Do you have this somewhere in your tree not to apply 21 patches by hand?

Yes, dt/cpu-type branch on my kernel.org tree.

Rob
