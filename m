Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F542C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E305820898
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgtRBHSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E305820898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeH2LjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:39:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38637 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeH2LjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:39:13 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so6014918ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DDAKbSLrjPXiyeHhBKSLKKCWbarsLJa9tjcfedxeyo=;
        b=hgtRBHSDoKByIjcU5mivSShK1XfMgmRNlQ2yds1Q0yKt+OKOwnyoIYHEcOO+RcH90a
         Ln8CogLcPV3IMBQYYBMgR0xaHr6runmahyAUeC8iT1LVVcpzcmt0T//Dn8ShGjfTRMC3
         5UYYidjPhyIxGKz8Vu8Hu36v9pOxbFmNtFd2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DDAKbSLrjPXiyeHhBKSLKKCWbarsLJa9tjcfedxeyo=;
        b=Q9wVPBiUglkhKM4xXl/dxsmS3sCSq65Nzbm2+TjmSUzoy6/VqSk8hLct1BAr2QYikr
         S7tIWl609bgaIPCfaS9aWdr+A1vVoI7S6opUdHqmw1nH/Y0fqXu0yO+7eFcFCJSQCN/6
         G2IQ9QW431uMCaKd4IyfVHlkKrORA+kP28/rs3Bi3M0swqoymsmpLx/bxFkGoFYk1NTd
         8PYQI2/2bCo+vbIQ8b4q5zYwqF9ClPYNjLyHwSeD5MEvk/hnkvF+76YsRWJHZuWpiiE7
         0RUPQr1YGzy099f8aqZTzztrBYCkfkXNv5gzWrUEDKChOrxHrWtVzX1ZpC6je/gkyXd8
         sDYg==
X-Gm-Message-State: APzg51BcFuycvmdX///Johk1h2+K7pc5XwURf+x+fR3yHfQsRlW6Lwvx
        dhiLmfe1GGGTlcByGnRR2wIXg5+E6Gui6MU7FFcSxA==
X-Google-Smtp-Source: ANB0VdaZjcyijibOq9OBqQoFcNNUdN76mON+47u9PB4dPN5QnH8v275kK+i+VS4xRz0hhLW4A3/xzBWrkEe0m/91jlc=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4089951itk.62.1535528619556;
 Wed, 29 Aug 2018 00:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180816200648.90458-1-swboyd@chromium.org> <20180816200648.90458-4-swboyd@chromium.org>
In-Reply-To: <20180816200648.90458-4-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 09:43:27 +0200
Message-ID: <CACRpkdau5Wnsq3NO2-HY_XSZ3TJHcX9hYU-W46ng+_BwOviqGA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: msm: Configure interrupts as input and
 gpio mode
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:06 PM Stephen Boyd <swboyd@chromium.org> wrote:

> When requesting a gpio as an interrupt, we should make sure to mux the
> pin as the GPIO function and configure it to be an input so that various
> functions or output signals don't affect the interrupt state of the pin.
> So far, we've relied on pinmux configurations in DT to handle this, but
> let's explicitly configure this in the code so that DT implementers
> don't have to get this part right.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied for v4.20 with Bjorn's ACK.

Yours,
Linus Walleij
