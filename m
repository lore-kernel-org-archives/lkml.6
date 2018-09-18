Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB8BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42212133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjJeYGCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42212133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeISDmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:42:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44088 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISDmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:42:20 -0400
Received: by mail-io1-f67.google.com with SMTP id 75-v6so2860733iou.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJW+s/wJ2sMVW0clksn5zGboVHCOD/cdOVShnt1+QL8=;
        b=UjJeYGCBhCp2fFMCvCiOkJIy+M/7Vc7o9RUzxE2b3XZ6R6zIRdzhePp9uSjWx5jq6y
         78IDZLAfGt0Y1LWhZPbUOd5FpXXZP1+QMrvZlMz3+KHgCH8nlXvXKrkWd1Ki/Iw69BGq
         NWnYEBfxUvF6nzGXRC7bvuO7658ymvE9AEEaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJW+s/wJ2sMVW0clksn5zGboVHCOD/cdOVShnt1+QL8=;
        b=NtMmimCeDBHWtcAS04oQjA78hWr1z8ro9t5GQGBM/ltsZ9Zwla+1jyZ5mk9EmZPSHS
         ehCIhi2rW5EYm4+4R/9TOQ5zgzgm4h4ZVAKPaEfsCGAEJrLhT2LmOjzHpi2HK9WthZjb
         pXJDyRGkMJknC2gTwPXSwrjmMK9D5DccOAhpUtUGFyVpjKTCpCiD43MJPNSx3qfZAOPJ
         qOmC4jeqw/oTm+FC8oTs5v3XyLh0yLqCGTXgK0l9ugGt6rKK7twL7ge3itB4IaXGPBoD
         E/GbeApMBqQaJowRSwYDUoH9MI8JauBfHdxOyXpjkFQAUA7/f9zoYoOXz+bMCMLmfg3K
         Dj1Q==
X-Gm-Message-State: APzg51CG3QWVDIMLE1s6m0+CTuas1bG2+RVMXu+SroRRWiP1Mb+U8FvK
        gknTF/yGt24sjS9cv6Ob3e1C0DN3myHkLxphdaXkJg==
X-Google-Smtp-Source: ANB0VdZ6UCoKPwlERy5/OOt/nM6NeZBMm9lHMzFg5UiOAOHiYXDGpoqPHtwdVvOwZ4MCiEbEsX2r9rHfjLnQpGiohBQ=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14896628ioa.277.1537308461782;
 Tue, 18 Sep 2018 15:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 15:07:27 -0700
Message-ID: <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for MT8183
 and MT6765
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> v2 and changes since v1:

I had trouble applying the last patches in the series so I applied
all on an immutable branch (ib-mtk) then merged that into devel
and added a patch on top to fix up some GPIO includes (just sent).

Please check the result!

Yours,
Linus Walleij
