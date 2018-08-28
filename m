Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72BE20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72BE20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH1LOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:14:50 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34242 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeH1LOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:14:50 -0400
Received: by mail-ua1-f68.google.com with SMTP id r15-v6so386005uao.1;
        Tue, 28 Aug 2018 00:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkYKcRMDElJBrVNb2gJdhldKMun+UTbbioAc8VuJpRo=;
        b=KO/xOOixDPOHz/QycljYDkimN0cjSqy0Oh21CL25jeUk1IhaLLpeCI/tkCbMdR4bgR
         IebFxTBKoaYw8yV0pnN2m42M+BGq9RM1OFiASEFRu2GkyAMYBBoXmmyV69+rzYFCwjjd
         DpsusBCB170x7C6ukuIliqbVGLopfG5p9r4o3TNdRsjzaRJ7EMZULpS+Y0XoZTmWn/w0
         WD8+RAO9vm/S2qBqml5saW+OOtZqAc6roKSrW5A1Vk2L6WYLvuISHqvx3AzGSRA9wh67
         2DcP9NxMnzkzK3t32QF8xHDQ8HII4HpK+mOKxw1m3VYDyIw0hpSBjVJQoQHIeyFcABZ2
         L6HQ==
X-Gm-Message-State: APzg51BvpVgQJhF3wg9OaXp0xeXQy+fp2icCu6T3XaeHqpTeU9AgdJ5C
        y+bthEp9RSroyDx+AT6HvOBYlSSWToH1TlXu0UE=
X-Google-Smtp-Source: ANB0Vdbsno8sLeTr5AnaUlwOwsPvBI2Xj/z+KV0tVbvR/Wdfk46jMlZtZ6M7r4XyBv44xE1QxmOBlJlUGDDB22QAsNQ=
X-Received: by 2002:ab0:51e4:: with SMTP id h33-v6mr178660uaa.137.1535441072017;
 Tue, 28 Aug 2018 00:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-2-robh@kernel.org>
In-Reply-To: <20180828015252.28511-2-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Aug 2018 09:24:20 +0200
Message-ID: <CAMuHMdV9QeMRSTzcbCeUHFi_a77ceumEW6mzoC+zrpEUsZEM=g@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:54 AM Rob Herring <robh@kernel.org> wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
