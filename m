Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F60204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRLQvVKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F60204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLCLPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:15:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39063 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeLCLPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:15:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so2808503wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kwz4XAQoZXUTAlJ3tr6pimGrL8gGKRP/JZPcb2fI/00=;
        b=NRLQvVKtJVaB/pCc/m3hbe/DfOyvL3zJIwdqPMsvfzzUSzR5FQ80HN1MSmx/Ycvy7S
         nUB1k7Bn+DiUYb/7lbmSW9tfGdjnMFucmr5FbwB+Qf8M1xh0S6muuInTw9LZBRnheTJR
         89FN5ZQzkicutdfBRKSG5+TibQav44tcyzYTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kwz4XAQoZXUTAlJ3tr6pimGrL8gGKRP/JZPcb2fI/00=;
        b=C8fLbgOHjzxzYAdPdah5tDqpQ4FShfJyP6fMRbB5ckBN3FP1KKOOqXYxc8px5NEgzv
         VypmSNUuWKMI7ERtwImygiJDD28qeqRqNZYZalt2mSGCEvKrwTKYQY1FvuR+rhJCjfbD
         xwPyHuA6Ql66/nLh9xat5v7cZ6AK6ymgzcEcBsAcqKo01HQoZMbcKahjeqDc9uTh/5rR
         IPcP/y+QCq4U0zxVB+fVWpHOOywJg62pREqpLWNW/w7V7BLMcvaWx4lpgapzEN3Nmts5
         qsYc3Pq9W7tdxZbAqoJla03K8YwU7z16BmbbSuprjZ6xehcAQeke49Na+kZZgHACI6hT
         4kfw==
X-Gm-Message-State: AA+aEWbaqvZ9oL/jt4aHcnhWMC5nS94jFMG0nEpK3S+XmiW5oiqwaaSS
        trIZA6ZHyL2777OQN9YgAcx6TQ==
X-Google-Smtp-Source: AFSGD/V1lSnmuUUiijmpdbuA7wruLrq0p2sOn5CB4zDmwRq5QiWzUbf+vcevgVXvQk6LGRyp+sE2tg==
X-Received: by 2002:a1c:8bd0:: with SMTP id n199mr8268232wmd.104.1543835684656;
        Mon, 03 Dec 2018 03:14:44 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id w16sm21915210wrp.1.2018.12.03.03.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 03:14:44 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:14:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/22] mfd: sta2x11: drop unused MODULE_ tags from
 non-modular code
Message-ID: <20181203111442.GK26661@dell>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
 <1543811009-15112-13-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543811009-15112-13-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2018, Paul Gortmaker wrote:

> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_STA2X11
> drivers/mfd/Kconfig:    bool "STMicroelectronics STA2X11"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> We replace module.h with init.h and export.h ; the latter since the
> file does export some symbols.
> 
> Cc: Lee Jones <lee.jones@linaro.org>

I think you should add some of the driver developers.

> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/mfd/sta2x11-mfd.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
