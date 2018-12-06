Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2138CC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCB3213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCB3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeLFDCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:02:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39347 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeLFDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:02:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so18806262edt.6;
        Wed, 05 Dec 2018 19:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vChUQErCySB5pPQauDNCeDK4RanyGb3OBR/VfuVN84=;
        b=BXgX9AKQi8wdg52HdG3Rq+GmETOWCWxIP6wRhvJAo8gJVQ1Au0MfljYXqpYpf8FKGd
         rok1wmXYznQ7aQkvCYSgUoxhZBsfODn3hnTjwBHHqFnpvpgeO/cReQYmN7HnPWANv2Rj
         pad/tNyQXK9HzHB7kILVpxMp8P1x3n7SDR2S8NvHvjzx0OhuLy0EpRBF4Tq6abk0Sk1o
         fhhqswbW1iNNglzdui8Iw4kqS0yZ57Ye2TEf/RqCvv9Z4/rlJ5BXcjjxDv4qkxOk5cdD
         Y1aQs3qIGeypjvCigLZFHgBfpwoGD6yiQxK8wEWCxOS9bwWnGQZmosSzEohuX124npfm
         qlnA==
X-Gm-Message-State: AA+aEWbMCNPRIPMkOeghCwibtT+vX2ECrZXXl43+nVjhHlzDBh2irIV2
        TzS27NNFRbL4CWBuzDIEwOuR0e+ob60=
X-Google-Smtp-Source: AFSGD/WJkGGdpLPudEBp2KakK8E43bDQ3bNbIE70ZqiiqaXQgfqqckCDnQtBzlRJbfORFDilmXvOlg==
X-Received: by 2002:a50:ae8f:: with SMTP id e15mr23708029edd.250.1544065319632;
        Wed, 05 Dec 2018 19:01:59 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id 24sm5910432eds.97.2018.12.05.19.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 19:01:59 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id a18so14964174wmj.1;
        Wed, 05 Dec 2018 19:01:59 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr17777709wmd.111.1544065318756;
 Wed, 05 Dec 2018 19:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-5-jagan@amarulasolutions.com> <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
 <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
In-Reply-To: <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 6 Dec 2018 11:01:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v66kEStHyg1apCsDcAEVk6Gr5xiJ4tV50+0TL2k+CZwtjQ@mail.gmail.com>
Message-ID: <CAGb2v66kEStHyg1apCsDcAEVk6Gr5xiJ4tV50+0TL2k+CZwtjQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:56 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Dec 3, 2018 at 4:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > vcc-supply property is need for some Goodix CTP controller like GT5663
> > > where 3.3V external pull-up regulator connected via controller VCC pin.
> >
> > "External pull-up regulator" sounds fishy. Chips have power supply
> > pins, either combined, or separate rails for analog, digital, and I/O.
> > For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
> > and description you provide match none of these.
>
> We have vcc pin in the connector to supply vcc-ctp, but indeed it is
> AVDD28 supply as per the reference schematic design[1] Page 23.  Host
> interface has AVDD pin which is connected to ADVDD28 on goodix chip,
> so I can name this as avdd28-supply. is that OK?

Yeah. That's better. It's always best to be precise with hardware
descriptions. If you simplify it, the reason should be given in
detail. And it should be a good one.

ChenYu
