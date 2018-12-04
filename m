Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753352146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euO5tJf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753352146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLDEnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:43:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45006 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeLDEnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:43:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so7628490pls.11;
        Mon, 03 Dec 2018 20:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJZgGw6jy/GVagLjewYzoiq6g1ydiIvAwKzOsUbz0iU=;
        b=euO5tJf45nr/IUy5ukSp17SJrFJfh/JFyVoAzQ5H250v46YlvnpgdvorSM+KE3Wu08
         Tzl329V0IgZuWaoiVpO7U54o/Qr5Q/NZbdaRz2yOjKy5gl4jD0WrRd1ORG3SX7RhPn6Z
         /4PihCGgPvnRkGhxVa46XGRWOH9HJNJtUWMZOVNSWx/ioxZ6eFTdh71wtR0wYddAec+4
         wqDwF3asu2/xMvfNjE8X3ZAV//gtrfOj+PSFIBfgcD1LOTf+dZJgtqX6h2/CIaR72Uho
         7idbuTTcBqTvG7YRg2jvKDcfC+xDKTa5BeK9JmhN8FgvcrXzWpPlkGxiwuDNafWEcZ9X
         uPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJZgGw6jy/GVagLjewYzoiq6g1ydiIvAwKzOsUbz0iU=;
        b=sw+QwHiYcZGiBW9uBd/+Df82UTLlM2g/JVmf4zPz2k9a3Q6iPdceKAotWhB5JcGrOl
         kxpnvGnsBMF5Xi2bRUCbReVPE+/5LuLK4cnkOnHFPeTZ2RV6/pwqKQAVPusQSASZjutP
         TUO48cRy3c2sQ3sUJrXpYtie47C0Euv3GouYogGGobWbOEbvSGsbVOdAskNf9t6+D+Mj
         UMZq92phv7TQBcicrXRf52rHfUED5z2xtmW5qI4LaGAuyo7MRbTpjh6TUAUtTuXv1Wmg
         tIoIBNXzAf7ljdwHwPyEHUJP+d7e3pbCt80PpBnS89u4Sapw11weQp7zndeEURuwsPjc
         wbHw==
X-Gm-Message-State: AA+aEWYe6kqOw1QwWTwmw7slNFoF7TvMN49lbs+MnfTcfHlaIXI+ml1d
        uRLIoBrGvh+M4MBjWah6uGE=
X-Google-Smtp-Source: AFSGD/Usv05EGMlCuZ9CjosnWUgUymNUGYzzptdLeuVcxGWaMnOGgkeJKpYtMNBX7XpUu7T9+u71bw==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr18202126plo.328.1543898580845;
        Mon, 03 Dec 2018 20:43:00 -0800 (PST)
Received: from localhost (c-24-4-239-105.hsd1.ca.comcast.net. [24.4.239.105])
        by smtp.gmail.com with ESMTPSA id z127sm24754180pfb.80.2018.12.03.20.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 20:42:59 -0800 (PST)
Date:   Mon, 3 Dec 2018 20:42:57 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181204044257.grk3na2wyrx6nssg@localhost>
References: <20181130163252.e6z33t23j3qud57z@localhost>
 <20181203105506.GA21127@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203105506.GA21127@unbuntlaptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 01:55:06PM +0300, Dan Carpenter wrote:
> We recently modified pps_register_source() to return error pointers
> instead of NULL but this check wasn't updated.

But it *was* updated!
 
> Fixes: 3b1ad360acad ("pps: using ERR_PTR instead of NULL while pps_register_source fails")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2:  Use the correct Fixes tag.  Add Greg to the CC list, because he
> is maintaining this driver.

What driver?  (I am maintaining drivers/ptp/ptp_clock.c)
 
>  drivers/ptp/ptp_clock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 8a81eecc0ecd..48f3594a7458 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -265,8 +265,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  		pps.mode = PTP_PPS_MODE;
>  		pps.owner = info->owner;
>  		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
> -		if (!ptp->pps_source) {
> -			err = -EINVAL;
> +		if (IS_ERR(ptp->pps_source)) {
> +			err = PTR_ERR(ptp->pps_source);
>  			pr_err("failed to register pps source\n");
>  			goto no_pps;
>  		}

YueHaibing's patch has the following hunk.  It really is already
there.  I don't see it yet on Linus' master branch, but the patch
should update drivers/pps/kapi.c and the callers all in one commit.

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 8a81eec..48f3594 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -265,8 +265,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 		pps.mode = PTP_PPS_MODE;
 		pps.owner = info->owner;
 		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
-		if (!ptp->pps_source) {
-			err = -EINVAL;
+		if (IS_ERR(ptp->pps_source)) {
+			err = PTR_ERR(ptp->pps_source);
 			pr_err("failed to register pps source\n");
 			goto no_pps;
 		}

Thanks,
Richard
