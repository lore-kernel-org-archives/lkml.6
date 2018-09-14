Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EE2C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D520861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3D520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeINNx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:53:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58849 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeINNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:53:28 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 7460c9ea944ab518; Fri, 14 Sep 2018 10:40:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi: remove a meaningless null check before debugfs_remove
Date:   Fri, 14 Sep 2018 10:37:19 +0200
Message-ID: <23292371.I5A41k64Vn@aspire.rjw.lan>
In-Reply-To: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
References: <1534589360-64938-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 18, 2018 12:49:20 PM CEST zhong jiang wrote:
> debugfs_remove has taken null pointer into account. So it is safe
> to remove the check before debugfs_remove.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/acpi/custom_method.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index e967c11..4451877 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -92,8 +92,7 @@ static int __init acpi_custom_method_init(void)
>  
>  static void __exit acpi_custom_method_exit(void)
>  {
> -	if (cm_dentry)
> -		debugfs_remove(cm_dentry);
> +	debugfs_remove(cm_dentry);
>  }
>  
>  module_init(acpi_custom_method_init);
> 

Applied, thanks!


