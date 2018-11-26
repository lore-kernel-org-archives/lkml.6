Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4652D20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yull3VtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4652D20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeK0Ghn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbeK0Ghm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:37:42 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC6020989;
        Mon, 26 Nov 2018 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543261352;
        bh=6D2Oo/Y4c7eGJqzbWVmaMhNUpIHL4jhrZN7C8DrhY8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yull3VtGovYoC8yWWVSj4NUwWGEpBuGyYg3qN3rZNbSukfZq/hE9ZmIldeqnLe6i4
         2yp6Jz9YNVqlKpAz4DLMQt1IeVR6FfPV++9nqYOHyV+XzA55cKhKG3sbPKKK1EpfxS
         GmTH7KZq33HrQ7glkMKfUQrXACc0ozLITqw/rJpw=
Received: by mail-qt1-f179.google.com with SMTP id n21so19018696qtl.6;
        Mon, 26 Nov 2018 11:42:32 -0800 (PST)
X-Gm-Message-State: AA+aEWatNgQSsdU622o63YhCISJd435UeyQiag4ya8T+kxW8B1NFrZAN
        qddIN+IE4/QIzkJ62dPwEDOnqMBhIFtXHlqEmg==
X-Google-Smtp-Source: AFSGD/X13EZKbaPMY+Toi7putoCa+E+fSRcCNgR35vZAlBrkxGiSzLldx78B+RqDLbnP6O6Du93poXzY+eXgwEJd0uk=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr28408623qvl.77.1543261351649;
 Mon, 26 Nov 2018 11:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20181122094602.5156-1-tom@aussec.com> <20181122094602.5156-2-tom@aussec.com>
 <20181122094602.5156-3-tom@aussec.com> <20181122094602.5156-4-tom@aussec.com>
In-Reply-To: <20181122094602.5156-4-tom@aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Nov 2018 13:42:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6fM3+pcC3b-eXEex=j_ft6Z=vukhLK9wULfWJqOTN-A@mail.gmail.com>
Message-ID: <CAL_JsqJ6fM3+pcC3b-eXEex=j_ft6Z=vukhLK9wULfWJqOTN-A@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] dt-bindings: pps: pps-gpio PPS ECHO implementation
To:     Tom Burkart <tom@aussec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, lukas@fridolin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:49 AM Tom Burkart <tom@aussec.com> wrote:
>
> This patch implements the device tree changes required for the pps
> echo functionality for pps-gpio, that sysfs claims is available
> already.
>
> This patch was originally written by Lukas Senger as part of a masters
> thesis project and modified for inclusion into the linux kernel by Tom
> Burkart.
>
> Signed-off-by: Lukas Senger <lukas@fridolin.com>
> Signed-off-by: Tom Burkart <tom@aussec.com>
> ---
>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> index 1155d49c2699..e09f6f2405c5 100644
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> @@ -7,10 +7,15 @@ Required properties:
>  - compatible: should be "pps-gpio"
>  - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
>
> +Additional required properties for the PPS ECHO functionality:
> +- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
> +- echo-active-ms: duration in ms of the active portion of the echo pulse
> +
>  Optional properties:
>  - assert-falling-edge: when present, assert is indicated by a falling edge
>                         (instead of by a rising edge)
>  - capture-clear: when present, also capture the PPS clear event
> +- invert-pps-echo: when present, invert the PPS ECHO pulse

Why do you need this? Can't you just make the echo gpio GPIO_ACTIVE_LOW?

BTW, using the flag probably should have been done for
'assert-falling-edge' as well.

Rob
