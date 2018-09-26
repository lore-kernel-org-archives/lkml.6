Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94426C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF6D2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="My/9e8vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF6D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIZNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:50:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35972 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:50:18 -0400
Received: by mail-io1-f66.google.com with SMTP id q5-v6so22549054iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bogHCDyw8lE4a1plfFrub/iZGu5wvdaYp3004Jncjb0=;
        b=My/9e8vNEH5EShtQFWvjFZFkzCvMUteFLMI3nuL6koc7K1A23q5u7Jt/vwlcruYmoq
         /ngmRD/WAhVkb1hLwYWz1Lc0I0GTh2PSHHrvp7GtBg1yITgCfWTAxpo1dIa9QPs+dh5R
         izy6Tt3hFp6kKN3mWrh1pz+dvK24JuIz8wJcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bogHCDyw8lE4a1plfFrub/iZGu5wvdaYp3004Jncjb0=;
        b=GTX+YpRnBbV6Ob27/PkEBn6aMQAqVHE/Hhyq1FU8rtSVLS6k5AiKA5+plBppFpoUVx
         JZoB4HqufrL4DI3WnxLbcCCgbOgrGEvJAoxNL6KF1ok2Vo4nkKTmZ45A/PQlxFFa6ueX
         V4p3nv34Z9k9CX5auZ73mBewFpIeS152Z2PcwqWfCfb4Wsw5fhz377TfEA4jJU7FKk6e
         0O9NofT09WDV+UA/oZHoM8xZ/lluYpFs7bkglzTG9Qx3t+NWqzJSwyAvlclW9Aas/Q1D
         OHmwzSyOdSIw4H5eeyYmQfCmHukHDk5BOu429z5+O9Q9ODHebMMmIzgzTaRwABeM3BDf
         fNqw==
X-Gm-Message-State: ABuFfoieAK0dwW3MMhI2MYIoCkJVp74a2s7wN77h/Mwu+3UrH20p4wc5
        frYgvWURwEiyBtSXm7FTZiIDynmdTfjk0uLervMy8C5G
X-Google-Smtp-Source: ACcGV62l1N6bdGvRHT4dTbSAOU/hHhO+wdpDb3wzmyvB37cDRrdojKpQnrg/F+XZxBm4ZTsFSRB87ToOrSl3sRLLUQo=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3677550ioa.277.1537947523811;
 Wed, 26 Sep 2018 00:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180924144902.607-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:38:32 +0200
Message-ID: <CACRpkdYtU7J-0g8T9FzaGrbLkWEBPjn+xUZUq0AsJZcN=bvyXg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rtc: ab8500: use rtc_add_group
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use rtc_add_group to add the sysfs group in a race free manner.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
