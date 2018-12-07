Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD004C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B7520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544202388;
	bh=8NOTRdDxL9DO2TkPzg0lBofzjvFlR2etOHmkF1N/2vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XgjtqrUcL94nUHtHaqTFHCwBET90CZOFP5eFGOdJT60am2mDcxMhc61dgSBX+N7/D
	 L8RutL7KSwvt3po977ZJWa1X41FHOrSkqg8gL8okQEPTWC+zK017qma7heNf/oi+wO
	 61T/IcrrbTNXiEb6vwOFbBOGvuEsEMrWnX1h/Al4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B7520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLGRG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGRG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:06:27 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CAE20868;
        Fri,  7 Dec 2018 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544202386;
        bh=8NOTRdDxL9DO2TkPzg0lBofzjvFlR2etOHmkF1N/2vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWaw3JM5yaIBerBgTBYPquNMst2PpG4Sg41Y3Ir+T3/4CSGuiMDObJdhxVzAmvszp
         kUAI9yJjrUiSQhA/+7txNyaxFu/Ni6pVtkWFGEbXhj7rViZwhPp4wSV0OeqVDiKaAC
         e5lYSGkgOtJdjcB/C1sb/dFIG+W7M9gqJEvQnC+4=
Received: by mail-qt1-f182.google.com with SMTP id v11so5248067qtc.2;
        Fri, 07 Dec 2018 09:06:25 -0800 (PST)
X-Gm-Message-State: AA+aEWY2ujPgTL3m3HnFzs8owXaGtSI517bXZzFt1coLctXt8vwGhgUe
        D4e4W5HPHU+N+SiTOrB9AtDg9qUPPUlsXOzGug==
X-Google-Smtp-Source: AFSGD/Xn4+KOOAN3rLYed2v1hfmFVDybPPejCSE+QuREMuX/ddOznHdkMA5PTXoHVfxstpKVCzygbAOLJvFzcGLrr+4=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr2895278qts.144.1544202385156;
 Fri, 07 Dec 2018 09:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20181122094602.5156-1-tom@aussec.com> <20181122094602.5156-2-tom@aussec.com>
 <20181122094602.5156-3-tom@aussec.com> <20181122094602.5156-4-tom@aussec.com>
 <CAL_JsqJ6fM3+pcC3b-eXEex=j_ft6Z=vukhLK9wULfWJqOTN-A@mail.gmail.com> <20181127150629.10795h1esqtc53ut@aussec.com>
In-Reply-To: <20181127150629.10795h1esqtc53ut@aussec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Dec 2018 11:06:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJmuDbPgc3WYRU8y3hbDL5A4_Luj0FfAiSvJ2+J-TM9_g@mail.gmail.com>
Message-ID: <CAL_JsqJmuDbPgc3WYRU8y3hbDL5A4_Luj0FfAiSvJ2+J-TM9_g@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] dt-bindings: pps: pps-gpio PPS ECHO implementation
To:     Tom Burkart <tom@aussec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, lukas@fridolin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:06 PM tom burkart <tom@aussec.com> wrote:
>
> Hi Rob,
>
> Quoting Rob Herring <robh@kernel.org>:
>
> > On Thu, Nov 22, 2018 at 3:49 AM Tom Burkart <tom@aussec.com> wrote:
> >>
> >> This patch implements the device tree changes required for the pps
> >> echo functionality for pps-gpio, that sysfs claims is available
> >> already.
> >>
> >> This patch was originally written by Lukas Senger as part of a masters
> >> thesis project and modified for inclusion into the linux kernel by Tom
> >> Burkart.
> >>
> >> Signed-off-by: Lukas Senger <lukas@fridolin.com>
> >> Signed-off-by: Tom Burkart <tom@aussec.com>
> >> ---
> >>  Documentation/devicetree/bindings/pps/pps-gpio.txt | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> index 1155d49c2699..e09f6f2405c5 100644
> >> --- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
> >> @@ -7,10 +7,15 @@ Required properties:
> >>  - compatible: should be "pps-gpio"
> >>  - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
> >>
> >> +Additional required properties for the PPS ECHO functionality:
> >> +- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
> >> +- echo-active-ms: duration in ms of the active portion of the echo pulse
> >> +
> >>  Optional properties:
> >>  - assert-falling-edge: when present, assert is indicated by a falling edge
> >>                         (instead of by a rising edge)
> >>  - capture-clear: when present, also capture the PPS clear event
> >> +- invert-pps-echo: when present, invert the PPS ECHO pulse
> >
> > Why do you need this? Can't you just make the echo gpio GPIO_ACTIVE_LOW?
> >
> > BTW, using the flag probably should have been done for
> > 'assert-falling-edge' as well.
>
> The hardware I use expects a positive-going echo pulse, however, it
> was really easy to give users the option to have it inverted in case
> they use different hardware that expects a negative-going edge.

It will be even easier to implement if you use GPIO_ACTIVE_LOW or
GPIO_ACTIVE_HIGH as appropriate. If the flag is set appropriately,
then gpiod_set_value(gpio, 1) asserts the pulse and
gpiod_set_value(gpio, 0) deasserts it no matter which way the h/w is
wired. You can then get rid of invert_pps_echo in the driver.

Rob
