Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B55C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B987524EE7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 12:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B987524EE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeFXM4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 08:56:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52531 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeFXM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 08:56:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C2D3A2092B; Sun, 24 Jun 2018 14:56:00 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8F594206A0;
        Sun, 24 Jun 2018 14:55:50 +0200 (CEST)
Date:   Sun, 24 Jun 2018 14:55:48 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] ubi: fastmap: Relax size check
Message-ID: <20180624145548.2259fe38@bbrezillon>
In-Reply-To: <20180613212344.11608-10-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
        <20180613212344.11608-10-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:23:39 +0200
Richard Weinberger <richard@nod.at> wrote:

> While attaching via fastmap we verify whether the found fastmap
> is as large as we have computed.
> With preseeded Fastmaps this assumtion can fail since ubinize cannot
> know the total size of the MTD and uses the number if used PEBs for
> the calculation.
> Therefore the found fastmap might be smaller than the kernel expects.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/ubi/fastmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
> index 09a9d3a0ccf5..dabeb01af24a 100644
> --- a/drivers/mtd/ubi/fastmap.c
> +++ b/drivers/mtd/ubi/fastmap.c
> @@ -1168,7 +1168,7 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
>  	}
>  
>  	fm_size = ubi->leb_size * used_blocks;
> -	if (fm_size != ubi->fm_size) {
> +	if (fm_size > ubi->fm_size) {
>  		ubi_err(ubi, "bad fastmap size: %zi, expected: %zi",
>  			fm_size, ubi->fm_size);
>  		ret = UBI_BAD_FASTMAP;

