Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA0EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6942082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6942082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeLDO4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:56:50 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38005 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:56:50 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so5865330uaa.5;
        Tue, 04 Dec 2018 06:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYWDfCgBygTPCB63SMbqvdA93cB4zrg0LhY5khUtxJI=;
        b=XfFsZCdOqTMHTtjqpeXb9+iboaqWtfQ6Z0iUM5el8XROYwE6z1rmrXpNptKX6cuIp5
         Tt11P6BIyG+pBqa9Tbi0eBK3nEHoLAn2emmXhM9DUbW7m4OIQw2RS7wMKFaGkjXUZrUz
         Dt36J6L8Jp9bAoVN6cL3xnQ8ZPCegS8ai93HyQYlEBqMIRoXx+YrqoxEjIlJDB3xSRo9
         P3EmvYPNqVP53+X4DBcKLU5B5dh9hsNzab+qX55ay9JoyUpu5V5CvTWBNRn7gvRholDR
         +/PRP5o6Wndffv/Frspenad82Lpfu3UFGsx94tW2zKnooNOfp5ezePRwsfdJHgR5v+lL
         SH5Q==
X-Gm-Message-State: AA+aEWapHhJKJhu4Fek10ZxuW28ErrZ1Guh7DT6fx7qvDpwv3NLLY3qF
        x3pkHxu7t0QM22lCIf7zv/tjxir1ghQuNMmXdJs=
X-Google-Smtp-Source: AFSGD/UgfmisPTWx/S3A0dv/jJjsOtEKTW5ZSEF8Z79b9aWaFZHp8P3MGOAKfcJSD2NsZfPk0TGTzf67IxFgOhZthsY=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr9656963uap.0.1543935408537;
 Tue, 04 Dec 2018 06:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-26-robh@kernel.org>
In-Reply-To: <20181203213223.16986-26-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Dec 2018 15:56:36 +0100
Message-ID: <CAMuHMdXLpAR=EJnyhRFvTPEBVe8EhGiDd814sM9NkKYwePJdww@mail.gmail.com>
Subject: Re: [PATCH v2 25/34] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        darknighte@darknighte.com, Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 10:35 PM Rob Herring <robh@kernel.org> wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: devicetree@vger.kernel.org
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
