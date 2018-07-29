Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1292C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D320857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MarrqHB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8D320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeG2VPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:15:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56162 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbeG2VPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:15:09 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so14416089itl.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWG62cDUL5rKDJNCQA/NqhsMWvS2DLC/nEaXLf/xpK0=;
        b=MarrqHB4LyfBePHH7xyhXKuukTVOMw6Kb7mM21hZcliA3NsDd2uigRZPdtw1pwnUXN
         gopQHLcOF2nXpem3APTuwvnX3f4CA1XbR99GqhHPR6OhIIHGOSeLnNgaPguOhDMwQRvM
         oeoi950u5xtSRwcQiEQW+DWfGm0yCyOq94kG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWG62cDUL5rKDJNCQA/NqhsMWvS2DLC/nEaXLf/xpK0=;
        b=ErDoKB6AHR2LwUtjPd0e3siFB+WDOCrqyLzxYh+lfdZ2Z4FkWvB0aXWT4MWNRX0tLL
         bJlVmXHB1+rPIaKdKL0w9Lpf3/HWMhGrmO5VL5oCfDN/feDS+wVs56D18KOsa5a5Id2h
         CKh5X6zDf66b+LgumD2b25hplM8FS3D7bjtdRx8/JGC4TYqPqgn6S3RSyqUAY4wlZjAU
         kE25dzMXDC3CJU23p4oRKueVylkGiP39ym87r+Ma1CJRKfSqnKcH3ozhBB8GnRQFwGaK
         deD1laiYYLupaOCG3oRvyTb9kqK3OQDMp7kudRwFTI4qX2eYAEJXSEB9zAGl88b4Mr6Q
         +PHA==
X-Gm-Message-State: AOUpUlHFDJjtHhgVrGTpszW+dfhKslOCQq2LgH0KXy/VTvViKru6KnUv
        kxHX4Oacp6F6ANgwTfXICCm9tC7Gb0LnKrgrOjcu2w==
X-Google-Smtp-Source: AAOMgpfyrw3ZobmLe7WN6d63fna26eZzCNZTN1P06SoiIlS5y1G0n50y66TxCmHLKBes9wux4HIB/YopLTOkvqPp1so=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12446064iti.135.1532893415935;
 Sun, 29 Jul 2018 12:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180718135613.1c559b9c@xhacker.debian> <20180718140030.73eb45ca@xhacker.debian>
In-Reply-To: <20180718140030.73eb45ca@xhacker.debian>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 21:43:24 +0200
Message-ID: <CACRpkdZoTwjL-g6xRhCdACi1QNEKbzEvsax0-1KmowLg_kZ8Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: berlin: add the as370 SoC pinctrl driver
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 8:02 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:

> Add the pin-controller driver for Synaptics AS370 SoC, with definition
> of its groups and functions. This uses the core Berlin pinctrl driver.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Patch applied.

Yours,
Linus Walleij
