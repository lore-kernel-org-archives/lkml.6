Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CFC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079952;
	bh=3hbxqiFH8RfdHD3hO5L8LeoR1Pl2xXVjflRV6jG/bD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HV4Y4ZolNhPm1bNZ6Huusc1uJFOAmROeWpPbDq8/CObXcGrFDsCF/HHkRZpUrnKnl
	 Kd0EYwSYGLhtXIY9DPTO3ndEnOlioHYGyUr5hnVK3ie6+d9pf3+sn7fK/IpM/H46Q8
	 wt0ZNIgEEfAX13S38cITxcES3Br41QBJUhD5F6pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfAUOMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbfAUOM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:12:28 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F74214D8;
        Mon, 21 Jan 2019 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079947;
        bh=3hbxqiFH8RfdHD3hO5L8LeoR1Pl2xXVjflRV6jG/bD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tcmyc4+TjSwy35QbCNWIjjjiGQAQIZBPwPepsUquOPvEP+NnZB69HUrqP0Gq3YiY7
         nME12X7OMnCf71qLZ0SgD5KS8237FKDDpCSLf4oIsNjrESu2VgdhmjAf42/+Y+RxPw
         1QpIC0J8xqN9wVU9Cv6oBgjHm+p7Ww/EcmI7yX0o=
Received: by mail-qt1-f182.google.com with SMTP id t33so23645664qtt.4;
        Mon, 21 Jan 2019 06:12:26 -0800 (PST)
X-Gm-Message-State: AJcUukezM283PpyNA5/2Wm2j0I59+HtXzDfezWj9Mx7KXmyhk30x+Oou
        pb5MO/WnyBXFysJOCYxbtGfDmyFKNJ0w9t6g1g==
X-Google-Smtp-Source: ALg8bN7FDJ+jtdO3a1NZ12t3LOfP9YZ4JPXCj68lCQWN19tNwa4BMSxIdtXyDseyu+yZ+Mo+DDU/3mX4p2Q/uyCf3hw=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr25572780qve.246.1548079946201;
 Mon, 21 Jan 2019 06:12:26 -0800 (PST)
MIME-Version: 1.0
References: <1547830371-22122-1-git-send-email-guoren@kernel.org> <1547830371-22122-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1547830371-22122-2-git-send-email-guoren@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 08:12:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjQK-qViMm55EiP5hXjfr04++5vBTAXCEa6yg9u1qCaQ@mail.gmail.com>
Message-ID: <CAL_JsqKjQK-qViMm55EiP5hXjfr04++5vBTAXCEa6yg9u1qCaQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: interrupt-controller: Update csky mpintc
To:     guoren@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:53 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Add trigger type and priority setting for csky,mpintc.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt  | 33 +++++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> index ab921f1..badbd38 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> @@ -6,11 +6,18 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
>  SMP soc, and it also could be used in non-SMP system.
>
>  Interrupt number definition:
> -
>    0-15  : software irq, and we use 15 as our IPI_IRQ.
>   16-31  : private  irq, and we use 16 as the co-processor timer.
>   31-1024: common irq for soc ip.
>
> +Interrupt triger mode:
> + IRQ_TYPE_LEVEL_HIGH (default)
> + IRQ_TYPE_LEVEL_LOW
> + IRQ_TYPE_EDGE_RISING
> + IRQ_TYPE_EDGE_FALLING
> +
> +Interrupt priority range: 0-255
> +
>  =============================
>  intc node bindings definition
>  =============================
> @@ -26,15 +33,33 @@ intc node bindings definition
>         - #interrupt-cells
>                 Usage: required
>                 Value type: <u32>
> -               Definition: must be <1>
> +               Definition: could be <1> or <2> or <3>

For a given controller, '#interrupt-cells' shouldn't really be
variable. If there are different capabilities, then you should have
different compatible strings.

Rob
