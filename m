Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D9C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63821708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxkzdmKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63821708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHCCCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:02:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36472 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeHCCCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:02:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so1747759plb.3;
        Thu, 02 Aug 2018 17:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGHVE1v1KcAk6ue3THS7iw1vjHl7+m10u9eQjINU/+8=;
        b=PxkzdmKuv+hbLvM+UA5kam8em+H8Yk8LkRgtlshcBcNWRyjKD6l5VdApfpO3O/hrhz
         QjrvtxRmHdYkonnUapXwK4iCn7vElSqDo0gLucLkBT08AHb7qxiw1T0i6WeKUWgBFB6K
         eZ86a7d6v9DLfRu5LotNlPGgsDL9iHzkRccurErRK7KLojVpwj+iD+y71iLCvTDTVXod
         FMgrRU0EZwyEcj5pBKRTz2KHbqRRjyDR6JB0r36mq/fiFRXSj7ZmFnkTT17K5lWMtCzY
         qxq6VMMcxS4LzTNMkt3or5asYve9PN/vnpEkWd/QOz5iiV7UTH5l0MHywYc/M1Mhla2v
         U+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGHVE1v1KcAk6ue3THS7iw1vjHl7+m10u9eQjINU/+8=;
        b=T3Sh40p7Xmfq3fG7S3Wmakkd/Y2Vr35vAKVX94/GzY2s/l+zDZivmoGvnPOxP5lvPs
         ce0Fb3BHnj54biDBi5NlR0tBxpshUlIy1zU0RiK03LvA0OF3VmJA3EveY/ORowVqcF+X
         z7a8a7gb2Adg9giYPqgTu4nQOnXNsv/ilu0T8QhiGOaC9LmQmB+ZxyDW46Xd4TbFNM9h
         sAa4vfW6kxvd/UlAEi1xBFMdepkVQ9KB2CKz4l3sTUNO794NgAnaWM/WlFccNzH2J5gl
         x6vkcyIJ2n1IbYlF0GF3TflYOpBlpdc+rhUsBTQLtm9dDUA92C3bnX4m1htzWDg7KLDm
         0MMA==
X-Gm-Message-State: AOUpUlFGKeNXRRuvtWwqGXQ4ZQmbup9enELC56gSJVRUE7ZsnhJozMYS
        UWfoIxV+4UM/A3qNkFKlWQM=
X-Google-Smtp-Source: AAOMgpdAKnyPDu9iVdWJzORlG85PNIVnEvCaqdJCMPh82lz0OfueE2GPzje3k9I+a3P00QDjf8Nz8Q==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr1403677pll.82.1533254925167;
        Thu, 02 Aug 2018 17:08:45 -0700 (PDT)
Received: from smtp.gmail.com (110-28-135-239.adsl.fetnet.net. [110.28.135.239])
        by smtp.gmail.com with ESMTPSA id f90-v6sm4557212pfh.168.2018.08.02.17.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 17:08:44 -0700 (PDT)
Date:   Thu, 2 Aug 2018 21:08:38 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/vkms: Fix the error handling in vkms_init()
Message-ID: <20180803000838.ku2lgy4hakcgqc6o@smtp.gmail.com>
References: <1533200699-124300-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533200699-124300-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Wei Yongjun wrote:
> In the drm_vblank_init() error handling case, platform device
> unregister is missing. This patch fix it.
> 
> Fixes: 3a0709928b17 ("drm/vkms: Add vblank events simulated by hrtimers")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 6e728b8..5ad09d4 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -110,7 +110,7 @@ static int __init vkms_init(void)
>  	ret = drm_vblank_init(&vkms_device->drm, 1);
>  	if (ret) {
>  		DRM_ERROR("Failed to vblank\n");
> -		goto out_fini;
> +		goto out_unregister;
>  	}
>  
>  	ret = vkms_modeset_init(vkms_device);
>

Hi,

Thanks for the patch! Everything is fine for me.

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> 
