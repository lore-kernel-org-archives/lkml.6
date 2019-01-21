Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E7EC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ABB2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSwUrFHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfAURwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:52:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33821 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:52:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so16235987otk.1;
        Mon, 21 Jan 2019 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXfBSW6STZiPEOQOAySNNO6egmxyHUG0Ck45uKgq8aE=;
        b=hSwUrFHNC2C3N83iNvEMIypUQmqOg4i9KjsB7o0dwYB452BDJqkP3bh9TRSSGF+26y
         EubaJJEeRbptkJ3rqrL/jTpLYnMqX/wJIExttuRgRI71z0Z48DJbmtqhEd5m0HAYYcHy
         Gji+B5ERinJbZDHGPzV4sZLhks/TdtB4UipDHt5jR5KmHXc2mxJoFqLm/ms8JMoCcjJj
         G2zO+r3MGmxQgQ302Qf82bIE2O0b27ADoGW5jDIXXQ89kLZM/vlwGYz+3Eth11lvwZEV
         gv5d8TJVKCy2n0CTR396UZECKIPYygAtHDIHTlLaWzyocyhFKweSfoA8tu/lPNCKT7lI
         Dq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXfBSW6STZiPEOQOAySNNO6egmxyHUG0Ck45uKgq8aE=;
        b=GB3fHLvwO55HqSVs6jJQU4yJgEWqi6M2f/jDN0NObd7Daoo6Cfs5v++l4ly6Txvobp
         YVeUH2jSpdb/s7z2/Ed/mFct70CWGKcRj3MfKjt92ja7HaogI10o2WJlNJyV+4V9Xf0u
         QuE/kV61goG7serLHRG/BC4TJMR0vcO33uBEM/q86gzEaaXnjjuLhHGrQn2QVHEQvS/t
         kRMK0v9TvsfSmEGQMEBrOPMg14NurM24jtZ/r7dWeXk9M5JCfwh6icW7JO3GtmskTKBI
         Bdltwvt7kOEGVvt/xGXrG3BtV+lTEPiYNROuF1w1G6iDUoNCO5BF8mA3xZQY4NF96y21
         M5rg==
X-Gm-Message-State: AJcUukemzOvPcmeA8ySCnTIpZ7LkMcWhKVJBrjXM2dMQ+rRjGF5IhpnV
        DqbMIGonC/GlsvNVDLubakCFBjm0cii4cfdyOnI=
X-Google-Smtp-Source: ALg8bN4YY5IAgha9fXVWtvsDMWlJLnqC3wQWt4cGDuT9QvT2KZMxHWw8kQ2OdAXnZusSROg+jR6M029dGSlkcV/97Sc=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr21200687otq.255.1548093140741;
 Mon, 21 Jan 2019 09:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20190121032109.10220-1-spinal.by@gmail.com>
In-Reply-To: <20190121032109.10220-1-spinal.by@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jan 2019 15:52:14 -0200
Message-ID: <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
To:     Arthur Demchenkov <spinal.by@gmail.com>
Cc:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 5:43 AM Arthur Demchenkov <spinal.by@gmail.com> wrote:
>
> Wrong polarity of card detect GPIO pin leads to the system not
> booting from external mmc, if the back cover of N900 is closed.
> When the cover is open the system boots fine.
>
> This wasn't noticed before, because of a bug, which was fixed
> by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
> CD and WP).
>
> Kernels up to 4.19 ignored the card detect GPIO from DT.

Signed-off-by tag is missing.
