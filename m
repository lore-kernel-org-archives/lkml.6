Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD648C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CE32087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CE32087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJHOQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:16:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41664 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:16:12 -0400
Received: by mail-vs1-f67.google.com with SMTP id w1so4995386vsj.8;
        Mon, 08 Oct 2018 00:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osue1mJgsfaS1EFwpZk49zemL2dWAZG7kJzubCuh1oU=;
        b=h3un5TIZAHE6+/ahOSNe8yjh4e2/wtwRpIp0VCiCIoiNj/+2ZjCOabHnjESpMOSE5D
         8nEv14TO5AKzlM2Y1Pwy8u6YcXEEwp4iPL+jplWKYeR5cUjF/C1qcExiHzA7/6sPIW/m
         a6A9V8txPq4J1P8pFLUzoXmhgRSpQhd+XQIcKPemh5ZCeTJ5gFWkm2KrZdphkIV08zyV
         MS3HaOfGFo7DIRg4DpPBj6ighzU/MowCSbKUmFFfVkonyp9T4/U3mW6Eo2sPtJkjMmbR
         EZ+wHPyS6bGeDQCNpvJXD4d3Y/neplAqpt8p8E6r3nzKTIJvAoI+3vmR3wG2CDLhPgps
         r0Pg==
X-Gm-Message-State: ABuFfojS0bBXE3VccTnq2UbhI8IKxNWUmkhnCNMlVpPVjhkYGDD3FGgz
        9ogNyru+2iDBsr0GDW39/vu+ZVsR2+k3/t3QI2E=
X-Google-Smtp-Source: ACcGV63O0pQ2gzNbJoy0LYbI3d2s9A8d4XFSj/sseIF/MligeMeHm/bttdlCvYhsl9AqRoEt9ZhUSlCrK5hTfvIa3IE=
X-Received: by 2002:a67:843:: with SMTP id 64mr5388261vsi.166.1538982356908;
 Mon, 08 Oct 2018 00:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-6-robh@kernel.org>
In-Reply-To: <20181005165848.3474-6-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 09:05:45 +0200
Message-ID: <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
Subject: Re: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks good to me, but needs a rebase, as the PRR section has been extended
in -next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
