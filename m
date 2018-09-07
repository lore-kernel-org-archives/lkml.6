Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9032C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704EC2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Gp4FsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704EC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIGXV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:21:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37345 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:21:28 -0400
Received: by mail-yw1-f66.google.com with SMTP id x83-v6so5742646ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9ICrNiuDX5QGblBXMfmPqF1GSUCKxt6OTSy0huNL9A=;
        b=S7Gp4FsX+Wapj/bo4RdLgjTbB2sE42SDKQPyKLPGKEOM9N3r1vx5ZVll+HoA1PdSX1
         G9mEHzAwo6zHnIrTxWe/M8+80pMUJg2Y8Gx+DB1LRg7kRIWOGVgzaModglBvJAerdOc/
         ljWrVV3U+ikeNTNmnhDYtY6hax55MqwJXEYMtudcjkeEKPTnYRrWAiXTZ+MoMYbaYcUT
         NHiJi0GUiinLMCfapvfQNk9ibBhERLEggtC3ReeV1vgVoxI6xSRUq1Se4CiVDqNYYTM+
         qt/t7BfPX/LfkIzUUFvRvRUow4I4rFLVnW4SBKdN7GClCEPDILjwyLsu1ow0GUjjtT/i
         zmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9ICrNiuDX5QGblBXMfmPqF1GSUCKxt6OTSy0huNL9A=;
        b=rxsT3fFKjCFW3twnocWOWaC6W1kVhpgoAxBm+5x6x8pnPspi01IuSkYodpi4o6lCCf
         EOop1+YSLapul4wroGdHu9WtnFQ8tgb+yvXdngWWmmA7dQrsgN7PgZouSuurJ4poRQje
         NDAkIr6dtktA/ARfZd9uXJr10oKli6auT2yhBpRwGXo/4IjHz2HTwa22EopyL8+GMT3h
         n3Fs4xFymSdqXP2W3KpeyDgWMuv5KbTwcUj5V5f34/pJGJfdG79QfBibMz10MzGESN4k
         63deXM1h7kQxIuM2Mlo8wHx7dteRdNbA1NHg/+bPhvvI/AatZCFAo+HY6ol6CNXDWKyQ
         Bfww==
X-Gm-Message-State: APzg51CgXTxGVEnGG8TqgFaPdXYtbBXRIcPRnhZC6fxx3n7gNbROqzP4
        /IrG70jSITgcsYe3WuJpbMA=
X-Google-Smtp-Source: ANB0VdaUPuuMiDzIyF58vd8wL5/2qgN1FNUBhLmkBBBKikcE5acnjIZ5rRF540uRrUWhx8rWusNneA==
X-Received: by 2002:a81:af0d:: with SMTP id n13-v6mr4961951ywh.105.1536345555210;
        Fri, 07 Sep 2018 11:39:15 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::9697])
        by smtp.gmail.com with ESMTPSA id n187-v6sm5686758ywn.76.2018.09.07.11.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:39:14 -0700 (PDT)
Date:   Fri, 7 Sep 2018 14:39:12 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        zijun_hu <zijun_hu@htc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mm: percpu: remove unnecessary unlikely()
Message-ID: <20180907183909.GA84248@dennisz-mbp.dhcp.thefacebook.com>
References: <20180907181035.1662-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907181035.1662-1-igor.stoppa@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Fri, Sep 07, 2018 at 09:10:35PM +0300, Igor Stoppa wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to
> wrap it into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Acked-by: Dennis Zhou <dennisszhou@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: zijun_hu <zijun_hu@htc.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
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

Sorry for the delay. I'll be taking over the percpu tree and am in the
process of getting a tree. I'm still keeping track of this and will take
it for the next release.

Thanks,
Dennis
