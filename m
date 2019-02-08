Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF7B2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUMgM7Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBHNxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:53:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46784 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfBHNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:53:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so2539626lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPNmJ15KEK8QlnNyQUI2whawGc1QMo6m2jIEISNaNE0=;
        b=yUMgM7Lo2ER9OkIyI9MiiM5OUgzU8i0hi0XWbOV5mI5iwZPcijQrRCjjJGBUx8XZCa
         FvkKQdnERlzbrrKjxdDN8RONPhTuOcFFl+FJff1y43YLC3vs7DhHmiRrWcEpnUv3KMPA
         Y5mhqTe/3KVigfV4e7syx+l2IbPbya18pApTA56PmHuo81TwPTCLJRsJKBr7biTacLVo
         9VYh6cg1cE6/i9bRB+9uluYEyYJtSfm8v/snddH9zLHXuYpAC/AW5cwPu4MdR/uXIKzR
         0xi1HX1h6LCAnjDdkwhwFi40j0a+yBd3lpkZcjzZW8vUMhklXvuAYN2xuxd7zoHNS/FH
         zQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPNmJ15KEK8QlnNyQUI2whawGc1QMo6m2jIEISNaNE0=;
        b=uYOAtMQnoR/P5yl4795TUUNo6Hwz2oaxZ4k+LtcyUBbwBsFAMMOSSEpQOcwThsyBP4
         Ev/39anSs8F2/cEGqYQb613sJJkkUYaMS322vR8C0hTeBRQntK8zm0OhocRUUJHJneT8
         mCYxxA0aza7RouPxr9o8MWqF1Hmzqw1FCLse0ap/Ddgh9KCANjuXCJLnyR8J9pDcbyv0
         r4fnn+FF4EKkJuKE1NjjVLsA/peqJZTJCA/y90rQ7WLF/nvXxkq7cjTj1sPJHCUdxeRp
         ExSjZjrSNGmLi4QGE05iR8pji2ogVHu5GUYj2lm2g1nfl2sbreYmPpCc6iIfNiqG2RXi
         NOYw==
X-Gm-Message-State: AHQUAuZOkoknciAJm2ODL0gPoCrZEBGg5aid6zWZmrD5U84hrBiMlhGR
        9mVJFEbAKu6rboanM5JMVD8z7IbJy1ngoBj2mynpeQ==
X-Google-Smtp-Source: AHgI3IaIrZMPapB0BgETZ1wjFbskiZhzO2E/nH+1osqKOjlDOpn74o8cVB4BavFg+AORqKDSsBLEj9lejIp3MmRee4A=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr14170440lfc.27.1549633997617;
 Fri, 08 Feb 2019 05:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20190205195909.3565-1-krzk@kernel.org>
In-Reply-To: <20190205195909.3565-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:53:06 +0100
Message-ID: <CACRpkdbXZnYP0=BXqoSyr9=y4+WWWax+KYQ8MvcAUVyMVL652w@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: samsung: Remove legacy API for handling
 external wakeup interrupts mask
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 8:59 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Remove the legacy, ugly API of exposing the static value of external
> wakeup interrupts mask, because all arch-machine users where converted
> to use generic implementation from pinctrl driver.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch applied for v5.1.

Yours,
Linus Walleij
