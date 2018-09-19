Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809092151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K38XxkW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809092151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeITBRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:17:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46865 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbeITBRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:17:34 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so5444255ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InO57H590H+fENKspG9Kt0sUdwBisPVmTNeTGZWJLA0=;
        b=K38XxkW9swqobP6nOjqQkzQQ/6DVOMz7PcAJfZ/WY06dAKlweYdRFfwiyEfrWpxDTI
         U6qClP0ZO5BgPkphcSaJYd/mDYTyLs23w6uuGJFU3xqPNYzV9UZKs3FyOCdRJ5AFcj5M
         5MXQlCOpTwHOn8SvM4aKgKpQ/JsDPUg99yaHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InO57H590H+fENKspG9Kt0sUdwBisPVmTNeTGZWJLA0=;
        b=ulBFLr0PPs1AdQyGw3I4xnyP0reAH68J/i0kl6dmiayqwmkyN4MQVePyTxzMZdbymH
         83Iq1t580tuKKPNuuJa2FFnPv06aVv7RtFZDqRw3kkGGPPRTTqNsiX+jpnMtI4l4tPFs
         BoRZowdKYSABVPWyF3irJff9/s20CmBRsI3+O2TC3IyIQgZSqcxwD+FSUNN13WIA0G3w
         d3N6QR0wVz5h1gz7023j0nVZPUVGMpul6ndVgZEHy2ESvtBolXjz0CiT3R4sgWBPuipS
         i0bAhIpc5ZahAP9BPAzfqSi2KJXNuUOgDRiVqz9FOlfxmUCjlRB82B/moks/WFMrk2Lr
         mMhw==
X-Gm-Message-State: APzg51CmIBFkk77XYpL0FYb5QdKyOwcS4/x/M9x01Yr6HHL//tGdYw5b
        vM71LWnEZru+/2rfHyJ9ly1auhGuICeUU4V3u8S5WQ==
X-Google-Smtp-Source: ANB0VdYVOGYWE2GmBpr1shq2x5M3K6Pb38JBvTjXM0Xntsz3MbQYdcphHneCwi7WZREY2XXUdQ7f+0fydjfB2xwDOWU=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr30236550iog.175.1537385890483;
 Wed, 19 Sep 2018 12:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com> <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:37:58 -0700
Message-ID: <CACRpkdZBeHC3EVzGU_GNSeW_y7FBbsEibOO5JPi+LD-jhzSooA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
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

> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

These bindings look good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If you want you can shorten the interrupt description by just referring
to interrupt-controller/interrupts.txt

Yours,
Linus Walleij
