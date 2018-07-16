Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7AE208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7AE208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeGPKq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:46:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeGPKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:46:58 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ff0c2-0001pt-CE; Mon, 16 Jul 2018 12:20:14 +0200
Message-ID: <1531736413.18173.10.camel@pengutronix.de>
Subject: Re: [PATCH] reset: simple: export reset_simple_ops to be referred
 from modules
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 16 Jul 2018 12:20:13 +0200
In-Reply-To: <1530699236-27867-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530699236-27867-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunihiko,

On Wed, 2018-07-04 at 19:13 +0900, Kunihiko Hayashi wrote:
> Allow reset_simple_ops to be referred from modules that use reset-simple
> framework by adding EXPORT_SYMBOL_GPL.
> 
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/reset/reset-simple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> This patch is due to the building issue as modules [1].
> [1] https://lkml.org/lkml/2018/6/29/181
> 
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index f7ce891..a91107f 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -87,6 +87,7 @@ const struct reset_control_ops reset_simple_ops = {
>  	.deassert	= reset_simple_deassert,
>  	.status		= reset_simple_status,
>  };
> +EXPORT_SYMBOL_GPL(reset_simple_ops);
>  
>  /**
>   * struct reset_simple_devdata - simple reset controller properties

Thank you, applied to reset/next.

regards
Philipp
