Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 92900C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468F2208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UIvZkhVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468F2208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeFLKhL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:37:11 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43903 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeFLKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:37:07 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5CAalhT012362;
        Tue, 12 Jun 2018 19:36:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5CAalhT012362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528799808;
        bh=TB2W3sAWHNM2VtLFteR9rvaNgle4FM3F4g9T9b+Wk5Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UIvZkhVsnvPSRYG1FeAdI44SRMBO69RIpbagwBBfU2CMbdxyJztRmpxzPcPOGhDbO
         UmQYljRRG+A0Ga3gZAVMIqpSy0UmzE6CkKZ5vKwUf5SxJ/sQrMV845H3tBbQ52X7Zi
         poINUtlCJ402DKut9McNas8IopLs4MbMxacMrTjDf7PWKk7mFUTkuVCoC36UJCRvkE
         k3+i3R1zDPwAqjvl/6ZpLEk0mnxo+kGDOl3WdY/+PrJ4Y5RkE9Ke8LcNVdfztQHs42
         3+XIQjr5V6ON6IRHd2VUkxTDNRBv+MKkObfhDs2KZi+VihVl4QCzNEAeOm989/zrT8
         53cs4Q7gBQrBg==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id c23-v6so15605892uan.3;
        Tue, 12 Jun 2018 03:36:48 -0700 (PDT)
X-Gm-Message-State: APt69E16vMzPnkw3AxIIfTwKoCzkRw8zFzFyhzK9CLltpJd3zUBQuMQF
        mPyYtyjT2qnLS0WXxTupxrhVOH+ilIKNMY1U5d4=
X-Google-Smtp-Source: ADUXVKJS0GAPasi9Fzpcdqm6TAWXZT5OHEtbx9Wd4d4XheooKqOZr8ykAoW0+jw+2KKa8V1+rCA2ZRiusTGbyRanx9c=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr1932015uaz.82.1528799806736;
 Tue, 12 Jun 2018 03:36:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 03:36:06
 -0700 (PDT)
In-Reply-To: <1528799515-1356-2-git-send-email-yamada.masahiro@socionext.com>
References: <1528799515-1356-1-git-send-email-yamada.masahiro@socionext.com> <1528799515-1356-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Jun 2018 19:36:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASM53scdd-OZOj_7404Eru3a98uNLagip_GdkrSSaG3-Q@mail.gmail.com>
Message-ID: <CAK7LNASM53scdd-OZOj_7404Eru3a98uNLagip_GdkrSSaG3-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: denali: add more clocks
To:     linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Richard Weinberger <richard@sigma-star.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe, the commit title should be:

mtd: rawnand: denali: add more clocks and improve setup_data_interface



2018-06-12 19:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> According to the Denali User's Guide, this IP needs three clock inputs:
>
>  - clk: controller core clock
>
>  - clk_x: bus interface clock
>
>  - ecc_clk: clock at which ECC circuitry is run
>
> Currently, denali_dt.c requires a single anonymous clock and its
> frequency.  However, the driver needs to get the frequency of "clk_x"
> not "clk".  This is confusing because people tend to assume the
> anonymous clock means the core clock.
>
> Instead of the cheesy implementation, the clocks in the real hardware
> should be represented in the driver code and the DT-binding.
>
> I improved the ->setup_data_interface() hook as well.
>
> The denali_setup_data_interface() needs the frequency of clk_x
> and the ratio of clk_x / clk.
>
> The latter is currently hardcoded in the driver, like this:
>
>   #define DENALI_CLK_X_MULT       6
>
> The IP datasheet specifies that clk_x / clk should be 4, 5, or 6.
> I just chose 6 because it is the most defensive value, but it is not
> very nice.  By getting the clock rate of both "clk" and "clk_x", the
> driver can compute the timing values more precisely.
>
> Adding new clocks would break the existing platforms.  For the backward
> compatibility, the driver still accepts the single clock just as before.
> Also, ->clk_rate and ->clk_x_rate are set to hardcoded values if clk_x
> is missing.
>
> It should work for all upstreamed platforms because Intel Moorestown,
> Altera (Intel) SOCFPGA, Socionext UniPhier use the following clock
> frequency:
>
>   clk = 50 MHz
>   clk_x = ecc_clk = 200 MHz
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


-- 
Best Regards
Masahiro Yamada
