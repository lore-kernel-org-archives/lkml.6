Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8918AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A832086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbeLNKHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:07:03 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40447 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:07:02 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so3029065vsf.7;
        Fri, 14 Dec 2018 02:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4+QAh314kwqq7FzGxSO3gs/sdfCQvDVlT0fAM72g1I=;
        b=eRHmDD2neKMBHowIMGnN74J8Rn1ip4eC+X9MFV6M7pRClFlGHUDqTFd9W3c3HQ0szu
         EmUMFzHyf4IWjRNY410bn207s/KXTDR2GSzDy1yagm3PHP6htr8ibbBc6CxR05J6Z0tM
         ZPWNLBejyeGV44FW4EAFTiZEPiSL3aAjMVLwKRkszIF3aSoTpd8+JNF8YtpMUAklG0D8
         jdRqS80GRTGDyYnSm7Bx3tr8c3h55c8tzNUQnpZUgfJGPX4aMcdouSvjSmVrztFJ2Qir
         UBvFlxvM7W299ZxYnmVujkcI25FVKcRa2iMYppTggCPw4y58fhid6dogdkpRRKDF9s3S
         pEOw==
X-Gm-Message-State: AA+aEWZGdi4aOnTx8aKxBHoAukmg2zwnEKnI1dy6DV7K9rp4gwNe13H4
        3D6iP7ptQahOPiDx3LqQc2GjWV7RPeGA1F945XmY0GaQ
X-Google-Smtp-Source: AFSGD/WVdZopZOasItOQ75IojOdtoamrRFkca31y13bmPBP9bIKDpeUwGKG89VIGy5302scUHyxWHajcdLBSjJ6dRHw=
X-Received: by 2002:a67:c202:: with SMTP id i2mr902710vsj.11.1544782021482;
 Fri, 14 Dec 2018 02:07:01 -0800 (PST)
MIME-Version: 1.0
References: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:06:49 +0100
Message-ID: <CAMuHMdXTZTxaKwJ3R+1FqHZDxgC-WPQGMHOBxh3MLCNJxu7ZBA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:19 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> RZ/G2E (R8A774C0) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
