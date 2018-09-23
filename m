Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994CECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 10:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE992148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yiyxxQdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE992148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeIWQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 12:36:47 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:56245 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeIWQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 12:36:47 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w8NAdLQc010501;
        Sun, 23 Sep 2018 19:39:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w8NAdLQc010501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537699162;
        bh=pa/jP2LMB4EsNqAo1vydB5oZns6ko4DZvNfPjwxB9Jc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yiyxxQdmj69ZNloDE3GqylJpd1AxRk5atQtLHq2nhOdBvEccMRLDbvf4uJpTdsW3s
         nQbkAF32JGnmdsMZkSI/mXgWW9Y/9houwFi+7jm+wf9p4JkeVcv8mZGm9hrIfsOyX9
         D15cxdZlDEjTk8xauwRBlZOd/ObysAmYxF/LUf+RE6FtterFNfgwGkW6hsl3ISswaH
         c8xGBv1K6F4VLgi3KCSLAO6lub4lQJSljHQoDOK866TtPN8y02MvrdDDraROM5e9DF
         E4PC85AQ/zJeNCie0QK92Ud1l1xJKMBwaWkmepfhELYGoEyBw00bgW8Z51a3nMSd9A
         /BBNsKJxvI1zw==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id f4-v6so7308603uao.10;
        Sun, 23 Sep 2018 03:39:22 -0700 (PDT)
X-Gm-Message-State: ABuFfogs4WvP8kGbPCnQFY6gze+p6s+WczkVlkvJw1LI7/RViEXYbC/j
        Fz53E2ySQd9E49orf7+uUz+1pvohYvH+Cau2h/A=
X-Google-Smtp-Source: ACcGV605HykFSVleRgv6BIJPWJ/Sp9PaxZ+eXJA3dGTLaRnyvUNsbCpk6wgfs22Fmkve4wJM8deW3k4J/18J7uRW3VM=
X-Received: by 2002:a9f:3826:: with SMTP id p35-v6mr1364584uad.42.1537699161027;
 Sun, 23 Sep 2018 03:39:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 03:38:40
 -0700 (PDT)
In-Reply-To: <20180922101116.7c9b4767@bbrezillon>
References: <1536317783-4942-1-git-send-email-yamada.masahiro@socionext.com>
 <20180907160822.319047c8@bbrezillon> <CAK7LNAQJOD3mxwbiOSn5wpDsU23DhZcx9QB_ufFZB8LUnh1KdQ@mail.gmail.com>
 <20180907165348.3e0027ee@bbrezillon> <CAK7LNAT3ZjdW3ENekNJq=26SAh=tXdirmhHyA9qDGnwpXQ6Arg@mail.gmail.com>
 <20180922094111.1c2969e8@xps13> <20180922101116.7c9b4767@bbrezillon>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 23 Sep 2018 06:38:40 -0400
