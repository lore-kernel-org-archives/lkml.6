Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17339C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51C420859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547575636;
	bh=eUXfawc0N+EHlqTH/VDVDJ88au1LXeCaTxBVIG1XEHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kdchfJmY8qB/ZNWw2onEMCl6yG4p2ncjQ7eRTAAwByUtxNBIpl70z2bgw73HtmkdH
	 hFzLZuQO7VBfKJ41T5zAhw5+fgLB8glCSC0wWm3ylod9dtHPRMj5p971skWpfvj8VO
	 7Gx7NCO3z74vVYjhgmvK85SAxfQz8ZtJam/Vcmj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbfAOSHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfAOSHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:07:14 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7636E20866;
        Tue, 15 Jan 2019 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547575633;
        bh=eUXfawc0N+EHlqTH/VDVDJ88au1LXeCaTxBVIG1XEHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L+9/t53bh1eUPK65cDL6HYn1QuEcXnmDKMUkhL957RwZ6CNCloWNJjkVU+pUvspRP
         W/tr0i8JQAZ6axYqazCt0I+YkBbeWZ043p+h4AliEf1PN51KHMNxOG+3tIbydjVJsp
         yKRtuL2ZzngYTxaORqv23YaObfM/rhQyxYxQx1Gs=
Received: by mail-yb1-f180.google.com with SMTP id h81so1104238ybg.2;
        Tue, 15 Jan 2019 10:07:13 -0800 (PST)
X-Gm-Message-State: AJcUukcbPJyhs4aTX+pfJaXW2a5T4++xZn7QWH9EXchtSKF8CwsZlmOA
        faAcrg8o/1J64TXorymUNJOP9NCgqDMa9Y/h94Q=
X-Google-Smtp-Source: ALg8bN78x1G+uZsK/N/Y25Z0wSmKko9r3Y8KCqcmM9fHfKjtx9T9cWgSSOPYdleMCEqXDFc/ZI2miMHdXA+rvKXXIJA=
X-Received: by 2002:a25:2b0a:: with SMTP id r10mr4070394ybr.315.1547575632509;
 Tue, 15 Jan 2019 10:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20190114223312.3254-1-atull@kernel.org> <0574de1a-a238-7ad3-1bc2-24d27ff50cba@kernel.org>
In-Reply-To: <0574de1a-a238-7ad3-1bc2-24d27ff50cba@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 15 Jan 2019 12:06:36 -0600
X-Gmail-Original-Message-ID: <CANk1AXQQUVUBfSHCEQbiVEe4ud=K6s75CTmAoBfamkj1oiQ=NQ@mail.gmail.com>
Message-ID: <CANk1AXQQUVUBfSHCEQbiVEe4ud=K6s75CTmAoBfamkj1oiQ=NQ@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: altera_freeze_bridge: remove restriction to socfpga
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:47 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> minor nit
>
> On 1/14/19 4:33 PM, Alan Tull wrote:
> > The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> > since it can be used on other platforms such as Stratix10.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 0bb7b5c..da5786a 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -104,7 +104,8 @@ config SOCFPGA_FPGA_BRIDGE
> >
> >  config ALTERA_FREEZE_BRIDGE
> >       tristate "Altera FPGA Freeze Bridge"
> > -     depends on ARCH_SOCFPGA && FPGA_BRIDGE
> > +     depends on FPGA_BRIDGE
> > +     depends on HAS_IOMEM
>
> can just be:
>
> depends on FPGA_BRIDGE && HAS_IOMEM

I agree.

>
> Dinh
