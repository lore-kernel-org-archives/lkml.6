Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF46C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901F320831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsvKeZOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901F320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeKTBpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbeKTBpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:45:32 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0099E20989;
        Mon, 19 Nov 2018 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542640897;
        bh=xQ25fvpoTXUHNNp0PteSHaC1N4hn/+Yec2ykpa6QZeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bsvKeZOydSAL2vMnz/k24ENaz1QDYxoBnUGXrdnPQtKPbMRzfSh+zSTQYjeK9Nkoh
         fi9Agx+ti3jdFx0QcptkSwixtl8fsN3ayp5qdM1SHPL81kxaL2S89QSA+I+gPV+9Or
         VshPjTFWdulP632aTVT49zzmhJiuCSxs+Rw91BkE=
Received: by mail-qk1-f177.google.com with SMTP id 131so49098761qkd.4;
        Mon, 19 Nov 2018 07:21:36 -0800 (PST)
X-Gm-Message-State: AGRZ1gJJfwhWiCjcvdTTp0iwvu1aBfH4K3BWe0qZOfLnOJhgntazoxDC
        dZW+JaptzZSWJODRDlxdLBoP+/uSoEYXVpMzWA==
X-Google-Smtp-Source: AJdET5d8Re3M7Mwm6i+I4vI/j95JKYEjc/Tsu1nrg9Bkya6tHLJaolDioMpJSnrIIprxSjkWkGHqON0vjlakKNDWeVc=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr21813202qts.144.1542640896211;
 Mon, 19 Nov 2018 07:21:36 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com> <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Nov 2018 09:21:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
Message-ID: <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
Subject: Re: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
To:     sugaya.taichi@socionext.com
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 7:00 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Add Milbeaut M10V earlyprintk.

Do you really need earlyprintk? earlycon is preferred instead. It's
not quite as early, but doesn't require rebuilding the kernel and
supports more than 1 fixed device. If you crash before earlycon is
enabled, that pretty much means either a bad dtb memory node or just
flaky memory.

Rob
