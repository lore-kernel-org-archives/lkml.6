Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9771DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A90F2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJBRMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:12:13 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36923 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeJBRMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:12:13 -0400
Received: by mail-ua1-f66.google.com with SMTP id y5so511149uap.4;
        Tue, 02 Oct 2018 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYToSVA4Z1A2jXnRtXXiny37FpvlWAhzpQl6pPLGHXo=;
        b=RXPH7jymy6M0W6XBiJmFYWTIl2CmOkqvhqnXv8fEXJmHL1SuPDXDokEyPErOORFieV
         NYBbdEy+fLg3y7GhP7W9dj2iDIIQuHIdUw0z4wJHIApGSWwRpb0JDKMQsgPThGjfqYwH
         v52cYL378BGepkWhLfn9qwjD1bVtJ3UuTyZ8TbxtsYVZjThDrkjKQZ4AYC1DtsOr3R94
         rqnKnfH2OXgIxQmQv6qfEXFqChIq7j1FZSEYxYsvikKvtod6uTu6+LmkVE29epAv1DEv
         pZgAggbrAS9s1Eu7zOVTFJBjXXqUIG83y1Q2oKlUEMkTH9X/H6FdN5liOu5mQMYvS8xs
         IcMg==
X-Gm-Message-State: ABuFfog4yoVnMSvU28RHIryQ3po/DRU4ftMjtK1C6V0rglbsmDJ5H+6Z
        rVxgazowmr8NE1S8ML8WfdFm+8e4oIVTcnUDouk=
X-Google-Smtp-Source: ACcGV603vd5ib2mKb8+SUYl8nJKSswS2OF7H34GdznKfcsp1G9yXlGq2nJdUWgJOxMH5k9WfxuhEzPEdib0VF1PwkO8=
X-Received: by 2002:ab0:1e46:: with SMTP id n6-v6mr5952269uak.78.1538476176901;
 Tue, 02 Oct 2018 03:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181001131026.14635-1-phil.edworthy@renesas.com> <20181001131026.14635-2-phil.edworthy@renesas.com>
In-Reply-To: <20181001131026.14635-2-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Oct 2018 12:29:24 +0200
Message-ID: <CAMuHMdWc8qfzFdFeuJgJaTgSvws_AOBu4c9o91b=4FwMDYwPnw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Mon, Oct 1, 2018 at 3:10 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> The Renesas RZ/N1 device family PINCTRL node description.
>
> Based on a patch originally written by Michel Pollet at Renesas.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> v7:
>  - Revert changes in v6, and just remove the token pasting
>
> v6:
>  - Instead of combining the pin nr and func into a single element, use
>    a pair of 8-bit elements.

Thanks for the update!

I have replaced v5 with v7, after s/RZN1_MUX/RZN1_PINMUX/s for
consistency with other SoC families.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
