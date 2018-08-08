Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437B621742
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO5/lK8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437B621742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeHHOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:22:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34665 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:22:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id n96-v6so1405493lfi.1;
        Wed, 08 Aug 2018 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkQV6ERRhHujLJXQax25AFjbXf+F01rk5+esUtAbI9w=;
        b=rO5/lK8VtY0vqqE/inKmrQHdAgEv3RQD6BXzxCa7dnyaLJYqrsdKfpZE4xZab/yWcS
         oBf+TCXEX1xZJbkDQr+iUM8uwaTs8h8i3wo0i6Fat6ZswL1twtx8n3g8rTWgiGWXtlEQ
         X+zMrjJ7TQBB2S8pH/wj5O+hlrF8F8C0AG0v/5pcKYr5MJ3By+iPSoUZ9Raz5mXNtjz+
         9Kxrt7Ah8h3885bPMnCLouxe1qtJ0GRCNVfAB5zqPc76clgH0Y7ToCy45M8YbYInKCNf
         lLErMCPPPS41xT/bF8dlOJbNxA17TWafQ/D+woHnoqWs6rCMlcbX3ZlZX16LXXuG31a9
         CD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkQV6ERRhHujLJXQax25AFjbXf+F01rk5+esUtAbI9w=;
        b=slVD7WkPXESDMn+G28NvilUSrRYA/QjXFkxgFIFs3M7WjXyMGCrL22Zsi7rKx5AylD
         iqZLK7Bcxasg9yqRMC/sKGxf3gpPXCnlvGLk2vCixQR8x2DtcmAgz8/6Jmc03cfnxHWF
         lSXKjkbjVgUinTgqMTUyJuchbCU+TT7gp8zvZIFugDQ0MnZTITq6PfINrjnT2jglXR4y
         l/Iv9PFeGH0nqczlOCw2lItTNTzMzPT8zJgGTwZRwqpHoDYZnVwu0ye4hMS7ukLKky2A
         KF4JiNfakyO+ze1ZzLIdOFYOcPrjjZ8mnnNSVq7hjlHd1GXt44zgUlGr6QwM6qcG5v+I
         bF3g==
X-Gm-Message-State: AOUpUlGGJ1hsGXux7qonRgQXhfN9Ao1ufKKtn/JOx494DjwcuufGmogj
        RmNE2LEzUW2zY8aMLXCQGZbJq2cNDQmz377vZIs=
X-Google-Smtp-Source: AA+uWPyDjZRBRGeRHFToqTJseqHREA9Wy0lzOiKXZgCbX+pnFkJLD9C3giX4hZlfS8vPS14aycfEnJBnPL2oYOFOFr4=
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr1890525lfq.113.1533729793437;
 Wed, 08 Aug 2018 05:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180808090944.861-1-simon.k.r.goldschmidt@gmail.com> <f27a5e90-9783-761e-a87b-9b8a2d46d2a4@denx.de>
In-Reply-To: <f27a5e90-9783-761e-a87b-9b8a2d46d2a4@denx.de>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Wed, 8 Aug 2018 14:02:44 +0200
Message-ID: <CAAh8qsyHxMjwBtBa5pYejkOxwFRbbFbt+myC4ynQQonK8MAo-w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: socfpga: use stdout-path for chosen node
To:     Marek Vasut <marex@denx.de>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 1:32 PM Marek Vasut <marex@denx.de> wrote:
>
> On 08/08/2018 11:09 AM, Simon Goldschmidt wrote:
> > Use stdout-path dts property for kernel console.
> >
> > There were two socfpga boards left not using stdout-path:
> > socrates and vining. Make sure they match the other boards.
> >
> > Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > ---
> >  arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 3 ++-
> >  arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> > index 53bf99eef66d..6f5255a7d192 100644
> > --- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> > +++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
> > @@ -22,7 +22,8 @@
> >       compatible = "ebv,socrates", "altr,socfpga-cyclone5", "altr,socfpga";
> >
> >       chosen {
> > -             bootargs = "console=ttyS0,115200";
> > +             bootargs = "earlyprintk";
> > +             stdout-path = "serial0:115200n8";
> >       };
> >
> >       memory@0 {
> > diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> > index f50b19447de6..e61efe16e79c 100644
> > --- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> > +++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
> > @@ -54,7 +54,8 @@
> >       compatible = "samtec,vining", "altr,socfpga-cyclone5", "altr,socfpga";
> >
> >       chosen {
> > -             bootargs = "console=ttyS0,115200";
> > +             bootargs = "earlyprintk";
>
> Why this earlyprintk ?

The reason is Dinh added that to all socfpga boards in his commit [1]
and I wanted the remaining two boards to be the same.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts?h=v4.17.13&id=efc1985c8f79ee8259d19a9b6e3df6a07d063669

Best Regards,
Simon

>
> > +             stdout-path = "serial0:115200n8";
> >       };
> >
> >       memory@0 {
> >
>
>
> --
> Best regards,
> Marek Vasut
