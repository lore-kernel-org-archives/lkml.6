Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFF1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D7121773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxuWjM/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBKVec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:34:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32838 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfBKVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:34:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so829448otl.0;
        Mon, 11 Feb 2019 13:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHCvldYD0BzLfpY4nxhOH+w+R+Gn3IuDB620WQL49ls=;
        b=AxuWjM/7pHcN0Rif+J9myATOkYNB6dH+89qIsVs2wJoWNyaUA42ZQUttMd1khzeifb
         K9v+qLMEBIduS3rNFuL0aaJ0YzcI8C8joWy/zGDaus2GQWG67sHd10bkgvdNCblzSRdQ
         ztHsTCZnuVw7rU01blHWIrZria1+agMFDgsUllpttPQudgj/9VMXbCKk0HKF6NnS79uL
         7VUjcSxu6ZbXs+xi/FixmIt7JhAsdRFbYalaFVf38iTevvmBe2y57xVAnpbiLsgJFF8f
         hoP1d6oZLZq3Sc9//mDfyAbvhd36xoSNBP4l8wemGm6LjsmYos3i9h21W9F7T+yqb0f3
         McGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHCvldYD0BzLfpY4nxhOH+w+R+Gn3IuDB620WQL49ls=;
        b=RfzW+JPIuhaolFPt9N0cdUQlqrV8kWr/mhAG+gA5g9nzM2oThxAd9opH5J/mV6G7Xf
         mQDMdKY6E6ZwTMYl1pQydLQLd3JCT2+6aqmByuPsQiI6XNqpLyh+JT1CSEzw24DKIVhW
         6oikMeb2QGqLI2CJzZHlYFc9eqkHPao0gwbauXsKfok62gtK8HMSTaOT/+V5BU28I5mH
         saskSPQM3s3CYRIDfmAN5MTlBXkbgzY/TTlAEWthvQH00F+o9xWyJ4oLfu1KPA2epRaC
         FNwgnHg5SexL8zbP3Q9fSsaFoui/Y2Po6o25edluXBF5PvWfrW8boqoohu/xGLZo+JEK
         /Ykw==
X-Gm-Message-State: AHQUAuaKyzlaf2MfSmAyDHPjZGgP3tF4a8mQA7R8F9V5TR/oktE25UD6
        hx83zf+flMd8iqTCl0c9ItMpqRh3qWdrt02mvuw=
X-Google-Smtp-Source: AHgI3IaPWx04d6vXqqvrebKNmFPbU/FKyoqA7w5QwzEfG31LFlUoQ9T2OhxUIBzYmlmrx77oKXqtWypfi6pFriQRNbA=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr348098otj.228.1549920871129;
 Mon, 11 Feb 2019 13:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20190107132226.16216-1-stefan@agner.ch> <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon> <1549916056.3075.102.camel@impinj.com>
In-Reply-To: <1549916056.3075.102.camel@impinj.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Feb 2019 19:34:19 -0200
Message-ID: <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trent,

On Mon, Feb 11, 2019 at 6:44 PM Trent Piepho <tpiepho@impinj.com> wrote:

> I've had more time to test.
>
> Without DMA, I can reload my FPGA hundreds of times and get days of
> uptime using linux-next.
>
> With DMA, loading is unreliable.  The higher the SPI speed, the less
> reliable it is.  Unfortunately, it's hard to duplicate the problem with
> a small amount of data, and with a large amount of data I can't examine
> it in depth enough to determine if the problem is related to SPI bus
> timing or IMX sDMA sending the wrong bytes to the spi controller.
>
> Using DMA with SPI causes kernel panics.  Not always immediately, but
> after using DMA it's a smaller of minutes before something crashes.
> The backtraces are all over the place and don't usually point back into
> SPI.  It does seem like they usually hit something has allocated or is
> allocating DMA memory.

Did you test with an external SDMA firmware or with the ROM SDMA firmware?

Just trying to understand if the SDMA firmware plays a role on this
behavior or not.
