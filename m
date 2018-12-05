Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAE2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B7620989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544026254;
	bh=eqOfNcHX61VS3GDpCujp799MGd6FR/REhoc3IIJwGJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=scx41Z3QzjHD0tpLNr0r1U4eN3j1F9vQOSAgHhYLUhiTqVMO3ksLWGbhxMt2t4/uX
	 PlNNLFR8ajDhkvjcdGiJAUFEvj+1ql8asjtRfizxUttv64fwi23+VGVlItgj6IZ7w3
	 WBnmSGZaisdUHy5EhnIn2QA3LD9AqPkOVN1+GuOY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B7620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeLEQKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:10:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:10:53 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC3D20989
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544026252;
        bh=eqOfNcHX61VS3GDpCujp799MGd6FR/REhoc3IIJwGJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lj5zIWJoJFn0NMFfC6mlijB6ysA82GrFZKPfo3iCOeswsdvKoSyXvm/L05d9u2AD/
         /tsIUljru1EnhTvyO78XXLkUNz+6kOm7Ro0rJ+LBVcPY4rQZMF5SMKVBR30bLKQPww
         i5aYTxQyFSxPzHguebbg+wHAIkVjXhgoPmF1i1VM=
Received: by mail-lj1-f179.google.com with SMTP id 83-v6so18836429ljf.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:10:51 -0800 (PST)
X-Gm-Message-State: AA+aEWaqniv1x8TTo9hJzD7XA+anX51YIDO0AAf6TFkn9CqNxKBwuIYp
        BN3Nln2XcpC0kNpNjK4S3jXtqL7fNPNwcQ2NiWc=
X-Google-Smtp-Source: AFSGD/XgqoW9rMSK9AZxyMP2i7oJjEauDZoInq7nBLyiTOQ486xJoHFK9zE72Q2+HOv8ZdusUHGslIybs4TzK6EED/k=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr17684070ljb.89.1544026250013;
 Wed, 05 Dec 2018 08:10:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdPnha1-1dCRFaPZ-CGzS1OzNcFrxuOJmWstHJcRAMZwg@mail.gmail.com>
 <20181120113326.0d4f061e@xps13> <CAJKOXPcrVXdCXqmxffJca7HfEV3G3agkzjWu1rfsNDDbMzc_XQ@mail.gmail.com>
 <20181120130859.78d53da3@bbrezillon> <CAJKOXPfgyw9tFTC=eZFVHz8us1+6RxEcnmLUi-umO2+N9vRzDg@mail.gmail.com>
In-Reply-To: <CAJKOXPfgyw9tFTC=eZFVHz8us1+6RxEcnmLUi-umO2+N9vRzDg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 5 Dec 2018 17:10:38 +0100
X-Gmail-Original-Message-ID: <CAJKOXPepDpdhz2yPmdBMcncJ8noRdNTyXqP6WbUZR4Cf=BnEFA@mail.gmail.com>
Message-ID: <CAJKOXPepDpdhz2yPmdBMcncJ8noRdNTyXqP6WbUZR4Cf=BnEFA@mail.gmail.com>
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

On Tue, 20 Nov 2018 at 13:15, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 20 Nov 2018 at 13:09, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > On Tue, 20 Nov 2018 12:48:46 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > > On Tue, 20 Nov 2018 at 11:33, Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > > >
> > > > Hi Krzysztof,
> > > >
> > > > Krzysztof Koz=C5=82owski <k.kozlowski.k@gmail.com> wrote on Tue, 20=
 Nov 2018
> > > > 10:46:33 +0100:
> > > >
> > > > > Hi all,
> > > > >
> > > > > Since few days linux-next has problem on Freescale VF500 - MTD se=
ems
> > > > > to be broken.
> > > > >
> > > > > Bisect pointed me to commit 7c27338c728e39ef47c83d101959aa3325069=
69d
> > > > > ("mtd: rawnand: Move the ->exec_op() method to nand_controller_op=
s")
> > > > > as reason of failure to find MTD partitions.
> > > > >
> > > > > Toradex Colibri VF50 on Iris board (ARMv7, UP, Cortext-A5, NXP VF=
500,
> > > > > 128 MB RAM, 128 MB NAND, Systemd: v232) booted from NFS root (NFS=
v4)
> > > > > trying to mount UBIFS from NAND/MTD. Board uses VF610 NAND driver=
.
> > > > >
> > > > > The MTD partitions are missing entirely (nothing under /dev/mtd).
> > > > > In the logs you can also see:
> > > > > [    1.232161] UBI error: cannot open mtd ubi2, error -2
> > > > >
> > > > > Attached - dmesg.log
> > > > >
> > > > > Let me know if you need defconfig or any other information.
> > > >
> > > > Thank you very much for testing and reporting the bug!
> > > >
> > > > Could you please test with this diff applied [1] please? We discuss=
ed
> > > > with Boris and we think it should fix your setup (and all others al=
so
> > > > impacted).
> > > >
> > > > [1] http://code.bulix.org/r1m99i-509201
> > >
> > > error: patch failed: drivers/mtd/nand/raw/nand_base.c:4399
> > > error: drivers/mtd/nand/raw/nand_base.c: patch does not apply
> > >
> > > Maybe you have a git tree with this somewhere?
> >
> > Yep: https://github.com/bbrezillon/linux/tree/nand/next-fix
>
> Works fine now, thanks!
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Although the patch fixed the issue... but it seems it is not in
linux-next. The next is broken since almost two weeks.

Best regards,
Krzysztof
