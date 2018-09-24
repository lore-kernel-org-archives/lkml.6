Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D252C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA8020874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ck+ItWTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA8020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeIYFHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:07:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42496 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeIYFHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:07:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8-v6so11392671qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hfPBT0CQIOkxkDtJF6m2WhFu5wIhuuvt3JCAETKqozU=;
        b=Ck+ItWTEBijcIHeHFF//Fa5XOR5KF2nnZc3kMwN+dXwa9HZx3DnrEOBoAvEXgf1bsz
         CNuyRX/eG3zGqBSeage020SxMbE0HJrVsvHQcWBuAVuCsu8uE2Wu+GNGhZkMSXXMmtNS
         b16F18Sl1nUTkIxc/N5Nzr0D93ofXogms91A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hfPBT0CQIOkxkDtJF6m2WhFu5wIhuuvt3JCAETKqozU=;
        b=X085cm5V3x4p7w+fVm24Re7eAjwBqHdoS3M0y6H0hYfLCj12imK2/90T/k6b/Gu438
         +QP00ujjMJihaR2gIIONwewfRia/2BExS6BnkTdFGYc1/C+Cqqdn91krfbgzhe6Vx1qC
         ZSlc5pmQzhDSknfXQPbwnLQ3a71njYGUOqdSkVVCKtpXVk38wpPPFp6UyszDisL0XOpc
         7fh/z5GKybnP3e8UVYkuii1Kp4UI74tBcQRqznPUDrtnlgM/hw3fNdLrrTu+OuCJo6k7
         EeVcW1bHUUD/aNxbjlv9/uaS5GGpIwI2QQCiIceuvIdlA7Bf4wp1nBQjcHufrkz6ZSlY
         IWbw==
X-Gm-Message-State: ABuFfogPidkD7wrhJRGUFI7R/DugjKSNCowXlz2+LZqwFttYeVfrWagT
        JmFkx0PTFCyMCeeSfrv2/ziqlp3VEWAXHw==
X-Google-Smtp-Source: ACcGV63jGkQC0IpEyUOTLShke3bNyGDAA4+HR0bgqtx2tQ1O5ItTt+YskPje9jmLKMLCuETNZCUtjQ==
X-Received: by 2002:ac8:38e6:: with SMTP id g35-v6mr855541qtc.55.1537830160143;
        Mon, 24 Sep 2018 16:02:40 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d83-v6sm472957qkj.24.2018.09.24.16.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:02:39 -0700 (PDT)
Subject: Re: [PATCH] staging: vc04_services: Update TODO re: arm64
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180924224835.32539-1-qader.aymen@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <bd51e861-41a6-6cad-c8aa-d56b13aa45c8@broadcom.com>
Date:   Mon, 24 Sep 2018 16:02:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924224835.32539-1-qader.aymen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aymen


On 18-09-24 03:48 PM, Aymen Qader wrote:
> This patch removes the TODO item to remove manual cache flushing from b
Remove the use of "This patch".
Please read 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
"Describe your changes in imperative mood"

Also, it looks like you broke "bulk_receive" across 2 lines.
Please correct and fix receive typo.
> ulk_receieve - this was done in 7e8dbea. Also remove the unnecessary
also read in the guidelines:
If you want to refer to a specific commit, don't just refer to the SHA-1 
ID of the commit.
Please also include the oneline summary of the commit, to make it easier 
for reviewers to know what it is about.
> asm/cacheflush.h header.
>
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>   drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
>   drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
>   2 files changed, 7 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
> index cefce72d814f..6c2b4ffe4996 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/TODO
> +++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
> @@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
>   hardware can do.  If we exposed the native padding requirements
>   through the V4L2 "multiplanar" formats, the firmware would have one
>   less copy it needed to do.
> -
> -3) Port to ARM64
> -
> -The bulk_receive() does some manual cache flushing that are 32-bit ARM
> -only, which we should convert to proper cross-platform APIs.
> -
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> index 51e5b04ff0f5..6e5c1d4ee122 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> @@ -21,7 +21,6 @@
>   #include <linux/slab.h>
>   #include <linux/completion.h>
>   #include <linux/vmalloc.h>
> -#include <asm/cacheflush.h>
>   #include <media/videobuf2-vmalloc.h>
>   
>   #include "mmal-common.h"

