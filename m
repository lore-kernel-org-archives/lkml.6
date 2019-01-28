Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CC3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6182720882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu1YuLPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfA1HP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:15:58 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34176 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1HP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:15:58 -0500
Received: by mail-wm1-f51.google.com with SMTP id y185so9675750wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T3+d2YCc8O/D+og224lvFJVFgIGdEPx0FxaVjZOss+E=;
        b=Nu1YuLPTXVVcAWgZ82KxhLthodc6WuolXbyBgCT9+zkKzjKNJy5ZnUYklG8Wv6fQCs
         EKxt0h+AlYRy0jyxkT2WOQhMTuzql2RfdSM5xnGi9OIVy1nDbCTXkTJ7GdC1qzssF5hE
         4SgZh+PqFQ+i2jNZ+q8ouXz0rW3a4/lLDWV5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T3+d2YCc8O/D+og224lvFJVFgIGdEPx0FxaVjZOss+E=;
        b=hjfD4hHRMh1JivHwd3J4UR8GT/aDBOAHwdNNk0Ec/jCmXZ1xvxqgcU0HoxgCPQx8Ln
         EXHq56R9DAOhHtoxkSfUbyjVe2znW51zhWi191pA/vN2iu0Bv9FbutkSPlc+TFw3w2/f
         sHoEDUfJBAa5MA+Y8eIxvrS/8ZKZnTiGDZiveSfYM0xI0p/e4Pbk+S/4dk4YLq38VP32
         YLLK6iHGdBsIiMjRZEKkodRlGSUZfjmFModR9inSDI1T71eDYiPMQ9r1WMqCzqTlEv3r
         pGZmEXz47EWip//agWvGmqfLTGOPEnWj+8gSZQlSNZz2H/E47qX5CVCX4JBoIkzZ4xjr
         sj8w==
X-Gm-Message-State: AJcUukcR2Oe8o3WJI8KzSKNizI35vM/iPwA1M9FPnYmzfnWS0nocla02
        7u8+zsLc0Afwfn4u2z1dlyqJLw==
X-Google-Smtp-Source: ALg8bN4UGAhQcE9PV9zBYjCtaSAv87cJU4ZW8NW4mCIJr1mHD6tnNBnnfPWbkKDkXgrJoei8G9QfVA==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr16071923wme.16.1548659756034;
        Sun, 27 Jan 2019 23:15:56 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id p12sm73796850wmi.5.2019.01.27.23.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 23:15:54 -0800 (PST)
Date:   Mon, 28 Jan 2019 07:15:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     20190123065620.22250-2-markz@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
Message-ID: <20190128071553.GB4678@dell>
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jan 2019, Billy Laws wrote:

> >This patch adds PMIC configurations for low-battery
> >monitoring by handling max77620 register CNFGGLBL1.
> >
> It might be an idea to add lbhyst configuration here and support using
> custom lbdac values to specify a different cutoff point.

Do you know why this email was sent independent of the original
submission?  Something wrong with your mailer?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
