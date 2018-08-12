Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FF0C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CDB21A17
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CDB21A17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeHLNyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:54:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44657 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeHLNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:54:36 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 896c7cc6796004aa; Sun, 12 Aug 2018 13:16:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / EC: Use ec_no_wakeup on ThinkPad X1 Yoga 3rd
Date:   Sun, 12 Aug 2018 13:14:46 +0200
Message-ID: <1855499.yJd7R0ESNr@aspire.rjw.lan>
In-Reply-To: <20180731105239.22008-1-aaron.ma@canonical.com>
References: <20180731105239.22008-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 31, 2018 12:52:39 PM CEST Aaron Ma wrote:
> Like on X1C6, on X1Y3 EC interrupts constantly wake up system from
> s2idle, the power consumption is extremely high.
> So make ec_no_wakeup be true as default to keep system in s2idle mode
> and reduce power consumption.
> 
> Power button works when ec_no_wakeup=true.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/acpi/ec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 917f77f4cb55..6291d5c77267 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2045,6 +2045,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>  			DMI_MATCH(DMI_PRODUCT_FAMILY, "Thinkpad X1 Carbon 6th"),
>  		},
>  	},
> +	{
> +		.ident = "ThinkPad X1 Yoga 3rd",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
> +		},
> +	},
>  	{ },
>  };
>  
> 

Applied, thanks!


