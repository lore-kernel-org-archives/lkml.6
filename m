Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CB6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA0320862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6Y2TajZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA0320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeKGRDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:03:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42259 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeKGRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:03:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id q6-v6so10732441lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 23:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY3o894jFxAVpG3/rNrs3uyCqKXzBiAUwje6kIKndYM=;
        b=R6Y2TajZLWd2azMEqm5S30HFk3GQJlbShJSGHXgx4D82LuufxtElvfPMALbb93Nu8x
         fZK3shu1VEPdUHKVr8PRoV3k9FQzfGDm9PEnDDTM6jwAeVXZLcs5kw8sNBMDyr0Sf41t
         jK6Yz6ejmD4xxGV73E4UVG6PqQRq3MplW96jKsrJmIydsIzUG/4oFysFkSeV8iQhhuUO
         ZMTXgn6LHnT90Jq/hc/X5Y0uKFuug6tN6Cda5/AVPaMsAmCA7yXJ7zcewhYR7MnAUJm1
         CEymj2puzhvCg7RLWD2C90DreW0ltTt2D18yMoY/i1kRyq5k9VOiD1Ya72qfv5nCFcpW
         tX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY3o894jFxAVpG3/rNrs3uyCqKXzBiAUwje6kIKndYM=;
        b=XgYESOhF4YpLX8rgl/aOETIVVwWhYnG8p4xs+/ZV/v8Y3eIqGFeOXTnrdrQ29yMuTG
         oI0/4NIwIYXuiE7EBzT2nepRWhxmdeiuksSZWYu01EUd6aaM7bYRDP1RFeJac4HysrIp
         wD8DjjuizlkS/wJWWp/0li/WIXlFO00rBhowDhzbzkrhaG7Vr7lN9gZsuVjk3Nsv21GC
         9cL1fPaG0wTfi/IK/vaB4Mp8Z82vhevq+R3ucunoSk0nRLAyGwu/gWpSU6xXl/iEa1v3
         VcZuzEIne6UFUW8TxEsauTO0fav1lYmDDf5stiGIvcYEhB2R+2hPHvgot5tEObMPngno
         MOlQ==
X-Gm-Message-State: AGRZ1gIKu8BNaY4W9TbMB67yr7DsNhz+dJjoYPytKyNS4J5GVe+vzdoi
        8rwysFWUHWVMKVUPvs2SbxZutkz0NASy8tjlj74=
X-Google-Smtp-Source: AJdET5cqQMKwcP6/O4motqPz1HPHsBwxKn+sokHsRnH2+5s7FXN0NhF/ooIKMyTFOvzSITALcaZqQ/lB9xbXho5YVGY=
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr479554lfc.147.1541576054326;
 Tue, 06 Nov 2018 23:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20181106214416.11342-1-geert@linux-m68k.org> <20181106225829.5ecbe19e@bbrezillon>
 <CAMuHMdUQhsikcBzRFAvrCwZwzFK_Coh=fqpSihFP6jEtugCMQw@mail.gmail.com> <20181106233432.76df6bbf@bbrezillon>
In-Reply-To: <20181106233432.76df6bbf@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 7 Nov 2018 08:33:57 +0100
Message-ID: <CAPybu_0c115rhqO4RTa27H2j78t9z=rfOy9ukL1h4z18J8MBDQ@mail.gmail.com>
Subject: Re: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM
 type probing
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and Geert

On Tue, Nov 6, 2018 at 11:34 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Tue, 6 Nov 2018 23:19:14 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > Hi Boris,
> >
> > On Tue, Nov 6, 2018 at 10:58 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > > On Tue,  6 Nov 2018 22:44:16 +0100
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Toshiba RBTX4927, where map_probe is supposed to fail:
> > > >
> > > >     Creating 2 MTD partitions on "physmap-flash.0":
> > > >     0x000000c00000-0x000001000000 : "boot"
> > > >     0x000000000000-0x000000c00000 : "user"
> > > >     physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
> > > >     CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
> > > >     ...
> > > >     Call Trace:
> > > >     [<80320f40>] get_mtd_chip_driver+0x30/0x8c
> > > >     [<80321004>] do_map_probe+0x20/0x90
> > > >     [<80328448>] physmap_flash_probe+0x484/0x4ec
> > > >
> > > > The access to rom_probe_types[] was changed from a sentinel-based loop
> > > > to an infinite loop, causing a crash when reaching the sentinel.
> > >
> > > Oops. Do you mind if I fix that in-place (squash your changes in
> > > Ricardo's original commit)?
>
> Done.
>
> >
> > No problem. Thanks!
>

Thanks to both of you for fixing this .
> Thanks for reporting/fixing the bug.
>
> Boris
>


-- 
Ricardo Ribalda
