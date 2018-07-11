Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39ACC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1BD2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1BD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeGKJmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:42:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60797 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbeGKJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:42:12 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5be4475e3e804521; Wed, 11 Jul 2018 11:38:44 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/button.c: fix defined but not used warning
Date:   Wed, 11 Jul 2018 11:37:12 +0200
Message-ID: <19389915.917i3WGPId@aspire.rjw.lan>
In-Reply-To: <2e91930f-c762-532b-6607-223385078edb@infradead.org>
References: <2e91930f-c762-532b-6607-223385078edb@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 7, 2018 5:25:01 PM CEST Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a build warning in the ACPI button driver when CONFIG_PROC_FS
> is not enabled by marking the unused function as __maybe_unused.
> 
> ../drivers/acpi/button.c:252:12: warning: 'acpi_button_state_seq_show' defined but not used [-Wunused-function]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/button.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-next-20180706.orig/drivers/acpi/button.c
> +++ linux-next-20180706/drivers/acpi/button.c
> @@ -21,6 +21,7 @@
>  
>  #define pr_fmt(fmt) "ACPI: button: " fmt
>  
> +#include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -249,7 +250,8 @@ static int acpi_lid_notify_state(struct
>  	return ret;
>  }
>  
> -static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
> +static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
> +						     void *offset)
>  {
>  	struct acpi_device *device = seq->private;
>  	int state;
> 

Applied, thanks!

