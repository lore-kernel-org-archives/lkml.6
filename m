Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C5420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRlbeFNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfANHVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:21:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52654 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANHVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:21:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so7759395wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 23:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KiDJGN4dK6qvqeQXHOyzNMA5uUR2jqaLa82iAH5YyhY=;
        b=TRlbeFNiHY5yc/R3S83A0JzEtwajuaM674ZUltHcTC1/3vpRlkoIGWedaUeta58qmw
         HriAKR5xPBJG9z42YOxaWlhgWWRa6agq1l5xODHU4rSiFEBNvRBjrI406bPsGP64Toec
         ZauF7JhgZHxhNTxbgayCQw9ef1ECpBvuIl1CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KiDJGN4dK6qvqeQXHOyzNMA5uUR2jqaLa82iAH5YyhY=;
        b=Hop1sRsJMQqGc9hYnrpOBiQYyAnfOF3qQCxpP7v+gk78pks3Rjy5WDJO9/2tpqIaHF
         GH+vO/jvnGtncae4KjHs/GCcUiz7ZQGJtspLWrLXAWo6/+WMS4LW/yyJpaRgPoJpS/70
         3G82iWgrXCX6+O6fQo8e+lvbTr/6cuzih9fGPQDTjpx0vcsYyQzTlxxX5/l+sZnLSy0B
         Uy+TmearibIAj8BOFwvENX5DMjpd1R+RkHmU+DCPomFISgWhxWAfM60ciGIvmMBuDGgr
         RkKTU2UkLJc5ZSs6FRDRvGtu1+Z31mGwR5EFUjSkS4kw1MDnoeRNARmPK9UtT5tChq16
         Gzsg==
X-Gm-Message-State: AJcUukdFf/kaazwrSZP1XdIO3nw9vGg/UwDa/OLGptOKCV2DHvvdLiq+
        n31wveDx4K4ynaTBFWkP+01yV0JVB58=
X-Google-Smtp-Source: ALg8bN67k+Fmsa6xiiD5jU4RBxScxWsAUISfhb7/woJkLPPoKVxtyJXH5rmab3FDpm2kkiQ9u82qqQ==
X-Received: by 2002:a1c:834c:: with SMTP id f73mr10642588wmd.126.1547450512067;
        Sun, 13 Jan 2019 23:21:52 -0800 (PST)
Received: from dell ([2.27.35.240])
        by smtp.gmail.com with ESMTPSA id a12sm76240999wro.18.2019.01.13.23.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 23:21:51 -0800 (PST)
Date:   Mon, 14 Jan 2019 07:21:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v5.0
Message-ID: <20190114072153.GB4703@dell>
References: <20190109072252.GC27286@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109072252.GC27286@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2019, Lee Jones wrote:

> Good morning Linus,
> 
> Please accept my apologies for the lateness.

This should be v5.0 of course.

Sending late seems to mess with the brain.

> Christmas holidays, yada yada yada! :)
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-4.21
> 
> for you to fetch changes up to 3cee7a7d05b11038c8b5fa093e45c6f839ffc867:
> 
>   backlight: 88pm860x_bl: Use of_node_name_eq for node name comparisons (2018-12-14 12:30:24 +0000)
> 
> ----------------------------------------------------------------
>  - Fix-ups
>    - Use new of_node_name_eq() API call;
> 
>  - Bug Fixes
>    - Internally track 'enabled' state; pwm_bl
>    - Fix auto-generated brightness tables parsed by DT; pwm_bl
> 
> ----------------------------------------------------------------
> Heiko Stuebner (2):
>       backlight: pwm_bl: Re-add driver internal enabled tracking
>       backlight: pwm_bl: Fix devicetree parsing with auto-generated brightness tables
> 
> Rob Herring (1):
>       backlight: 88pm860x_bl: Use of_node_name_eq for node name comparisons
> 
>  drivers/video/backlight/88pm860x_bl.c |  2 +-
>  drivers/video/backlight/pwm_bl.c      | 28 +++++++++++++++++-----------
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
