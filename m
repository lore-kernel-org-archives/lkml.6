Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD43C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F70D2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170350;
	bh=KIFscL//F22DPcXexa3r8aN3FhgzPMtQQmgiZuAuheA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2vVKH8AgnJtfErvpiPo+OZwv4b+ORfaD8KaKLi9m4+zQkEMRsHS4iJwpd9Ifehndd
	 e07qCGTor7Gc1nw41OvXmjgJqdmL5KowrbBFIsUnqfOS6Et0QSztKvLC6QAfJTLFhq
	 AJCObpWvQBELIa5FKcEe/LAmk2ktjUh9/aHiLGac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfAVPTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfAVPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:19:07 -0500
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8618B2084C;
        Tue, 22 Jan 2019 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170346;
        bh=KIFscL//F22DPcXexa3r8aN3FhgzPMtQQmgiZuAuheA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LwjvfC7cEAVIi1utCiTV7+6nIXyRrA0W1R6XZoaZKnGOlcVx4O+rD4BezTLE00mHo
         dFPvKRifqVIDhC6CVy4fIo7XbVFzZcyqU+esiUmQs49e3bPh4DvR/FsLW/5GpoxcGm
         Oq43FlYHUZx8lVzEMIOst1d5cm+SRupt8WBkrC7I=
Received: by mail-yw1-f43.google.com with SMTP id b63so9513912ywc.11;
        Tue, 22 Jan 2019 07:19:06 -0800 (PST)
X-Gm-Message-State: AJcUukeL8c+JN24zpDWKVifkkv2c/WA9o9Ynm2gqN0I/HKTYU92O7TH4
        zz/xa1SAnbxLG3cqjX7IGZlssWM2j2r/a5CDTzw=
X-Google-Smtp-Source: ALg8bN7oWVrhUBie70J7iZE55wqCl39x9GHeFd87uxuROHHclESZBi3HvD2CpfMwEVyndBEqgh9MevjRqqzkPGnob84=
X-Received: by 2002:a81:5984:: with SMTP id n126mr31704696ywb.433.1548170345808;
 Tue, 22 Jan 2019 07:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20190116020100.4813-1-atull@kernel.org> <CAJYdmeMfH-2aY09_rA0JavL4=WoRy+jWe+ZwgGgefDq-CbpCaA@mail.gmail.com>
In-Reply-To: <CAJYdmeMfH-2aY09_rA0JavL4=WoRy+jWe+ZwgGgefDq-CbpCaA@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 22 Jan 2019 09:18:28 -0600
X-Gmail-Original-Message-ID: <CANk1AXRmdU01xEs=62fEOJNTmcmCe35mowHUeRidnPDSDB_2Qw@mail.gmail.com>
Message-ID: <CANk1AXRmdU01xEs=62fEOJNTmcmCe35mowHUeRidnPDSDB_2Qw@mail.gmail.com>
Subject: Re: [PATCH v3] fpga: altera_freeze_bridge: remove restriction to socfpga
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 6:41 PM Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
>
> On Tue, Jan 15, 2019 at 6:01 PM Alan Tull <atull@kernel.org> wrote:
> >
> > The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> > since it can be used on other platforms such as Stratix10.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>

Thanks!

Alan


> > ---
> > v2: add depends on HAS_IOMEM
> > v3: put both dependencies on one line
> > ---
> >  drivers/fpga/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 0bb7b5c..c20445b 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
> >
> >  config ALTERA_FREEZE_BRIDGE
> >         tristate "Altera FPGA Freeze Bridge"
> > -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> > +       depends on FPGA_BRIDGE && HAS_IOMEM
> >         help
> >           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
> >           freeze bridge is a bridge that exists in the FPGA fabric to
> > --
> > 2.7.4
> >
>
> Thanks,
> Moritz
