Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E69ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB962150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB962150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbeISXFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:05:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37936 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeISXFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:05:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id s129-v6so644718qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=hDZJx+YP6oiLLg8g4Pbx+urRGgjD9Vu8BwVMmcwY/0k=;
        b=Zk2z/ZxUY0ynl5dPNRhx6PcXbIUOhhAx2pS5NwxPo4OjVcvyI137A0yGwgVrEyA6le
         gNIPUJxoRIIo00mzYTVX8mLeeCZIeFojAfi9EWqSUrMDVABaji8VLiLG9/lMHU/d1Qyo
         faiTKyQhKv+P5KV6GesdPc0a5Ulfl9GxUV6eaWjTKeP6ONx3TNKb6O/Z8aAGqQkKzqmO
         SuU3Mh002obsM9N2YcfY4e6dHNE6WcK1ICbO7Mx9zwFbD4mqeL2/r5zwm3usGkxOW0cY
         J4qZm0VBZ53wUt9bmdbDBlkUGW2+yxxa9xJnsFbjfCRgOEzxf7C/uNkRH/louwSh/v9P
         KkLg==
X-Gm-Message-State: APzg51Aqkj9lnfhiYFjPze6EVXechkoIfT2aPIgDUL8Qylb4eIlJJ4dI
        CXBj1R4VJ/PbYGYFqtfWnF6vFQ==
X-Google-Smtp-Source: ANB0VdZgLwvh1ghTOhAvMes4Utm3sc/NBCitAMdXXdyxstRCMK3ktB/QKan+Q9SteVZnk4B+4l9K7g==
X-Received: by 2002:a37:f50f:: with SMTP id l15-v6mr24087659qkk.251.1537377990466;
        Wed, 19 Sep 2018 10:26:30 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id b18-v6sm13180159qtk.92.2018.09.19.10.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:26:29 -0700 (PDT)
Message-ID: <df06258cf4c30070bb5fdbe0abacbce71024e3d3.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH] drm: nouveau: remove a redundant local
 variable 'pclks'
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     zhong jiang <zhongjiang@huawei.com>, airlied@linux.ie
Cc:     okaya@codeaurora.org, nouveau@lists.freedesktop.org,
        helgaas@kernel.org, bskeggs@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 13:26:28 -0400
In-Reply-To: <1537367764-59819-1-git-send-email-zhongjiang@huawei.com>
References: <1537367764-59819-1-git-send-email-zhongjiang@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lgtm

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2018-09-19 at 22:36 +0800, zhong jiang wrote:
> The local variable 'pclks' is never used after being assigned.
> hence it should be redundant and can be removed.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> index c79160c..cae8f71 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> @@ -56,7 +56,7 @@ struct nv_sim_state {
>  nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
>  {
>  	int pagemiss, cas, width, bpp;
> -	int nvclks, mclks, pclks, crtpagemiss;
> +	int nvclks, mclks, crtpagemiss;
>  	int found, mclk_extra, mclk_loop, cbs, m1, p1;
>  	int mclk_freq, pclk_freq, nvclk_freq;
>  	int us_m, us_n, us_p, crtc_drain_rate;
> @@ -71,7 +71,6 @@ struct nv_sim_state {
>  	bpp = arb->bpp;
>  	cbs = 128;
>  
> -	pclks = 2;
>  	nvclks = 10;
>  	mclks = 13 + cas;
>  	mclk_extra = 3;

