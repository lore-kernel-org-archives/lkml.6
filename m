Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE90EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0F9243F8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjzOvqxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0F9243F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeGDPz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:55:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46435 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:55:24 -0400
Received: by mail-io0-f193.google.com with SMTP id p7-v6so5242635ioh.13;
        Wed, 04 Jul 2018 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Bbt9nircKwoCK2gvtodDA9hiZeD/O1pdw/jl26zbFek=;
        b=EjzOvqxif/bmFGvPDwdNNyxEmFIchWujXaD83YM7ST1EBFBMPosvQLm8fOYxWA3XrU
         rj+SkY5Bs5OpcERtgSXtUpKtkrovKnESE2lAQUJkHLoIbYLUho01oiwEjJbglbyGp/JT
         Q2+FnpEW+6eaj2vpEgmHJiGITk6dF5g+HtB3UEHDctmdaXSSV2iJcPveQEFsyDNojN1Q
         XSOP8ncIo39JgFSCnKu+5TPeshBAHkB0vXoocAQ+gtW7tKKsMXCGgidILFxM7iZCu+4H
         WmCzzq6DrZdBg/iJ7obTEV/S2wi0Vp23xBOnftBO5A4x3zDTwk8H990vxyRxbK0EA8RG
         67QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Bbt9nircKwoCK2gvtodDA9hiZeD/O1pdw/jl26zbFek=;
        b=U4DESQLfY6pRyfw8sHDxSbZP94t6/D3aH9V/rLSp8W867prUreW6cIzS6fq+Z0yaNg
         BhuFR2oEq4G+bRIvFuUc/FVmOLeBDB8KjAgCGxYCfLmuazTdKMZx1SpwYSxVJttfhl/o
         Lxb041FoeWlUn4M53Nh9Imo1IBGrq2crAgEaS/RkyiLygZdWuGKOv85jxjqXIR4oIvPi
         pKuSq0HDRQZOtpcicDWdYmqmV97ZXoDNcaGv9gzn5MoNqScrweO8OgnYP83fDRKmLkcF
         owOVq8mC8Z6j/bLF3mbIB/njCBgyNMn7iyFmORBp5YyvEqUNIO91syBne5i07Lg7CScD
         8yTg==
X-Gm-Message-State: AOUpUlGamB0c8aElJw5YM8sSH4poKE8X3OsOWRF4qZqbZKfodPvPNg6j
        3kp2ISRzujSG843T6b7nv2w=
X-Google-Smtp-Source: AAOMgpeHqzIKNDOIvQwKwReq5EIL2dR8HiMHMKhif8Y52WDKhId28RovBgAI6DtbKGgyboQfUpfniw==
X-Received: by 2002:a6b:e814:: with SMTP id f20-v6mr1955294ioh.269.1530719723765;
        Wed, 04 Jul 2018 08:55:23 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id y82-v6sm79309ioy.40.2018.07.04.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:55:22 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:55:10 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cros_ec_keyb: remove redundant variable num_cols
Message-ID: <20180704155510.b7q2zy4zehwumngc@penguin>
References: <20180702162841.12553-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702162841.12553-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 05:28:41PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable num_cols is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable ‘num_cols’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 820bebad519a..81be6f781f0b 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -160,9 +160,6 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
>  	int col, row;
>  	int new_state;
>  	int old_state;
> -	int num_cols;
> -
> -	num_cols = len;
>  
>  	if (ckdev->ghost_filter && cros_ec_keyb_has_ghosting(ckdev, kb_state)) {
>  		/*
> -- 
> 2.17.1
> 

-- 
Dmitry
