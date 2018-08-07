Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9125C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BFA21A18
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iv1gs+at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BFA21A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbeHGIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:39:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:38508 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHGIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:39:54 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com [209.85.217.174]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w776QvBr021463;
        Tue, 7 Aug 2018 15:26:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w776QvBr021463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533623218;
        bh=QZ1+JYig2et7/LHrhjfT/9OYFQ/HeBK9zQkE9uqdRro=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iv1gs+atSVOrnGoNqHUu19LDT0C3AuFXDm3Bg2UaCXFJ/UM+dbTjdRS7LqLUS4D6H
         tfFCAb6PbYYZVwJldnAYwOw73KefnP/XJXx6vEjfwgY3124A2Iy0AeT3CYiEwE0Zib
         kb6rp9B2B8PjZsm+nSHZ0wIdVnG1CZ8e6onN/ts03a8xuCdAVD1lwxuzu7H/VwwqZq
         TSKglz35+y2S1GdDm6Fc4bkWabGcoLbqi/zqSsroDsUgE4WgwrXTktxU7ukz2rGV2Y
         F2TRz4QB3f7vDTOIbDChZmfQBHeRCp7c4U7OhiF1ix1e2lqRkkMshqv1RW+F+3Qo54
         dVe2yzwSF56Iw==
X-Nifty-SrcIP: [209.85.217.174]
Received: by mail-ua0-f174.google.com with SMTP id k25-v6so14903576uao.11;
        Mon, 06 Aug 2018 23:26:57 -0700 (PDT)
X-Gm-Message-State: AOUpUlEK1K5QsyXvrir4AIWtf9X0RfTV4vdYbbrl7fF5CSsGuJgMRA6F
        +EsnuBKt9o0OYoeFmKdJF+rwgIJhtr1XLXoQqj8=
X-Google-Smtp-Source: AAOMgpfEyhvyIMMDsiaKogVVh1vCP2Pff4eZt2AiQgcWEDQKsjafus4ThCn+LLWwzCBzslQAOxrwhIIvbUPFmJYj2ss=
X-Received: by 2002:a1f:4049:: with SMTP id n70-v6mr11700500vka.140.1533623216482;
 Mon, 06 Aug 2018 23:26:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 23:26:16 -0700 (PDT)
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 7 Aug 2018 15:26:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7fwWofFb-xVU7E4=hJh2x=NPOce9LBF3ncWqYtqt-hg@mail.gmail.com>
Message-ID: <CAK7LNAQ7fwWofFb-xVU7E4=hJh2x=NPOce9LBF3ncWqYtqt-hg@mail.gmail.com>
Subject: Re: [v0.1 PATCH 0/7] mmc: tmio: refactor TMIO core a bit and add
 UniPhier SD/eMMC controller support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-07 15:17 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:


> [v0.1 PATCH 0/7] mmc: tmio: refactor TMIO core a bit and add UniPhier SD/eMMC controller support


This series is v1.

v0.1 was the internal numbering, which I forgot to change.


-- 
Best Regards
Masahiro Yamada
