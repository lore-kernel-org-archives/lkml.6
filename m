Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B59C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272782075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZE56inQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272782075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIFKwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:52:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34673 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIFKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:52:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so18498102ois.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 23:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RYX/byXU8cinHwy3eos7dv0zx9PA7s9+2xlGye6at0I=;
        b=ZE56inQCaVNEST4CTwPfCSq+VMELjQDUxIJbTI6pRRlAYSLwsRjIOUGaScquCgjDor
         IxC5JUwW97ys9SUp0ffplTVcg6udCJZjujDPt/9XJHyl8bVl5vWLPJp6/STD6FxsnKRv
         XIf3B3dn3cDayupnIcyCt++OIsPRR46uU31GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RYX/byXU8cinHwy3eos7dv0zx9PA7s9+2xlGye6at0I=;
        b=XIfbrZTo4FTdKVMB7+OYPrSsLNLUbPv2tt0fZf420LGumReKLy/GMOyBsgvOrDLX2i
         Ea1hcQPnSCcjdW3tVzOq03EsLZwDyMraCtW0CMAWuSyphsyE6y0fiECzNjfGYWRfenu4
         lVpNKlo/T6hbN2LDS38hGv2JgWx69+EULvnwcXT4jvKX+ljtWj+LhzLluCQL20UBwF0U
         nZ9R0Q2mUoTftffPHNeetzW4W3MzXI5vptKlqdXdrw4rB+fBBkfFgKMqQm1HgGXkniNe
         dYwXVjcWocIn9SLJPLARadfJvc/evkU7TPlvkFOAYS1FBAq56FZBd5EEJdwX8hl2Y4Uz
         4HJA==
X-Gm-Message-State: APzg51BvMCMB5U0iZDqGzWtB7zuMdO8t+B7IrGwHRZ6EOg5DG8op2A36
        HIx867BIZZfcP6dxDkaApyvRFe/FTbIazq3xnzpqEw==
X-Google-Smtp-Source: ANB0VdbkTsBqi5c8iIXX6KVkgB+hJn18WUi0yIPU9f4qLMHdRg4+qvnuqFCg19G51dZPUm2s8f2YKpNFf9969wvy1gc=
X-Received: by 2002:aca:e214:: with SMTP id z20-v6mr1383193oig.95.1536214694329;
 Wed, 05 Sep 2018 23:18:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6a05:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 23:18:13 -0700 (PDT)
In-Reply-To: <20180904044053.15425-9-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-9-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 6 Sep 2018 11:48:13 +0530
Message-ID: <CAMty3ZDn=uj3buvJx93R1J7Swr3CyfjJJ=MgQTGvRZ01izbAAA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 08/11] arm64: dts: allwinner: a64: Add
 display pipeline
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> Allwinner A64 have a display pipeline with 2 mixers/TCONs, the first
> TCON is connected to LCD and the second is to HDMI.
>
> The HDMI controller/PHY pair is similar to the one on H3/H5.
>
> Add all required device tree nodes of the display pipeline, including
> the TCON0 LCD one and the TCON1 HDMI one.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: refactor commit message and add 1st pipeline]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes for v4:
> - Misc fixes
> - Dropped second PLL from HDMI PHY clock

Why? it was there in previous versions.
