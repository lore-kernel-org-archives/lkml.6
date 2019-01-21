Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185BC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AB32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoALnmII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfAUN5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:57:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35584 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbfAUN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:57:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so15566796lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doSyHQLOS4rWfmx54arJENuXimoCMFHCJpGs26MCLlY=;
        b=XoALnmIIS53acMM5HwwGzVRTxgam9ePjKCTfq8l+WgxukQ3BfkhxKRicS7uJqEb0EL
         7cDms21gv6ZDV9XZHmV+p5uurCAdpFgpOx76q5FAxanbnH4FOqk+mbhUGNQIKAmO4h7a
         Zu90CnqGl350svXygiUFw/pqLJ1f1bGSIv8f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doSyHQLOS4rWfmx54arJENuXimoCMFHCJpGs26MCLlY=;
        b=M9jO49MK2NeBj+Dy9eMBHspvxwQI6yusCTPKemh/R4fSXgMO9FFWKFG3Lk0e5h6J5W
         rAaCSUCRioGF7SkWenCvvgZ2Xyddx6qraRsL1iTfz2I7SuHnSNM4rL4NzuwrPBYCYsgW
         EMuYyCGfYe6Fqa9RGYkDzwyGMGB/M5sR9xIkw43VS4ptZITMXxzBCNVeoIKBZbPeUOeK
         oRMqIlyixfXum5Urh1e2qc6HIRnkVAUD3ImIt46tmCq60C/METEWBZYOG5GNZ7nbbGeK
         LQSeHJWTeBv04RVeEyEvPDdpP5JOteSJ6qvwPIATMVrkL6i77s5WjEc1J0H86ghtZgTU
         gHEg==
X-Gm-Message-State: AJcUukc1fU+DQaBnNGqE0iJH/DIjzFtE4URyaOk5Mqdu9iothdLeFHCg
        Xh61TZt6b5FupINNQgTiNhl0myLpsoRLcM+IzkCXJw==
X-Google-Smtp-Source: ALg8bN78kiRX3YmNQt0pCKV36IdbbzCbUwOVDqFSwNv42EDKQfTTyNG6tUS4K3pSQe/1bCUwWJ0BD97TqhrZZDRl1is=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17907232lfa.62.1548079066808;
 Mon, 21 Jan 2019 05:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20190118033229.22553-1-jiwei.sun@windriver.com>
In-Reply-To: <20190118033229.22553-1-jiwei.sun@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 14:57:35 +0100
Message-ID: <CACRpkdaX5O6j85L83KyMN3dxjkzrgSdhMRm5BwFb58fdMdA2+w@mail.gmail.com>
Subject: Re: [PATCH]spi: pl022: add a message state STATE_TIMEOUT for timeout transfer
To:     Jiwei Sun <jiwei.sun@windriver.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 4:33 AM Jiwei Sun <jiwei.sun@windriver.com> wrote:

> When transfer timeout, give -EAGAIN to the message's status, and it can
> make the spi device driver choose repeated transimation or not. And if
> transfer timeout, output some useful information for tracing the issue.
>
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>

This looks very good and helpful!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
