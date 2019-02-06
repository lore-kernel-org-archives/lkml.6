Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D73EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05660217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fJY0sOQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBFUkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:40:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41561 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:40:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id p15so2827308edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TcFr+rQH0odkIUor3u2H3BNmJOToPZn9FCa6jQJ2Gnw=;
        b=fJY0sOQoftTHwboF3Q7SoO7K6oWcafFIgPZk1Yr5XfGnGIfXTCZ/0jgOHU5jCG1efZ
         fKgl4KDa3tRavFi8d6rg90k2oBTQ0aKGfUXoYYNE2GC8IGH8xBJF9mVhYnTbuD8k1JRL
         EVO6YJrzbc/FNT+B/xtYcpTa4Vz5Zt9/bl61c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TcFr+rQH0odkIUor3u2H3BNmJOToPZn9FCa6jQJ2Gnw=;
        b=lpFzyv9GbDqPV5TzhZqeocthIJvYzNAxYR51Y5B1O5Wr5hVZo9feq5W3/vMxTMlpSG
         rE/Y/EKcvS5eNu5lovlG5+jDZlFoYYL5oxT+VlSshzGpF03RK/ao+ZifqjIOSYaYxA30
         f5K2xHRRc7aod3VhDNpZRcvQUy+hZKvz9VFG3U7WpkQ49IeSPDn9hGWlZFa3MFRc0Hjo
         T9y2BrkE3+Bau4tf6himfNulI7/P6fXPN81zcBM3icd9/OCO5GrPh7JcBzy6M85VZ8ML
         x1y+ZAOC5EOjFb6ikMe3M91vXm+/CWRXrVGMay991FYq+vnKrXBnpL2UEr3OVCzCkTPx
         b9Ig==
X-Gm-Message-State: AHQUAuYtMeWMU++kag030ZTTrZNn5C6nliEAZHPMASGqbwUT8m6YWx2D
        +HUTYJD5rKWM7ZO6irzs5LkQmA==
X-Google-Smtp-Source: AHgI3IasITbSYX/F3S9Wr7E8dQsgQCY9Ndyo3yqCL88fyvxG0rfEOGdjwd4PnqOjIKWsQECuipjSzQ==
X-Received: by 2002:a50:9724:: with SMTP id c33mr9712260edb.288.1549485652408;
        Wed, 06 Feb 2019 12:40:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a27sm6289951eda.65.2019.02.06.12.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 12:40:51 -0800 (PST)
Date:   Wed, 6 Feb 2019 21:40:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/doc: Remove solved "VBlank issues"
Message-ID: <20190206204049.GM3271@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190206193157.3b53ipdxtcqc4hv4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206193157.3b53ipdxtcqc4hv4@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:31:57PM -0200, Shayenne Moura wrote:
> Remove the list of broken tests on VKMS solved by patchset
> https://patchwork.freedesktop.org/series/55994/
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Excellent work from you!

> ---
>  Documentation/gpu/vkms.rst | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 7dfc349a4508..61586fc861bb 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -23,17 +23,6 @@ CRC API Improvements
>  - Add igt test to check extreme alpha values i.e. fully opaque and fully
>    transparent (intermediate values are affected by hw-specific rounding modes).
>  
> -Vblank issues
> --------------
> -
> -Some IGT test cases are failing. Need to analyze why and fix the issues:
> -
> -- plain-flip-fb-recreate
> -- plain-flip-ts-check
> -- flip-vs-blocking-wf-vblank
> -- plain-flip-fb-recreate-interruptible
> -- flip-vs-wf_vblank-interruptible

Patch applied to drm-misc-next, thanks for your patch.
-Daniel

> -
>  Runtime Configuration
>  ---------------------
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
