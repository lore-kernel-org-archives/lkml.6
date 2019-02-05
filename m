Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C69A20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC1gCk8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfBEPWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:22:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45858 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfBEPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:22:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so6190315ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MozAZbg/lc3xRWjn6YkeFHkBJ7fte+FJbAP94vyT2DE=;
        b=vC1gCk8Y6BgYigpxi6FqH3CqGfZ7qty0mSF+MqpXRSReqO/VEffTyluiTt29AFWM/V
         qF+lY+iMsFTYy/bDOSHVKoWHfLa2gWzez4fMPxYmeUa+cv9v5kTiodlx/Bn8aHOAoHEL
         ABG6etRJucV+w/8M0nHQAC1mVJ4zyTiN82wn9wlkhxesYjTKPO3Lvr6SbwCTWIG/eR4p
         Y6CBzOIQwoorFrZgv5STBHaC62tVa/KzAx5U3TlMIlg/4NapxH23lwDktH6F71tlolAF
         4XN3iEa2KFAIwAyuocT9d9dJnkJyTPO5CN5gU6rXl7a8p4pZcVsI9P4AKJ+sfpZL4DBx
         HN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MozAZbg/lc3xRWjn6YkeFHkBJ7fte+FJbAP94vyT2DE=;
        b=IsPiyIqXvx7kHhIefl73xcAYLGP3b5jSeoxDBeFxpfLbj8Dg33jbz4UPuDAWS9nUwI
         Y1jJkIOwxc7VxFEfWDgaFnHc/5YNnjAXoJFMNdITcdWQcUvB1+wsO76pR6bZN70hRLee
         vOJXD9tA4g8/kp6Zt4rM2oP+L59VzueR5Bp58RtvEDLnrH4JiT28b1yANXR7GRtVEsLv
         rLJceSdYlxTcZxGf+OyKYgg146cVIlF7ICewi35xh4ZYEdWgD9lm2bp9wVXH0OmM4OSF
         qAoODfbI1zBKui4vfIGBoKYlxTfe30n1/rJg27rjRjruL3AXmL0ry9ocExy+vQnuQUH1
         Kszg==
X-Gm-Message-State: AHQUAuaZlTnjbJCSUqPH5HIslWTTOeydF8oE7Z1MMpjpLh2ElPdBHxy5
        /Cbn9zevuI6r5rQXwaFrlqYLFxzL8OiBz2oGhBA=
X-Google-Smtp-Source: AHgI3IZyuu54aF9Yoh5JlDJTWhxeiN/6pBGEYytsssnL0XRLMPlS2SK87Jv3AYnEPKeXjuGOxEWqBnx4GbUSI01zM/c=
X-Received: by 2002:aca:ab57:: with SMTP id u84mr2717592oie.87.1549380168611;
 Tue, 05 Feb 2019 07:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20190129153700.18717-1-martink@posteo.de> <20190205135946.64eda55c@xps13>
In-Reply-To: <20190205135946.64eda55c@xps13>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 5 Feb 2019 13:22:45 -0200
Message-ID: <CAOMZO5Cbhr-Wxu8W-oCKBP9NS3UN92=NUfYdkyYp-yy2oy12SQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Martin Kepplinger <martink@posteo.de>, bbrezillon@kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Richard Weinberger <richard@nod.at>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 11:00 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Martin,
>
> Martin Kepplinger <martink@posteo.de> wrote on Tue, 29 Jan 2019
> 16:37:00 +0100:
>
> > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >
> > Disable BCH soft reset according to MX23 erratum #2847 ("BCH soft
> > reset may cause bus master lock up") for MX28 too. It has the same
> > problem.
> >
> > Observed problem: once per 100,000+ MX28 reboots NAND read failed on
> > DMA timeout errors:
> > [    1.770823] UBI: attaching mtd3 to ubi0
> > [    2.768088] gpmi_nand: DMA timeout, last DMA :1
> > [    3.958087] gpmi_nand: BCH timeout, last DMA :1
> > [    4.156033] gpmi_nand: Error in ECC-based read: -110
> > [    4.161136] UBI warning: ubi_io_read: error -110 while reading 64
> > bytes from PEB 0:0, read only 0 bytes, retry
> > [    4.171283] step 1 error
> > [    4.173846] gpmi_nand: Chip: 0, Error -1
> >
> > Without BCH soft reset we successfully executed 1,000,000 MX28 reboots.
> >
> > I have a quote from NXP regarding this problem, from July 18th 2016:
> >
> > "As the i.MX23 and i.MX28 are of the same generation, they share many
> > characteristics. Unfortunately, also the erratas may be shared.
> > In case of the documented erratas and the workarounds, you can also
> > apply the workaround solution of one device on the other one. This have
> > been reported, but I=E2=80=99m afraid that there are not an estimated d=
ate for
> > updating the Errata documents.
> > Please accept our apologies for any inconveniences this may cause."
> >
> > Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Does this also need a Fixes tag so that it can be backported to stable?

Thanks
