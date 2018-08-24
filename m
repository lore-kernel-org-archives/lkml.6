Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C341BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F58B21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEd1SNMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F58B21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHXKCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:02:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35312 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeHXKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:02:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so6024692ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0qwBTDMGPSPGyNCxhSHGeW6XHrIhw3wvUOBWJD9Kwk=;
        b=HEd1SNMURgsTGqghh+NMBrIi6JpSA5xRDa18paHg0B3e4Zre/jl8R+LSZzjNR/KV7H
         6i19M8LT2GzEiOgpt3LhYUvyOPMW98V+uyQSiSfmMhmy83OA/HlRofVztzw/hB9rW9Hl
         SeDjPzXJydPWCLux/x8Luih3jaMAdgkeVmUOfaUCtsovNvnYUXfbt0nheFgcSnNa50Hs
         JeN3jRK0WQpeSsYlT6A2tV9ZiN/TkkIWlv2/WKpCzEKwvUWXtKFoGFUXuRMBMZaAlpg3
         BFFlweUXCd9/lxBBvdOQvm0zgEop+IGxjGxVAEgjawtfHJhpHUkuxcTFeHfcAIwEzKsT
         vSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0qwBTDMGPSPGyNCxhSHGeW6XHrIhw3wvUOBWJD9Kwk=;
        b=jNZQXNg9y+5wPSmHaPnPUBbuRFslLPTQloC0Npbvv7cGpVrHFo9VVMoMiuQVVUB6T9
         U6GFiA/gvnIgXECn3B2P4TZ7erzSFb/rA/JNlEClniIa1XCVYjy1epa+BxlVdDLWiwBH
         8BMad+Bh42E3Wc6Q6Ao0L8tjnvptpyE5xNuDS46UE4aaYpkusnYbb+Wg848rIj07Mh0U
         1tTeJObRujQIUKZ9GAGA91cbaCpfL7oP7/iDNptlhHdA80sjbqqzjTTiir6YSM1byhEJ
         YOXjgl0h8jEwCRcU7RjFGnidt6WwqK4Ke/E4CNz4KvKl+yBIfMpx+QJPbeVos7dAUIln
         ou3g==
X-Gm-Message-State: APzg51DH56QIzUYj1KIgt8TvF3juRe31cWVLzdbWs7ZSXRncifmUuu8Z
        3CzGpXMpoWIWM/Jg/F+KXxE=
X-Google-Smtp-Source: ANB0VdYYiM88KNpmPX3rO5Ma3R4WsRVqGnWHKNU5lJkudZluLpGHi7UaBOP59Z3b9ebZa6lZfPMRXQ==
X-Received: by 2002:a2e:2bd3:: with SMTP id r80-v6mr290698ljr.57.1535092173591;
        Thu, 23 Aug 2018 23:29:33 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o184-v6sm1169374lff.95.2018.08.23.23.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 23:29:32 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ft5b8-0000TS-0R; Fri, 24 Aug 2018 08:29:30 +0200
Date:   Fri, 24 Aug 2018 08:29:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] staging: greybus: Fix null pointer dereference
Message-ID: <20180824062930.GS14967@localhost>
References: <1535083631-1892-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535083631-1892-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:07:11AM -0400, Ding Xiang wrote:
> If fw is null then fw->size will trigger null pointer dereference
>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/staging/greybus/bootrom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> index e85ffae..3af28a0 100644
> --- a/drivers/staging/greybus/bootrom.c
> +++ b/drivers/staging/greybus/bootrom.c
> @@ -297,7 +297,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>  
>  queue_work:
>  	/* Refresh timeout */
> -	if (!ret && (offset + size == fw->size))
> +	if (!ret && fw && (offset + size == fw->size))
>  		next_request = NEXT_REQ_READY_TO_BOOT;
>  	else
>  		next_request = NEXT_REQ_GET_FIRMWARE;

How could fw be NULL when ret is 0 here?

It may not be as obvious as one might have wished, but the current code
looks correct to me.

Johan
