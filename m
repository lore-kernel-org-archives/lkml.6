Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC9420863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="EdfRr3Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC9420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeK3Tog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:44:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35470 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3Tog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:44:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so4256111ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mCARxxw98yN9PqVmOMrDcW5gJ9a4Nl9C3uk8omMruKk=;
        b=EdfRr3DjPyED+LRv3c0LQqpxHwE2Kf4kJKZ2CgH8SejPNIEtDgDokY9O0B5/9YhZCX
         oSG5sLRZbQ29D0QVb5R1gbWHYmEl95BbpivsRkIW8G2FWhaKL3+baTu0KA4QENALkqTT
         gv/374lpSF8cqfQPQJPc/cgIACNNNmHkWWdOd6TlhPleXh58C9HwPAUrnfyVeWZ+u7rG
         9auEFRML4LEEKurnC4Uv8Zgg9IRoxGoCYnDMx7S+JlYYxbj4X+zketEUgE8YaFjbSoTw
         K+6ZOTEwYyZFGnHl5sJDm7k87DlRfjytLZwJDq5kY1UyPDf8vVABBCJZKC0WmOQmjRIn
         HTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mCARxxw98yN9PqVmOMrDcW5gJ9a4Nl9C3uk8omMruKk=;
        b=bB+pYc/ZQIucImkr0ym/Al6DjQvn7jKKtVC3H+dF2p9PX66jhFWJMQZoymY/9Dt6uX
         dQ2eVN59hI32dHraJUkX3fOQBUlYzy5ukI3zhCrt+zAUalaxtWj1zhaxuWzm9ub1KEZf
         JCEfooaXrOk5gB+c5dnb8oEUO+7/evx/et+TKT0xfLZKtgGI1t6AuWD2RvCDq8Cz02VO
         u9kZQB9rdwKIavQ0Q04MFutr3RI4ACfhg3XiOBu0KujjFP6BNg5gTLlhZlB3Voe4EqaW
         HIGtEShWqEDt90NQc5355sSVJLymD0WtTyWdlwP/Dt4v2W3ACbT7APaAW3NrA+bwLj1r
         JQEw==
X-Gm-Message-State: AA+aEWZGQmF8l4IcvTP6NTwp0srdNCdhRYueyO20FLA4+rZREze6uowE
        HcWpCdkwwIqQCJ6Z3CSfaqZp3A==
X-Google-Smtp-Source: AFSGD/Wptq4+eb8SB/m2utNOEMxbcKz/6Muq+2GUAqgMpukvWEDPyKL+Z1UlbVdmgtx0B2RkXayxGw==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr3656795ljj.61.1543566962120;
        Fri, 30 Nov 2018 00:36:02 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id v5-v6sm678716lje.78.2018.11.30.00.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:36:01 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: add comments wrt locking in recovery path
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1543404016-14902-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <55c31953-4816-c53a-72bf-1d159007378c@lightnvm.io>
Date:   Fri, 30 Nov 2018 09:36:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543404016-14902-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2018 12:20 PM, Javier González wrote:
> pblk's recovery path is single threaded and therefore a number of
> assumptions regarding concurrency can be made. To avoid confusion, make
> this explicit with a couple of comments in the code.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c     | 1 +
>   drivers/lightnvm/pblk-recovery.c | 3 +++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 44c5dc046912..f1b411e7c7c9 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1276,6 +1276,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   	return 0;
>   }
>   
> +/* Line allocations in the recovery path are always single threaded */
>   int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
>   {
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 416d9840544b..4c726506a831 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -13,6 +13,9 @@
>    * General Public License for more details.
>    *
>    * pblk-recovery.c - pblk's recovery path
> + *
> + * The L2P recovery path is single threaded as the L2P table is updated in order
> + * following the line sequence ID.
>    */
>   
>   #include "pblk.h"
> 

Picked up for 4.21.
