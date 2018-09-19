Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C6ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB2720880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="daUlNlKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB2720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeITBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:19:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36227 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:19:41 -0400
Received: by mail-io1-f67.google.com with SMTP id q5-v6so5485496iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WY/6CssEJY+UuFJLT5i1WabJ4VIBZWRlZfbbKOvaBQ=;
        b=daUlNlKAaPdQ8tpL0SqzZXye3SgmtdMr0XarkDF6AfuSyfyx6v963bedTWSSsDawGd
         JsloP4fR5GkVU4YCy4yzQRBlCDrH08nfroLiBV3Cch13mQytJEEpWykZsbgLDSKPVYrX
         qV881Z69jSVW1ivhoWYMh8O0E7GrzcATAEa4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WY/6CssEJY+UuFJLT5i1WabJ4VIBZWRlZfbbKOvaBQ=;
        b=dZY40jTSuIcT9tr5EGtO60bVhgK01FQxa48ZEFQhXcda/v1TsNGNoUm8XvKubahHFo
         5X2zmGbVjAABqTCxtU9XaycSGxM7JjgZN3LO/IpzqSRHKz0X9XuzyiC8APDgm3VhRTzJ
         H7/iQ5FIJSt/18hw/sr8RfYFQou0W4vvIJh/xdsWsY0diz1DZR4Kx3tHfHs0X6eGOaFV
         kvHj1nDZkF1gwMng6ea/Y+Vdz/LPfQLrUxdMHUQ55XDQWC0+M9/b6RB/zv1fRitSLBf9
         nnYGQ9/O6RQux1TjR21J7STZ+UOzZlcRbRVcPMk7juCBRVZ/mIHN2AHm3hkdpczI62KH
         ls+Q==
X-Gm-Message-State: APzg51BlRR1/xQfbePfSj9JeKz4KBHQy6MNwPAows5xQGvrTnINqvLBO
        VELvYuoijNrmT9fFOyMiwqQ4D3yhp4ITMW4m6+/vq/ie
X-Google-Smtp-Source: ANB0VdYAm3fKcUm3WoEhoHVSqA2FtC4y1UQvIRfcLJ8uv9+k6bd6uchoZGG99son+vjYpbEssdXOtW831A8gnF6g0fw=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr30242421iog.175.1537386017088;
 Wed, 19 Sep 2018 12:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com> <1537363669-25991-3-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-3-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:40:04 -0700
Message-ID: <CACRpkdYLiBsCsFw90zGeYDpXh6wKyiqG4cJTuq+E7_2-9iXh1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mfd: Add ST Multi-Function eXpander (STMFX) core driver
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> STMicroelectronics Multi-Function eXpander (STMFX) is a slave controller
> using I2C for communication with the main MCU. Main features are:
> - 16 fast GPIOs individually configurable in input/output
> - 8 alternate GPIOs individually configurable in input/output when other
> STMFX functions are not used
> - Main MCU IDD measurement
> - Resistive touchscreen controller
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

This looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
