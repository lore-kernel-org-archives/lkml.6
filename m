Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B854D2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBN1xabN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B854D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeJYVar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbeJYVar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:30:47 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201A820840;
        Thu, 25 Oct 2018 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540472287;
        bh=3FkoqUQ+gY6SrsUHv+8in/oTANUFQUq26YcpK03ambE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iBN1xabNvhluiPtMrhZg9NL4B7rfc9pkn1CBREurbCZ7Tj/HNRJuvrflltAbiqJxr
         oW74oXVNgx7/G8aS3rb+kRHI2NoiuHEm7G6bej7Rb4FVoPA8YNGKuiLy8QalqdP8Z1
         ZfrlHqUspHlfmTxYBPydU/UrtRqan8l0pDqby3/k=
Received: by mail-qk1-f182.google.com with SMTP id m8-v6so5577044qka.12;
        Thu, 25 Oct 2018 05:58:07 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLgk8nAGNTOnnyECPFqS+eNDX3pNbSZ24flDsmGBWxkCZbDDSkp
        SP//oAS3vYOMTgLVw3SdHhBToy/81OisIdOf/w==
X-Google-Smtp-Source: AJdET5fxMj0PUE0IGLFLxfrStTJvYWNilQlklzacuBpplVZZtgHPGbMaYi76Axf577mntdBj+LyrDnKQ/TRXXWDu8Kw=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr1134613qkg.147.1540472286228;
 Thu, 25 Oct 2018 05:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com> <20181025094430.GQ4939@dell>
In-Reply-To: <20181025094430.GQ4939@dell>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Oct 2018 07:57:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
Message-ID: <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pascal PAILLET-LME <p.paillet@st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Rob: please grep your name for some feedback.
>
> On Thu, 18 Oct 2018, Pascal PAILLET-LME wrote:
>
> > From: pascal paillet <p.paillet@st.com>

> > +Optional parent device properties:
> > +- st,main-control-register:
> > +     -bit 1: Power cycling will be performed on turn OFF condition
> > +     -bit 2: PWRCTRL is functional
> > +     -bit 3: PWRCTRL active high
> > +- st,pads-pull-register:
> > +     -bit 1: WAKEUP pull down is not active
> > +     -bit 2: PWRCTRL pull up is active
> > +     -bit 3: PWRCTRL pull down is active
> > +     -bit 4: WAKEUP detector is disabled
> > +- st,vin-control-register:
> > +     -bit 0: VINLOW monitoring is enabled
> > +     -bit [1...3]: VINLOW rising threshold
> > +             000 VINOK_f + 50mV
> > +             001 VINOK_f + 100mV
> > +             010 VINOK_f + 150mV
> > +             011 VINOK_f + 200mV
> > +             100 VINOK_f + 250mV
> > +             101 VINOK_f + 300mV
> > +             110 VINOK_f + 350mV
> > +             111 VINOK_f + 400mV
> > +     -bit [4...5]: VINLOW hyst
> > +             00 100mV
> > +             01 200mV
> > +             10 300mV
> > +             11 400mV
> > +     -bit 6: SW_OUT detector is disabled
> > +     -bit 7: SW_IN detector is enabled.
> > +- st,usb-control-register:
> > +     -bit 3: SW_OUT current limit
> > +             0: 600mA
> > +             1: 1.1A
> > +     -bit 4: VBUS_OTG discharge is enabled
> > +     -bit 5: SW_OUT discharge is enabled
> > +     -bit 6: VBUS_OTG detection is enabled
> > +     -bit 7: BOOST_OVP is disabled
>
> I'm surprised Rob allowed you to add register bits in a DT property?

Yeah, they are certainly questionable and not something we encourage,
but the alternative would be dozens of properties which only apply for
this one device and just get translated back to register values.

Rob
