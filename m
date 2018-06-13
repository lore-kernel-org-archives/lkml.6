Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1DC4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8895F208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyDhMSz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8895F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935731AbeFMTgt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:36:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39116 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935698AbeFMTgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:36:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so7539212wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7F/yJpvRCrCkMM/TNmBpewu6fi/uU1k/++e6VtmIe2Y=;
        b=QyDhMSz2/Hl6pAKCb0jARERbZ+N+0ymorewddh9ZTVscv+VvX14WMOy9q8/c8yU4I4
         SpNONJOwYPlopTK3GBNEKJDlXeqIKJFxwczeg9z5YxcitVDlWm4uPKKmGdrDyJ9yy0Qr
         PMc5W9T6vqDHjn7ykmjI9ENe90s1CAZu+NyZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7F/yJpvRCrCkMM/TNmBpewu6fi/uU1k/++e6VtmIe2Y=;
        b=k1nDwPLnv/fY7PdHTJyL85O5z/09f3ftLeJVifVaRnawWmVJTpqEflixpDoBiO8CXn
         ei0IHfeB6ilntLsMB3uhGuqY0YxnKSy1ma+LUiyup8Uq+Jm/XznFIuOSAWH7HITxKweu
         QabuTsDNu9LTigOH0n9wRjH7Vl1mPivueir8pkc5zZQhL/glLfTLD/IidIk5V+ApR8lR
         ZdIry80BwMwWG12UzOKO+iEZgvKY6q6lR/kTwIdNyupNbNJxQQKPqaLm/lJAYkOzs+gr
         jpkUnrJSa4Cbu+Rwd8HL6qwlwHF0egvgi2zoeuqYFfEKGOUqG7NoYwj4SYePsXVag4hF
         /weA==
X-Gm-Message-State: APt69E3ngKWpBS/+6akiK15vnaHWPfJiwwrmv8eFjsTgWibWNxwKmmaG
        QNkYqU6Byb6oyZo2IOhHAwXU9j+w9wL2vmutjQbtcA==
X-Google-Smtp-Source: ADUXVKI/EK7hm3z5u5NY1BRlL+RG1s16a/XTtCbUL5kKZ+/38szUd+iXLcsBi9cL0UCHMGADpwSzakWrqTmxHEYLxJ4=
X-Received: by 2002:a1c:40d4:: with SMTP id n203-v6mr4255143wma.101.1528918600748;
 Wed, 13 Jun 2018 12:36:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 12:36:40
 -0700 (PDT)
In-Reply-To: <20180613180321.16745-1-ryan@edited.us>
References: <20180613180321.16745-1-ryan@edited.us>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 Jun 2018 12:36:40 -0700
Message-ID: <CALAqxLWuUJYfXszaO01KODbom8WykKQKm0X3fzPTwSRK+G3zqw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
To:     Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org, Eyal Reizer <eyalr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:03 AM, Ryan Grachek <ryan@edited.us> wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES. This fixes
> a regression found here: https://lkml.org/lkml/2018/6/12/930
>
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: John Stultz <john.stultz@linaro.org>

Wei Xu: This also fixes a functional regression with wifi on the
HiKey960 board that was introduced in 4.18-rc with commit 60f36637bbbd
("wlcore: sdio: allow pm to handle sdio power").

Could you please be sure to queue this for the 4.18-rc too?

thanks
-john
