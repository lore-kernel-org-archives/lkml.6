Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 17:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EDA2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 17:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbeLPRr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 12:47:27 -0500
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:36400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730449AbeLPRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 12:47:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9800B100E86C0;
        Sun, 16 Dec 2018 17:47:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub06_40a9d16c48d3b
X-Filterd-Recvd-Size: 1997
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Dec 2018 17:47:24 +0000 (UTC)
Message-ID: <1bfa8186371146e05bc0d84e308e0e08115236d5.camel@perches.com>
Subject: Re: [PATCH 2/2] Staging: nvec: nvec: fixed check style issues
From:   Joe Perches <joe@perches.com>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>, marvin24@gmx.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org
Date:   Sun, 16 Dec 2018 09:47:23 -0800
In-Reply-To: <1544979463-10126-1-git-send-email-indigoomega021@gmail.com>
References: <1544979463-10126-1-git-send-email-indigoomega021@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-16 at 08:57 -0800, Amir Mahdi Ghorbanian wrote:
> Fixed an endline open parenthesis issue and replaced udelay() by the
> preferred usleep_range() function.

Not all checkpatch bleats need to be fixed.

Function names with 40+ character length identifiers makes
fitting within an 80 column limit nearly impossible.

> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
[]
> @@ -382,8 +382,10 @@ static void nvec_request_master(struct work_struct *work)
>  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
>  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
>  		nvec_gpio_set_value(nvec, 0);
> -		err = wait_for_completion_interruptible_timeout(
> -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> +		done = &nvec->ec_transfer;
> +		timeout = msecs_to_jiffies(5000);
> +		err = wait_for_completion_interruptible_timeout(done,
> +								timeout);

This was easier to read without the temporaries.
And where are done and timeout declared?

Please compile your patches before submitting them.


