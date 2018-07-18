Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEDECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BB22084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am6/9YBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BB22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeGRXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:30:21 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41508 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGRXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:30:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so11918249oiw.8;
        Wed, 18 Jul 2018 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0fmy0ROpeCXqpWRgQ0ZOx2DRBArL+edgsAjbl6KBbGc=;
        b=am6/9YBlVG/lGwCiT/N8qu3LuVesbaQhq0aic9EqbyHKhMHK85/2RUEC8GTq5dHZ/f
         J7tbcvwvPbSLdCxWAA0d8lTlQbtajDwoVTfKGoq6a0anfV3lg9rIqMIi208pQKOYc79X
         e4cOQCWy+652zhav5re8Ckko7GXv1te4ObCCsWC8lpnWrczSRT5MTYLKypXBr5RMcZTq
         5huiY8082HP+cvbz9XdxdoB1xJOAgz9M03cXYk1bC37ch8EZbGXwTvkNrrWZDljw2VVu
         Mptd/XUh2dxywSvNLzS/sIIzqjBFSPvSACYUcS1I3jGkt59PbF/l44K0OuUafdPGH815
         V4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0fmy0ROpeCXqpWRgQ0ZOx2DRBArL+edgsAjbl6KBbGc=;
        b=eaSFibgqAfuTDdyG9i4TP2j/r+OEDw8pUJivmcA/97VU4uXBT1YG/FVLonGxEjRKVX
         AHCGeAPeJeFERrcagz7gcY/gQAXdY6Wp5Xvfshmh7ddA0vlaxcro353cJQrNa78lenwt
         wf9WWv3VpEE9v4+2ygYuchHmULzjDrxKoZDthZeMMUr2b5FASzwJ+A94sfOXVrQuTi/D
         DdXsZ+/Cxt4zKNunh2xtg4NJ9fOvHCSw88Qu/TuDlz8vG5U4Uk+y8ejdB6f22dcn81lM
         spk869g6fqS+f333V48SsvuJwmKnRqlvJnTy2/yjmVf/2tlCSGuFtf3Oi5S06PEb9mKi
         v+NA==
X-Gm-Message-State: AOUpUlGsYkEdF3navrDJJTvn8DG1L4YlFehq5e0XrAAHNqsucdXID8F2
        M0fREolgPA8TboT2DnDtvcjN6MNqmyLiIk1H3cg=
X-Google-Smtp-Source: AAOMgpdkoGv6KREnjwEOXt5eBbf7qlRIO2zDapcqqxkBcY2heAEqP10cy4D04LK1fwgaCT5mCAAb5N/AoyQUI92o/Co=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr9055505oia.69.1531954216331;
 Wed, 18 Jul 2018 15:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 15:50:15
 -0700 (PDT)
In-Reply-To: <20180717040651.641-1-andrew.smirnov@gmail.com>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Jul 2018 19:50:15 -0300
Message-ID: <CAOMZO5Dp5aTZF0drkD+QSRyX6qGxAe0yeYGUS8-v=FtJwA7=SA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Jul 17, 2018 at 1:06 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +/dts-v1/;
> +#include "vf610.dtsi"
> +
> +/ {
> +       model = "ZII VF610 SSMB SPU3 Board";
> +       compatible = "zii,vf610spu3", "zii,vf610dev", "fsl,vf610";

Looks good to me.

Just a minor comment: Is " "zii,vf610dev" really needed here?

Anyway:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
