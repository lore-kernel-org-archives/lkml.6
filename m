Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kPGjA0JmGVuXDQAAmS7hNA
	; Thu, 07 Jun 2018 17:07:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9A5046089E; Thu,  7 Jun 2018 17:07:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyPrZcqg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EB8260590;
	Thu,  7 Jun 2018 17:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EB8260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933246AbeFGRHy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:07:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39841 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932609AbeFGRHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:07:51 -0400
Received: by mail-oi0-f65.google.com with SMTP id t22-v6so9297592oih.6;
        Thu, 07 Jun 2018 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y1RsjnLjby4Eqik7xxvBqZDtpZ5upwG00JxIDEsmRr8=;
        b=eyPrZcqgDPBtT8W3YIJx0Lb6qLuYBqeBV6BhN/SVu1EEvq1VtRwg6UDAlRVIbWnBDd
         wM/BK+VR3WcUwrPFVyaeNo0lZDn9HTNTA39ge76r0dOUw9ZpZnzFX3pOR9o8fLmuCc8W
         dutNwsgf4+t58DZ7NxtlUBt2G5j/79u324SMROWhK5JPxM+ckdmrtbq1hjG0LHhsiJpz
         DtN4tBHNbHMPlxj5hok2wuPsPJVCMY+07SY2zrrE+GPCgm+v2qGMilksU8oPzZXnBazD
         9SPLVH9tE3tOdBT5DVFeoNjEmOVvO0xgS6srZhqzxYHBdr4BPdxcGjqHQ3300+SSEwvR
         zLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y1RsjnLjby4Eqik7xxvBqZDtpZ5upwG00JxIDEsmRr8=;
        b=Vp3LQOExX1QZszG536uRVyHNd2/1A2HZbbIpIddo6+DWyKnLigmcj1KPZphxi/TUeY
         piyh029kImOaKBtq3x0Ra8TEZqq/EztRwI7McDKQhNOL3xWZO1fho+hinPiCFSoFv4zX
         dUnbkytj5j4/RQ34bsE65uvjdETryh5vWPbVlefayJDscnyWS2oDEpA1vwhV8IxsdeQn
         HT0oSoBEkglkfauKU5ygg+Chu46sDnTwrLWy+Q5M84HaEsE73a6xQgkBTQH3w2pYofQ1
         KUjjwq92PLs8twqY7KbBK6/lBLv4kIHhMbVuec/YPjxqCm27VuLbTMJ6a6hBbUZnEH62
         z6ag==
X-Gm-Message-State: APt69E19u7WHjk3oWoxZhAAaELdU2xX8AGOM/cjAwa4L/Bb7+80aNpL7
        RVavh6FZI/1kAE32N16Vby18E2AaB+OmIwilxVA=
X-Google-Smtp-Source: ADUXVKIzd4P0CUnCP0mCz/6eFOzc+PYAj6sVyKNgci3FrbEYqVLmxdessr333tTiRvJE5bdJonyyjKHRXtvG6AtrNWk=
X-Received: by 2002:aca:f244:: with SMTP id q65-v6mr1457235oih.71.1528391270704;
 Thu, 07 Jun 2018 10:07:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:07:50 -0700 (PDT)
In-Reply-To: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
References: <b31ca3ff50566c193003614d0bbf5e0a0e95901c.1528390418.git.leonard.crestez@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Jun 2018 14:07:50 -0300
Message-ID: <CAOMZO5Czf1bO7vJZ1UG46DyVhzApqS82GFw+NFm_HN5tjD=xoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Thu, Jun 7, 2018 at 2:00 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

> +
> +                       isl29023@44 {

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

So you could write:

light-sensor@44


> +                               compatible = "isil,isl29023";
> +                               reg = <0x44>;
> +                               interrupt-parent = <&gpio5>;
> +                               interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> +                       };
> +
> +                       mag3110@0e {

No leading zero in unit address, please.

Building with W=1 will give you warnings about it.

magnetometer@e

> +                               compatible = "fsl,mag3110";
> +                               reg = <0x0e>;
> +                               interrupt-parent = <&gpio2>;
> +                               interrupts = <29 IRQ_TYPE_EDGE_RISING>;
> +                       };
> +
> +                       mma8451@1c {

accelerometer@1c
