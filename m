Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46673C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B9D2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wnLUxI3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLDTxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:53:05 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39062 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDTxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:53:04 -0500
Received: by mail-yw1-f67.google.com with SMTP id j6so7486462ywj.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+VG8OeAI5diR1prMWfOG9jypspaoM2+GkCaXxs9Fkh4=;
        b=wnLUxI3jiVK/TZ6SfjDQh0Cu6nYvzK2mrpLOLEkUPUGkdupA/tT7gziopeU58X+Zpe
         85vv/WMoH84pvMg2DIDc6EZ51eb36yC7g/mSS6qIX8Ib71Bv5wb6lW3p+lGkBgdjL4K5
         HEEI824CFmFUm4cTRbQljlmnF3A+2tQlXzQwRo0ELL59Nek8w9qiQg55pXRvRW7qtjm9
         zruHxhq84zGez1dw04hNiSL/P8DpsRWdmXvNQmFTyIsGiGfvQMIz7NbRpMfJya0sspUy
         WlxS5EWvy5fD9PVNNlI/LrcJV4NyEkW92sJ8o8vOiQqV7xVVXc9IT1Dm+aMKRmsT+Qv1
         xU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+VG8OeAI5diR1prMWfOG9jypspaoM2+GkCaXxs9Fkh4=;
        b=CqfyTzzW0bCe4tWMb/4FV5QN9Enp2oBVISp4BuyZ7LmRBwh+bnEUQAmCcLCl5613iL
         G1Ggxp03PJJXaTcTnwxktX1K5hk+X56U3J9yfwfpkm4ecmOncLXrRvO3t34LwCt5YSuX
         GHehEm1sBbYSnC6kHFcGDxjt24B546hxfZ5JuHNy3wkOUSYtrYIWW8Sgc+3eqd0FoxHK
         ytwOcKfkJcYEvCI9iIceMEvH+Tg/J3dao75KaYTCJ/sUjb8xMmoRKjz3PtJWrN5JiJpU
         9jA39ON5QAtHdTELh+hpM3v75EhiWxl0MOaU60jJGqyT8373WUOvVzWikEf9Vo2wSoxj
         21Jw==
X-Gm-Message-State: AA+aEWaI2O6RdjwpP2g89UDDcipwLuNpUYxe7rN96dr+bZnpOetwwbkn
        2ZGi0ityYfVzTtrTzoQ4pQWmFA==
X-Google-Smtp-Source: AFSGD/Wbi84YUh7pqhteeiQX4EG/oBNIwQ4BIQpmk0wWfuROkdBZxdPdxXD1h/lIARNYJvYhrmJzfw==
X-Received: by 2002:a81:27d6:: with SMTP id n205mr21628438ywn.305.1543953183865;
        Tue, 04 Dec 2018 11:53:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k187sm5284901ywf.71.2018.12.04.11.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:53:03 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:53:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] blkcg: remove additional reference to the css
Message-ID: <20181204195301.delc756zuo5gxtlw@MacBook-Pro-91.local>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-12-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204183600.99746-12-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:35:57PM -0500, Dennis Zhou wrote:
> The previous patch in this series removed carrying around a pointer to
> the css in blkg. However, the blkg association logic still relied on
> taking a reference on the css to ensure we wouldn't fail in getting a
> reference for the blkg.
> 
> Here the implicit dependency on the css is removed. The association
> continues to rely on the tryget logic walking up the blkg tree. This
> streamlines the three ways that association can happen: normal, swap,
> and writeback.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
