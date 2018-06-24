Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E6D24EE5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E6D24EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeFXMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:54:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52503 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbeFXMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:54:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF29720734; Sun, 24 Jun 2018 14:54:02 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 925E1206A0;
        Sun, 24 Jun 2018 14:53:52 +0200 (CEST)
Date:   Sun, 24 Jun 2018 14:53:50 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] ubi: fastmap: Add UBI_FM_SB_PRESEEDED_FLG flag
Message-ID: <20180624145350.11231190@bbrezillon>
In-Reply-To: <20180613212344.11608-5-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
        <20180613212344.11608-5-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:23:34 +0200
Richard Weinberger <richard@nod.at> wrote:

> This flag indicates that the fastmap was preseeded, which means
> it was created offline by a tool such as ubinize which cannot know
> the whole MTD state such as real size and bad blocks.
> As consequence UBI has to take special care to use that fastmap.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/ubi/ubi-media.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
> index 6136a97f4844..be339fb924af 100644
> --- a/drivers/mtd/ubi/ubi-media.h
> +++ b/drivers/mtd/ubi/ubi-media.h
> @@ -390,7 +390,11 @@ struct ubi_vtbl_record {
>  #define UBI_FM_MIN_POOL_SIZE	8
>  #define UBI_FM_MAX_POOL_SIZE	256
>  
> -#define UBI_FM_SB_FLG_MASK	0
> +enum {
> +	UBI_FM_SB_PRESEEDED_FLG	= 0x1,
> +};
> +
> +#define UBI_FM_SB_FLG_MASK (UBI_FM_SB_PRESEEDED_FLG)

You update the def that you use to check when a flag is supported,
still, you do not support this feature yet. Better move this line after
the support is really functional, don't you think?
