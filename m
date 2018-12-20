Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1714EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D209D2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c66Z99Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbeLTNPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:15:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46718 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeLTNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:15:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so1303790lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zSmBrlvAFtbSjHBVsAmGCDb8ITZKsyMGYhRFh7uw5Xg=;
        b=c66Z99PubTEOrYSs8uWsx7Cys3HYnRS03mYX75eLquhV7z8xbQsg5e4+qua/RWylnM
         JM9jIu4+KEujCLOtZ6V/8/o1b63zOChZzvNgG6kNSTf8YH6YlF4zNX86ojHCEM+3w87p
         95hH0w872E7vpnj8dqoJMWjf0Wxck3M9cJvEf+CM86z6LnQKDa9znvLerYW7v0AD/KI6
         QyVCxz2tcayPgvQCJJHhjB+mn/xnvCNDTwrCRL+VFALbzYzBmNXe/mYiBEDSI9qFOm8p
         gHn4kHlUnzgE0bSVYGQDgSRgB+C8JkaqziALviUMyMB5r88J3MX/r/2RiBnY1J16qfXZ
         NNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zSmBrlvAFtbSjHBVsAmGCDb8ITZKsyMGYhRFh7uw5Xg=;
        b=J06t4m4v5s16Zl0ZPVMJ8TfwGOUZsdrx3nj/qE7vRnEDLsJUhKnwgbArdE+zXzxPFS
         AIf09IgK2xOAW7BptN8VpoRRsKk1HfTO4QT/dcq8gGdMYVaR831bDihR1abJMKCcly9u
         QHyxBaL8356sTs+Q0iJfzNMGRzIJp72MJJ5mkLWsk3sXapibbYZMCmRY7ISWa1o7daPa
         UaMMHp0UleL9JtG1QJuDiy2ZtK2bx6Xf8Pu+NlwSSbZ2UqBXHKpYRELPhvrcRQAehxkI
         AWkm+Uo9I4m0wPO8gWwSAFMye/oN7R6W3Mu+aHc4aS9y9hSMzCqh4bhCpwbTC/mXT2EA
         Gujw==
X-Gm-Message-State: AA+aEWZlz5Ho2/AYiJNTp9K8cjkN+qNE422Zl6ZgWLXcmcEbLQSJ/Hmn
        PxoaxLzElQ5sKP1a3jW9hyI=
X-Google-Smtp-Source: AFSGD/WW4Rtqhpw0IvW/5ztV5Rz8XwO+qTPWoxa+ef879uLzGQuz9D+Zp3Y5piJh2i+nzILpgMWflA==
X-Received: by 2002:a19:3809:: with SMTP id f9mr4482093lfa.148.1545311719529;
        Thu, 20 Dec 2018 05:15:19 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id c203sm4335546lfe.95.2018.12.20.05.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:15:18 -0800 (PST)
Subject: Re: [PATCH 12/14] drm/bochs: switch to generic drm fbdev emulation
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-13-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <bff8ca4d-f0bc-0d6e-3d17-e6e99337c1e4@gmail.com>
Date:   Thu, 20 Dec 2018 15:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-13-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/bochs/bochs_drv.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index a9c7140e3b..f1f65324bb 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -27,7 +27,6 @@ static void bochs_unload(struct drm_device *dev)
>   {
>   	struct bochs_device *bochs = dev->dev_private;
>   
> -	bochs_fbdev_fini(bochs);
>   	bochs_kms_fini(bochs);
>   	bochs_mm_fini(bochs);
>   	bochs_hw_fini(dev);
> @@ -58,9 +57,6 @@ static int bochs_load(struct drm_device *dev)
>   	if (ret)
>   		goto err;
>   
> -	if (enable_fbdev)
> -		bochs_fbdev_init(bochs);
> -
I think that after this change you don't need
"module_param_named(fbdev, enable_fbdev, bool, 0444);"
>   	return 0;
>   
>   err:
> @@ -178,6 +174,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>   	if (ret)
>   		goto err_unload;
>   
> +	drm_fbdev_generic_setup(dev, 32);
>   	return ret;
>   
>   err_unload:

