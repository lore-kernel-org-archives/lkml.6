Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB92C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F362620881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3t1WPKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F362620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeG2Vee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:34:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33886 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeG2Vee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:34:34 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so7417830ith.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlfWHObULu0Um2ZfZuXQQbwt8xKHWpOhNWg2Be6oBzM=;
        b=h3t1WPKLqGy2MKhiuoOtB2AZGZR4dJaCHNNvp138IWNx3yAakyx94FRG+/OshhMu6h
         KlXMe10XTdLE5jq9cKmnik6yY+LUTMKSjeTz2hGqdTgRHHjrXg9F/oOzRTjMocSXjO5b
         xIsRMtcTrcJoB2brI65r0zCDBpnLl39lnywdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlfWHObULu0Um2ZfZuXQQbwt8xKHWpOhNWg2Be6oBzM=;
        b=pylL/fzopGDJRAwcETD/2KfMF6aU4YCiCiVoHkTCqJ0maNvV90N2Ig1y2J2Atvftxy
         V7SK3zMMGdNhoUvvwWXRa+eWSbYKjZX/7I/urmoP5UyxdZ6PSzf4A5Eujp9pwoBGeOxo
         9BPBCzu61syRuC9sulooYyksYzKRFtNiafeNN0mQ3MOyUdxfDaogEEfft07Bsw3L3xtg
         lGfWI2vcwe3TLTuBd5rLmyONu/ciPVSnttg63E0JNxVdQdDTjs+gGmV6nuVTMrmL7yzy
         dkAyWQYasVfrDQqqOFiXRcKEvBk8clOxzSylLr1Wq4rKz/nqP9XOJtkKjxCVyJ2OBqxt
         upYg==
X-Gm-Message-State: AOUpUlEysyJFeeB0SD1TbPGFTpDBzfMXI7c7epSpuruTwOAJOAOdaiO5
        XtlTR3qJnWi3k+Q3PgsXAqlkiDWf1pb2VJQtW4tZPw==
X-Google-Smtp-Source: AAOMgpfJabvLwrd9HkpgyDntc174yyLqwJrtvzm87p0U3Up+olMN4S2ohtOcawx9c1SYRvWr3mOaxSHH7BmowhDyjgA=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr14116993jab.87.1532894576251;
 Sun, 29 Jul 2018 13:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com> <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:02:44 +0200
Message-ID: <CACRpkdaO4-7ODpTo02mJjx167NH42QnFGj+hBRq3p=2-4j0iew@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: stm32: fix bank io port number
To:     Alexandre TORGUE <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 2:57 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> In case the exti line is not in line with the bank number (that is the case
> when there is an hole between two banks, for example GPIOK and then GPIOZ),
> use "st,bank-ioport" DT property to get the right exti line.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
