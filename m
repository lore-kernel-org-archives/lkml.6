Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6862C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2B620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNiwS/eE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2B620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeKITjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:39:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44360 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeKITjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:39:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so1053893lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tBXRTyO6O6twjXCPC/C499u+0qdHG4j9CTYYpXTXSQk=;
        b=iNiwS/eEyRC0jBug19Ioq50zEpd8uEy7qrD8iLt2RgXwz54d2n80c6PBnQoJKAIROT
         kZ84gyC0ZAh53pHlvAeAMnuOSiPglqIAaOLv0YaDH1fZVr1DctYQ8qfwqXTLVhrYbUHe
         N5k7Cuv9GReBAlRNev20TKha0efuuGn7b0cNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tBXRTyO6O6twjXCPC/C499u+0qdHG4j9CTYYpXTXSQk=;
        b=JK4UmaNbEk3Z3sy3vtG7zQMsakdKjDi32yKovSLQkpLYQRSRWDz4CuGRdce/Vq9SMx
         8cEIUiAr1chQpDig0I9cNzYxuNVy6e2womR7noGZBiwrCFlDZRuENsuQ53AwmOXJgKV9
         Uo3uPB7g4Tgsv6htl4cyCSPSb3I/VBcZIKfidzIG34rs1rfjouy7RQt1iTaHp/oiAJjN
         Qz/WvgdSMSUenIWne9lhGLdll9YurAZE6bxw0CNPfvBsCyu4/S/himmrxli50Whth3ev
         hv3tHP2izVlvb+tGsYB2kpYnOZJkwFl9H70y3WQKQZaRKU12RePopGHWoArirfnzowvR
         UcaQ==
X-Gm-Message-State: AGRZ1gIgEjTelQfKVOpbp2luzRwiqByR4unk8H9SLdTCUnfnHJ2D6jdG
        k6IHAKzh50Do3aBuc/MJ+CI07Y/BGx247JGlI8NeUA==
X-Google-Smtp-Source: AJdET5ezKfWdXHcPdEaN+AoX7xBWwXmy2lZ95/A3c8HavAQJwz3kYS/B65UgZvSz9aaZkQvYWZB+fZo7Ffr2cwffBzw=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr5286914ljj.9.1541757571828;
 Fri, 09 Nov 2018 01:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20181102103539.6077-1-marek.behun@nic.cz>
In-Reply-To: <20181102103539.6077-1-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:59:20 +0100
Message-ID: <CACRpkdZRi_prZK=EwFF86bWEC26+ajr9F9s3ALqVi-rQW+r2AQ@mail.gmail.com>
Subject: Re: [PATCH v2 bus+gpio 1/4] bus: Add support for Moxtet bus
To:     marek.behun@nic.cz
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:35 AM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote=
:

> On the Turris Mox router different modules can be connected to the main
> CPU board: currently a module with a SFP cage, a module with MiniPCIe
> connector, a 4-port switch module, an 8-port switch module, and a 4-port
> USB3 module.
>
> For example:
>   [CPU]-[PCIe]-[8-port switch]-[8-port switch]-[SFP]
>
> Each of this modules has an input and output shift register, and these
> are connected via SPI to the CPU board.
>
> Via SPI we are able to discover which modules are connected, in which
> order, and we can also read some information about the modules or
> configure them.
> From each module 8 bits can be read (of which low 4 bits identify the
> module) and 8 bits can be written.
>
> For example from the module with a SFP cage we can read the LOS,
> TX-FAULT and MOD-DEF0 signals, while we can write TX-DISABLE and
> RATE-SELECT signals.
>
> This driver creates a new bus type, called "moxtet". For each Mox module
> it finds via SPI, it creates a new device on the moxtet bus so that
> drivers can be written for them.
>
> The topology of how Mox modules are connected can then be read by
> listing /sys/bus/moxtet/devices.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

This looks fine to me. Maybe strange with "gpio" in the
subject of the mail? Consider adding sysfs ABI documentation
in Documentation/ABI/testing/*
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
