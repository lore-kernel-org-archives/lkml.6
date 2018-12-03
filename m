Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68178C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371F720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371F720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeLCKcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:32:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38726 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLCKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:32:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so10268073ede.5;
        Mon, 03 Dec 2018 02:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sE+1U35myL/a0/KB5evo09ZYb4a3/tW7nLxw06aPoE=;
        b=Avjggk78IJ5zie56RdFccbadnCwlwAaZaXeBpkfxHM9Pq6cQ/e6ceWB4hsRI2y69yl
         5Ic6E2pJVvOcwvf0hPpBCw7IhyWZ61j2jyuO6joS+zDUFboYZbt9wWtF0Wci0b5QB6pD
         sV0O1hwyvT67OvcGJYFvBRZnheVbXQICn9aSTOffoRFEdtI8OwJDEWh0mQIbBt2dIqqt
         37J31WgMaLlk5p6d4YquU9JkF+zeu0/t1kxyXQg5P5mVa9WBYdDap/5P8pUpuVuQ19wB
         Wz6ALSjSy3S7G6oYBgkaL/pqhCZyvZQCOe9hpExW5exFDlZlUiKA2huJTBZZj9lXM2L6
         4hvQ==
X-Gm-Message-State: AA+aEWa50jz7lnI2hJ+FhKLUmZSWE6c+8WNZvcGvFsrYsRbMt9HUBGnP
        Gg22HcSyRbDt8rPxLaZpnmhIJAnzLziwJA==
X-Google-Smtp-Source: AFSGD/ViZUDrGXe2lZhl1fdaDbGI3xL6C2AaKXLsoRHGKTbBcqz+ZYMmWURVhr+9PCh4DbNJtrjYmQ==
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr14160595edc.293.1543833136099;
        Mon, 03 Dec 2018 02:32:16 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id p20-v6sm2124831ejj.54.2018.12.03.02.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:32:15 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id r11-v6so5167155wmb.2;
        Mon, 03 Dec 2018 02:32:15 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr7509901wmh.124.1543833135222;
 Mon, 03 Dec 2018 02:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 18:32:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v67aqRC4-KPMDyE80ZHcvUJvB-tLXzAUL8atvzkcJchd5g@mail.gmail.com>
Message-ID: <CAGb2v67aqRC4-KPMDyE80ZHcvUJvB-tLXzAUL8atvzkcJchd5g@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: gpio-axp209: Add AXP803 GPIOs compatible
 (w/ AXP813 fallback)
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> AXP803 PMIC has two GPIO's which is similar to the one in
> AXP813 PMIC.
>
> Add a compatible string for it with AXP813 fallback compatible string, in
> this case the AXP813 driver can be used.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

First of all, please write a cover letter.

Second, the GPIO stuff is covered already by Oskari Lemmela's
"AXP8x3 AC and battery power supply support" series. The device
tree patches from that series were merged last Friday. The driver
patches are pending. That already covers patches 1~3 and half of
patch 4 of your series.

ChenYu
