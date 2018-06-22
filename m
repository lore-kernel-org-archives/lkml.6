Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0562FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1332242A4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AKnHJCtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1332242A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFVNZp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:25:45 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:46214 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeFVNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:25:42 -0400
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com [209.85.213.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5MDPbQf011218;
        Fri, 22 Jun 2018 22:25:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5MDPbQf011218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529673938;
        bh=G71pbK2quiWimsDtN051nuMZycdXb18xVVYshsVl/+k=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AKnHJCtGtFoJNIojOu+KCnSN1kJ8cW19AHN2OeUxBnusHCOyc1Srr4SP5QpqjiPYg
         SXonc9/M5XrBSo+361GJfuhCQRPTzniQdvm0ZfAWIwF5NVMvcc0FsrhLkWC/5mqiKo
         X8cM2xM0WuwOZWTwfvLi1rq7RzsTs7UvUqKMdper5OSY3yrnwIMvyGRdypdlCyDQVH
         Q4Tp/lOh5lEvIA4MSfRziUA9Peqizb8GIivUi2GvHSeuBjYdxhBSGBx3vZzhjFwxUY
         0YAMaPOKHuovy12inpoeQ1Aov7BHWfwUVC056yrlO6Hr7Gv5epqkz6hmSis/rRnoV2
         feIqxIGux8DJw==
X-Nifty-SrcIP: [209.85.213.47]
Received: by mail-vk0-f47.google.com with SMTP id b77-v6so3900939vkb.5;
        Fri, 22 Jun 2018 06:25:38 -0700 (PDT)
X-Gm-Message-State: APt69E2Sk2gm3bxbT0Wgx35PHEUgddW+8jufthMwYfcdAs93+/IqacYT
        IHCqD5xIJtsamrZ9iPkWRdb7AVlNUb5jt7s4pOg=
X-Google-Smtp-Source: ADUXVKKPWrg7DRmNMEn/o9or4dOjDLbRZFS2FZoASk5CkOW9EKQ3RC7R9wUvrLxv7ut/7p1w9xKrxhtlOB6OTsyhGAM=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr1007835vke.54.1529673937233;
 Fri, 22 Jun 2018 06:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 06:24:56
 -0700 (PDT)
In-Reply-To: <20180622134235.5ab76325@bbrezillon>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
 <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
 <20180619132811.45bf6454@bbrezillon> <20180622134235.5ab76325@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Jun 2018 22:24:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdfEF3j69DnmpwTMnuBQJ+f4x-1Di9TZ1f5hvVmPDwmw@mail.gmail.com>
Message-ID: <CAK7LNAQdfEF3j69DnmpwTMnuBQJ+f4x-1Di9TZ1f5hvVmPDwmw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mtd: rawnand: denali_dt: add more clocks based on
 IP datasheet
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-22 20:42 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> Hi Masahiro,
>
> On Tue, 19 Jun 2018 13:28:11 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>
>> Hi Masahiro,
>>
>> On Fri, 15 Jun 2018 10:18:50 +0900
>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>
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
>>
>> Sorry for changing my mind, but I think this patch is doing more than
>> just fixing a bug. The bugfix should IMO be limited to unconditionally
>> setting ->clk_x_rate to 200000000 since this is what was done before
>> commit 1bb88666775e. And the remaining changes should go in nand/next.
>
> Do you want me to write this patch? Note that I can't really take this
> patch since Rob asked for a new version with DT bindings changes placed
> in a separate patch.


Sorry for the delay.  I was traveling.

Now I am back home, and started to flush my TODO queue.

V4 will be soon.




-- 
Best Regards
Masahiro Yamada
