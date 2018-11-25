Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F32082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="wjl0R4Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3F32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeKZJNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:13:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37803 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:13:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so14124959oia.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=b/6EJkdQFxhYvlr4Rst7gVXP5NNsDx7toOt/M6qbnAI=;
        b=wjl0R4AhQHwbMtUps/DjC7DIYRgcRq6GHkKt6QV14MjaGw1jZvsEyoW+vZST70LV86
         f7PHScoLFYmY3k+65O2MTBCMK6HUwSp8Dt3HlW3/9MNC/Kc3dyOYgc+mWJtKV+O0ayJz
         rEPRMuD54MajDfxyibvwDF++myxSMvnEp02LR/FWlH63XpBh1lwwDaAOmjIMHKdfFkMz
         BHTY3juowgdWdMoJumr83VE6s7ck8DnRk4PqQ8S1NG9yYlCIqtIRrzvwNHei0IyBSxoF
         BzBPHlbClmjGDLxu2mXvNzIz3w0w5AIeBFx2TBpfJkrUkUjx1y4uNtE5AkfqA50jCLrw
         BIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=b/6EJkdQFxhYvlr4Rst7gVXP5NNsDx7toOt/M6qbnAI=;
        b=ESt0PpN6Y2Aqf8U7IhPnW23XuvC/qcAObqRE+FKzcCtTc0eC4sQ8OGT0LvZ92ewVtV
         I8aeajl323HikVV0s03ynpsOoj2LWXmd+CI0iIcCzq9+0uNMVXfonUe1pn/0WD2/pMsu
         9+URbdNqxUizb2j1J2HZlh91K+jrhk2/ZpvoTufYBb+9g12XgXasdh2Xuh5aWRM2XMPq
         egZrXlXp/kiYXw1KoWsJLBaLeVo+2haUycPK6t1LJSQjVOCLnmr+BXkBTuegKmu96GC1
         GD3Vel1z/RRxW57k+z5PakBDF1p5ZpjgqyhcbFg5Are/MB7gjuyRmBcNr1Nl+jPvaLRX
         QC+Q==
X-Gm-Message-State: AA+aEWZ+MHK0ayLIlt9b7QQCt5Unv8Sau3WFdQDlI4wPgF1mb2cQQ145
        DrHb9m1k9PP5sNWjxT3kh3h7UcmOeI/Whg==
X-Google-Smtp-Source: AFSGD/W4s+VxyW38IavnRNS13UNQxbiwEz+HP2oVaNGKzDy1qNxqGzGA8x4KzJUGs4SaOCH47Y14Xg==
X-Received: by 2002:aca:b388:: with SMTP id c130mr3270809oif.123.1543184504530;
        Sun, 25 Nov 2018 14:21:44 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id x127sm16524846oia.20.2018.11.25.14.21.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 14:21:43 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f171.google.com with SMTP id m6so2462541oig.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:21:43 -0800 (PST)
X-Received: by 2002:aca:dfc3:: with SMTP id w186-v6mr14419970oig.331.1543184502717;
 Sun, 25 Nov 2018 14:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20181125212159.11590-1-otavio@ossystems.com.br>
 <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
 <CAP9ODKqDySwsJ+3hJFXYfm8NyhsVGDwyRi+3sUUJiP304SU07g@mail.gmail.com> <CAK8P3a3bCK4MxXoCmzfdgvELz9dNgOkACb1Gzpf8vRH8Cd-FnA@mail.gmail.com>
In-Reply-To: <CAK8P3a3bCK4MxXoCmzfdgvELz9dNgOkACb1Gzpf8vRH8Cd-FnA@mail.gmail.com>
Date:   Sun, 25 Nov 2018 20:21:27 -0200
X-Gmail-Original-Message-ID: <CAP9ODKr3kQjEcKGwiVpsnFTFEEzjTxP0HdJYsQuc7jvqLEBypA@mail.gmail.com>
Message-ID: <CAP9ODKr3kQjEcKGwiVpsnFTFEEzjTxP0HdJYsQuc7jvqLEBypA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
To:     arnd@arndb.de
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On Sun, Nov 25, 2018 at 7:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Nov 25, 2018 at 10:45 PM Otavio Salvador
> <otavio.salvador@ossystems.com.br> wrote:
> >
> > On Sun, Nov 25, 2018 at 7:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sun, Nov 25, 2018 at 10:24 PM Otavio Salvador
> > > <otavio@ossystems.com.br> wrote:
> > > >
> > > > CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> > > > selected by the Kconfig logic.  This is done in preparation to making
> > > > further changes to this defconfig cleaner.
> > > >
> > >
> > > Does this mean we no longer get the unwinder, or there is some other
> > > config (which?) that unconditionally selects it?
> >
> > It is selected. Before changing the defconfig I did a savedefconfig to
> > avoid unrelated changes to be included on the subsequent patches and
> > then I found it was now selected.
>
> Ok, then please mention in the changelog which other option selects it,
> as I said.
>
> Aside from that, your series looks fine to me.

Thank you for reviewing it. I sent a v3 mentioning it.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
