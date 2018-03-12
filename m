Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932292AbeCLXbJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:31:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbeCLXbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:31:08 -0400
Date: Tue, 13 Mar 2018 00:31:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefano Manni <stefano.manni@gmail.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mcp795: remove VLA usage
Message-ID: <20180312233102.GE3795@piout.net>
References: <20180312231338.3756-1-stefano.manni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312231338.3756-1-stefano.manni@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/03/2018 at 00:13:38 +0100, Stefano Manni wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them with
> fixed-length arrays instead.
> 
> rtc-mcp795.c uses a variable-length array declaration to contain
> the command to write the rtcc; this can be replaced by a fixed-
> size array of length 2 (instruction, address) + 32 (data out),
> assuming a maximum data length of 32 bytes before wrap up.
> 
> This was prompted by https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
> ---
>  drivers/rtc/rtc-mcp795.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
> index 77f21331ae21..a5f504e2364c 100644
> --- a/drivers/rtc/rtc-mcp795.c
> +++ b/drivers/rtc/rtc-mcp795.c
> @@ -61,6 +61,9 @@
>  
>  #define SEC_PER_DAY		(24 * 60 * 60)
>  
> +/* Maximum length for data out in write operation to RTCC */
> +#define MCP795_MAX_DATAOUT_LEN	32
> +

This is wrong, see https://marc.info/?l=linux-kernel&m=152046370320811&w=2

Also, https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=74ce1a932504da166cfbccf5567aa3751b6aa599

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
