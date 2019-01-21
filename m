Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12667C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3B52085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="as2GmtpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfAUMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:47:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38921 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfAUMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:47:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so17414308ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdJc8luRTCBHnRySb7sJvLK4WClf7SA9Ms8/zMxQTTQ=;
        b=as2GmtpB5+fGd3vH7KaOkgI2ZH/0jffc6ubkgoTi5KV/1D7jWy1wmX3o2M3rgVWZ/U
         DBV/BQcsdcmFb6thYbWpcrEuP0UZmQmhSFaFRjFuMK++KUyhqm7GcHA4qqQdIJ8IrPpT
         RXurFGVJOu3oE7m8wOG12IbtaiCTJbtZRuCjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdJc8luRTCBHnRySb7sJvLK4WClf7SA9Ms8/zMxQTTQ=;
        b=C5jow1NN1TacM+eimWVcMLTve9aq7E1xNLfUGODQb1+zMPnSzOL24LPSVbYAGDIQw5
         NqFzMsbRfrqKgfa++POOdfRAFAZSY7T+5BT4tKFhDlWjl8k8bKvozSCmZWeedqkhWM1O
         GXTlHBcJpPG3PXJgKnUDt0VTecikGiLi2Ew9O9AD+cSByV+lvwQ7UjBHBh/flfBKRj0P
         QepNirGreqtAZIFfl3N1PjdZq0YWHs01H6K2MU7EXdfiDgGbwdp/lmAzSdYtYMutr41Q
         6tgiWcUoEQD+m7clPFMnokY6eb+HJi/CqJE4MkJfLAJo7lHg9bZnIQ7YKAtirAYQhPqF
         B+8g==
X-Gm-Message-State: AJcUukfB8NSJXrEGmc/VJFF4bvOzVt3GH94pAHsOzNZ6ZOnBNoHyADNg
        VoUajbzF8TiEgSYtSYVTr6wOdO4PAGdG3ZNVVsvciQ==
X-Google-Smtp-Source: ALg8bN7X13Fb1Ev474fISC3A/p+04bUWUxOA7Uop6VtuOVTEGYSdiR9+NHJWeUUD1Wbxd2+1J0xawd+zmStTbhsK3gQ=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr16086307ljj.120.1548074863797;
 Mon, 21 Jan 2019 04:47:43 -0800 (PST)
MIME-Version: 1.0
References: <972fd6c1a222b35159671ca82fb63db1632c3ba3.1548046988.git.baolin.wang@linaro.org>
In-Reply-To: <972fd6c1a222b35159671ca82fb63db1632c3ba3.1548046988.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 13:47:32 +0100
Message-ID: <CACRpkdZwFX4_LQoyVp8OxNXaz3CN9fJHHAcyeT5FzUrY0DMytg@mail.gmail.com>
Subject: Re: [PATCH] gpio: sprd: Remove unused irq trigger setting
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, neo.hou@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 6:06 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> The Spreadtrum PMIC interrupt controller has no registers to set irq
> trigger type, since it is always high level trigger. That means the
> PMIC EIC controller as a child device of PMIC INTC does not need to
> set the trigger type, so remove it.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Patch applied.

Yours,
Linus Walleij
