Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxbGKhZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28C4460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeFFMsS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeFFMsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:48:16 -0400
Date: Wed, 6 Jun 2018 14:47:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: binder: Drop dependency on !M68K
Message-ID: <20180606124751.GA21439@kroah.com>
References: <1528288856-11841-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528288856-11841-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 02:40:56PM +0200, Geert Uytterhoeven wrote:
> As of commit 7124330dabe5b3cb ("m68k/uaccess: Revive 64-bit
> get_user()"), the 64-bit Android binder interface builds fine on m68k.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/android/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index ee4880bfdcdc98d2..432e9ad770703275 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -10,7 +10,7 @@ if ANDROID
>  
>  config ANDROID_BINDER_IPC
>  	bool "Android Binder IPC Driver"
> -	depends on MMU && !M68K
> +	depends on MMU

Wonderful!  Thanks for this, I'll queue it up after 4.18-rc1 is out.

greg k-h
