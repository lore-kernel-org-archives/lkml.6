Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B05AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69282089F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o9lbVdUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69282089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeKZApr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:45:47 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:30936 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeKZApr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:45:47 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wAPDsZMX027010;
        Sun, 25 Nov 2018 22:54:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wAPDsZMX027010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543154076;
        bh=hH/vAaOoUpB2TDSUWPW2NjP83PJ6T46EPcY68HGCbUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o9lbVdUXPUN2Mk7hxo4Z4CTOnSAIPHnYNzJDkuljnPEZn9b0uJZGL9Ffh6Nbq/dMx
         iIljJyV5mSqidlQo940Wii6w7k2DSw4yzpOJIO9Ivk7mHExjssf+wsIlZiH9cF2Abg
         denZ12BM4rWRhxBJeEsRmmynqUtX9nNawE2EOp2Z25LsP44P6nBtK7S5uEKUDISEzj
         i+TcAEQ3L2Dpwyzb1xxISSEREvJayfumloyyRMdgbb1GDD6U0B9wTMiQhHYluoRZzM
         q4R7zF29ixVzepD0lZxhy3932HJcClgs0OQzTW6JT0m1ffRaM6leOE+GAge8fm7/fg
         KWDQUfE8NP3nQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id r14so9675341vsc.13;
        Sun, 25 Nov 2018 05:54:36 -0800 (PST)
X-Gm-Message-State: AGRZ1gIYIU4JRGDaqcDz8BMmBczy2T3yZrkGbyq40AGzZYENoaDuC34U
        jW3XypiJGjLj6/dfq8PhxKBLHGMX8moD6+UfHHk=
X-Google-Smtp-Source: AJdET5e1EdGgMmiZINniI8FuHlakqq2Pt71qlvCou1g9zRa/Xfc+96FMdb13P6n1ySTzBSEapDxHcROyztQ0ShydXoU=
X-Received: by 2002:a67:385a:: with SMTP id f87mr9823917vsa.179.1543154075229;
 Sun, 25 Nov 2018 05:54:35 -0800 (PST)
MIME-Version: 1.0
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com> <20181124141616.GH3175@vkoul-mobl.Dlink>
In-Reply-To: <20181124141616.GH3175@vkoul-mobl.Dlink>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 25 Nov 2018 22:53:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
Message-ID: <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 11:16 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 12-10-18, 01:41, Masahiro Yamada wrote:
> > 1/2: DT-binding
> > 2/2: driver
>
> Applied this series, thanks


Thanks.


> While building I noticed that we get few warns when compiling with
> C=1, I would prefer you fix them. Please send fixes on top of the
> applied patches.

My code is fine.

If you are talking about the following, your sparse is too old.
Upgrade your sparse.

./include/linux/overflow.h:285:13: error: undefined identifier
'__builtin_mul_overflow'
./include/linux/overflow.h:285:13: error: incorrect type in conditional
./include/linux/overflow.h:285:13:    got void
./include/linux/overflow.h:287:13: error: undefined identifier
'__builtin_add_overflow'
./include/linux/overflow.h:287:13: error: incorrect type in conditional
./include/linux/overflow.h:287:13:    got void
./include/linux/overflow.h:285:13: warning: call with no type!
./include/linux/overflow.h:287:13: warning: call with no type!





> Thanks
> --
> ~Vinod



-- 
Best Regards
Masahiro Yamada
