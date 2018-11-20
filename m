Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532FC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AE720671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+XeVGTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AE720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeKTWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbeKTWoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:44:09 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63FA20671
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542716118;
        bh=Cfj1fMhkmUYRRftMBOR/7DftYu/3bzdnk43yN0a5mi0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D+XeVGTjBdwZwOU9w35NzcpV3oIWlNZeSkqwdqOcf6gOmfRDLg6nRsBZqGvlHGpGl
         Z8vquZBy6OMhQ7yVXcSJgpQpYr4PewaTnWshS++KkGai3hfZSku6/gLuD4vi4Y6gIY
         eFieTkArwvkcCPj/c7k8o97ugivwVN+zqPgkcd9M=
Received: by mail-lj1-f175.google.com with SMTP id s5-v6so1406222ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:15:17 -0800 (PST)
X-Gm-Message-State: AGRZ1gKjqZ0pez9NYH89b9XRs5CK+n/v1bgWWUPWuKeknfXZBBVNlzYE
        aUrHrEwgQLPYfu89wWQQ0g42WifQ2JSnQBK0XGE=
X-Google-Smtp-Source: AFSGD/Wvot9iaOuRZLOtae0qDbgHgQnxXY3FXhecb23+/KO1X78iN2cr6Y1/T2IvqIOAjYbaTxUSGvHcV+lqpCI7y6w=
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr909161ljg.138.1542716115927;
 Tue, 20 Nov 2018 04:15:15 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdPnha1-1dCRFaPZ-CGzS1OzNcFrxuOJmWstHJcRAMZwg@mail.gmail.com>
 <20181120113326.0d4f061e@xps13> <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
 <20181120130859.78d53da3@bbrezillon>
In-Reply-To: <20181120130859.78d53da3@bbrezillon>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 20 Nov 2018 13:15:04 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfgyw9tFTC=eZFVHz8us1+6RxEcnmLUi-umO2+N9vRzDg@mail.gmail.com>
Message-ID: <CAJKOXPfgyw9tFTC=eZFVHz8us1+6RxEcnmLUi-umO2+N9vRzDg@mail.gmail.com>
Subject: Re: [BUG BISECT] Missing MTD NAND partitions - mtd: rawnand: Move the
 ->exec_op() method to nand_controller_ops
To:     boris.brezillon@bootlin.com
Cc:     miquel.raynal@bootlin.com, jmkrzyszt@gmail.com,
        Stefan Agner <stefan@agner.ch>, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 13:09, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Tue, 20 Nov 2018 12:48:46 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > On Tue, 20 Nov 2018 at 11:33, Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > >
> > > Hi Krzysztof,
> > >
> > > Krzysztof Koz=C5=82owski <k.kozlowski.k@gmail.com> wrote on Tue, 20 N=
ov 2018
> > > 10:46:33 +0100:
> > >
> > > > Hi all,
> > > >
> > > > Since few days linux-next has problem on Freescale VF500 - MTD seem=
s
> > > > to be broken.
> > > >
> > > > Bisect pointed me to commit 7c27338c728e39ef47c83d101959aa332506969=
d
> > > > ("mtd: rawnand: Move the ->exec_op() method to nand_controller_ops"=
)
> > > > as reason of failure to find MTD partitions.
> > > >
> > > > Toradex Colibri VF50 on Iris board (ARMv7, UP, Cortext-A5, NXP VF50=
0,
> > > > 128 MB RAM, 128 MB NAND, Systemd: v232) booted from NFS root (NFSv4=
)
> > > > trying to mount UBIFS from NAND/MTD. Board uses VF610 NAND driver.
> > > >
> > > > The MTD partitions are missing entirely (nothing under /dev/mtd).
> > > > In the logs you can also see:
> > > > [    1.232161] UBI error: cannot open mtd ubi2, error -2
> > > >
> > > > Attached - dmesg.log
> > > >
> > > > Let me know if you need defconfig or any other information.
> > >
> > > Thank you very much for testing and reporting the bug!
> > >
> > > Could you please test with this diff applied [1] please? We discussed
> > > with Boris and we think it should fix your setup (and all others also
> > > impacted).
> > >
> > > [1] http://code.bulix.org/r1m99i-509201
> >
> > error: patch failed: drivers/mtd/nand/raw/nand_base.c:4399
> > error: drivers/mtd/nand/raw/nand_base.c: patch does not apply
> >
> > Maybe you have a git tree with this somewhere?
>
> Yep: https://github.com/bbrezillon/linux/tree/nand/next-fix

Works fine now, thanks!
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
