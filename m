Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAC1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FE02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KKECg1Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FE02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeIGUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:53:05 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:32291 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIGUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:53:05 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w87GB7OR027198;
        Sat, 8 Sep 2018 01:11:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w87GB7OR027198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536336668;
        bh=q7/yCKOhBeSEL9bhKekNDITWl0Ds4HNUQsleotDM+Zs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=KKECg1Bbi4cbkZO9Wbj9hfHA+RvzYLihN+R7sRHQa6Y4NUJNz2iS1sQSx/eCoag3b
         eCFI4k2CzLvp2FLOT/uHIbbR7hzkl7ZN05lEib5uK2f7YHpdKxu8YwNDmH2YCUwlna
         MSbfuDVhY1Ba9i8mPgqJcPNTjFcQchLFcBJsBxD4bvM17NKLjvYv1wmeweeND1MoY2
         diw+QsfC/EuafNmFfeSWjByPxfF9muqKC7NaruLXbedr6/RhL1fk/Qr3CEjZWF8+3X
         0nxhvZs5AGAvBDbvWnGOo76vboXJxUfxF5Wh2L4rg+CqyaGVxJilLErvS0gLDmfp7m
         H8/8oO7VaUggw==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id l143-v6so1033883vke.1;
        Fri, 07 Sep 2018 09:11:07 -0700 (PDT)
X-Gm-Message-State: APzg51B5qe4PlPNUu+BaUtfWFL4j5TouX04aW2rsaepY55+pfTurk2LQ
        xBQt6oUV0QqwMAimqlhnS/uDhxkuEDyI1DNqqZ4=
X-Google-Smtp-Source: ANB0VdYK+qnm4xV5eZeuNC5bqF6hHJVo+45eoZm6QC2vD/ETN3CjQKpoka9KEAw9NJnzDrp463FNGpFbgSLpqhF6vYo=
X-Received: by 2002:a1f:f8c2:: with SMTP id w185-v6mr3010667vkh.135.1536336666295;
 Fri, 07 Sep 2018 09:11:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 09:10:25 -0700 (PDT)
In-Reply-To: <20180907165348.3e0027ee@bbrezillon>
References: <1536317783-4942-1-git-send-email-yamada.masahiro@socionext.com>
 <20180907160822.319047c8@bbrezillon> <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
 <20180907165348.3e0027ee@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 8 Sep 2018 01:10:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3ZjdW3ENekNJq=26SAh=tXdirmhHyA9qDGnwpXQ6Arg@mail.gmail.com>
Message-ID: <CAK7LNAT3ZjdW3ENekNJq=26SAh=tXdirmhHyA9qDGnwpXQ6Arg@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: add DT property to specify skipped
 bytes in OOB
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

2018-09-07 23:53 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Fri, 7 Sep 2018 23:42:53 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> Hi Boris,
>>
>> 2018-09-07 23:08 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>> > Hi Masahiro,
>> >
>> > On Fri,  7 Sep 2018 19:56:23 +0900
>> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> >
>> >> NAND devices need additional data area (OOB) for error correction,
>> >> but it is also used for Bad Block Marker (BBM).  In many cases, the
>> >> first byte in OOB is used for BBM, but the location actually depends
>> >> on chip vendors.  The NAND controller should preserve the precious
>> >> BBM to keep track of bad blocks.
>> >>
>> >> In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
>> >> the number of bytes to skip from the start of OOB.  The ECC engine
>> >> will automatically skip the specified number of bytes when it gets
>> >> access to OOB area.
>> >>
>> >> The same value for SPARE_AREA_SKIP_BYTES should be used between
>> >> firmware and the operating system if you intend to use the NAND
>> >> device across the control hand-off.
>> >>
>> >> In fact, the current denali.c code expects firmware to have already
>> >> set the SPARE_AREA_SKIP_BYTES register, then reads the value out.
>> >>
>> >> If no firmware (or bootloader) has initialized the controller, the
>> >> register value is zero, which is the default after power-on-reset.
>> >>
>> >> In other words, the Linux driver cannot initialize the controller
>> >> by itself.  You cannot support the reset control either because
>> >> resetting the controller will get register values lost.
>> >>
>> >> This commit adds a way to specify it via DT.  If the property
>> >> "denali,oob-skip-bytes" exists, the value will be set to the register.
>> >
>> > Hm, do we really need to make this config customizable? I mean, either
>> > you have a large-page NAND (page > 512 bytes) and the 2 first bytes
>> > must be reserved for the BBM or you have a small-page NAND and the BBM
>> > is at position 4 and 5. Are you sure people configure that differently?
>> > Don't you always have SPARE_AREA_SKIP_BYTES set to 6 or 2?
>>
>>
>> As I said in the patch description,
>> I need to use the same SPARE_AREA_SKIP_BYTES value
>> across firmware, boot-loader, Linux, and whatever.
>>
>> I want to set the value to 8 for my platform
>> because the on-chip boot ROM expects 8.
>> I cannot change it since the boot ROM is hard-wired.
>>
>>
>> The boot ROM skips 8 bytes in OOB
>> when it loads images from the on-board NAND device.
>>
>> So, when I update the image from U-Boot or Linux,
>> I need to make sure to set the register to 8.
>>
>> If I update the image with a different value,
>> the Boot ROM fails to boot.
>>
>>
>>
>> When the system has booted from NAND,
>> the register is already set to 8.  It works.
>>
>> However, when the system has booted from eMMC,
>> the register is not initialized by anyone.
>> I am searching for a way to set the register to 8
>> in this case.
>>
>>
>> The boot ROM in SOCFPGA might expect a different value,
>> I am not sure.
>
> Okay, then why not having a per-compatible value if it's related to the
> BootROM? Unless the BootROM is part of the FPGA and can be
> reprogrammed.

FPGA is unrelated here.

Neither the boot ROM nor the Denali core is re-programmable.



I hesitate to associate the number of skipped bytes
with the compatible string because it is not a parameter
of the Denali IP.


Rather, it is the matter of "how we use the OOB",
so I want to leave room for customization like nand-ecc-strength etc.
even if the boot ROM happens to expect a particular value.


If you prefer a per-compatible value, I can do that,
but I believe the NAND core and the boot ROM are orthogonal.



> I'd really prefer not having a generic property that
> allows you to put anything you want.






-- 
Best Regards
Masahiro Yamada
