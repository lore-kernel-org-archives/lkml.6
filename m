Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D045BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969B920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542160;
	bh=AtUMkIE4IETPqnqTkclVVj9L1zrkVt/67Wobo+vfbpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Q38f2YANY6MdMJO79ivrtizBYcQuwNGVolwt4TCi0Of8iWDBB4hpQ3GC1KBMPLkv
	 9ymv1QWoCgyVBTOcUw50cqRQ7Vqio2DWM7FpkwrFEzIIKi89scn0xEVA8s2mEqEVfe
	 AxdOXjG8+UKgzQhxzZ7Oup1kx2msBJL3ML3zhUWY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969B920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeLKP3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeLKP3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:29:17 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FCF20851;
        Tue, 11 Dec 2018 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542156;
        bh=AtUMkIE4IETPqnqTkclVVj9L1zrkVt/67Wobo+vfbpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSVKxJBnhAtz00o6VydTK1HsfKZWVQikgIQsiLBcHvJYGiawM4KRjEE3mY+NMr4a6
         xTRHE8yI1k9OhaAZrKGe0yFYxZHtS8YZtESUNBHM8DEWql0cNKLCUr9j0S+jMguyiQ
         Yb24JDs/qy8UFDkDMlEvcoWrHxd8drqSpvwYjY/I=
Received: by mail-qt1-f171.google.com with SMTP id l11so16839308qtp.0;
        Tue, 11 Dec 2018 07:29:16 -0800 (PST)
X-Gm-Message-State: AA+aEWagc/zIC066uFTyrec5NTQqMeXQrwOrCa1cKlIkYPjEARN52C6c
        hA/vJ8urFBAZHdmQBH6N0AG/GG7BncBPeGTxQA==
X-Google-Smtp-Source: AFSGD/W695+WXDLPdc/Ze0rKDuXT2mtilmiQXtDf3pKUYVT4cvm2rm2dz31Xzw006eQv8VJdiVbpf9eiq0kfDnklu4g=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr15802303qta.38.1544542156001;
 Tue, 11 Dec 2018 07:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20181122094602.5156-1-tom@aussec.com> <20181122094602.5156-2-tom@aussec.com>
 <20181122094602.5156-3-tom@aussec.com> <20181122094602.5156-4-tom@aussec.com>
 <CAL_JsqJ6fM3+pcC3b-eXEex=j_ft6Z=vukhLK9wULfWJqOTN-A@mail.gmail.com>
 <20181127150629.10795h1esqtc53ut@aussec.com> <CAL_JsqJmuDbPgc3WYRU8y3hbDL5A4_Luj0FfAiSvJ2+J-TM9_g@mail.gmail.com>
 <20181211131716.931947v9gya4ajos@www.aussec.com>
In-Reply-To: <20181211131716.931947v9gya4ajos@www.aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Dec 2018 09:29:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK877WtcFDEVc-fqRu0nSJwpgGBNjuxH0yiN7uy1BBRbw@mail.gmail.com>
Message-ID: <CAL_JsqK877WtcFDEVc-fqRu0nSJwpgGBNjuxH0yiN7uy1BBRbw@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] dt-bindings: pps: pps-gpio PPS ECHO implementation
To:     Tom Burkart <tom@aussec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, lukas@fridolin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 8:17 PM tom burkart <tom@aussec.com> wrote:
>
> Quoting Rob Herring <robh@kernel.org>:
>
> > On Mon, Nov 26, 2018 at 10:06 PM tom burkart <tom@aussec.com> wrote:
> >>
> >> Quoting Rob Herring <robh@kernel.org>:
> >>
> >> > On Thu, Nov 22, 2018 at 3:49 AM Tom Burkart <tom@aussec.com> wrote:
> >> >>
> >> >> This patch implements the device tree changes required for the pps
> >> >> echo functionality for pps-gpio, that sysfs claims is available
> >> >> already.
> >> >>
> >> >> This patch was originally written by Lukas Senger as part of a masters
> >> >> thesis project and modified for inclusion into the linux kernel by Tom
> >> >> Burkart.
> >> >>
> >> >> Signed-off-by: Lukas Senger <lukas@fridolin.com>
> >> >> Signed-off-by: Tom Burkart <tom@aussec.com>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 9 +++++++++
> >> >>  1 file changed, 9 insertions(+)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> index 1155d49c2699..e09f6f2405c5 100644
> >> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> >> @@ -7,10 +7,15 @@ Required properties:
> >> >>  - compatible: should be "pps-gpio"
> >> >>  - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >> >>
> >> >> +Additional required properties for the PPS ECHO functionality:
> >> >> +- echo-gpios: one PPS ECHO GPIO in the format described by
> >> ../gpio/gpio.txt
> >> >> +- echo-active-ms: duration in ms of the active portion of the echo pulse
> >> >> +
> >> >>  Optional properties:
> >> >>  - assert-falling-edge: when present, assert is indicated by a
> >> falling edge
> >> >>                         (instead of by a rising edge)
> >> >>  - capture-clear: when present, also capture the PPS clear event
> >> >> +- invert-pps-echo: when present, invert the PPS ECHO pulse
> >> >
> >> > Why do you need this? Can't you just make the echo gpio GPIO_ACTIVE_LOW?
> >> >
> >> > BTW, using the flag probably should have been done for
> >> > 'assert-falling-edge' as well.
> >>
> >> The hardware I use expects a positive-going echo pulse, however, it
> >> was really easy to give users the option to have it inverted in case
> >> they use different hardware that expects a negative-going edge.
> >
> > It will be even easier to implement if you use GPIO_ACTIVE_LOW or
> > GPIO_ACTIVE_HIGH as appropriate. If the flag is set appropriately,
> > then gpiod_set_value(gpio, 1) asserts the pulse and
> > gpiod_set_value(gpio, 0) deasserts it no matter which way the h/w is
> > wired. You can then get rid of invert_pps_echo in the driver.
>
> Hi Rob,
> I have looked at the appropriate changes to my code to implement the
> above.  However, there is no GPIO_ACTIVE_* as part of the gpiod_flags
> enum (include/linux/gpio/consumer.h).
>
> What am I missing?

You don't need to know in the driver. You set the gpio state to 1 for
active, 0 for inactive and that does the right thing based on the flag
in the DT. IOW, if the DT defines the GPIO as active low, then setting
the gpio state to 1 will result in the GPIO being 0V. It's a bit
annoying and confusing at first until you realize the driver can just
handle either polarity transparently.

Rob
