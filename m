Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C22C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C084F25B7B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GG5iBZtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C084F25B7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965775AbeF0Vkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:40:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34454 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeF0Vkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:40:36 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so3431526wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKf9+SOcwKLR+kikWTZNfA5f848WCMpG3Dn0bi37xw8=;
        b=GG5iBZtCpzfJd/xw9pZqnqTcAGfLqNk96dhPqrKJybnWkRRNqIXbrk6vOEEOgeedP0
         Mup5Uf5kLc1dhVo5rCWMBBbQJ/Tx+2KCW5R7FLL3XplaRJ8X386id1u89di1yYZNr+FF
         5tacxaaixs8FPEF1MDrNDdmcjipWVXdjHDcK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKf9+SOcwKLR+kikWTZNfA5f848WCMpG3Dn0bi37xw8=;
        b=nE565gmpz8wYGwwYbaTIgOSN7aT39phSvtS89ywFGocRgYrItU6/Lsi/g+6/Oasd6x
         h0ialwKs81ZnSLe+RB0ECcJ/yVKT+6BF3uP9JPn3marQ35J+1QnRqk+Q85AlpxN1ealM
         ROhvwLSQMGfW2vqHFaQjydnk/Ar/c9PEo6q1KEiRf465+xRs3/zsylMMuoMmq570wzpE
         SLq91UxnchYzluaFxOmVfvhV30byPORkkhkgvsKwoIqKZptIQezNyXHzAR11SuBaf3h8
         liet7hjAsP0kvsIU7WgWfhd3MemAZpQnwwzqyOgGmU8HcnAlili87idJ9Fpyk2n9o4qp
         181g==
X-Gm-Message-State: APt69E11nCBayMQ4M2CnZKXi/ZhIYZ69GViugSAiQxa9r1137Uy2Fpb6
        sJi72ZgG7KC5NGUVKayi9jCgA+/aGClo4dM9JkXXGg==
X-Google-Smtp-Source: AAOMgpeekXfjW9oM6cAx7G/qw/wNT33sfUuz2aYmVZCote8xfF87LfEp7kwBPWTJrliJwJnelXXFNqghTh7uGPULI4Y=
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr6799542wrh.267.1530135635348;
 Wed, 27 Jun 2018 14:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180627194124.26366-1-robert.jarzmik@free.fr> <20180627194124.26366-2-robert.jarzmik@free.fr>
In-Reply-To: <20180627194124.26366-2-robert.jarzmik@free.fr>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Wed, 27 Jun 2018 15:40:23 -0600
Message-ID: <CABGGisxeC=1Lc+ZKpR=Uzy75BQ8k=Tah4cYmZDnc_mdJWiCD1w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: pxa: fix the rtc controller
To:     robert.jarzmik@free.fr
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 1:41 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> The RTC controller is fed by an external fixed 32kHz clock. Yet the
> driver wants to acquire this clock, even though it doesn't make any use
> of it, ie. doesn't get the rate to make calculation.
>
> Therefore, use the exported 32.768kHz clock in the PXA clock tree to
> make the driver happy and working.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: change the dummy clock by the actual 32.768kHz
> Since v3: remove spurious bracket
> ---
>  arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
>  arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
