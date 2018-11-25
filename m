Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F54E2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F54E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeKZI13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:27:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45627 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKZI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:27:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so15519228qtr.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDbzWaQjB9pxowCq+mjTMm2t9odY0nIx5d3P3NyyhS0=;
        b=keKU1lw1m3DNLOnTLAClColbua/qzLt3UVaL+X22j1/5wF7MXLtD90cLtZIDvWyX/c
         l2el5UKZgp2sevwxrpdjOHlhzB2off63/d3OS4WiOkav6K8wZtHCngnI7vS3I5FfnHxh
         FO+5fQcj3veoYOnrr173dPb0m4M34ANBO85ZwphVr7i+1UFBFOKnwZqBW/GE4cvBcSyj
         rkmLg8ACS5JYoenpr/bfKQnd4KkHMA01bt1K4YTrNQtl7f8GyEdAXOVk5KhRC3yFep5A
         bm+3CBRJUhA9GWkb6iZnSvzRdC8OdAVFLqQqkWbPwGYrozqn/3dajRr2BhiX4+/0nJvQ
         x3bw==
X-Gm-Message-State: AA+aEWaieEfsKY5nkxkPdpLx9jN4/DmdUpVYEHqvNRrBJakWZ9EJk47g
        qlEmo9BVcvj7rlbRVn+5I29QmJ6eOxkX9Hx5LAY=
X-Google-Smtp-Source: AFSGD/V6sxgYDz0aL9pe9gEe7+3I108v+2CUsuJEwrA53I+KzRfP/1FBbcqh6uLctXwDs9vck0AG+E5j7bJs9bhGo4o=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr22687827qvl.180.1543181726543;
 Sun, 25 Nov 2018 13:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20181125212159.11590-1-otavio@ossystems.com.br>
In-Reply-To: <20181125212159.11590-1-otavio@ossystems.com.br>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 25 Nov 2018 22:35:10 +0100
Message-ID: <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
To:     otavio@ossystems.com.br
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:24 PM Otavio Salvador
<otavio@ossystems.com.br> wrote:
>
> CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> selected by the Kconfig logic.  This is done in preparation to making
> further changes to this defconfig cleaner.
>

Does this mean we no longer get the unwinder, or there is some other
config (which?) that unconditionally selects it?

      Arnd
