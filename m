Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D682087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D682087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smida.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeH1XzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:55:09 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:42665 "EHLO
        4.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH1XzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:55:09 -0400
X-Greylist: delayed 15054 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 19:55:08 EDT
Received: from player729.ha.ovh.net (unknown [10.109.159.7])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4412BD2814
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:14:45 +0200 (CEST)
Received: from smida.it (unknown [194.136.86.45])
        (Authenticated sender: andi@smida.it)
        by player729.ha.ovh.net (Postfix) with ESMTPSA id 60AFE5E00BD;
        Tue, 28 Aug 2018 17:14:39 +0200 (CEST)
Date:   Tue, 28 Aug 2018 18:14:38 +0300
From:   Andi Shyti <andi@smida.it>
To:     Colin King <colin.king@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: olpc_apsp: remove unused pointer 'np'
Message-ID: <20180828151438.GA10857@jack.zhora.eu>
References: <20180828145648.11619-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828145648.11619-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 7414332361960773025
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrgeeggdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Tue, Aug 28, 2018 at 03:56:48PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'nb' is being assigned but is never used hence it is

'np' here. Other than that,

Reviewed-by: Andi Shyti <andi@etezian.org>

Andi

> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'np' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/input/serio/olpc_apsp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index 8e9a4209fcad..8bd8ed25946f 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -172,7 +172,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	struct serio *kb_serio, *pad_serio;
>  	struct olpc_apsp *priv;
>  	struct resource *res;
> -	struct device_node *np;
>  	unsigned long l;
>  	int error;
>  
> @@ -180,7 +179,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	np = pdev->dev.of_node;
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->base)) {
> -- 
> 2.17.1
