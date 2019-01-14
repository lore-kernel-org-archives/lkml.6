Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873C120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547504131;
	bh=DbRxkJ7OjLuaACN9g4X2SeAIXxhqqbzTFKJT4X9oN74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2SuUa4EDOdI5fIo9K0Y6fua/ZRWGcJmSxEZACLrDMJf51cerrDN17V8pBykj0T/3R
	 JQQ3CfL0kwj1UqOQrBcIOsHg71ZAra2h/tbMg79Pawy7Ozo/xi0TC3FNPZ8r+uHPRG
	 Y9NtmIUje1yvRdqqL1IBbm6Kr9aVmuNifG++2yBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfANWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfANWP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:15:29 -0500
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2965E206B7;
        Mon, 14 Jan 2019 22:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547504128;
        bh=DbRxkJ7OjLuaACN9g4X2SeAIXxhqqbzTFKJT4X9oN74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EmIIAQmd8L4ohP7AC4VOTr/mjJ2tD/+5h6+cWfUOR0QXaqEnGzTKJjq7c9xQ+ttb7
         urIjpNNyi4dak+wPLNXTQKxHhz/wZZXkibLkx8//XxjDW4gq61ZXzLoC/HXgdXCErl
         cq85Mhp9I7rbL696cwH0STvkr68r3KkzVNMTqGXo=
Received: by mail-yw1-f43.google.com with SMTP id h193so280412ywc.4;
        Mon, 14 Jan 2019 14:15:28 -0800 (PST)
X-Gm-Message-State: AJcUuke/MZ52yjAtO7ChxKy8dhSSQUTguBj8U3YIZr3k7JbcYOPhyqv5
        R3xEOK08Hr40of0tnH/oO7YXEIQpFfHLdX69gDc=
X-Google-Smtp-Source: ALg8bN4fsmgjFweydQznX/b/xM+/01BHqL/dKKY0NlY4fhfvsVjh99MtCHe6bWNnlJmQ45hm1YwV1gY3kZzpkIl0yD0=
X-Received: by 2002:a81:b649:: with SMTP id h9mr585889ywk.57.1547504127366;
 Mon, 14 Jan 2019 14:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20190110230626.4130-1-atull@kernel.org> <CAAtXAHeuGCz7msGnG-kPWN18h6h9z3VgbrBf0eXKvtKaEm7=mA@mail.gmail.com>
In-Reply-To: <CAAtXAHeuGCz7msGnG-kPWN18h6h9z3VgbrBf0eXKvtKaEm7=mA@mail.gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 14 Jan 2019 16:14:51 -0600
X-Gmail-Original-Message-ID: <CANk1AXRtWBWhR3UEihL35pa7YmhPiOTDzHK+nAZe6qmMtQ8_HQ@mail.gmail.com>
Message-ID: <CANk1AXRtWBWhR3UEihL35pa7YmhPiOTDzHK+nAZe6qmMtQ8_HQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera_freeze_bridge: remove restriction to socfpga
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:42 PM Moritz Fischer
<moritz.fischer@ettus.com> wrote:

Hi Moritz,

>
> Hi Alan,
>
> On Thu, Jan 10, 2019 at 3:06 PM Alan Tull <atull@kernel.org> wrote:
> >
> > The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
> > since it can be used on other platforms such as Stratix10.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 0bb7b5c..0bdbd3d 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
> >
> >  config ALTERA_FREEZE_BRIDGE
> >         tristate "Altera FPGA Freeze Bridge"
> > -       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> > +       depends on FPGA_BRIDGE
>
> Doesn't that need a dependency on HAS_IOMEM at least, then?

Right you are!  Thanks!

Alan

> >         help
> >           Say Y to enable drivers for Altera FPGA Freeze bridges.  A
> >           freeze bridge is a bridge that exists in the FPGA fabric to
> > --
> > 2.7.4
> >
>
> Thanks,
> Moritz
