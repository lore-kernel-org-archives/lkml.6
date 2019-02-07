Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2961C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169520823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+O4E7m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:50:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBGJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id v16so8910307wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6Lw0XbbfuTdfHNBnTGM7kFMZFkuAEzWW15iD++USDMg=;
        b=Y+O4E7m14nir/+jN5iWe/o2KZMZ6aE2d/SHuFpEcEHPkjlAIS2KV9ClCj0DzrbFC4j
         oPf0q4LxeAZ7jd7lpuPWneFCao+h3EM/FXMzjQDAsA/h70HicQZc1AgGGlRx+3VIUEJP
         F9GdAmQMmvOWo3t8kz7WUBYhrSeA3fmksYxLInHz3msy2QNvEF3DXSZLM9ZtLCL94tI/
         RWSbUYAEESRZsckk16MOGNLLyZtJmDfHdSXzNlLGnBm2AEm1dzXYh7PG2aHegy0Lfe5c
         eyEVMQA+ydWQZElT0zVZ8r1uQBBZxlFTRcdAxoxi+X5LtUiZYG/oqTq0AXaq0q4w7omc
         RKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6Lw0XbbfuTdfHNBnTGM7kFMZFkuAEzWW15iD++USDMg=;
        b=GYLBibrleK+tMtN+kL4Qx/PxlbgNwuZJdKhRfi07FBZlinqkjHquXilkYS5wUJ/MLy
         SafGZZqLgUpUbjCJ4sGiS5NpWbojLoCSXsdlZ98lp0OGJe/DeG6lZVABW96Kunm8WQ8J
         yx9tdl6Crbp4B8Z2L6yXtMLRDa5hWCQvV3VlsqLbpZNa2riP0U6IsWxmiyU3UdpAMUUY
         J+1xiP+gkvrmtFbxa9CHjkcubwKjD8knYmtVvIqoauP/4c8Lz0wuvWRUu5tKX4UBQrS4
         /KmY8dPROJAc+mB1XdCPjANKEcYDgF9xREQT2/NohwLEbI5ML4fg3d8yQwg3MbSE+ScB
         DUhg==
X-Gm-Message-State: AHQUAuaP3pTMfVDPlJgeFg5QWc0JxqZRDA7Y/rm/YLHViP2pztdxtfbn
        iK2lJa0XzcwgWYOaLZOmoSmkaw==
X-Google-Smtp-Source: AHgI3Ia5+Zw6gnVlR1JK4NhtCKkZy+8kWfXpM2O2nZuhcLQ/fqkIeBNkMYbxWdu89uUn04u1ONfAEQ==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr5671650wru.306.1549533000067;
        Thu, 07 Feb 2019 01:50:00 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id m6sm16095163wrv.24.2019.02.07.01.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 01:49:59 -0800 (PST)
Date:   Thu, 7 Feb 2019 09:49:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps68470: drop unused MODULE_DEVICE_TABLE
Message-ID: <20190207094958.GA20638@dell>
References: <1549480267-17822-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549480267-17822-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Feb 2019, Paul Gortmaker wrote:

> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_TPS68470
> drivers/mfd/Kconfig:    bool "TI TPS68470 Power Management / LED chips"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Hence we remove the MODULE_DEVICE_TABLE since it is a no-op for
> non-modular code.
> 
> There is no removal of <linux/module.h> here because there isn't one.
> Instead, it is relying on including that implicitly from an ACPI header.
> 
> In cleaning up the ACPI instance of module.h (which also isn't strictly
> needed), then this mfd driver breaks when MODULE_DEVICE_TABLE becomes
> undefined here.
> 
> The easiest dependency solution is to simply defer the ACPI cleanup
> until this change is present in mainline.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
