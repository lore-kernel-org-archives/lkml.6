Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C325C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF9F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toQHpeF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfAKLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:08:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37293 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbfAKLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:08:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so12582676ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YZQqVTBW83xm/pkYcwpS7HpU5GCp9v1hmBP35xE8vJ8=;
        b=toQHpeF+czgXEeCu+k5ayIsxyFfxtYlyvpwd+jydQou7IZ+WLse0AmFkb/w3wF7xST
         1c5417SkiqFTTZzeckxF910VxsmA3PHPHoap4XxTYa+JmT3Y0WGxhS1JygVD8LZ4onEi
         XFkyrpou33+8bBtYQkete2ZppMBm0TXlgUYnQwMwBvtmqUd+GetHoQWm/1YS5GM/6jo+
         Q4nqW5qgCuTU+9uy5nOVQbFRkPGSWmtZWKrseQXD4zmTGGFTNwypo4QBgeFf2gOO5ZIm
         CVvWKBBjNhrQLemmnjAJLRgZb4ZQoR/gAUAPdgp91lRlmPgSyc8seCOQ4yufSoiC4HyB
         BBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YZQqVTBW83xm/pkYcwpS7HpU5GCp9v1hmBP35xE8vJ8=;
        b=EzB7drneD6maDaT+g0RWKuxyodzNVfh+tE6iySJJrm83/6BdjlDnNDEo90TJrKLeUm
         P8/huZF7CaeOLtBQ9FkGNkQhzO3SzyAnH0xHQ2d1amvh2pYrOUY0joYzmRAnKE6kb6fq
         +1hzF/wjMniB/ERKVgGGKongEHfExrr20A3CIaAIcQPpZTdfap9Ls9J+kCig2WUylgnK
         iIZ1kliyY0traG1n258fpJCheJBQrp+tzkVb9oO5rzk0bZfRLsJB3jCKrnV6jQYvQ/Ri
         pMck8uF0iqSmLV/+j/PGWRp4giPhQfqWAmbHS+eZyIFnaACjMcPE/oaqWbJ/5srKxj+R
         iCLA==
X-Gm-Message-State: AJcUukdGSkT/w52Y8zQY83iDwRLMzMezNF0ivEjLg2CO7kHRJ/4U+wvf
        H02+wcEsZzAqXfjXPx4gQ82bVWd+
X-Google-Smtp-Source: ALg8bN4vy2VDGjnjYKTcwkxDXBV4UiJuazXauvWgmVRFSVsZC+EZ8vZFU8Grqz6Xp9072zk6qNMPMg==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr8162287lju.116.1547204884377;
        Fri, 11 Jan 2019 03:08:04 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id p89-v6sm13341602ljp.60.2019.01.11.03.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 03:08:03 -0800 (PST)
Subject: Re: [PATCH v4 08/16] drm/bochs: atomic: use suspend/resume helpers
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     noralf@tronnes.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190111053752.4004-1-kraxel@redhat.com>
 <20190111053752.4004-9-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <71b9afc8-c984-a837-c12d-a55c5468575f@gmail.com>
Date:   Fri, 11 Jan 2019 13:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111053752.4004-9-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 7:37 AM, Gerd Hoffmann wrote:
> Switch to atomic helpers: drm_mode_config_helper_suspend/resume().
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_drv.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index f3dd66ae99..08ba6029d2 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -103,11 +103,8 @@ static int bochs_pm_suspend(struct device *dev)
>   	struct drm_device *drm_dev = pci_get_drvdata(pdev);
>   	struct bochs_device *bochs = drm_dev->dev_private;
>   
> -	drm_kms_helper_poll_disable(drm_dev);
> -
>   	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
> -
> -	return 0;
> +	return drm_mode_config_helper_suspend(drm_dev);
>   }
>   
>   static int bochs_pm_resume(struct device *dev)
> @@ -116,12 +113,8 @@ static int bochs_pm_resume(struct device *dev)
>   	struct drm_device *drm_dev = pci_get_drvdata(pdev);
>   	struct bochs_device *bochs = drm_dev->dev_private;
>   
> -	drm_helper_resume_force_mode(drm_dev);
> -
>   	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
> -
> -	drm_kms_helper_poll_enable(drm_dev);
> -	return 0;
> +	return drm_mode_config_helper_resume(drm_dev);
>   }
>   #endif
>   

