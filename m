Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614D620881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfDQjOEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614D620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeGIT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:28:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45657 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGIT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:28:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so12468497oic.12;
        Mon, 09 Jul 2018 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1B8OtU7Tq1R/xUauFVMR3uEmntBOF8DEdwEbIz27eBs=;
        b=DfDQjOEOb6PWOvfgU+v7tVCWiZEE+ciX9qlWyNm6FJI/IMQ42x5iAnW1shSPLDl4hU
         8JAeoPUnHC5KQph/6jJCaZx6e6r5F705R7JFrIWPTG8texfsCEJxkLl9Cw3vk4wZ0L0O
         GhKSAdc7ZbxrWVUPZ0gNnrUS6TfqexsoJjHOfpGeA5H8Xtefo2Q4uVsDbBveIZ49uxQi
         pwgu2hkm7taRq75fCu9A/Xmj86Avx10dG7Jm2SQ7cC6DE15XmwvQXgG8JzhvgYGwGVbf
         GaiisgD+yyBJe8se0hOwyUvq3HjorAujjE3N+QqWsxvsbT00AkJotUeU0HWDegNRhmb9
         9Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1B8OtU7Tq1R/xUauFVMR3uEmntBOF8DEdwEbIz27eBs=;
        b=Oc5Zj/aScovTy5nbo2k8xk8r7MKqx1sDJ74GvXrtTzj93ShUncKuhGhjiwqvXIYYzr
         9gO2XRcRs2zrF60cjFUmqOAN40iLVN7t2kW2tis/0NjpCZ0ZNZ/rNd5aK0acCHUPVkUF
         qbVLckT+hq35/+8xp3cP3iOPH6gDFlGdPWwK2xGJT+xWI8hmmbUjMMC9jG5WDObeUlgl
         QjQX5KrQKbz2mUTQHLQKPK6R2k5BWllAeKlrPd2AAxif/efI/yOOyYQ8sf49L2eNw8MP
         ZjxCnUK64LTVQFJDbQZwlRc2P4fJNHEOBtzxGGJJbZAWDXsD4u3lX2Hr1p9vLgq0czsc
         ZYsQ==
X-Gm-Message-State: AOUpUlFlBqh8jIogrrrtKiidSdqOMAClLa4cTJN4HpcHBwmKXrFkt49V
        +fR4viG5gP5ECyS9odrZAyxJAHw+2UEaPfQkfX4=
X-Google-Smtp-Source: AAOMgpdb4Cxoz0ZrIS/BNTnBcofdhfeG8DiplMtE8zAz1CnSIJdzU3uXiR7MwnsUySd9ccnUijOY6so3rAPocxplMlY=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr2465234oia.198.1531164521643;
 Mon, 09 Jul 2018 12:28:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 12:28:41 -0700 (PDT)
In-Reply-To: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 9 Jul 2018 16:28:41 -0300
Message-ID: <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Wolfram Sang <w.sang@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:16 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
>  of_iompa() can return NULL so that return needs to be checked and NULL

s/of_iompa/of_iomap/

> treated as failure. While at it also take care of the missing
> of_node_put() in the error path.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
> ---
>
> Problem was found by an experimental coccinelle script
>
> Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=y,
> CONFIG_CAN_MSCAN=y, CONFIG_CAN_MPC5XXX=y
> (with a number of sparse warnings not related to the proposed change)
>
> Patch is against 4.18-rc3 (localversion-next is next-20180706)
>
>  drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
> index c7427bd..2949a38 100644
> --- a/drivers/net/can/mscan/mpc5xxx_can.c
> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
> @@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
>                 return 0;
>         }
>         cdm = of_iomap(np_cdm, 0);
> +       if (!cdm) {
> +               of_node_put(np_cdm);
> +               dev_err(&ofdev->dev, "can't map clock node!\n");
> +               return 0;

I think you should return an error code here. -ENOMEM maybe?
