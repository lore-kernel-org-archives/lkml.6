Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8094421759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8094421759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeHCOcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:32:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbeHCOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:32:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1C3FACB8;
        Fri,  3 Aug 2018 12:36:13 +0000 (UTC)
Date:   Fri, 3 Aug 2018 14:36:12 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Parth Y Shah <sparth1292@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, bhumirks@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom: assignment outside the if statement
Message-ID: <20180803143612.121fba20@endymion>
In-Reply-To: <1533288043-19624-1-git-send-email-sparth1292@gmail.com>
References: <1533288043-19624-1-git-send-email-sparth1292@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Aug 2018 14:50:43 +0530, Parth Y Shah wrote:
> Assignment of any variable should be kept outside the if statement

Actually there are exceptions to that rule, but this isn't one of them.

> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
> ---
>  drivers/misc/eeprom/max6875.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
> index 0e32709..fc0cf9a 100644
> --- a/drivers/misc/eeprom/max6875.c
> +++ b/drivers/misc/eeprom/max6875.c
> @@ -148,7 +148,8 @@ static int max6875_probe(struct i2c_client *client,
>  	if (client->addr & 1)
>  		return -ENODEV;
>  
> -	if (!(data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL)))
> +	data = kzalloc(sizeof(struct max6875_data), GFP_KERNEL);
> +	if (!data)
>  		return -ENOMEM;
>  
>  	/* A fake client is created on the odd address */

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
