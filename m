Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03066ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03AD208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFoZ4VJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03AD208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGPITC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:19:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36784 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeGPITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:19:01 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so36895591iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37OPrp0hyc+ProDq1mg4oTeP0vfT5B+jGTUb7DC5ToU=;
        b=QFoZ4VJCB7qQeiKinBl1d8vLOeMBIwoNmDvX1r/KWt5HoT6lQ3FVN3xg33ThL+/i/j
         FmoDij7Olrx1ROFQ7jO9mn1reyEl+e0Hww3sxaBfIzglkl2agyb479cmATF/Q1mIkLqJ
         WL24Vwvm9nkBfJm8U7pmwzNkTHmDmI1YAO/wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37OPrp0hyc+ProDq1mg4oTeP0vfT5B+jGTUb7DC5ToU=;
        b=iDfLNvQteEwvTqssD8wkc1vZAW14ixJh//Fynggz0J7WUJSpAwUHRIWgJ71y/n0VfE
         q0Vg6AVmcr/08enmsTf2Seo4+VBk08YBT6sURvVw9OUDpKAP0CWkI/jDxWiDEfBZb5e8
         +FWTipX1iel07OstDi8PsV6V6ufrryHKqqlak9KRjOxkkQbdzWr6+3KJE88pWgqJgdRo
         jfAuouLjGglhRYRsloF+12PlqDin7jWPrT/6ASSvp2faStTqueuS2lapMOznZ9+ztRj9
         7x2IqcJAugX58eV0gKr710HVX6L9HZDNczepyW/mGO3FYMGFaX74y2ZUd4ctgRWiQzUw
         366Q==
X-Gm-Message-State: AOUpUlHnbz6XSgETOPPwP7sdGPBLOMnr6j2X5gWoQABLXie6rgqS6A5U
        OGl3AH5phDljvXQYXXQPusoelQg51K24enrHdcOKnlp71Kc=
X-Google-Smtp-Source: AAOMgpeYyMkzhIaldKbBZymv2kNv/7jMZodZqEaLG4l/7YFnSdw3dDuv3L2eOrjW4t+0HQRPpiQkREQqMpsyZ75478Y=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr37801078iof.304.1531727575690;
 Mon, 16 Jul 2018 00:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180716081018.21bfe495@canb.auug.org.au>
In-Reply-To: <20180716081018.21bfe495@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jul 2018 09:52:44 +0200
Message-ID: <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:10 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commits
>
>   bc319333c156 ("pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions")
>   99500c6a4836 ("pinctrl: sh-pfc: r8a77990: Revise USB ID pin name")
>   3d3c62d3458a ("pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and functions")
>   1e0f13198edf ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions")
>
> are missing a Signed-off-by from their committer.

I am looking at this and I just feel confused. Top to bottom:

commit bc319333c156a710891942d34560b9fca0f52f5d
Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Date:   Thu Dec 14 13:04:55 2017 +0900

    pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions

    This patch adds HSCIF{0,1,2,3,4} pins, groups and functions to
    the R8A77965 SoC.

    Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

commit 99500c6a48360ebc9083c690add888c17afed519
Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date:   Wed Jun 6 15:43:04 2018 +0900

    pinctrl: sh-pfc: r8a77990: Revise USB ID pin name

    Since the datasheet Rev.1.00 has an error about the USB ID pin name,
    this patch revises it.

    Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

commit 3d3c62d3458aef24f819834791c364c9f86146c7
Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Date:   Wed Jun 6 15:43:05 2018 +0900

    pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and functions

    This patch adds USB0_{PWEN,OVC}_{A,B} and USB0_ID pins, groups and
    functions to the R8A77990 SoC.

    Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
    Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1e0f13198edf47d0df1a8c0561eaeb525eac2154
Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Date:   Tue Jul 3 19:53:28 2018 +0900

    pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions

    This patch adds USB30_{PWEN,OVC} and USB3HS0_ID pins, groups and functions
    to the R8A77990 SoC.

    Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
    Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This is very confusing, it looks correct to me.

As usual it must be some minor syntactic thing like a character missing or
something, I am just soo.... what's wrong here, really?

Yours,
Linus Walleij
