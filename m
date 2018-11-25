Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C442E2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C442E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeKZIkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:40:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44210 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeKZIkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:40:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so11153663qkh.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il91rjfr52Gb1Nc4feu1mOCMPvzqR7i2HsL9CpA5iw4=;
        b=W0DpEAGyKCHBVFOCM8kMV60fU7eyUyy68UV9oWZA4iqRj9+b4avsjsg9m81MxhzHA5
         BVVKRoO465K10VgBoeBD1VsrQzMzkHHmo5qdNjPX+8za/Vl+a7vHy2jIEzUVAWuot3sW
         C69HC68YCK+LlZLubN/0gbM+OVXdx/OwlwaXFH2SieG1WJegx4xW1PcGvWhxQKAXWg4/
         CDIDkmgFPdkoJe7xngybcnGlWlaaiQuFJRXlFy7eNLF/9C4f07XeJW/HvvlbYb1j6eoQ
         wR8eU0B65Ri2+EhDuhghyxXpY3pSygIT7wNKailCUYdXM4bjZn6/wATC60fUI3SM8bEU
         eaYw==
X-Gm-Message-State: AA+aEWaGaaTG1NjtikRSlobFuSPBJrnWkCqW00tSPG2IZKgVGEmKzwIb
        sypphgBO0yE6S1XwzbgmE6KVTUf/N3sK963+clFQJQ==
X-Google-Smtp-Source: AFSGD/WVx9PPTx40fxoBNjn1/3mgwuiEUvLQr5xtRS7+CSra0vF0zHNfGuD6RoJ9JHHzfcdMOYylcdw7yYAYilVsaP4=
X-Received: by 2002:a37:324a:: with SMTP id y71mr22595878qky.291.1543182479281;
 Sun, 25 Nov 2018 13:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20181125212159.11590-1-otavio@ossystems.com.br>
 <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com> <CAP9ODKqDySwsJ+3hJFXYfm8NyhsVGDwyRi+3sUUJiP304SU07g@mail.gmail.com>
In-Reply-To: <CAP9ODKqDySwsJ+3hJFXYfm8NyhsVGDwyRi+3sUUJiP304SU07g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Nov 2018 22:47:42 +0100
Message-ID: <CAK8P3a3bCK4MxXoCmzfdgvELz9dNgOkACb1Gzpf8vRH8Cd-FnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
To:     otavio.salvador@ossystems.com.br
Cc:     otavio@ossystems.com.br, Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:45 PM Otavio Salvador
<otavio.salvador@ossystems.com.br> wrote:
>
> On Sun, Nov 25, 2018 at 7:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sun, Nov 25, 2018 at 10:24 PM Otavio Salvador
> > <otavio@ossystems.com.br> wrote:
> > >
> > > CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> > > selected by the Kconfig logic.  This is done in preparation to making
> > > further changes to this defconfig cleaner.
> > >
> >
> > Does this mean we no longer get the unwinder, or there is some other
> > config (which?) that unconditionally selects it?
>
> It is selected. Before changing the defconfig I did a savedefconfig to
> avoid unrelated changes to be included on the subsequent patches and
> then I found it was now selected.

Ok, then please mention in the changelog which other option selects it,
as I said.

Aside from that, your series looks fine to me.

      Arnd
