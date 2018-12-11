Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E99C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFF12086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w20jgmv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFF12086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLKSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:53:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41363 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeLKSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:53:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so7553670pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=DuQDtI7Ks7igJGjWgewQyDBlOgL+Pl+vbRs9TAT/5aA=;
        b=w20jgmv5a+J2U1hOgAHPvjaQQfkcUZzIvABmFfEYcpqss/+2m/dtoyAoeMs6l0ZMhQ
         1P4I3jJ6+qTt5pG3a3dqCzUCNlhr1DN/4/3YxqAOqF8J2llLEXW3RKxq+q1eTCmuZPNi
         pt0E2j49gw752i4Y+q4MOGRxqlLeGpTazIJyxMzBN9ZUKbHhz+z8tzqf4fFZOAcHh8HT
         lrx6d/ZmHsvaAHcgw1lR8pYWn98eIQLe8A9TcAaUgGxjRGmkWwW7O6ETXVaskCArlpwq
         QkEZbOh+gD0NkZM8owxxO2uXDnNT9CNWer1wzAq1iPwzNQQtfVwS3mbNnCWVbUtnWdqF
         RuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DuQDtI7Ks7igJGjWgewQyDBlOgL+Pl+vbRs9TAT/5aA=;
        b=kYm55AuumgGewBSWpY21D+HH6EwsBNLW1I1upIxnMJ1slP/gnPw0WX0UDhxJIzNkR1
         mn//xr3eNvrJQrI5SJygc2LZToeTWqEvVe9X3AOWeEsba5FNKgvrVFUotnmEgtmjSwBM
         7kI7RSxT3WKuloSf/60cy+ttCAkmBiehcbIm79owJQxc+t/ujBBma6QoodgFkd+7mEU/
         GVE0Id5CUzljIjJuo9o8OhVPfYBXpLFt9h7OsYxxe3aJnD3aUIJpnJYLYZaZmkAVwxnL
         Hr7dca9N5IEmn0vbA9kEvouuq3r8hQFJ8UUSj7cZxGwSC0Zbq1jIVIcIB/wsk7cpo/cS
         Me1w==
X-Gm-Message-State: AA+aEWZgE5I0m9kFgu6IliTXVcsIimmm23j89ASnJsts8Y9v1R/vnBEh
        k03TqMhROeOfsqgP3HmeHf3jnA==
X-Google-Smtp-Source: AFSGD/WHEmEEU0h1fThAqx0Tx9Q4zoK2DtOjaWrTweOtuniBWf/igKxVlz5t9jJJM3Pymn5DsZVG/w==
X-Received: by 2002:a62:cdd:: with SMTP id 90mr17330855pfm.219.1544554387055;
        Tue, 11 Dec 2018 10:53:07 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id v9sm21267563pfg.144.2018.12.11.10.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 10:53:06 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Thomas Meyer <thomas@m3y3r.de>, khilman@kernel.org, nm@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / AVS: SmartReflex: NULL check before some freeing functions is not needed.
In-Reply-To: <1543760930051-514988180-4-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de> <1543760930051-514988180-4-diffsplit-thomas@m3y3r.de>
Date:   Tue, 11 Dec 2018 10:53:05 -0800
Message-ID: <7hy38vuc8e.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Meyer <thomas@m3y3r.de> writes:

> NULL check before some freeing functions is not needed.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
> diff -u -p a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -1010,8 +1010,7 @@ static int omap_sr_remove(struct platfor
>  
>  	if (sr_info->autocomp_active)
>  		sr_stop_vddautocomp(sr_info);
> -	if (sr_info->dbg_dir)
> -		debugfs_remove_recursive(sr_info->dbg_dir);
> +	debugfs_remove_recursive(sr_info->dbg_dir);
>  
>  	pm_runtime_disable(&pdev->dev);
>  	list_del(&sr_info->node);