X-Gmail-Original-Message-ID: <CAK7LNAR0=1zAWkf9c4mYgLrJNmKR=8=mi6idWaaeuN4uHQVjug@mail.gmail.com>
Message-ID: <CAK7LNAR0=1zAWkf9c4mYgLrJNmKR=8=mi6idWaaeuN4uHQVjug@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: add DT property to specify skipped
 bytes in OOB
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-22 4:11 GMT-04:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Sat, 22 Sep 2018 09:41:11 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
>> Hi Masahiro,
>>
>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Sat, 8 Sep
>> 2018 01:10:25 +0900:
>>
>> > Hi Boris,
>> >
>> > 2018-09-07 23:53 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>> > > On Fri, 7 Sep 2018 23:42:53 +0900
>> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> > >
>> > >> Hi Boris,
>> > >>
>> > >> 2018-09-07 23:08 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>> > >> > Hi Masahiro,
>> > >> >
>> > >> > On Fri,  7 Sep 2018 19:56:23 +0900
>> > >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> > >> >
>> > >> >> NAND devices need additional data area (OOB) for error correction,
>> > >> >> but it is also used for Bad Block Marker (BBM).  In many cases, the
>> > >> >> first byte in OOB is used for BBM, but the location actually depends
>> > >> >> on chip vendors.  The NAND controller should preserve the precious
>> > >> >> BBM to keep track of bad blocks.
>> > >> >>
>> > >> >> In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
>> > >> >> the number of bytes to skip from the start of OOB.  The ECC engine
>> > >> >> will automatically skip the specified number of bytes when it gets
>> > >> >> access to OOB area.
>> > >> >>
>> > >> >> The same value for SPARE_AREA_SKIP_BYTES should be used between
>> > >> >> firmware and the operating system if you intend to use the NAND
>> > >> >> device across the control hand-off.
>> > >> >>
>> > >> >> In fact, the current denali.c code expects firmware to have already
>> > >> >> set the SPARE_AREA_SKIP_BYTES register, then reads the value out.
>> > >> >>
>> > >> >> If no firmware (or bootloader) has initialized the controller, the
>> > >> >> register value is zero, which is the default after power-on-reset.
>> > >> >>
>> > >> >> In other words, the Linux driver cannot initialize the controller
>> > >> >> by itself.  You cannot support the reset control either because
>> > >> >> resetting the controller will get register values lost.
>> > >> >>
>> > >> >> This commit adds a way to specify it via DT.  If the property
>> > >> >> "denali,oob-skip-bytes" exists, the value will be set to the register.
>> > >> >
>> > >> > Hm, do we really need to make this config customizable? I mean, either
>> > >> > you have a large-page NAND (page > 512 bytes) and the 2 first bytes
>> > >> > must be reserved for the BBM or you have a small-page NAND and the BBM
>> > >> > is at position 4 and 5. Are you sure people configure that differently?
>> > >> > Don't you always have SPARE_AREA_SKIP_BYTES set to 6 or 2?
>> > >>
>> > >>
>> > >> As I said in the patch description,
>> > >> I need to use the same SPARE_AREA_SKIP_BYTES value
>> > >> across firmware, boot-loader, Linux, and whatever.
>> > >>
>> > >> I want to set the value to 8 for my platform
>> > >> because the on-chip boot ROM expects 8.
>> > >> I cannot change it since the boot ROM is hard-wired.
>> > >>
>> > >>
>> > >> The boot ROM skips 8 bytes in OOB
>> > >> when it loads images from the on-board NAND device.
>> > >>
>> > >> So, when I update the image from U-Boot or Linux,
>> > >> I need to make sure to set the register to 8.
>> > >>
>> > >> If I update the image with a different value,
>> > >> the Boot ROM fails to boot.
>> > >>
>> > >>
>> > >>
>> > >> When the system has booted from NAND,
>> > >> the register is already set to 8.  It works.
>> > >>
>> > >> However, when the system has booted from eMMC,
>> > >> the register is not initialized by anyone.
>> > >> I am searching for a way to set the register to 8
>> > >> in this case.
>
> Maybe there's a solution which does not involve attaching a per-compat
> value or adding a DT prop. If the FW/bootloader has not initialized this
> register the value is 0, right? Why not testing the value and
> assigning it to the default (8) if it's not been initialized by the
> bootloader. That shouldn't break existing platforms since I don't think
> 0 is a valid value anyway.
>
>         denali->oob_skip_bytes = ioread32(denali->reg +
>                                           SPARE_AREA_SKIP_BYTES);
>         if (!denali->oob_skip_bytes) {
>                 denali->oob_skip_bytes = DEFAULT_OOB_SKIP_BYTES;
>                 iowrite32(denali->oob_skip_bytes,
>                           denali->reg + SPARE_AREA_SKIP_BYTES);
>         }
>


I prefer per-compatible values to a fixed default.


I'd like to set the register to 8 unless set otherwise
because the boot ROM on my platform (Socionext UniPhier SoCs)
uses that value.

Other platforms like Altera SOCFPGA may want to use a different value
(at least, I do not know what is the preferred value).



-- 
Best Regards
Masahiro Yamada
