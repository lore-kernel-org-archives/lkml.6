Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1BBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDB2208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDB2208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeHBPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:05:43 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:36117 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbeHBPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:05:43 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173])
        by mwinf5d40 with ME
        id JDEX1y00J3l49Wx03DEYPd; Thu, 02 Aug 2018 15:14:32 +0200
X-ME-Helo: mail-qk0-f173.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Thu, 02 Aug 2018 15:14:32 +0200
X-ME-IP: 209.85.220.173
Received: by mail-qk0-f173.google.com with SMTP id b5-v6so1478277qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 06:14:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlFf7XHf1mflMk/f8j25hAKoZbzouwkKWChD3A8Y28PXZheJfHh2
        5LtdvFxRUf7WBEC8EBBRMlz04d+IxwYHpzRQzEs=
X-Google-Smtp-Source: AAOMgpfBSszUSUshyxOU46kzVFyZUySQQ4E7qFTrQBiwd9Chiat9Bkkip1+GH3yMg2PdYsGMNgUW4QHEsqBbEbVdaOY=
X-Received: by 2002:a37:5b47:: with SMTP id p68-v6mr2360912qkb.202.1533215671405;
 Thu, 02 Aug 2018 06:14:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 06:14:30 -0700 (PDT)
In-Reply-To: <36fcadd3-074d-7c11-6ca5-b44aecaa3639@baylibre.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-2-maxi.jourdan@wanadoo.fr> <36fcadd3-074d-7c11-6ca5-b44aecaa3639@baylibre.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Thu, 2 Aug 2018 15:14:30 +0200
X-Gmail-Original-Message-ID: <CAHStOZ4DV8FbAgzMKhnbLOOPj7Gm8+5=KxMSGL6J1D00Ejk42g@mail.gmail.com>
Message-ID: <CAHStOZ4DV8FbAgzMKhnbLOOPj7Gm8+5=KxMSGL6J1D00Ejk42g@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: amlogic: add meson-canvas driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

2018-08-02 10:38 GMT+02:00 Neil Armstrong <narmstrong@baylibre.com>:
> Please switch to the spdx header format here and in the .h.

> In the DRM driver these are updated in IRQ context, we should make sure we don't sleep
> in interrupt context if IRQ occurs when the VDEC updates it's canvases.
>
> Could you switch to spin_lock_irqsave() instead ?

Will do.

> Can you add the endian defines ?
>
> #define MESON_CANVAS_ENDIAN_SWAP16      0x1
> #define MESON_CANVAS_ENDIAN_SWAP32      0x3
> #define MESON_CANVAS_ENDIAN_SWAP64      0x7
> #define MESON_CANVAS_ENDIAN_SWAP128     0xf
>
> the SWAP64 is the one used in the VDEC and DRM Overlays.

Sure. Maybe I should push the flags (0x1, 0x2, 0x4, 0x8) rather than
the combinations?
Or both, since the combinations are more likely to be used in practice
more than the single flags.

> I rebased my DRM Overlay patch on top of this and :
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
>
> You can keep this tag on future versions.

Thanks!
