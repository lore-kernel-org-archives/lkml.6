Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeBQU7I (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeBQU7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:59:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB2321726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shli@kernel.org
Date: Sat, 17 Feb 2018 12:59:05 -0800
From: Shaohua Li <shli@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH] md/raid1: Fix trailing semicolon
Message-ID: <20180217205905.pkbyr3w2lbqwzgsz@kernel.org>
References: <20180117133802.8879-1-luisbg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117133802.8879-1-luisbg@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2018 at 01:38:02PM +0000, Luis de Bethencourt wrote:
> The trailing semicolon is an empty statement that does no operation.
> Removing it since it doesn't do anything.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
> ---
> 
> Hi,
> 
> After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
> suggested I fix it treewide [0].

applied, thanks!
> 
> Best regards,
> Luis
> 
> 
> [0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
> [1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html
> 
>  drivers/md/raid1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index b2eae332e1a2..f978eddc7a21 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1108,7 +1108,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
>  
>  	bio_copy_data(behind_bio, bio);
>  skip_copy:
> -	r1_bio->behind_master_bio = behind_bio;;
> +	r1_bio->behind_master_bio = behind_bio;
>  	set_bit(R1BIO_BehindIO, &r1_bio->state);
>  
>  	return;
> -- 
> 2.15.1
> 
