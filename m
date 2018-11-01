Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF12C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F187E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F187E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKAQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:55:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35220 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeKAQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:55:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id d6-v6so7723858edi.2;
        Thu, 01 Nov 2018 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7RJDcXfP6uyFwLeNvtwx/13CoANBJPX0gPrT1kaWnI=;
        b=euBTHlXf0DtBBIxvogz9PkvfutuFBMx8YwHleInTgYTiknR0pb8DpIbYgdRP4ed0jW
         fFzUBgAjuSKRi8aVTdoqkymCMJNsWDI1bHjVowfFyoeVE4zLcyQmslBMe2/dZOIaGD6e
         u0J9L8UVRhPnTdlETvZdel941zEZmYQ9M8sVwyyxDqvigPJbn79pCa9rO0UY8nciw3FX
         8JXYvToHL35lMC/fI1fmDLdQgARp4oihRO51QNHmRk+IhBC6oITlWmVTYoyFShjnAl1T
         bYTdzArTMSLRVy5UWvL8pZHYfEsEvcMJ38KEKLmRBYjAg+jxcUhQGQ7uIRMJiuwqfLSc
         +MKg==
X-Gm-Message-State: AGRZ1gJB8Mw7odS8yorGYevae4NyrjckuM+g9r1ccib+xPR8YRVQ3Gch
        heiAx69bEBOtpouD/N/DYXB81vDdAkU=
X-Google-Smtp-Source: AJdET5dYwQJU4VUTjKFM8G8rMXqGwX774gx/BHfB0RdZxX96oi930YqVduKBKyiLi3URd+z6YOuqNw==
X-Received: by 2002:a50:dec2:: with SMTP id d2-v6mr4318482edl.129.1541058830882;
        Thu, 01 Nov 2018 00:53:50 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id t22-v6sm701314ejl.58.2018.11.01.00.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 00:53:50 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id j26-v6so4948321wre.1;
        Thu, 01 Nov 2018 00:53:50 -0700 (PDT)
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr5311104wro.208.1541058829969;
 Thu, 01 Nov 2018 00:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-5-jagan@amarulasolutions.com> <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
 <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
In-Reply-To: <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 15:53:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v67WZmG7qPqf_UoR4v=Zm2AbS8pcOQsWJPRVHr-i2NvRPA@mail.gmail.com>
Message-ID: <CAGb2v67WZmG7qPqf_UoR4v=Zm2AbS8pcOQsWJPRVHr-i2NvRPA@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Nov 1, 2018 at 8:25 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > From: Jagan Teki <jagan@openedev.com>
> > >
> > > RTC controller is similar to A31, so use the same compatible
> > > for H6 and update interrupt numbers as per manual.
> >
> > No. Unfortunately they are not that compatible. The A31 does not have
> > the RTC clock output. So everyone got it wrong. :( Plus the clock rate
> > of the internal RC oscillator varies between SoCs. I'm working on a
> > series of patches to correct this. Stay tuned.
>
> 4 bit, EXT_LOSC_EN of LOSC_CTRL_REG (0x00) seem available in H6. I can
> see external clock working with WIFI for A31 compatible.

That bit turns on the external crystal, i.e. X32KIN and X32KOUT pins.

I'm talking about the X32KFOUT pin, which feeds the WiFi module the
LPO clock in typical Allwinner designs. That is controlled by register
0x60, and is not present on the A31. That is the clock you say is
working. You have the two confused.

The clock tree looks like this:

IOSC -----------------------------\
                                   SUN6I_LOSC_CTRL_EXT_OSC mux ---->
LOSC --> (to CCU)
32k crystal --> EXT_LOSC_EN gate -/                              \
                                                                  \
                                                                  /
      (to WiFi) <-- X32KFOUT pin <-- LOSC_OUT_GATING_EN gate <---/

The bottom part does not exist in the A31. Meanwhile we've been claiming that
all later RTC modules that actually have that part are compatible with the A31.
Also the IOSC part has different clock rates for different chips.

Do you see the problem?


ChenYu
