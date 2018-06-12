Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7DA5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C563208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BgBDqwhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C563208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbeFLLHf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:07:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:34765 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeFLLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:07:34 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5CB7R8H031381;
        Tue, 12 Jun 2018 20:07:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5CB7R8H031381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528801648;
        bh=FyihJFQCAiYL1TyVuyJyFV5C/g6LW+Tll5ZbOJWLsiI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=BgBDqwhWOhEvwEdM8OGim718ANo6m9gO55DrfxmCFzfx1wMnUlfAlkLXtF9fYSrK+
         wGwelLZE7NokwDt+LrELLkt0BTTX76Yi4jX9Jy1+HA+K1W5HRdlUgkxyxEBTZBIl3e
         gy03unOkpdv5KWVYh9bYawOez9Kgkfog5awlz7WnyoBpkpfL22YMN4eftrPavbqbDt
         Ir2WD9oprU7uIvg+KHWcsHcxgSIKm8yZJ3rQSncQf9ytOhZEHiWUgaZHGQuP9uLczp
         n1Aa1HS05eYw6Dg2PV6YeXeKTYa3EAKe1wFB1bSI2mvJljm2RD4js3sPmoEu7PYPtg
         rzXbW4V2pyQYw==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id x4-v6so14105609vkx.11;
        Tue, 12 Jun 2018 04:07:28 -0700 (PDT)
X-Gm-Message-State: APt69E3jNpIXyaOdk03MyOZ/cz55uoUspFQ3dh05P0zZy74lJPE4SDf4
        3eheALS0tjb3/VcbCIiuz6ShoaGENnvctBAFV7k=
X-Google-Smtp-Source: ADUXVKIFtweA/MBKfTxCYiBvcIF31JhE0tj85vRoSKuqZc1Bhjgs+UQYdKQFgZ3a3/E2tKewA85SUk4KvEuIu7wjyYc=
X-Received: by 2002:a1f:9615:: with SMTP id y21-v6mr1779721vkd.154.1528801646086;
 Tue, 12 Jun 2018 04:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 04:06:45
 -0700 (PDT)
In-Reply-To: <20180612130329.1c17311f@bbrezillon>
References: <1528799515-1356-1-git-send-email-yamada.masahiro@socionext.com>
 <1528799515-1356-2-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASM53scdd-OZOj_7404Eru3a98uNLagip_GdkrSSaG3-Q@mail.gmail.com> <20180612130329.1c17311f@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Jun 2018 20:06:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATr54Eo-0PcTSLZvgmdTTngpTYXte=__17X4xRtywAgEg@mail.gmail.com>
Message-ID: <CAK7LNATr54Eo-0PcTSLZvgmdTTngpTYXte=__17X4xRtywAgEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: denali: add more clocks
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Richard Weinberger <richard@sigma-star.at>,
        DTML <devicetree@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-12 20:03 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Tue, 12 Jun 2018 19:36:06 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> Maybe, the commit title should be:
>>
>> mtd: rawnand: denali: add more clocks and improve setup_data_interface
>
> Or you split that in 2 commits, one retrieving the new clks, and the
> other one fixing/improving ->setup_data_interface().


Good idea.

I will try that in v2.




-- 
Best Regards
Masahiro Yamada
