Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeDWX1D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:27:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34713 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:27:01 -0400
X-Google-Smtp-Source: AIpwx490gDmY7sAwd91R2Sm/pbbYRtrB7iX7vSJle/oQgy9nTvTlIozxgkGMZpRVuWZgnyWCKkuxxQ==
Date: Mon, 23 Apr 2018 16:26:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: alps - Fix reporting pressure of v3 trackstick
Message-ID: <20180423232657.GH66646@dtor-ws>
References: <20180408155321.10433-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180408155321.10433-1-pali.rohar@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 05:53:21PM +0200, Pali Rohár wrote:
> According to documentation, all 7 lower bits represents trackpoint pressure.
> 
> Fixes: 4621c9660459 ("Input: alps - report pressure of v3 and v7 trackstick")
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 0a9e6a3a2f9f..1e28d9fc5492 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -583,7 +583,7 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
>  
>  	x = (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
>  	y = (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
> -	z = packet[4] & 0x7c;
> +	z = packet[4] & 0x7f;
>  
>  	/*
>  	 * The x and y values tend to be quite large, and when used
> -- 
> 2.11.0
> 

-- 
Dmitry
