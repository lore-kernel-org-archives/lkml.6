Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D3C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA2720830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oYqeukvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA2720830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeKAQkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:40:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35752 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeKAQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:40:06 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so897601itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkctEzOmZra2VW/Uspe/Ha8URiR/f7+ZVjubMqmu3rM=;
        b=oYqeukvKW8fA0/9lQbauyHOl0sbtqnyVo++0aagRu06UfQLn6Nz/igvHl8odYD9//S
         CejKmAI7auYdeGF34TI0VbZoXyYIYAs35FAP09RQTgOA9dp+x11hw1dGYFG1M+v5F5xR
         1wr3qjKoILKvSyk+9TmfCztYvY5+NnKjavKeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkctEzOmZra2VW/Uspe/Ha8URiR/f7+ZVjubMqmu3rM=;
        b=lSjXk00nSBBipNr1Ut7lC13odI38ZYAFEZ07DBkVmXDjxlkxocuK+3t3GR4GSfqVwq
         quEYbCOpHekd1Zdt0P1Toph/+84i8wuzmSFSDnFPMX6sWYXta9K63S4AYW1+TRMiFhSL
         NTa4lpPM4hBxm23FgntI64IPP/XX7I934go8vLUNOvKoE827LaIi7NyB2twJsDUWxSYR
         OrGN38ls11KH6FnNwO8SP+k+s6ixtOAa+p0iHaQ0zKJjCVbq0Po8AYk7VFQmuUe9ywdt
         K1NUqVdR8l8LgyFPJLuScjKglAzqQ9xRoLqVj0lUGBwYYQoiRq6uAmWiRod0g3GAocTp
         8gwg==
X-Gm-Message-State: AGRZ1gI2Pmfmuz9SSGIopPb4CXiaAhBh1ik1ATVDZL5KOMtbJQaGQ21N
        dh8e17LdQa3LNvik8clCQrzeZZeOn9V36Qwbsx70aB3B1oY=
X-Google-Smtp-Source: AJdET5fs0/WnNJ78TbrJSrYVgEhBrmJfmQ6rr4lL9clrqmA5xDTb4PP0E3/gnzY6i86p+tospMPKyYfeFM8rKkKvvxc=
X-Received: by 2002:a24:6b4f:: with SMTP id v76-v6mr582121itc.0.1541057895345;
 Thu, 01 Nov 2018 00:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180722053955.25266-1-icenowy@aosc.io>
In-Reply-To: <20180722053955.25266-1-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 1 Nov 2018 13:08:04 +0530
Message-ID: <CAMty3ZCcxGm0+5LcDXd+6zXVM03bCbdT7p+MXQ6LTp1MJYu48w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/5] Allwinner H6 Ethernet support
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, davem@davemloft.net,
        clabbe@baylibre.com, netdev@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 11:10 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This patchset introduces Allwinner H6 Ethernet support with code already
> available for A64.
>
> As the system controller and EMAC on H6 are all similar to A64 ones,
> support for them are directly reused, by using fallback compatible
> strings.
>
> Icenowy Zheng (5):
>   dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
>   dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
>   arm64: allwinner: h6: add system controller device tree node
>   arm64: allwinner: h6: add EMAC device nodes
>   arm64: allwinner: h6: add support for the Ethernet on Pine H64

Tested EMAC on Orangepi 1+

Tested-by: Jagan Teki <jagan@amarulasolutions.com>
