Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4004B21917
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVmM8iYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392023AbeLVBBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 20:01:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41611 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeLVBBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 20:01:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so3209145pgq.8;
        Fri, 21 Dec 2018 17:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0nZNXwmGz5jIUnO1kpd2wsWv0G6np65sw54BkVGHE0s=;
        b=KVmM8iYj3A5Sl45OcDIThvqAH8oK9QZYKCsLoOsNh0TsWOo/11GLPyWxQ2EEumqA22
         rzlSnCBhvqzh1U6ca29khT0wg6EO+DdAFimERkWX//uDy8ZRSOVM1sVSOmI/IbfAeAiq
         ULf92e0pwgtmUA3xUqhKinrwIqaCkBs8H2+DCT4sBDChYaji/L+0Gt1R1rTDuQU7LwCv
         /CKGXxjcwTZK75oXxJ0/KB5teoLPw0fDLiATeJznvEPMrqfA96WofDdWm3EAedq9qqOe
         sSqRDxAnVRLNrEBgqKL23dRWPylG92k0uLbQ/fY1HrErqsaQ2vrvnpyAlY/59WHHdio6
         890Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0nZNXwmGz5jIUnO1kpd2wsWv0G6np65sw54BkVGHE0s=;
        b=ZxhyJXzINFhRNByYmp78bwW4q2ZfiMTdvOdTC/I6nSjWV5jvyU0Nv5aPCuMFtAr4X3
         Et+C/qPw0Sij0GcM7s3WgyM31XXV6/GMmYgxazgtIu4/ETERjIwZF7jyRpnv4mURvrCx
         SQJOaD6nVjDBzZhOhv3PqaIp95qTnY9Mro7A9pqzslqXH65zPJd5V2ND6ZsNG34xfuc7
         Ot25bzMMimkalwMkDWd5WsCuqA9jvCmJD4VIBes4K7Qa9GYRxoBonwphjM55rQqhvHrH
         QmGSfMXL43cE2BLsWMN8tDKcmTLejqQqoDvW1Q8dL3gd7J/zsRiyOnaK0XuIwrUajwJE
         mkSw==
X-Gm-Message-State: AJcUukc0iDAHRl1Z2bl2YtgbVdgj+cvy79ljZ/Py2iP8ghqrvuv90DaK
        T1YbVcZy2oRgC+30BFuEmX8=
X-Google-Smtp-Source: ALg8bN7n86QeRs/383lXKATo2ELatVrxGyC6T2u3gTr5umzrrBlxtDJSG37kz4drhav61TqB/JfpaQ==
X-Received: by 2002:a63:f65:: with SMTP id 37mr4454951pgp.238.1545440490860;
        Fri, 21 Dec 2018 17:01:30 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w136sm35327688pfd.169.2018.12.21.17.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 17:01:29 -0800 (PST)
Date:   Fri, 21 Dec 2018 17:01:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: drv2667: fix indentation issues, remove extra tabs
Message-ID: <20181222010128.GB31346@dtor-ws>
References: <20181221231241.15925-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221231241.15925-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:12:41PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are some statements that are indented incorrectly, fix this by
> removinf the extra tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/misc/drv2667.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
> index 2849bb6906a8..6091f0490e8f 100644
> --- a/drivers/input/misc/drv2667.c
> +++ b/drivers/input/misc/drv2667.c
> @@ -177,9 +177,9 @@ static int drv2667_set_waveform_freq(struct drv2667_data *haptics)
>  		error = regmap_write(haptics->regmap, DRV2667_PAGE, read_buf);
>  		if (error) {
>  			dev_err(&haptics->client->dev,
> -					"Failed to set the page: %d\n", error);
> -				return -EIO;
> -			}
> +				"Failed to set the page: %d\n", error);
> +			return -EIO;
> +		}
>  	}
>  
>  	return error;
> -- 
> 2.19.1
> 

-- 
Dmitry
