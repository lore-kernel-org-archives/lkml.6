Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937209AbeE3HDz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:03:55 -0400
Received: from emcscan.emc.com.tw ([192.72.220.5]:55240 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935905AbeE3HDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:03:51 -0400
From: =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
To: "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <ulrik.debie-os@e2big.org>, <phoenix@emc.com.tw>,
        <aaron.ma@canonical.com>, <josh.chen@emc.com.tw>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw> <20180529180506.GB167092@dtor-ws>
In-Reply-To: <20180529180506.GB167092@dtor-ws>
Subject: RE: [PATCH] Input: elantech - Fix V4 report decoding for module with middle key
Date: Wed, 30 May 2018 15:03:50 +0800
Message-ID: <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGXKDSa603eNY0ATMXG8YhRn9eLDQGq8paHpLQcqrA=
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Wednesday, May 30, 2018 2:05 AM
To: KT Liao
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
ulrik.debie-os@e2big.org; phoenix@emc.com.tw; aaron.ma@canonical.com;
josh.chen@emc.com.tw
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module
with middle key

Hi KT,

On Mon, May 28, 2018 at 07:33:02PM +0800, KT Liao wrote:
> Some touchpad has middle key and it will be indicated in bit 2 of
packet[0].
> We need to fix V4 formation's byte mask to prevent error decoding.

Could you please let me know what devices this patch fixes? Are they
released or new hardware?


The primary target is Lenovo thinkpad P52 and it will be released in 6/M.

force_crc_enabled will fix the issue too because less bit-check in the
specific byte. 
I guess Fujitsu H730/H760 in elantech_dmi_force_crc_enabled may have the
same issue.
I leave them in DMI table because I am not sure of it.

Thanks
KT
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elantech.c 
> b/drivers/input/mouse/elantech.c index fb4d902..f39dc66 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -799,7 +799,7 @@ static int elantech_packet_check_v4(struct psmouse
*psmouse)
>  	else if (ic_version == 7 && etd->info.samples[1] == 0x2A)
>  		sanity_check = ((packet[3] & 0x1c) == 0x10);
>  	else
> -		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> +		sanity_check = ((packet[0] & 0x08) == 0x00 &&
>  				(packet[3] & 0x1c) == 0x10);
>  
>  	if (!sanity_check)
> --
> 2.7.4
> 

Thanks.

-- 
Dmitry
