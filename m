Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67902C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BDD20873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8lTktlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BDD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeG2VqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:46:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39542 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeG2VqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:46:20 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so14091597ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZefVeQjz/Bp+bhV02lDkI5lYW0WEGa4dmnSRHna9SXw=;
        b=I8lTktlB6VtBJKq8dCYRr6dDxWBYEMTZk4IYtflkEHnlP+kxdgaDtWdySbkjM+XyOk
         isj9uC9/ZiELWh/j5cpfxfzY8oWaO5HlWCMxY7o0i9+PvF7yEcBmP3TRObpXlvvI4AYP
         aD7b/WKm9KAXxz/ap01YeykYp2qalSR2rOalw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZefVeQjz/Bp+bhV02lDkI5lYW0WEGa4dmnSRHna9SXw=;
        b=PWz+JMn+cvCfp+knraCId1bX+lF7h9/Xkqht3pFPrgW9lDYcbIfYrn2ymK5gdxARRk
         HH8sl3QFrVzfvGpfVTY9lH3YQOEjV7pTtKcN12s6WSBw2vrLM4tOmZyHz8iq+d3zX9gy
         r46+c/SwzmK93AHLtGXUpQS9fHz9jAT4puJ9bdxDa4sWOdb0/1By5/8JTkVmbTOk2y7X
         1wCCg3hZmoyinbSlAlN9/rM4KTPQixPYQCE1c7dZbEQWck82xSUlEA8UEarryTc9heL+
         DcDWQr9bPiT8VeCrSWLl/GZSlcG3ynM+ekCJMWmApFgFymMMXhPqymcedXs/qDm2Ijar
         p7RQ==
X-Gm-Message-State: AOUpUlGmbZ16sfylpIREb0TpBJiKsVDkSee36jYj0tumC9YjOn9dgo7p
        ZmeX40P1KOOZjV3e4ZTsUFAyuiApCI/r3jCL2cj1Bg==
X-Google-Smtp-Source: AAOMgpcBF+J4C7F8u5Cn7MwFYc4zKQ9F+SzLTQH0xMDq8OhlC7XOyfHklyhV+App35NKftDwNBUxTvtzOvJJ94qlzEU=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr12496374iti.135.1532895280504;
 Sun, 29 Jul 2018 13:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com> <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1531821387-29845-2-git-send-email-ludovic.Barre@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:14:28 +0200
Message-ID: <CACRpkdb1OEQ+bsymueBTVwi+Qv8PYsxqipVWuLputdrhz_OgfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: add syscfg mask parameter
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:56 AM Ludovic Barre <ludovic.Barre@st.com> wrote:

> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds mask parameter to define IRQ mux field.
> This field could vary depend of IRQ mux selection register.
> This parameter is needed if the mask is different of 0xf.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Patch applied with Alexandre's ACK.

Yours,
Linus Walleij
