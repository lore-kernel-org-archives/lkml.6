Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D305AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C7420645
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C7420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbeLBHSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:18:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57750 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBHSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:18:38 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D99B3207B0; Sun,  2 Dec 2018 08:18:33 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 97F2E206D8;
        Sun,  2 Dec 2018 08:18:33 +0100 (CET)
Date:   Sun, 2 Dec 2018 08:18:32 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     robert.jarzmik@free.fr, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, keescook@chromium.org,
        shreeya.patel23498@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: remove DEBUGFS_RO_ATTR()
Message-ID: <20181202081832.08de39b2@bbrezillon>
In-Reply-To: <20181202015417.9100-1-tiny.windzz@gmail.com>
References: <20181202015417.9100-1-tiny.windzz@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Dec 2018 20:54:17 -0500
Yangtao Li <tiny.windzz@gmail.com> wrote:

> We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> such a macro,so remove DEBUGFS_RO_ATTR.Also use DEFINE_SHOW_ATTRIBUTE
> to simplify some code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -Remove a missing DEBUGFS_RO_ATTR
> ---
>  drivers/mtd/devices/docg3.c    | 20 ++++++++++++--------
>  drivers/mtd/devices/docg3.h    | 11 -----------
>  drivers/mtd/mtdswap.c          | 12 +-----------
>  drivers/mtd/nand/raw/nandsim.c | 16 +++-------------
>  4 files changed, 16 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index 512bd4c2eec0..80143972963e 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1603,7 +1603,7 @@ static void doc_unregister_sysfs(struct platform_device *pdev,
>  /*
>   * Debug sysfs entries
>   */
> -static int dbg_flashctrl_show(struct seq_file *s, void *p)
> +static int flashcontrol_show(struct seq_file *s, void *p)
>  {
>  	struct docg3 *docg3 = (struct docg3 *)s->private;
>  
> @@ -1623,9 +1623,10 @@ static int dbg_flashctrl_show(struct seq_file *s, void *p)
>  
>  	return 0;
>  }
> -DEBUGFS_RO_ATTR(flashcontrol, dbg_flashctrl_show);
>  
> -static int dbg_asicmode_show(struct seq_file *s, void *p)
> +DEFINE_SHOW_ATTRIBUTE(flashcontrol);

Just nitpicking, but can you remove the blank line between the function
definition and DEFINE_SHOW_ATTRIBUTE()?
