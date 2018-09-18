Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B82C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEE82146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdCR4Klv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEE82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbeISBcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:32:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41740 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbeISBcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:32:07 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so2606947iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNO6T3Q46JzPZSEL3gIj5AmPSiqSoKRvPsO+DHHsmI8=;
        b=SdCR4KlvxYGS1HnbEtu8HP4aW0Mx4AzrJrk8OCLGXOJCLeEIYDWAi7CqWcEH8lXqcu
         VUjUvlt4/31gyLwt817tdZ6g/pPG5hz2gwE+uAZUsahp/QuFOHj7zyvf4pgPPfBycK9H
         /q4N5N+UHPTPH2l33DRsacSjWXU88qb8bhpv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNO6T3Q46JzPZSEL3gIj5AmPSiqSoKRvPsO+DHHsmI8=;
        b=D+NqdUs87ZdNQZD5DYzygBRstnXw2mjQ1CpUY9yFhGRFrw1eoiimibdhR3XJ0YRO20
         OIihJXNqWmV7J+JRq3nbr0sME1RVopei7PJNW2NkZgaZwt1sCfx80Y2djzEUCipGfhgc
         feOx6gpqIC6cqvf1RSAk+s1wpkVsAyc6Lu2W6DRu5RrTeNdiBacd6qkQnXc5yg8BZfs7
         qjQ3may5jd4dchxt4hzP/v0oAcpno04Z6faQRjREq5w8m5p5HT6EDIq2S/tXg1iR1Wug
         zOIQlsno4njwFdpn6z7tLsYB6HBH8JjOaAhQH7mGwWoI3ubm3DWdsL43u7FSDaPSfVYz
         3HpQ==
X-Gm-Message-State: APzg51BBc0O0AAa1rmjYFD4ZFqowTPrIU/Gc07yAWf/jOGo6nUlJDndk
        4BphnhXKPnL6eg7pWaz7tImZfRnIZ74AbiONunC8ZA==
X-Google-Smtp-Source: ANB0Vdbjq+QX+mX3V0otWLvof3wbqEgnGvMWecO9EBuB6yOfSlDjnb3pRatIrSP/9sUDyxr1+BaO0yf0m8W819y9j6I=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr14522237ioa.277.1537300678945;
 Tue, 18 Sep 2018 12:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536404280.git.sean.wang@mediatek.com> <2873ce93abf93d31a160c7dcbf5b3ff42c5e3886.1536404280.git.sean.wang@mediatek.com>
In-Reply-To: <2873ce93abf93d31a160c7dcbf5b3ff42c5e3886.1536404280.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:57:46 -0700
Message-ID: <CACRpkdb6_bbNu-3mipymAbNMs8Wt-HGMegkj3vTt1cW6mmNV2Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] pinctrl: mediatek: adjust error code and message
 when some register not supported is found
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

> From: Sean Wang <sean.wang@mediatek.com>
>
> It's usual and not an error for there's some register not supported by a
> certain SoC or a pin so that in the case we have to adjust the message to
> print and the error code to get rid of unnecessary false alarm.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Patch applied.

Yours,
Linus Walleij
