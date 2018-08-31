Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E720839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8NwuuvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6E720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeHaGEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:04:02 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46648 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeHaGEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 02:04:02 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so333220ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/Ao+mQGjbU8DNivYLWqm5ccgBuwG9QH6Bcvi5bSBNI=;
        b=d8NwuuvSFu8/HTkAd9dsQNFRUneAB9aquzdUO38lOoqR7ZL+/84bRYUuG6wcmG73+D
         3f80w/yDEMVtt4fSMnVaTxfBbWfettITgZ98IZm93mzya6efHAbgRHRNToKrwhj89tH4
         SvHeWW2+/IXX22W38gCnOn22vWFxjrZzeVT+UXlzFSRoHlrpYp3GckZeanbv/+40KsES
         4tjYtZgUxx30Nm2L7m+BGDF+3JSl4NIFrpkLeVUheDfqbKaXed1jrxsUbMKrpZdlazH1
         qS8fAcoHwdhFcBakl5UysvtgYcoKoFLGj7vaVIoxNJzAqYojdALSHvRVWA563aGzzCBP
         HyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/Ao+mQGjbU8DNivYLWqm5ccgBuwG9QH6Bcvi5bSBNI=;
        b=gEQyRyaA8pGxzdFJIkIbmFbFKw9b4vX/6vbLIxJn0xS6Am2izmEN51fOvql9u78/NL
         xp4xzIN3+Qggid+wmYaxv34LOt6K+yAg5faeyVAuKmaVQ+y7qn6ddn+/XiAmmcpcpld/
         7J2tnsBOPTsoqPU0XGCSufEWrZoI0BIVXdivl0lHoEkv9QrGY+xhlwMT6v2txZRno+ar
         97Krkht6jL6sNQW2JcMjbL0n+x9UpSrFMldIzBE11RYup8FN48bVy90uOWFRyV6uKU0k
         N6mrfEBUK2Mx5iUX6w2ICsL0VZI6TxG3/2iX2qxLhSzKoIv3/IVa4OCYLbCawXxydbpy
         DZ8A==
X-Gm-Message-State: APzg51BE70mlYI+JQMQLuewg4rTlPAFN2BHe6tKZv7ciEZZeK0SIrG3M
        kXpQrk1ReFxRBgbXXQc3pNs=
X-Google-Smtp-Source: ANB0VdYCn4dZD1QYggQPqJ2LjB5VDuM4G6Vm9qrO8JYwMfypH6snpocEhlBCQCBauw0DXYYv11Kayg==
X-Received: by 2002:a25:3f07:: with SMTP id m7-v6mr7343525yba.50.1535680738666;
        Thu, 30 Aug 2018 18:58:58 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::d51e])
        by smtp.gmail.com with ESMTPSA id x133-v6sm4250393ywg.49.2018.08.30.18.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:58:58 -0700 (PDT)
Date:   Thu, 30 Aug 2018 21:58:55 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Igor Stoppa <igor.stoppa@huawei.com>,
        zijun_hu <zijun_hu@htc.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 20/23] mm: percpu: remove unnecessary unlikely()
Message-ID: <20180831015854.GA69977@dennisz-mbp.dhcp.thefacebook.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
 <20180830223429.30051-21-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830223429.30051-21-igor.stoppa@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:34:26AM +0300, Igor Stoppa wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to
> wrap it into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: zijun_hu <zijun_hu@htc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Dennis Zhou <dennisszhou@gmail.com>
> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a749d4d96e3e..f5c2796fe63e 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2588,7 +2588,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
>  	BUG_ON(ai->nr_groups != 1);
>  	upa = ai->alloc_size/ai->unit_size;
>  	nr_g0_units = roundup(num_possible_cpus(), upa);
> -	if (unlikely(WARN_ON(ai->groups[0].nr_units != nr_g0_units))) {
> +	if (WARN_ON(ai->groups[0].nr_units != nr_g0_units)) {
>  		pcpu_free_alloc_info(ai);
>  		return -EINVAL;
>  	}
> -- 
> 2.17.1
> 

Acked-by: Dennis Zhou <dennisszhou@gmail.com>

Thanks,
Dennis
