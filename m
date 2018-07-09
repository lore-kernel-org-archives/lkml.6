Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB258C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3222087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFD41h8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3222087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbeGIOCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:02:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37753 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeGIOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:02:13 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so17149223ioh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1IuO4WCIRDitDqsmzWW12AsWICW231kbBo8P7TiiIU=;
        b=RFD41h8xbBGbWEDOeFsaf8nqS69jKd4JqkNCdjMWXfXt9j1Y03/weXeXkHi7rAKa+N
         9pFniUiyA/v1uUeZXQu6HRbQSR1R13fpP+ryUrTA2vT6B8qLYW6KxzmyhycwWzsCLXsl
         0/5LtvDSNG/gWRV1u6dvsnWwNkaBawIA+bsdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1IuO4WCIRDitDqsmzWW12AsWICW231kbBo8P7TiiIU=;
        b=SXHrfR+ZaHg4FYuzQqM1WGf/wBv6Wj2adR+thjwGHkdFSc2UBnbUyimjTGpavohiFG
         NpLuKkrY0rsrAKTknl/9LylgZGBpYblQsyaXxEV1IAfiMhr4d50gQuQN9OdhEUkAqEMp
         NQKZbvDsPJxr8AZRAlXt5b5W8Ce16t65BfSJ/yyG+4m+OfkQz8yHXVswWFbIw7GCytUV
         Dqk1URY52M3kPYfC4Rrg+PB3ATA2jc0tu1HLlXWYILSWIg1dewrZ2fsb7N1Stb6YlzMc
         ZMG0Bk06T7b3UgIS54MwRy+2ryr3eUyCT9b9GTMp41ynYn3gbZFeqoCtJ6xmU8/11Ecj
         Q1PQ==
X-Gm-Message-State: AOUpUlHl2MOVtJnT4LTrHWp8ZrtaOBOQjQoJaCVfTrnkok1QLhwr8HLt
        HCd4wv9xEO4+AmdUaSGCrkB1yjv+7p+QEb+bVerXCw==
X-Google-Smtp-Source: AAOMgpdKz0ect04VBfO9nm1mMDE94dWh9suf3YNpYN9VwAnHhehIDyGWNh/oLPjEWy7euAiU8YKWccXn7ygkQsuocf4=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr16680644iof.304.1531144932760;
 Mon, 09 Jul 2018 07:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <1530532746-619-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1530532746-619-1-git-send-email-abel.vesa@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 16:02:00 +0200
Message-ID: <CACRpkdb=0uR4uYF_N8HcySJGPct6q5zT+fd6ZfnMqS4OCT_=GA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] pinctrl: imx: Add driver for i.MX8MQ
To:     abel.vesa@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Stefan Agner <stefan@agner.ch>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        abelvesa@linux.com, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 1:59 PM Abel Vesa <abel.vesa@nxp.com> wrote:

> This is the sixth version for the patch series sent by Lucas.
>
> https://www.spinics.net/lists/devicetree/msg212752.html
>
> Fifth version can be found here:
>
> https://lkml.org/lkml/2018/6/22/501
>
> Changes since v5:
>  * implemented Rob's review comments related to bindings

Can I get some review tag from one of the listed maintainers so
we can proceed with Abel's patches? It all looks fine to me.

PIN CONTROLLER - FREESCALE
M:      Dong Aisheng <aisheng.dong@nxp.com>
M:      Fabio Estevam <festevam@gmail.com>
M:      Shawn Guo <shawnguo@kernel.org>
M:      Stefan Agner <stefan@agner.ch>
R:      Pengutronix Kernel Team <kernel@pengutronix.de>
L:      linux-gpio@vger.kernel.org
S:      Maintained
F:      drivers/pinctrl/freescale/
F:      Documentation/devicetree/bindings/pinctrl/fsl,*

Yours,
Linus Walleij
