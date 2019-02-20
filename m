Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532932146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBTIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:04:26 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34297 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:04:26 -0500
Received: by mail-vs1-f68.google.com with SMTP id e10so13441925vsp.1;
        Wed, 20 Feb 2019 00:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WW+YjypGAcPCSk+diTMEaYFzvrBce9iXmvkBftQ/cE0=;
        b=sDkCNXSkEpF+K7eNt77HNbXI7E8u0viFL9AiDfU3Ij98bUdVHYAG2+rtPZM4B/D0IW
         KBjn5V269U2v64XA3UgdsmgTccQeg3PwXEBNdU7vr8o9vC1dhDm48Z/j8VDb1JK8zKGQ
         Bt7mCRlt9rE4u/cHM7xdivKMacKfZwGE34+ZxmNINrC6kAgtIdxT3XxxIgYZYUw3otjf
         P9vjOJTJK+rJyKZKhuB2aRqStnH9UdFx9KL2BgUH4XZLZ+H7JcvEXScQi+oN/qTm10qN
         KeMF4B1QT2LRI6zu5/h8oFxvoVyRiriHGqd9XtfLHdtrMDIDQR19/vIEMAt4tQAyj6WB
         mIFw==
X-Gm-Message-State: AHQUAuYiwoJq2cK8IIM9iLgHheMNnC9qBbx0f8og1FEEJXZnCxQ6jEfN
        yp4HdjV1HpBQPVP0h5FcldToFWDj/BjdcjL88mQ=
X-Google-Smtp-Source: AHgI3IaYkT/H8AgYYKVytSTf5tvPdPGyEIdRCTe+je5EO3YDdSJBM+s4WJc86FI078ja44vNmT2rHbtUUZqT8j+ecOs=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr3825153vsc.96.1550649865229;
 Wed, 20 Feb 2019 00:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20190220052435.20508-1-jiada_wang@mentor.com>
In-Reply-To: <20190220052435.20508-1-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Feb 2019 09:04:13 +0100
Message-ID: <CAMuHMdX1OqmwtCAtx8mxQtrG0D6bxkJ-trkA50qw=t16kBfdTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] rsnd: dts: change to use extended audio dmac register
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

On Wed, Feb 20, 2019 at 6:25 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> According to user reference manual for R-CAR H3 and M3-W SoCs,
> in order to access busif4 ~ busif7, extended audio dmac registers
> (PDMASAREn, PDMADAREn, PDMACHCREn)
> need to be used, rather than basic audio dmac registers
> (PDMASARn, PDMADARn, PDMACHCRn)
>
> This patch set updates H3 (= r8a7795) and M3-W (= r8a7796)
> to use extended audio dmac registers

The same change should be applied for M3-N and RZ/G2M, right?

R-Car E3 and RZ/G2E already use the extended register set, as they do not
have the basic set.

For SoCs having both, this feels a bit like describing software policy, instead
of hardware, to me. Would it make sense to extend the audio bindings, and
allow describing both the basic and extended register sets, and let the driver
make the decision which one to use?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
