Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeFDLyR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:54:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbeFDLyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:54:15 -0400
Date: Mon, 4 Jun 2018 13:54:12 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware-gsmi: make structure gsmi_dev static
Message-ID: <20180604135412.2f8316e9@endymion>
In-Reply-To: <20180601131939.4959-1-colin.king@canonical.com>
References: <20180601131939.4959-1-colin.king@canonical.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Jun 2018 14:19:39 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure gsmi_dev is local to the source and does not need to be
> in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/firmware/google/gsmi.c:96:3: warning: symbol 'gsmi_dev' was
> not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/firmware/google/gsmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index c8f169bf2e27..734146eec1b9 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -84,7 +84,7 @@ struct gsmi_buf {
>  	u32 address;			/* physical address of buffer */
>  };
>  
> -struct gsmi_device {
> +static struct gsmi_device {
>  	struct platform_device *pdev;	/* platform device */
>  	struct gsmi_buf *name_buf;	/* variable name buffer */
>  	struct gsmi_buf *data_buf;	/* generic data buffer */

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
