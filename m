Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9C7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266D2204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbeLQLkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:40:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57395 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeLQLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:40:44 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 89e5ceee8c812353; Mon, 17 Dec 2018 12:40:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     lenb@kernel.org, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI, APEI, EINJ: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon, 17 Dec 2018 12:40:19 +0100
Message-ID: <2171529.ACrt31yYEM@aspire.rjw.lan>
In-Reply-To: <20181130170106.4031-1-tiny.windzz@gmail.com>
References: <20181130170106.4031-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 30, 2018 6:01:06 PM CET Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/acpi/apei/einj.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index b38737c83a24..fcccbfdbdd1a 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -607,17 +607,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -static int available_error_type_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, available_error_type_show, NULL);
> -}
> -
> -static const struct file_operations available_error_type_fops = {
> -	.open		= available_error_type_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
>  static int error_type_get(void *data, u64 *val)
>  {
> 

Applied, thanks!


