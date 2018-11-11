Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73244C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 07:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253C320872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 07:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeVdD4Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253C320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKKRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 12:43:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33118 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeKKRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 12:43:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so6621869wmb.0;
        Sat, 10 Nov 2018 23:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FeefSBmW6qU7F0pHDfhAGdcBWTAzDMXfpuYC1k6Z4Go=;
        b=FeVdD4EsZHdzWgQRwn0DaEHgIyf+4nDiOM28aHYFZ7/4FMhtZtRNrd0xtYqyC8V2wK
         0clq8Vru9r3Zyqf5q9/o/rt2aXWxn86hi8m3kK8jPfuLjPcUDzbysx/y7CyHMpMASOLa
         Si0i4CD1egcuhOL7YjGGRCaytRtFX1xDMSIo3p/4HygGPHFtDp8RFMA94JZm4LpRe2QD
         kc3T7JdqlMktPhL8vtATBNgcEpED4g/ZkaMYxCwsrQz/Br8+sT1RbykV5fHVwplABMry
         QFnJVnfwHKayf+u3Ws0TiNbM+fSAD8i9e77tQ6aziXkO+D/byD4xOREvlAK/ev0T6AT/
         jFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FeefSBmW6qU7F0pHDfhAGdcBWTAzDMXfpuYC1k6Z4Go=;
        b=qG0j015k64uKyCURXBElIiOKcPixLs/Izv7p9VvGRJuKU6D40cWYklnYjopBm3g3Lk
         od2Y2+6dXZyaowCtItkfB1AnPNKrx++641OAuuY4Bgzvyu15U7QwpKEGAz5Iv61VsRaM
         oX5n63nAYc9biL0EF1cvtf9VaOkqXOdIy13Q0FlRSPDM96XYRLdY7MRPubsiKLRB6f7p
         rVnL/z0ToJmzrByPdGSatewoq1KET6JWE+XW7VIy4Oo4+1zS6fWxF1GdRXPBvvIqGopD
         PwQNUmMyOaYZPExjlI85UMFvlSHhv6i6AsDAJdfOxKrTcWllvwK0LTvppjyUBxTgxCkN
         2eQQ==
X-Gm-Message-State: AGRZ1gIyimVSQ3Cggp+Q1UJ1v5E7kxwj6JnvxxD98EbZIetesMxwlGZZ
        b7U0S4Ak6YhdvtBR1byjaT0=
X-Google-Smtp-Source: AJdET5fqsErUc3XZRC1s2WZ0Rwg4qQUdA4R95DZ2NEuFJI0oqx9E14K7MbIdQDAPVXcQfTk+0L4POg==
X-Received: by 2002:a1c:c46:: with SMTP id 67-v6mr4284937wmm.6.1541922921816;
        Sat, 10 Nov 2018 23:55:21 -0800 (PST)
Received: from camaron (211.red-88-7-211.staticip.rima-tde.net. [88.7.211.211])
        by smtp.gmail.com with ESMTPSA id m13-v6sm14542073wrw.14.2018.11.10.23.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 23:55:20 -0800 (PST)
Date:   Sun, 11 Nov 2018 08:55:18 +0100
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt7621-pinctrl: fix uninitialized variable
 ngroups
Message-ID: <20181111075518.GA23361@camaron>
References: <20181110232806.14255-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110232806.14255-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:28:06PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the for_each_node_with_property loop us incrementing variable
> ngroups however it was not initialized and hence will contain garbage.
> Fix this by initializing ngroups to zero.
> 
> Detected with static analysis with cppcheck:
> 
> drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:89]: (error) Uninitialized
> variable: ngroups
> 
> Fixes: e12a1a6e087b ("staging: mt7621-pinctrl: refactor rt2880_pinctrl_dt_node_to_map function")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index b8566ed898f1..aa98fbb17013 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -82,7 +82,7 @@ static int rt2880_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrldev,
>  	struct property *prop;
>  	const char *function_name, *group_name;
>  	int ret;
> -	int ngroups;
> +	int ngroups = 0;
>  	unsigned int reserved_maps = 0;
>  
>  	for_each_node_with_property(np_config, "group")
> -- 
> 2.19.1
> 

Thanks, Colin. Looks good.

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
