Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOOQ9Dgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C248E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIEVYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:24:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35005 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEVYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:24:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so3736342pgf.2;
        Wed, 05 Sep 2018 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dlige6MAsXw0Nyf287r/RPmrRs43jIQ+KJ1Cs1Mxj84=;
        b=OOOQ9Dgm4xQTMwet6NCYfoRkEBMXFx6hNGASsoRgFW/DBbImoOeC/QnBqbJ3sDUxP9
         aS5qNguWX6PcVb9dVzbjJXrFP1n+fEMbD7TA1gNLPL8Qp+TpxiTOm866Lv0F5Pu8O1y/
         bMacBohGEAJ+MbPjPYvkJ/34VR2F5a8Ee4xVxmOVe3XY572P9+DScUTmPPEO/EW+f5CM
         jbjLuL3kHu+GCvtil+MOUCJ1Xjiyo1naIhLmrpSIrFCido2Ktk8Cfxmey3X4LGvfQJtd
         d/OCgV4qMufsSY+3cwCGJDgl8q2NFlBygAq9p+EWwDyBBE0Fn3cXLX2h4stWJ+KC9xIO
         RJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dlige6MAsXw0Nyf287r/RPmrRs43jIQ+KJ1Cs1Mxj84=;
        b=G0wqeo1tLgT2FooeHMZBpWj6OoJXg7Q3erezSllm6Js+Fk9LRGI9qMqlanAFaGYYlM
         GBD2NwP38mycmWp3/M32cEf6Uvkk5sjaIYOgKSkPAhjtbeQyiRlfchcWl6AbgHwPGnru
         0KCtTy/yhWVD9LBfeNuYXuisJyoTkbzVl3R4AJFrm34d9mm1gVtsgXvxE1JirGPFnAu5
         zjWZSIvpIFwtJCA/qbcX9SsLJy6VH28rP8TS6JEqhWFJISzTo1ebvBKxy+KbjbgeV4cb
         TUbw3i08x+ZCGHrVsx1CyoCQsoIaaCjV1axcH+8B/6vW51rzI2aW13lBaNmBuhBf7feT
         Gzzw==
X-Gm-Message-State: APzg51B8t+oGrdOepCq9kEKpLxzvNgBKVeoWvwqSdP88mooyqffEXa6j
        BZZv//BsYlyTzxuNQd8b7LTF+MLn
X-Google-Smtp-Source: ANB0VdYggvvmmU336qiA2UCHXdFv8lLMp3KnlLGiB174jAxM0DmXeVsBLxrHOng+dpAT0HZP4fDXaQ==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr41566901pfi.66.1536166411895;
        Wed, 05 Sep 2018 09:53:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2844846pgq.56.2018.09.05.09.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 09:53:31 -0700 (PDT)
Date:   Wed, 5 Sep 2018 09:53:29 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] thermal: core: Fix use-after-free in
 thermal_cooling_device_destroy_sysfs
Message-ID: <20180905165327.GA1841@localhost.localdomain>
References: <20180813171400.15345-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813171400.15345-1-digetx@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 08:14:00PM +0300, Dmitry Osipenko wrote:
> This patch fixes use-after-free that was detected by KASAN. The bug is
> triggered on a CPUFreq driver module unload by freeing 'cdev' on device
> unregister and then using the freed structure during of the cdev's sysfs
> data destruction. The solution is to unregister the sysfs at first, then
> destroy sysfs data and finally release the cooling device.
> 
> Cc: <stable@vger.kernel.org> # v4.17+
> Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

Rui, can you please queue this one?

> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6ab982309e6a..441778100887 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1102,8 +1102,9 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>  	mutex_unlock(&thermal_list_lock);
>  
>  	ida_simple_remove(&thermal_cdev_ida, cdev->id);
> -	device_unregister(&cdev->device);
> +	device_del(&cdev->device);
>  	thermal_cooling_device_destroy_sysfs(cdev);
> +	put_device(&cdev->device);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>  
> -- 
> 2.18.0
> 
