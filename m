Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E642083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cRBtlUFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E642083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756336AbeFSIIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:08:14 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:43081 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755658AbeFSIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:08:11 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w5J887qh004272;
        Tue, 19 Jun 2018 17:08:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w5J887qh004272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529395688;
        bh=W/cR480XHr66lBJpxNAusvis4iG5M5eBr9fPlyB/bjk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cRBtlUFAZQ8vv6E0mYzBlbRuWQCG9b+GyaVxkqSwA1VrO1a0Qw6ftFjVF9TifgvQ5
         ST9qS8WGt5zVc5mOVWmG7xWZCkmG4EX26srcJDu0R2pyeb9DMc9v/JV9N34n52BZFs
         13hPXEL//7Rp69JglAuhH2gx2r/QpRzap8qsLjN+d+lqwDt8uc64CTAQFj4E1Z9lP4
         E0S+BaG1lWkMPc2hGzKtXpgy8SReEd+FsQkcdC7QcStINfy1KtbF0WlTtGkQ5Z+nby
         VCigI240zdtIkNDUALZs0WEX4b2M4dYWcyMHFdFJNR1aD9aPubtyQAcI05EwJYweMw
         TAuxm5giAji1Q==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id d74-v6so11142373vke.10;
        Tue, 19 Jun 2018 01:08:08 -0700 (PDT)
X-Gm-Message-State: APt69E1YjvrcznihpkMuYu0cCDA88x3Dv9SRvF1LUHOOPofRcsye6O/i
        Gi/ckD4CFgYkR/97PGPlGsavXjDiqZ3EDi9+Xj8=
X-Google-Smtp-Source: ADUXVKIk/durcHcTp+A2xbzKooJBzLhvVLDYnLZwpU09sUCYnmhnaaFtGGxiKtuykg58uE/iBGBkWLMljzoFDWL1ZQs=
X-Received: by 2002:a1f:1941:: with SMTP id 62-v6mr9064502vkz.34.1529395687270;
 Tue, 19 Jun 2018 01:08:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 01:07:26
 -0700 (PDT)
In-Reply-To: <20180618094636.0e40c518@bbrezillon>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
 <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
 <5816516.AqyscFuYxX@blindfold> <20180618094636.0e40c518@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Jun 2018 17:07:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCKhxtoOc3QdECF6p8BaBjab7Ed2y9Og+8LhvX4O83-Q@mail.gmail.com>
Message-ID: <CAK7LNASCKhxtoOc3QdECF6p8BaBjab7Ed2y9Og+8LhvX4O83-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mtd: rawnand: denali_dt: add more clocks based on
 IP datasheet
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


2018-06-18 16:46 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Mon, 18 Jun 2018 09:09:02 +0200
> Richard Weinberger <richard@nod.at> wrote:
>
>> Am Freitag, 15. Juni 2018, 03:18:50 CEST schrieb Masahiro Yamada:
>> > According to the Denali User's Guide, this IP needs three clocks:
>> >
>> >  - clk: controller core clock
>> >
>> >  - clk_x: bus interface clock
>> >
>> >  - ecc_clk: clock at which ECC circuitry is run
>> >
>> > Currently, denali_dt.c requires a single anonymous clock and its
>> > frequency.  However, the driver needs to get the frequency of "clk_x"
>> > not "clk".  This is confusing because people tend to assume the
>> > anonymous clock means the core clock.  In fact, I got a report of
>> > SOCFPGA breakage because the timing parameters are calculated based
>> > on a wrong frequency.
>> >
>> > Instead of the cheesy implementation, the clocks in the real hardware
>> > should be represented in the driver and the DT-binding.
>> >
>> > However, adding new clocks would break the existing platforms.  For the
>> > backward compatibility, the driver still accepts a single clock just as
>> > before.  If clk_x is missing, clk_x_rate is set to a hardcoded value.
>> > This is fine for existing DT of Socionext UniPhier, and also fixes the
>> > issue of Altera (Intel) SOCFPGA because both platforms use 200 MHz for
>> > the bus interface clock.
>> >
>> > Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
>> > Cc: linux-stable <stable@vger.kernel.org> #4.14+
>> > Reported-by: Richard Weinberger <richard@nod.at>
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Reviewed-by: Richard Weinberger <richard@nod.at>
>
> Maybe a
>
> Tested-by: Richard Weinberger <richard@nod.at>
>
> ?
>
>> Reported-by: Philipp Rosenberger <p.rosenberger@linutronix.de>
>
> Should I replace your Reported-by by this one or simply add it?


I think it is good to have Reported-by
both from Philipp and Richard.


Thanks.



-- 
Best Regards
Masahiro Yamada
