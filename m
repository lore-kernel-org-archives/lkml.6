Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8977116256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFB320892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="apYpqtuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFB320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeG3S7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeG3S7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:59:18 -0400
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391C1208A1;
        Mon, 30 Jul 2018 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532971398;
        bh=fXPJs5/PCC3bqDJB8Dasq7P6aNaG9REQht4t7e4erK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=apYpqtuGnuxDnIYNcvtmQ5F7IiaTp+ci8WlQj5i1yDBGKyrHV6LlT+aPJepZNjT1u
         U7crkr1hZiQzfuvMkjR5u7niCutFuQjUNZvHlOn2bCjaJ1TJm0q1tA1YE7MpRAwrh2
         R6fitYQFm+HFImarnBxKUshkRY/CgIKeSgz2aFrg=
Received: by mail-qt0-f181.google.com with SMTP id y5-v6so12898522qti.12;
        Mon, 30 Jul 2018 10:23:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlHqS109/zeGEQuTAslmxm93W7CdmEXleIKc5tKNvsfKQucds4RE
        JwZulx4t/ki5f6er4JAilKODR1G7zQp9V56j9g==
X-Google-Smtp-Source: AAOMgpe3b97C08Q5uhWZX2EwJl9+ZSduJGFMhypFisLv95RSxXAdmidZ2DuHt2Q96z8QUfCj4Pfu0JHHfdga1331nwI=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr18248532qta.60.1532971397425;
 Mon, 30 Jul 2018 10:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180712211244.11428-1-yixun.lan@amlogic.com> <20180712211244.11428-2-yixun.lan@amlogic.com>
 <20180724232917.GA27041@rob-hp-laptop> <e797412b-55db-6678-82ba-3a10ac99db9f@amlogic.com>
In-Reply-To: <e797412b-55db-6678-82ba-3a10ac99db9f@amlogic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Jul 2018 11:23:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrO+UMjhgSnaO+Ch-zpLj2-gjkuO=v1PRpMemYmcO2pQ@mail.gmail.com>
Message-ID: <CAL_JsqLrO+UMjhgSnaO+Ch-zpLj2-gjkuO=v1PRpMemYmcO2pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: meson: add DT documentation for emmc clock controller
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 8:14 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
>
> HI Rob
>
> On 07/25/2018 07:29 AM, Rob Herring wrote:
> > On Thu, Jul 12, 2018 at 09:12:43PM +0000, Yixun Lan wrote:
> >> Document the MMC sub clock controller driver, the potential consumer
> >> of this driver is MMC or NAND. Also add three clock bindings IDs which
> >> provided by this driver.
> >>
> >> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> >> ---
> >>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
> >>  .../clock/amlogic,meson-mmc-clkc.h            | 16 ++++++++++
> >>  2 files changed, 47 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>  create mode 100644 include/dt-bindings/clock/amlogic,meson-mmc-clkc.h
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
>
> Thanks for the review!
>
> There is a discussion about dropping "meson-" prefix in the compatible
> string[1]
>
> So, I will send another version with the new compatible name adjusted
> from "amlogic,meson-axg-mmc-clkc" to "amlogic,axg-mmc-clkc"..
> probably also rename the dt-bindings header file to amlogc,mmc-clkc.h

Okay, you can keep my R-by.
