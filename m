Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2BF84C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4517208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUQO2N8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4517208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934857AbeFLXav (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:30:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36921 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934131AbeFLXat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:30:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so341200pfn.4;
        Tue, 12 Jun 2018 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3A7q3aBJZ3UIxkW+DzJjR+YJZxhgWSL4OnjGf8xsvxE=;
        b=tUQO2N8MlGcwHBFOWqIrxrwU82p905ItFYVWwQ8yeyjvOBg4EteEGGtTuKHL7lC05g
         mGP4hnksppb8wYt/xi3BxmDzkUcDvbubx5yfHUZxSjiESqd1LLOQBf0JAsXMA1E3tfld
         3IY2G4UHh8Bp+lYsBeMyOzVXnRE1ItdmdA8OIaLm+kt00XgE/K2f+RnR8xLrY3DcndqQ
         UOXOYnIXcsXbURjjduQzPO/YaocCdqDfBNFGU3QSpoCB9ImuYjRtBiPd5BadarN4SBu4
         pzFwgVVg53FHZwRRTFVxroZeizVAbyRzI6V978AjhczUFe1bG+sam/BnakVw8uHC1hAX
         PzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3A7q3aBJZ3UIxkW+DzJjR+YJZxhgWSL4OnjGf8xsvxE=;
        b=kb39ewo1ELctOKOSJ6+OdkBCYaMKXoqg4Tumb3nlAZjlOh/fa6pnfI4BUF4G2PTYCT
         seAa5Rgwhc1X15sNcwuSJAKn1/jHMKasQ/u1/R8pmsvPVa5PndqRZGmIjKRqmISrdVxi
         mr1a1LSLL83ramYg4X8qf9zOpaTlUTJs9iOeq1yMeQ2AOQED7AFoaw8oBB01ewdwjN37
         Npjxe37YVFHmvegQAr1P+uHs1O/4wB0FuxJMtcsMOWILSI4+zfBTWguhb5t+MzNyv5YN
         njC3EjXNCExvYWFDleADrhACZVqMjkAYmgAjYpon1tsryphUphxTQS1auuxzNo1dSfV+
         blqw==
X-Gm-Message-State: APt69E0Q0pNkiHo0746mnDykUWltwvsbBjz58cpIONYbe3Vrd64ATiuB
        IL388zLOh4NRymoh0cU75WBJczct
X-Google-Smtp-Source: ADUXVKJag/w5Ej2ZD8QZxrJzwHXACsAc/u38c+UiC/knBRmjdTYbXRwyQhimls7zOPGo9HXBiGPMXw==
X-Received: by 2002:a65:5c42:: with SMTP id v2-v6mr2051871pgr.224.1528846248470;
        Tue, 12 Jun 2018 16:30:48 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id h10-v6sm1004508pgn.42.2018.06.12.16.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:30:47 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:30:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 10/12] Input: cros_ec_keyb - Switch to SPDX identifier.
Message-ID: <20180612233045.GF38773@dtor-ws>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-11-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606150900.8342-11-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 05:08:58PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied, thank you.

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 34 ++++++++++-----------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 9dd8c146699f..dd1b356d0004 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -1,25 +1,15 @@
> -/*
> - * ChromeOS EC keyboard driver
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// ChromeOS EC keyboard driver
> +//
> +// Copyright (C) 2012 Google, Inc.
> +//
> +// This driver uses the ChromeOS EC byte-level message-based protocol for
> +// communicating the keyboard state (which keys are pressed) from a keyboard EC
> +// to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> +// but everything else (including deghosting) is done here.  The main
> +// motivation for this is to keep the EC firmware as simple as possible, since
> +// it cannot be easily upgraded and EC flash/IRAM space is relatively
> +// expensive.
>  
>  #include <linux/module.h>
>  #include <linux/bitops.h>
> -- 
> 2.17.1
> 

-- 
Dmitry
