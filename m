Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeC0VFl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:05:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45389 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeC0VFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:05:36 -0400
X-Google-Smtp-Source: AIpwx4+un3meTJntkaou/rU3U/uMTqGq0iXZ5snyI6MAlYIZC0mPuVFVvb/Am8brHSb5oxnXBwLGpg==
Subject: Re: [PATCH] watchdog: w83977f_wdt: Mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180327193041.GA2432@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <268ac0e3-bcb5-f0dd-6bc2-f5dd52540b3e@roeck-us.net>
Date: Tue, 27 Mar 2018 14:05:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327193041.GA2432@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 12:30 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "Fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/w83977f_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
> index 20e2bba..672b61a 100644
> --- a/drivers/watchdog/w83977f_wdt.c
> +++ b/drivers/watchdog/w83977f_wdt.c
> @@ -427,7 +427,7 @@ static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   			return -EINVAL;
>   
>   		wdt_keepalive();
> -		/* Fall */
> +		/* Fall through */
>   
>   	case WDIOC_GETTIMEOUT:
>   		return put_user(timeout, uarg.i);
> 
