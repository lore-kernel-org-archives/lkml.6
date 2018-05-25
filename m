Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967120AbeEYPxO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965666AbeEYPwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:52:45 -0400
Date: Fri, 25 May 2018 17:52:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        ShuFan Lee <shufan_lee@richtek.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: typec: rt1711h: fix tcpci dependency
Message-ID: <20180525155228.GA17043@kroah.com>
References: <20180525153841.3314617-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525153841.3314617-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 05:38:25PM +0200, Arnd Bergmann wrote:
> Using 'select' instead of the normal 'depends on' causes
> a build issue with CONFIG_I2C=m:
> 
> WARNING: unmet direct dependencies detected for TYPEC_TCPCI
>   Depends on [m]: STAGING [=y] && TYPEC_TCPM [=y] && I2C [=m]
>   Selected by [y]:
>   - TYPEC_RT1711H [=y] && STAGING [=y] && TYPEC_TCPM [=y]
> 
> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/typec/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think that this is already fixed in linux-next with some patches that
I queued up there yesterday.  When did you last see this problem?

thanks,

greg k-h
