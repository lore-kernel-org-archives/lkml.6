Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB621906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAk/TH9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389413AbeLUKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:07:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41272 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbeLUKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:07:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so4203925ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWFs9n0wuX+juL6C3X3XuBmX2AMe66r/W6oxU0uW9hk=;
        b=cAk/TH9in3xjBto9ngfdj7mpLsF3e7xxGoOp24dpboYgVYF75mNFoUABLo1ppVal1h
         un9sSwWnWVGDIYSUUI1d6ufjPHYg2s4YB8g54Y4SFglphgAzSkPCXq6B1p9tfmPs4zpV
         RkaJfzq5mEN6hsT/FkgOnqycLqXUG/DANac4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWFs9n0wuX+juL6C3X3XuBmX2AMe66r/W6oxU0uW9hk=;
        b=XafPL4XHRNRoQmhbqn/A0Lc1EhzlMtZIR70UqU9bkiQWf4VXWJWo6FBkJgO3h4c3KO
         Ea0zPXYI/ZhGAvBsAJWmRzy/6ey1aHVHVXBP1JyKCJz/xWc9RT9/dPBRB6oOl4JRmX2Q
         mn40CWbmMjf6yz1DMt1WxLtEmMIYxd73FZ+AnvSpyp2qpn2JI6YvHwTXVl3pIltBHUEy
         ubWXUqOhBqIiPlY1xw/Txym5fmBaRBr1IsIOV5MfI7iacnXkDnHwdprTHQfuH9zu25sI
         D+2Oe8vkqEXBoGRmh+Bymi37uKZ12zL7Y2QHu5DXa8tT8dFRhVPkuwIP57Vumxxi2BZK
         RCrQ==
X-Gm-Message-State: AA+aEWZGp7b0d+tsom8qyPUzuDOQbXuyzEVd6VMDm200AVu9JicZ8SUx
        9e3H1XKwmhYslOj/jWLV89RdjiRAXgIyJlfr282LtA==
X-Google-Smtp-Source: ALg8bN535X5Lut3CA/Pgh99+NdqaMfER0nDqxGnW7ep1wEpGtSvfwgphjvbyJogSG/y1OWx0/KjevEGd3vOlqdu9eug=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr1021565ljj.120.1545386872356;
 Fri, 21 Dec 2018 02:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20181210205955.3254660-1-arnd@arndb.de>
In-Reply-To: <20181210205955.3254660-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:07:40 +0100
Message-ID: <CACRpkdYOU1-8Cj9zfYQ7i_gGhM-NrYcQOiZbJC=rdZKxPs_q+w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 9:59 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Without CONFIG_PM_SLEEP, we get annoyting warnings about unused functions:
>
> drivers/pinctrl/qcom/pinctrl-msm.c:1082:12: error: 'msm_pinctrl_resume' defined but not used [-Werror=unused-function]
>  static int msm_pinctrl_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> drivers/pinctrl/qcom/pinctrl-msm.c:1075:12: error: 'msm_pinctrl_suspend' defined but not used [-Werror=unused-function]
>  static int msm_pinctrl_suspend(struct device *dev)
>
> Mark them as __maybe_unused to shut up the warning and silently drop
> the functions without having to add ugly #ifdefs.
>
> Fixes: 977d057ad346 ("pinctrl: msm: Add sleep pinctrl state transitions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied w/ACKs and fixing a typo.

Yours,
Linus Walleij
