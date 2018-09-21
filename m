Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62108C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198C221557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ET3kI7xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198C221557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbeIUWEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:04:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33569 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:04:09 -0400
Received: by mail-io1-f67.google.com with SMTP id r196-v6so12824860iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJ3KtydreSwN5BR6cwgUf1jetzEptleJfeEByLlhiY4=;
        b=ET3kI7xBX0F1XYD4+XgS7LlNu7nDX4qrOWyzuteUXsLF/tjHlNlj51EBog51aWDlVV
         Zozz3sMB2f4y0hjSF1IgVEgWTm/4T9a1O85LyWpOQQ/KPKI7I+SHjVd1IB0PUEIJtcQ9
         dlA0Zi/IYfQSLmFc72t198kuUk3TpEWnGvTlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJ3KtydreSwN5BR6cwgUf1jetzEptleJfeEByLlhiY4=;
        b=X3zsCKrFxvVwNmNWaT6sd3X6igmfkraLKznDiZswD3wtg82790/j3txG2irrp3UJXW
         oPEv3ZVDvBb4KpmeaMh7PmFMMDkad99nTYCEfPS1xW25EQgHge5ceHlNcZM8MK16MfQj
         ck5w7/zTDmU4vWFjlVAYYwdOu14JnabQEoRmk+vBxZGY8qobUjeIJq9qJ1EExTOvoZkP
         gRKm09v+KvMeK0hxBfR2CruOJm45YNoEEawdMsdGi0eTup5Kz371mz2q5WXFRdg5ssgV
         gT+ubtrqWhf3e21OFKQ6BqjgCpq1Uomx+YRBXN0zwqR2C/wwIPkLqtOEdM7jEcYmm6BO
         3BwQ==
X-Gm-Message-State: APzg51B5xwUxgkDEaBEmuL0sCX/oK1UWXV7XGY1m2CseQIkZVr/c1i3G
        ABD3xTm7E7UXb2L3ZCsSJPSP8blT7hfyVMWqt7t1Hw==
X-Google-Smtp-Source: ANB0VdZrn1ixifMv6b3+spEpIaYYI4TfqIvx3NiQTNA9gTW1Mejel3Aqq1oM2jBYmmbCi705X68tnA7lYxflhTMOAFw=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr37078278iof.304.1537546474176;
 Fri, 21 Sep 2018 09:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
 <82d47055aec8e40422eb72568e96bfbaf199d9d2.1537502494.git.sean.wang@mediatek.com>
In-Reply-To: <82d47055aec8e40422eb72568e96bfbaf199d9d2.1537502494.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 09:14:21 -0700
Message-ID: <CACRpkdZ5Un1s5qM92GsLOjW0yQTvitzi9F7WVJu87DhSckSn7Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] pinctrl: mediatek: add eint support to MT6765 pinctrl driver
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mars.cheng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:07 PM <sean.wang@mediatek.com> wrote:

> From: Mars Cheng <mars.cheng@mediatek.com>
>
> Just add eint support to MT6765 pinctrl driver as usual as
> happens on the other SoCs.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
