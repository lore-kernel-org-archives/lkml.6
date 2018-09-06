Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80192C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306B52083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPhghl3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeIFFUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:20:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35863 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeIFFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:20:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so9503796wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/94KpfrApopehYa44oy06KYLaW2mUujUF2XnIayISw=;
        b=LPhghl3DGCpDiOJ+k00a+L2108ZMhdmAZ7Bu0XZjZZ6Odb2wg+fIRuSR1nzdnxBIaE
         CjeoaE0GvYOFqQhm/I6nsTadyxrLiLQfI36efNKZH3ATIPdkuQeSq2T4/SYz5mIM5COM
         fOoa5sRjCWUP1AxOnWebdGJScS3Isov7adDOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/94KpfrApopehYa44oy06KYLaW2mUujUF2XnIayISw=;
        b=eaHe6j2VWgSIImXQcMSKVUEsNQ4Htqqx3XF/NaKVlRWRtP9fkAxhfLvFaap6TsEf2m
         jXA9gSEJBns9Qx7geaCwlqEx9hMlwbqZlNNz83XYiA5qoLHS5pYJDqgufb423DbeUoLb
         iv9T+L9J4yRMAdu33eqUvO5G1TQENRKTB/AZwzogz9ykSjzT4SbbveGUgzr55mx29o6R
         TZk7oVeqL/w2IXNZ6RU80bT+gddERFy3tsPZhJ2EOBz3L/DSL//HOKgA2DT+cpSrRwF4
         4DK+BZ7tvQXCcr0bZCh9a3D4kbFLu4z5eiOHbxTSVlb1FnNpgkxjFoT/UGutEqFilTPJ
         E7XA==
X-Gm-Message-State: APzg51C75Bmk+we9fvI2o8pcHRA86XKzyH4LAV1QXF/OXNEvJywAqSGK
        SvGZzK2Bb5el9v46XA5XIzBDScsFmVjBvvBgr3JmnQ==
X-Google-Smtp-Source: ANB0VdaC+v1ZwYHX4p5NbdJtAKcAL+zB2vMQoaCa9kAt1K9fK2cTqRTcPM5E4QwNDCCBKr5WDrcxH/8srn9VxxU9Aho=
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr520496wmg.123.1536194860638;
 Wed, 05 Sep 2018 17:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Wed, 5 Sep 2018 19:47:29 -0500
Message-ID: <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
Subject: Re: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
To:     ren_guo@c-sky.com
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> new file mode 100644
> index 0000000..1136d9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> @@ -0,0 +1,46 @@
> +=================
> +gx6605s SOC Timer
> +=================
> +
> +The timer is used in gx6605s soc as system timer and the driver
> +contain clk event and clk source.
> +
> +==============================
> +timer node bindings definition
> +==============================
> +
> +        Description: Describes gx6605s SOC timer
> +
> +        PROPERTIES
> +
> +        - compatible
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,gx6605s"

-timer?

> +       - reg
> +               Usage: required
> +               Value type: <u32 u32>
> +               Definition: <phyaddr size> in soc from cpu view
> +       - clocks
> +               Usage: required
> +               Value type: <node>

phandle + clock specifier cells

> +               Definition: must be input clk node
> +        - interrupt
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be timer irq num defined by soc
> +        - interrupt-parent:

This is implied. Don't need to document it here.

> +                Usage: required
> +               Value type: <node>
> +                Definition: must be interrupt controller node
> +
> +Examples:
> +---------
> +
> +       timer:timer {

Needs a unit-address.

> +               compatible = "csky,gx6605s-timer";
> +               reg = <0x0020a000 0x400>;
> +               clocks = <&dummy_apb_clk>;
> +               interrupts = <10>;
> +               interrupt-parent = <&intc>;
> +       };
> --
> 2.7.4
>
