Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC88C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E01B2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQTgh62x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfASXCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 18:02:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43248 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfASXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 18:02:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so12975663lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D40KnZ08lsg4U2H/1xVTd820G6KgzOyAhBJv6sJavys=;
        b=PQTgh62xRpkh7A64jn0HVh9Z3KYYC1dLYl6YrEnIv4TZ96s0eTVzbAOlwGIgfVTSxJ
         bwUI6wSjMA4Xd4irzi0rGEsMhifXxFR4Esmi914iluINXyVrTRkWUOOf6xEI7+WNpItc
         sh1IsLwypzQbTFqOFjpwPilkyxh26wLINwOj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D40KnZ08lsg4U2H/1xVTd820G6KgzOyAhBJv6sJavys=;
        b=ErO2gGlaDUrnSXNU/Ur7HF+SfAb4upjJP5OIDAEvwBc8tpk3VNqPuyMKkSiAYWK6Ud
         BVOYfK8Tk9l/JsZOgquQkUi9QqPD/1BzccSW3ZqZJnT5Z0vqqBTiBa6mD0vVdrqUqlEJ
         dODEcQWaPdI7RQPS9NGZW0IAR3Wgn10ZdeAYSxejV4hRzg9WDdN02IFc1uEqZDhjEFC+
         //JJvNdTXCc/RTw4I/uPjZVsvKq5zrl1rZdB/qx0O0JQ/IaauLoKHbJgI+o82WfQJyPf
         MqlY1zadAR/i+NH96iMtYcocD79o1gWlEUdmyR3DCcebWoN9a9QIPvpbkZuj49g+kKpe
         0vrQ==
X-Gm-Message-State: AJcUukeP2fTucOedmp7G7d3mrvajKtyxdFEKnAdj8+QGadX2zeidhhyn
        HCICHgTJQwmu+9ZlIBu/Cxi7LpmqJH2d/EFn/f3hkMywTCc=
X-Google-Smtp-Source: ALg8bN42k6wGOULXCkYWxiEssAXmefriIZSwAZmDxuUU+a1VkYKx/0jNQ8oLVmGan1p5HUNxfiB+/5HVR0PTbxyqU1g=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr6630944lfa.32.1547938954449;
 Sat, 19 Jan 2019 15:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20190110143917.9054-1-linus.walleij@linaro.org>
In-Reply-To: <20190110143917.9054-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 20 Jan 2019 00:02:23 +0100
Message-ID: <CACRpkdbxDfOUqkjfkmbOReXrLKLEWDKfdd7==bGaTjXMKda5rA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: config: Update SPEAr 3xx defconfig
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.linux@gmail.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 3:39 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> This config is updates to the latest structure of the
> Kconfig menus so we can apply DRM driver changes on top.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

BTW I haven't seen many SPEAr pull requests the recent times,
if you want I can send these to ARM SoC myself, but I need an
ACK from one of the SPEAr maintainers to do so.

Yours.
Linus Walleij
