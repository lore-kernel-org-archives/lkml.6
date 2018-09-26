Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9139B2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8ZO4LKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9139B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeIZNlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:41:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39999 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:41:20 -0400
Received: by mail-it1-f193.google.com with SMTP id h23-v6so1543617ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTCLkuygTn2Ti3zL6fNYa9w1PjQBIcWrEQ5uhAGXYjw=;
        b=T8ZO4LKjZpsAGjsDRWb9Ma6wAOvuaK1WnOJCjNltNJiLWoGUxN5Px/DvjPn+2pODbF
         Odo6KVgLWm0hbUesrQQVrjxroDdwP35eVh4AwJv2ZhBsCKGanYq/HOzN+EJgiFvy/pvs
         O2zAPWqscOliDS1UWMzyc9LO8Xw3NTigx2Ydk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTCLkuygTn2Ti3zL6fNYa9w1PjQBIcWrEQ5uhAGXYjw=;
        b=cF158L0CY2JYgtKC6jJMp2DaERhuurdLXSpboVKDSk3JvDrIDAfjk8X6koPXrYp6D0
         6N6uhZB2ygmn8WelLsIIAazpPhP63oE5gWrJIHYBi76ombmfu09VGPdn0FyuadsCeqDB
         sr9FuBl4x8e5niPSFYHzWZWDSwd0Q/nbcWi0dJ4/5MfAgMEJrtmpwB4TAG/bOMBB3+4/
         ltnkh38O8U12ZXuyfz93QWadB8GrRqpxCIBAk9ThyBhyhgI0zBhXEy08DQb3d07SkBXy
         lgSh/Ub8iQR65qX2C6neaCqm9RODOR91MJ08Itgo3V7amHObayPJaofNEXxoMx0ZyyxF
         PnRw==
X-Gm-Message-State: ABuFfohQudnt78woBFrE9YSYARk4blj3RYD2AvCH//xln7z4GngoeZZY
        46jcq3F+mqfJdOQBttEJX63izzq13CgK0XeGosI7Mw==
X-Google-Smtp-Source: ACcGV62OPXe9YK7dlcwWIDSPHcRmgFzEpXr1wesIx2gQUZNvu3svkEsU3+da8q07GJslSBlaNSy676MaZjKMRfo9frs=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr4346217jag.112.1537946987979;
 Wed, 26 Sep 2018 00:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180925000656.23869-1-bjorn.andersson@linaro.org>
In-Reply-To: <20180925000656.23869-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:29:36 +0200
Message-ID: <CACRpkdb=xvwcQiDVr5cQf3sk6ONwHZwB0KoHXWVEvKJMTEp3FQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: qcom-pmic-gpio: Add pms405 support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:04 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> From: Vinod Koul <vkoul@kernel.org>
>
> Add support for the PMS405 GPIO support to the Qualcomm PMIC GPIO
> binding.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Dropped unnecessary driver update
> - Updated subject

Patch applied, as completely uncontroversial.

Yours,
Linus Walleij
