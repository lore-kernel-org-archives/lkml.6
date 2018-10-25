Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83152C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A35820831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBPaSAKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A35820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJYVlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:41:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33530 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:41:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id c25-v6so1238096oiy.0;
        Thu, 25 Oct 2018 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boyr0oJ/cxzgjz8AFLV0aKaBeN4jgWu3CvWLEH5OVDs=;
        b=KBPaSAKtwq96jKvVtlZCvqQpfchLCJgGQp5Ik0guMoJ6qpAKBAg0bdt4vz3sphdxAU
         j3jVirtPVjNcZwrAEaRFV3OXH5ZjZcpNd6kY/Z0XecxR8HOXqcZmvNY+W6X8xEQ07gTh
         Nx82geUR3Y1kWanIVvI6YRb0uFz5tgKgd9qOfXRGbZ9xe42KUnTiUSXg1rM1/PSiq84m
         k1KPtz/t2ba6wVgYLhtsPYNuR8DCfY8bF0UOInumVD8/Ru5PkYtGgZIB/VaeDj+pUrdz
         iSXfx2emnmhpWlu+hnTSzLAEYUjpaQt1eRFoaD/QpmEfdBCIFkmxvxDUGN9jl3rGzld8
         AMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boyr0oJ/cxzgjz8AFLV0aKaBeN4jgWu3CvWLEH5OVDs=;
        b=M7o5w/uzgcWuxUvjQ3QdSKkplMdN0Ljq7BDpLi4js5W2xtu2LRmvwRitsUWY6S33LK
         moMH1K0VD6RCWx8KsQIFpCY1h7qnzqm4zDX5BsfPViDtmnWcyJ9zRZ6dzlxlWKIl8aKx
         z3nPHprAFYDuafpnzRv4/fO3FZLqAcDBw4+CJh9kHOfxTDHHwFO5pQ6hfx1hs2I1ebKy
         P7hprK6J3BgYXObh732tXmL4sPW43a/VmqiEd+1Zmfhhawrz3ejZoQ7v2dfXdj6jtyth
         M90NCbUpobipWYPPoR3TcmrcT2U/PynnLySXOPVMaRjK5ym4K+sqCHbOz8tLKSQ1/hFi
         56kw==
X-Gm-Message-State: AGRZ1gKA1PTqEv8RgNpvcVfJ95W7fTH4pMc4ZsT6cCztVi3ZGrn0J2ur
        fGCeljWRk40Z2Vi/KuTbYX1HEeuZW0Z6QAwFAeM=
X-Google-Smtp-Source: AJdET5cUWMaiwQO3QzybhGuT7Lvg78Bp8BYR0tDh5kXuKP7Yfuce7Z4WWaPwuWiIXykcTiKfFhIqM+eYjpOolnUcS4k=
X-Received: by 2002:aca:4d14:: with SMTP id a20-v6mr399355oib.43.1540472934671;
 Thu, 25 Oct 2018 06:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Oct 2018 10:08:53 -0300
Message-ID: <CAOMZO5CPPk6nqQdZ8KfXd=+B5m5R_hoOvz6pfPnR4kWeYkG2OQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB controllers
To:     frieder.schrempf@kontron.de
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 5:00 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Some SOCs in the i.MX6 family have a USB host controller that is
> only capable of the HSIC interface and has no on-board PHY.
>
> To be able to use these controllers, we need to add "usb-nop-xceiv"
> dummy PHYs.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
