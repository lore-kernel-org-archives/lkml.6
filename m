Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BED2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5474F2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbeLQLmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:42:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43467 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:42:51 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a1856b31a88a363d; Mon, 17 Dec 2018 12:42:48 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / sleep: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon, 17 Dec 2018 12:42:25 +0100
Message-ID: <3468793.EN3tBH1YX1@aspire.rjw.lan>
In-Reply-To: <20181211162048.21906-1-tiny.windzz@gmail.com>
References: <20181211162048.21906-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 11, 2018 5:20:48 PM CET Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/power/main.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 35b50823d83b..98e76cad128b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -318,23 +318,12 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
>  
>  	return 0;
>  }
> -
> -static int suspend_stats_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, suspend_stats_show, NULL);
> -}
> -
> -static const struct file_operations suspend_stats_operations = {
> -	.open           = suspend_stats_open,
> -	.read           = seq_read,
> -	.llseek         = seq_lseek,
> -	.release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(suspend_stats);
>  
>  static int __init pm_debugfs_init(void)
>  {
>  	debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
> -			NULL, NULL, &suspend_stats_operations);
> +			NULL, NULL, &suspend_stats_fops);
>  	return 0;
>  }
>  
> 

Applied, thanks!


