Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C16C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC02086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxy8NG14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFC02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeIJUQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbeIJUQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:16:38 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A262088E;
        Mon, 10 Sep 2018 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536592923;
        bh=bFHWoKVEm3ZGwpuHiEtzyinbwNTlvpJOwpjDs6Ah4I8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pxy8NG141GnwbPf4lg//lYDEkhJByrr8qiGWM/IqFDbWATGAkvGxYHLQOez3agPRx
         50UQrv4lT4/g0NYz7vxSlhw9dNxE/5kpO4sxngqHfTInan7LOQxvIildTgsDJNStSs
         R38feHdc/SRA7Gfi5t88oxzvs4gBoqmJiiKGohkM=
Received: by mail-qt0-f180.google.com with SMTP id x7-v6so24559485qtk.5;
        Mon, 10 Sep 2018 08:22:03 -0700 (PDT)
X-Gm-Message-State: APzg51AUGU1blyiqsTxAQLgMeP8JJPBP38JJDXSXS5ODjqd2YARIDsFM
        PCSWvbUt2usNj72hG4rq1ixLkf7lQjvxTgQcRQ==
X-Google-Smtp-Source: ANB0Vdaju3GpY3DLSVOEwqaOcYrp+Lo/ySN8xTGbmjVJXKKMLb6HHkUu+P7FBv1KenxZbuzGjrRFs0HEtgiS1ythVPE=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr15044219qvk.90.1536592922305;
 Mon, 10 Sep 2018 08:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180910113031.42634-1-lkundrak@v3.sk> <20180910113031.42634-2-lkundrak@v3.sk>
In-Reply-To: <20180910113031.42634-2-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Sep 2018 10:21:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKgJFZnpuv7rW6ovxMKi4Q2AngWxKa=CMR_Y+xD5Oh3GA@mail.gmail.com>
Message-ID: <CAL_JsqKgJFZnpuv7rW6ovxMKi4Q2AngWxKa=CMR_Y+xD5Oh3GA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mrvl,mmp-timer: add clock
To:     lkundrak@v3.sk
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 6:30 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> index 9a6e251462e7..a2ede0bd12ca 100644
> --- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> @@ -4,10 +4,12 @@ Required properties:
>  - compatible : Should be "mrvl,mmp-timer".
>  - reg : Address and length of the register set of timer controller.
>  - interrupts : Should be the interrupt number.
> +- clocks : Should contain a single entry describing the clock input.

So now pxa910 and pxa168 dts files have errors because they are
missing a required clock. Plus somehow other MMP2 platforms either
worked without a clock or have been broken.

You can't add new required properties to a binding. That breaks
backward compatibility.

Rob
>
>  Example:
>         timer0: timer@d4014000 {
>                 compatible = "mrvl,mmp-timer";
>                 reg = <0xd4014000 0x100>;
>                 interrupts = <13>;
> +               clocks = <&coreclk 2>;
>         };
> --
> 2.17.1
>
