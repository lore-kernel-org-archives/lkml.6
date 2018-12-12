Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF0DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA80020811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA80020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLLG3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:29:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLG3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:29:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A8A51145173FB;
        Tue, 11 Dec 2018 22:29:53 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:29:50 -0800 (PST)
Message-Id: <20181211.222950.1995970751331458343.davem@davemloft.net>
To:     amhetre@nvidia.com
Cc:     herbert@gondor.apana.org.au, axboe@kernel.dk,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-crypto@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, vdumpa@nvidia.com,
        mmaddireddy@nvidia.com, Snikam@nvidia.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Update size type to support greater then
 4GB size.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
References: <1544595853-18492-1-git-send-email-amhetre@nvidia.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Dec 2018 22:29:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Mhetre <amhetre@nvidia.com>
Date: Wed, 12 Dec 2018 11:54:13 +0530

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 68e91ef..0a07a29 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -587,7 +587,7 @@ enum {
>  
>  struct nvme_sgl_desc {
>  	__le64	addr;
> -	__le32	length;
> +	__le64	length;
>  	__u8	rsvd[3];
>  	__u8	type;
>  };

Isn't this a device or protocol defined datastructure?  You can't just
change it like this.
