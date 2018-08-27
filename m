Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67C5208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67C5208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeH0O1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:27:36 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42834 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeH0O1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:27:36 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so7290723vke.9;
        Mon, 27 Aug 2018 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7XknSxpJpIcrEu4BGnDHCRmO4cixge7ib7L01NPpgs=;
        b=emeR/5leO3dU1GAkDYJ26LdzDFHTfnHbrEHHB/q6LGcvgUnufPgX3+oJEx7nCfoh0W
         v8YsQRMJGcZI8/KIQtBwGsBPpJIAWJLt6X1yGj6jM0jl803nPI3H0OFZ9Bh666+N8NBj
         FEekLL5JEcMJ785UHLE30piRsj+fCsHHLoXqYhuEwJi1gIao8wPbGqMnsnxwSxYKuHst
         px/6hlvNaIuPOwRT23K/uvTj5Yk9P5hfYyfRcoiVEP3jcwvCJ9tAEXu3Fi/oxvp95wtN
         K3fSUeCnwGGmsYi8VS8/V6lq9DX14VM11WjTsdho1k7abvyAVVS4mJ8NCbTvSN34dQnQ
         WfdQ==
X-Gm-Message-State: APzg51Bi1roCCLfWZubvtZvZXCkCjZ/e7BgSBxW7u7WG3l/drxtR87ad
        4dgfz6QLw6t3sRlAu50ZLkzcxWtYoxCrzcegK+64i1LI
X-Google-Smtp-Source: ANB0VdYvukNMn49udXd6T3ZoHSG5QeU/jEqZ+FBB2RcJKFMyZjDMkzFMRocmK9tv+uDBANCooYBXmO4azaUqGLeZEys=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr7526611vkd.10.1535366488989;
 Mon, 27 Aug 2018 03:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180823200834.GA9368@roeck-us.net>
In-Reply-To: <20180823200834.GA9368@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Aug 2018 12:41:16 +0200
Message-ID: <CAMuHMdUugeKbUgfKpwYCXQrpMys8hrWUXr0FZWAW7ryeZoS1dg@mail.gmail.com>
Subject: Re: -next: Traceback at at drivers/spi/spi.c:2179 spi_register_controller
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>, kirill.kapranov@compulab.co.il,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, Aug 23, 2018 at 10:08 PM Guenter Roeck <linux@roeck-us.net> wrote:
> I see the attached warning when booting 'sabrelite' images in qemu,
> using imx_v6_v7_defconfig and imx6dl-sabrelite.dts.
>
> Context suggests that the warning is seen since commit 1a4327fbf4554 ("spi:
> fix IDR collision on systems with both fixed and dynamic SPI bus numbers").
>
> Guenter
>
> ---
> [    7.105230] ------------[ cut here ]------------
> [    7.105509] WARNING: CPU: 0 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x7dc/0x938
> [    7.105760] couldn't get idr

Correct, all SPI controllers instantiated from DT and using DT aliases
are broken.

https://lore.kernel.org/lkml/20180821095303.27664-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
