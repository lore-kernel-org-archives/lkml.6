Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FE2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD221A58
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RURFBtOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECD221A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeGDHgo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:36:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42549 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeGDHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:36:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id p1-v6so4244160wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5XAwX8QZ1/PIpjP+clDZkzj+eRcmws3MaJd7wQkrGMw=;
        b=RURFBtOTKn9UAiyF1YuGchEZOMVrnQPGK2shvOBJFa2OV0UJBr/HDW2H1s0/8INSE9
         fCKvS5zUVpqQ/g2vhddJ22DsjEkDeYYpRcR5JhsAffeib3ci6tW8hkF3YkvhQVjKVv28
         Jnfib8PBGzTjf8WhlSUEfeOZbM2w20FPn3bcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5XAwX8QZ1/PIpjP+clDZkzj+eRcmws3MaJd7wQkrGMw=;
        b=koikV0JFT8+HlWn6j9fvpQEWuVf3rCB7oFmPFVF258C7ejJkRgcsfbu/MmWWozEO7L
         QK8WZuqX/e3XDo9IN9VGBqyXriFDiKtCi09yucT9JuF7VzbQoTVlK+0LR61kJmgNedRf
         3V7vyi+gGEvMZWL4e6ooywHyZHqatSihUARgZmmHsb6aP0EOniKqpxz4bNISkQgPe8qU
         t5GCBEOD1xDE0Z1pqOeR5zpXdfvuZgoxjLU37hlzFotcmsezYw6ks7RZOwjlyP7/jNBy
         hvEaMmqPjpH80m2RAHMnAmEXx/jZHyme5Zw1JFb6wOCk7Orht6AlfmPzEpqSaTxgcdoC
         gTPA==
X-Gm-Message-State: APt69E2TI1KdUHJdbtmKczOsqMLzXn+lO9lyvM6apXBWMA3aowGU992H
        5rEq06awfDS3/tDSA2AOVBbKmA==
X-Google-Smtp-Source: AAOMgpcaSwDUdVjQmxZG2emx69BOLXkdILDnHsWa7zDDPebDQhUmjPFIpVg7V6YmrVo3U6dMrmzJTg==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr751810wrr.138.1530689802086;
        Wed, 04 Jul 2018 00:36:42 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id s12-v6sm4558681wrf.0.2018.07.04.00.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:36:41 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:36:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     andy.shevchenko@gmail.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: arizona: Don't use regmap_read_poll_timeout
Message-ID: <20180704073639.GK20176@dell>
References: <20180628154935.31049-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180628154935.31049-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018, Charles Keepax wrote:

> Some Arizona CODECs have a small timing window where they will
> NAK an I2C transaction if it happens before the boot done bit is
> set. This can cause the read of the register containing the boot
> done bit to fail until it is set. Since regmap_read_poll_timeout
> will abort polling if a read fails it can't be reliably used to
> poll the boot done bit over I2C.
> 
> Do a partial revert of ef84f885e037 ("mfd: arizona: Refactor
> arizona_poll_reg"), removing the regmap_read_poll_timeout but
> leaving the refactoring to make the arizona_poll_reg take more
> sensible arguments.
> 
> Fixes: ef84f885e037 ("mfd: arizona: Refactor arizona_poll_reg")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Refactor to remove initialisation of ret variable
> 
> Thanks,
> Charles
> 
>  drivers/mfd/arizona-core.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
