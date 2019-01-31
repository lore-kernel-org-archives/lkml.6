Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA1C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728A520823
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548968967;
	bh=GzsjJG3Us8wxzLmCdLryEZZCm17bjKCIQn905dcb9PY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iwQoSTiwI0ftiYcpV1FICTAqabAYCDee4Xotw7C0tImCdoACBnt+A7RCnfiMmTr/5
	 54F0uK9EmLazT0cLZ1sygkvPW4WxLNXW/9nPPttocq2ThDut/uJGP63Jv3AoLdSg0X
	 a4Kz9wLRD5yq/Uu5CVhn/k7Z2boLBbSJKVsVsWbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfAaVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfAaVJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:09:25 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272A1218AF;
        Thu, 31 Jan 2019 21:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548968964;
        bh=GzsjJG3Us8wxzLmCdLryEZZCm17bjKCIQn905dcb9PY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=giDBVy/hs5D6eicAzqRmWqyeLWGrErakKcL4TotxJB3788tXTJ2+XMuJ3Yr7ekFUY
         ZPea6SEnaCNUgyRHeYy7BcVa60qNkYFBF6LmA+yCSHXJ7K12nfReYyHm1j1UyFCWFL
         dt+2KwPRAjIeDdpve0M3UNC27vBcn82B1KugrpJA=
Received: by mail-qt1-f173.google.com with SMTP id k12so5127722qtf.7;
        Thu, 31 Jan 2019 13:09:24 -0800 (PST)
X-Gm-Message-State: AJcUukccMcq+n4ppqh5YBnKonFMFVZrCuY3QoO7TfM3KvLC/NB9F14j2
        Ck40AX2K4UgC6LkPsjn02+MtBEQEnF0dO0A9Ew==
X-Google-Smtp-Source: ALg8bN6DWHHa3I0PzEntbrwDH0d7qeQ2qnJHOM8ChZHiEMjRe3lKkiUgCxYFAk0k27BS33j5IHhIX+tyxN+9KleKkQ4=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr33687286qve.246.1548968963338;
 Thu, 31 Jan 2019 13:09:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com> <127bd8d6765e35272ad174c59838d1374813c910.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <127bd8d6765e35272ad174c59838d1374813c910.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 31 Jan 2019 15:09:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJVpVto59MQ7jwgCe2Ohem4EomqqNaUg17F1ahz_DjBNQ@mail.gmail.com>
Message-ID: <CAL_JsqJVpVto59MQ7jwgCe2Ohem4EomqqNaUg17F1ahz_DjBNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 06/10] devicetree: bindings: Document first ROHM
 BD70528 bindings
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 6:05 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt

Reviewed-by: Rob Herring <robh@kernel.org>
