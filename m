Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27F32176F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ep1iuFX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeLUJzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:55:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44332 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeLUJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:55:23 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so3453921lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXYovhbry/kbeUtzDEBwEgohu7ga0irY9/zilVzuPDE=;
        b=ep1iuFX8bGn5G99fZUw53PK2hjRUlffOIPJanVR/pEF4/I9Ur4Vkozkb1H4ieKphGz
         8rqPGCpKV5qxFQ/+9I0NsTaRkKDtG7X3MMWi67F2pSsGVaiTJ8d9nFsgbfMMd95EfLWp
         ls0+xL0hhYrD1xiVK/pRQb9v4P+f9mbuathjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXYovhbry/kbeUtzDEBwEgohu7ga0irY9/zilVzuPDE=;
        b=suteO3Pd0fvXxXqRSdMcWBRjJlW8LthmRerSSNVNDeaNG5FgwcHokpNAjH7SrWXUib
         pTcWMCzf/0gbgR7OHMiC0dkhnVDEko3aw8BT0MvCyD878Ic+Zfyl0NccEbLvXOnB4F7m
         QEroA77Wn1PkX5nAdQIiC8jpzwze58JbNW52sfNk3iPJRUuzP3UcrMEpMTFl43YfCthy
         5RvjSIDlOSy7ougoBkRNCnLDRJR1KouiE6Q/myLYnpGkFayZNeQ8ZmaltPJHJLGbaaCK
         HRubuzpM1Phgeov9HeYqFpWnuFfCsYCtzdtbRsbza+eb75ZbcIfAlth0MTOmCfH9PWpU
         2CeA==
X-Gm-Message-State: AA+aEWb3zLGXK9/W/n1+s1p6UgJhljs98MwOgaajM9DkvupGqznskQkx
        ZfGLxwSZMjaPxWkQnn6PhAC90Yl/NAL6UrfbkE1Hnw==
X-Google-Smtp-Source: AFSGD/UFuzJTEEh9o8EA0tilG8FoAtJ6IVKV18qZthUnNmFo04uRLtTuWpxciJdlXsfJgq1NCzXKUfSdO5MtQdF9hJs=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr926538lfd.149.1545386121686;
 Fri, 21 Dec 2018 01:55:21 -0800 (PST)
MIME-Version: 1.0
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 10:55:09 +0100
Message-ID: <CACRpkdY+u0jiPNwbFR6pnaFm4VyXmw3q6JTBS+HNUniDuWaOXA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: atmel: describe SECUMOD usage as
 a GPIO controller
To:     Andrei.Stefanescu@microchip.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Cristian.Birsan@microchip.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:57 PM <Andrei.Stefanescu@microchip.com> wrote:

> This patch describes the Security Module's usage as a GPIO
> controller for its PIOBU pins. These pins have the special
> property of maintaining their voltage during suspend-to-mem.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
