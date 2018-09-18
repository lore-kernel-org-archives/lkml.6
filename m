Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B33C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27891206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTT7nF5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27891206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeISBYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:24:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35053 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISBYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:24:52 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so2611359iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+XVKgR02f4L07qLuwN6T6iagXsemj0DUpZWkqk5e+o=;
        b=TTT7nF5xWo8wJDxG5n8O0Vn1vtNnjOCdqNleOj34qjsuzJTieXQNAgVz4htozHsqsM
         Omk3wChm5iMRpyIEOhO7YvK/og3VVyMYdC9fVRwIvSInHdrcptBBLUi9DdNV7lcAQ46P
         vn/wk59uvuAryLfn2Hu08tNxVVNRhx9XdKFgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+XVKgR02f4L07qLuwN6T6iagXsemj0DUpZWkqk5e+o=;
        b=DGiCQxY+8iLmdCvtXScdoskozEv0S1juRFq+fxVDSxLOz31SjGYZ0+D7ltvdUVkrT2
         tw3V3jAMCoaPBvWl1yWZZ/AtxtPQk8yOT1or61NjxkG8BuOGGcvF7bLyLUSuXL1HUCLZ
         nd0zxKaIf65qi3ROt5dR7evK7api/WHIE9Vt7v9BqVOgw8Y1lbMOMtY7dekehTwAd6hY
         iqhZR1C4/DEFH4XTeypwvyuBab1x2UJL7KuQJK7zeRzW052KafNIvHEqUVztVIZle/5i
         2BcDAcmHGOIcTfOrMH+VSJLk94Fsby0yOeg/Q6jS5Wi/R17UY3LkO2hjmvXaIC9wwTgs
         UvGQ==
X-Gm-Message-State: APzg51BQueOwSEXFQLwkcK8PmYaBV3+OV6W03aKR0Qs1q00Gc0G0honH
        sqKAXpoxwtoimtpCIoLVI6urq3/nYCs0DfSdZoeLbg==
X-Google-Smtp-Source: ANB0VdZTtj3rZKgzUiWZ7gQhZTOkRGrHMFO+ApRyu5DEfLgVcbQK5xRWpvIacdhLX+ISkkg4TTM4hYQukjPQzsosXck=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14504459ioa.277.1537300244674;
 Tue, 18 Sep 2018 12:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <af007cdcec1d4e8512faf47182aa4b17b17c1093.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <af007cdcec1d4e8512faf47182aa4b17b17c1093.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:50:31 -0700
Message-ID: <CACRpkdbzXpsVzNtXAD=h_FkiQR5h7728BBQU28KPfhdTLk-Gcg@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] pinctrl: mediatek: add ies register support to pinctrl-mtk-common-v2.c
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Certain SoCs have to program an extra IES register to configure input
> enabled mode so that we add it in the existing path as an option.
>
> Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
