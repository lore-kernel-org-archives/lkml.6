Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2762EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34AC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItCjvqjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34AC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeJYQeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:34:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36637 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:34:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so498371wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wZwWvAsje3SwKx4M2NaP80BUUqaUB+/cDkavNcVdzi8=;
        b=ItCjvqjCSmBCizyrqOOCXVanXwYTwzrNS6LnkKImudHH0eFmTuDl/Nza6QJWa6X3d8
         kNEj4VPYHQGy5OPFaNJf+VuQCdI8ilWJu4dZfpru7QdvYOlveiTHfcCSZORnkosBwJIO
         KQGCdDHWn2r87GdpuN4b+XbzUw3zJkMTqrcYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wZwWvAsje3SwKx4M2NaP80BUUqaUB+/cDkavNcVdzi8=;
        b=QqYNVQg66TWAi0IDz7/X4nh1WzEj1+n9gYXB/7EV2vO4usnQbNLyo4/dkqxciyU+rs
         KA1i02qxRPn963oENsKNVbWmyZPS4/6B4JaoASGAGidZVEPWRXZTgqyNZfyPG4ytoyLE
         c7JIase6bqfMMOxh4Y14v5kYN4usRYEZ3GOAWCKaT0+L2wRcQf8q/qF1J99gECzp7Kr0
         fNOtip8rrFkBOmTBOkG33alDLufkC1lWQkFhN8Vhfjm/oZc2YC5LAeaPIPKsVuXCcuzt
         5MzA7pI98USwWGQODI3NR6gkrSplnXKyeEDWrOzUVNwtIkUsHM05Ol5sPJs5owpgnPsC
         IoWg==
X-Gm-Message-State: AGRZ1gIui7CXqun5q0p1JCsgR/88q0ANJNaXEg/q1IG9QDgJidGzfowu
        m6SBmvsiE/ARpYJImG6ja4i65A==
X-Google-Smtp-Source: AJdET5coumxdvkZhdRp+iSiKpxhewFkJ2PQnbncjfayeMRFLoniF3OKAqR4zUxbAl4Q1PuASxGPwiw==
X-Received: by 2002:a1c:7508:: with SMTP id o8-v6mr749613wmc.76.1540454579160;
        Thu, 25 Oct 2018 01:02:59 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id o17-v6sm7772905wro.2.2018.10.25.01.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:02:58 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:02:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl-core: Fix section annotations on
 {,un}protect_pm_master
Message-ID: <20181025080256.GH4939@dell>
References: <20181017171322.13572-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017171322.13572-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Nathan Chancellor wrote:

> When building the kernel with Clang, the following section mismatch
> warning appears:
> 
> WARNING: vmlinux.o(.text+0x3d84a3b): Section mismatch in reference from
> the function twl_probe() to the function
> .init.text:unprotect_pm_master()
> The function twl_probe() references
> the function __init unprotect_pm_master().
> This is often because twl_probe lacks a __init
> annotation or the annotation of unprotect_pm_master is wrong.
> 
> Remove the __init annotation on the *protect_pm_master functions so
> there is no more mismatch.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, I suppose that twl_probe could be marked as __init but
> I'm not sure if deferral is possible or not (which I believe would cause
> issues but not sure). I went with this more conservative approache but
> I'm happy to respin if necessary.
> 
> Thanks!
> 
>  drivers/mfd/twl-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied for v4.21, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
