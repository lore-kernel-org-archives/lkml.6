Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3741FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oat7Keb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E3E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJPXBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPXBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:01:51 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4AB2145D;
        Tue, 16 Oct 2018 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539702657;
        bh=yIc3xtPtY6iJlLud/fDjuKu6ru4U8U9vhQpjhoPF72w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oat7Keb1n88V6jaBEqw6iuOMassjdHkRV/oDTUW62BOFCxiv/VlDvujLtq5n2ol31
         idYfuSc+/QCSDX2Q0nka6Le1J9WqP7W+bRoVgdMw4RsD74exVmJC1mkjoRFpNlLmnx
         G3GUIDOxC95Gb0GEpJN7jyZZkUx/jpwjPdLbDc5E=
Received: by mail-wm1-f44.google.com with SMTP id a8-v6so23602159wmf.1;
        Tue, 16 Oct 2018 08:10:57 -0700 (PDT)
X-Gm-Message-State: ABuFfohaRg2flqKSZ+jsVcSfeIzcPhtF3JMg4/iiIxJREQXh29xxampw
        MrtNtjVS/vfGAH8AF1d4O1EKfkh3lln78I+bZs4=
X-Google-Smtp-Source: ACcGV61Hp3wCVgnXDxpjwUl/aS5SzE/V58J64zywIPjUmIBHW7O0EyRUo8m1lg2jhehJGBEdnuXz8VTP2APx6zMKd0A=
X-Received: by 2002:a1c:9a4a:: with SMTP id c71-v6mr16803361wme.71.1539702655729;
 Tue, 16 Oct 2018 08:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com> <20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0~eHqOSKKqJ2135421354eucas1p2J@eucas1p2.samsung.com>
In-Reply-To: <20181016145650eucas1p2330e8d680b70acffaea223a5a8c51ca0~eHqOSKKqJ2135421354eucas1p2J@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 17:10:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPews4f8Js89AJ7Zz4GUT7ama9LKu1xP-OcV-0Kq28p-bw@mail.gmail.com>
Message-ID: <CAJKOXPews4f8Js89AJ7Zz4GUT7ama9LKu1xP-OcV-0Kq28p-bw@mail.gmail.com>
Subject: Re: [PATCH 08/11] DT: arm: exynos4: add support for thermal trip irq-mode
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos4? 4 trip points?

Beside that other comments apply as well.

Best regards,
Krzysztof
