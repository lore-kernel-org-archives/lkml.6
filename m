Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A6DC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95743217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2q4F2LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfBDGHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:07:20 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46576 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfBDGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:07:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id v24so4082551uap.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KG15wM6Jwx9Avl8HGL6Rq2KKwKL64VNzgD6ZPPI8pTY=;
        b=X2q4F2LNVwkuzn5p6WpLwB3s2R5YFu7qGAr55eorUXnrm0NoV8nlSzjilmwHg1qcXl
         DD6qzO39oFADV329MhsvAveYtE/qJWzZIiMgpZ46M+yTGpYmvGL4fp+KV+aoDMRxJP3L
         ifeZ7aS7tZsRCC4eECwsQwQ31mQRPrsQlY9oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KG15wM6Jwx9Avl8HGL6Rq2KKwKL64VNzgD6ZPPI8pTY=;
        b=PxF5a2ctLjhh3p0fAPBuHlL9QVMJWlIDwOtgqg6GeJRgGyczbQe3v85wi5xQiA9fNC
         dNkL+G0/chvm2VsibcoWtP86zAGAB0/jgDOmcubVG7L3iv0wUprq2ePdpokXaxnUKiFk
         qaVR5D+6eGdkdQoFRwAJj8TrejvqXzvu8PAWTyIlCIesgVE7O6s4EUwdmbWqpbY7GcNo
         2CJqNq3JZK40aXIyI1cu3JiVu2tyqMAIO/jiFj4Pt7/mHM9EBVqa/1lljPI5Tdlu9tam
         5b35fl9dsz9NZ5KnzRH33KeAW9L3SiaRD1gYa7zUkHoO2WU4BQrxCR6sxy7+N9e1qgQq
         /ZAw==
X-Gm-Message-State: AJcUukevFBr/gLcy+WlR0Ky79CFoUeU4wOAjQ4JoUd3oDm/JgXaQgUiC
        GZ+xHdt25T41tybQAv8w0B8xNt6tf6oI1F/WQUwUJQ==
X-Google-Smtp-Source: ALg8bN4FpJdHRTRWA4ygDlfIdgG0Zg11v1m6of6DJzSd7yJ27nXx183e6ThqUE4MLG7Ixl95gvAUFuazndfxxCxBKSo=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr21397916uan.107.1549260438893;
 Sun, 03 Feb 2019 22:07:18 -0800 (PST)
MIME-Version: 1.0
References: <e944650d-514f-3727-2e68-b318aab9ee7f@web.de> <14a011aa-862f-7132-8741-df5173875f34@hisilicon.com>
In-Reply-To: <14a011aa-862f-7132-8741-df5173875f34@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Feb 2019 07:06:41 +0100
Message-ID: <CAPDyKFqYWGv7bWW7rcCYhc-PdmRCBdskUTycFxK25VQgd0TWeg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: hikey: Give wifi some time after power-on
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Jan Kiszka <jan.kiszka@web.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ryan Grachek <ryan@edited.us>,
        John Stultz <john.stultz@linaro.org>,
        linux-wireless@vger.kernel.org, "Reizer, Eyal" <eyalr@ti.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 17:34, Wei Xu <xuwei5@hisilicon.com> wrote:
>
> Hi Jan,
>
> On 1/24/2019 7:52 AM, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Somewhere along recent changes to power control of the wl1835, power-on
> > became very unreliable on the hikey, failing like this:
> >
> > wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> > wl1271_sdio: probe of mmc2:0001:2 failed with error -16
> >
> > After playing with some dt parameters and comparing to other users of
> > this chip, it turned out we need some power-on delay to make things
> > stable again. In contrast to those other users which define 200 ms, the
> > hikey would already be happy with 1 ms. Still, we use the safer 10 ms,
> > like on the Ultra96.
> >
> > Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Applied to the hisilicon soc dt tree.

Wei, can you please also add a stable tag to it?

[...]

Thanks and kind regards
Uffe
