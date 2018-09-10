Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA04C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5C82086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToyVfpHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5C82086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeIJUWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:22:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33399 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeIJUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:22:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so5752944wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SVUMosySlGmO+E67ykB6ytXU1f+ejqD3RhE+eKO2LCQ=;
        b=ToyVfpHi5l5MtuXUdbnhwIRaCcvmkelWSFjGHEBimzt5ycfZ3dkrhURzMlmWCbey1m
         pCUXWrhEXGhyfcwDzrLZeIn4HrjlE1dCzOK+3iffdhi4PWOBJ+vW99squABjaxCGzoV6
         +FFz5WUpZceOj4Yv6jurIRMA4NoVDqWOi4Qe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SVUMosySlGmO+E67ykB6ytXU1f+ejqD3RhE+eKO2LCQ=;
        b=FtUtEdd8w5xKc0osirEmt4TirlqCu7qOCl8hy5ukIPPLjUVNU7hyYo8mFiJQGVZKqQ
         3shs3gwrYmdtLtZT41+xOOeI2oVuZ/EAgl2+RXZGVwuFgKICKnEpGKusrsWdMcfZhnt2
         rAN0GaaOAwcYF8ewdNPT/1ktAxJ3rr6jalOv4brw0kNXPlZcMcHi19i+Lhqgrq2LScBu
         ekXHCsCssf/sCTGrP4N9jEcTYgCrOM0b09vyIzGgKyKE8T2FB3Fj7/Oi6k4ek1JmcToE
         AksE4agZl/0AEPpAF10sG1um3wT/AuBBDcIXcHvnZnle5s3RUQ4cBhPi20PWbo/nZIx/
         3CDQ==
X-Gm-Message-State: APzg51ColV4ugqUiqB9tvo8CSUywIskYLaym95TcYFTpc82zHtAa7f0y
        zC6Icvjru3AIg49jEe2OYKsNpg==
X-Google-Smtp-Source: ANB0VdafsfEj5coF2C7MmhyTd4fizRrfIO3ZnVqwT0smTEg8NBjuZkbwlyplmyruR0833olvXEZ/Xg==
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr1151608wmc.24.1536593289165;
        Mon, 10 Sep 2018 08:28:09 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id b22-v6sm16212592wme.48.2018.09.10.08.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:28:08 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:28:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: madera: Remove unused forward reference
Message-ID: <20180910152806.GA28860@dell>
References: <20180828084158.20554-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828084158.20554-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Richard Fitzgerald wrote:

> The madera_irqchip_pdata struct was replaced by the irq_flags
> member of struct madera_pdata so the forward reference is
> obsolete.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/mfd/madera/pdata.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
