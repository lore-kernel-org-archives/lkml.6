Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53D621780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEcL/CCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53D621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbeKOTXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:23:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36293 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbeKOTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:23:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id h192so13627506lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56338LcQmSd/ZHWALKbq1+wmBV+o1Y/7vbWoULQH7NE=;
        b=GEcL/CCXG7p5Twz6Q5OWZsIvEu9t6EzLIMzA2Cxa8ORCmgqFFNWt7wKehVLtKVGTaQ
         U0lMoiO2UxsbmRvRazBb127BhK6EZ+TEc4+AZZg0GMUnTGjoJiDf39oiW55R/3BQqXz4
         TvGJ4DQKNqAP7tAG65LiqK1BtfygzkcOCgyNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56338LcQmSd/ZHWALKbq1+wmBV+o1Y/7vbWoULQH7NE=;
        b=P9UputO2gFhQLbGqlt82WL9jhbxDNXWTT+gum6kzzccqTtNfwe7Oxhg+fA6dS4oQnb
         XPTedDHs+VHCJtW8UpZonM09v/Tmz1eDT0b5unK+cpKg4mVCE7/wykDfgGFj32j0YTDG
         9con6HNMp3lInw+jyBiCSsGgDASSJAm0/R7jWxD+mz/rd1XWpsILbaPNqJE15MacQVuR
         81iX4jdTh754kNJf11l6kfhKG4K9uAMItOyJErqksGYTA3gn9kGNYy279Xu3kotXQq0v
         YJ9ojgA9uKDd5NcbzCnAHolJOe4ddrrhZVtecEmzA3voQEaglHHNk8cQGYsBh7oa9w4w
         yhiQ==
X-Gm-Message-State: AGRZ1gK683m5heu3XTINknkJ+gHdyXDJpYuAMl3mLMj9w7FQDwORrvLu
        QqiCp94iJZXeK3O5v/uwKXsyQgFuxjVjvolLJqmKAw==
X-Google-Smtp-Source: AJdET5f/q45nThfEa5kJVh34dbqhm9CHR9aejLq2gZqmgB9PIBtcuVgzsG60yx5d6aGoGpbTYzsfUqu0hVj28jXULTE=
X-Received: by 2002:a19:f813:: with SMTP id a19mr2865477lff.67.1542273394324;
 Thu, 15 Nov 2018 01:16:34 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com> <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
In-Reply-To: <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 10:16:22 +0100
Message-ID: <CACRpkdb6VP5hsg8ScrfAEt7TV5k_8zf7cruNxzhwfHrkdgwyuA@mail.gmail.com>
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 11:07 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:

> +#define LED_FUNCTION_DISK "disk"

I recently added triggers for "disk-read" and "disk-write".
This was because the D-Link DNS-313 does have dedicated
LEDs for each usecase, and so does DIR-685.

So I think you may need
LED_FUNCTION_DISK_READ "disk-read"
and
LED_FUNCTION_DISK_WRITE "disk-write"
to cover these cases.

Yours,
Linus Walleij
