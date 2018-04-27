Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757248AbeD0BeZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:34:25 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:4048
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752358AbeD0BeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:34:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DTAADRfOJa/zXSMGcNThoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFRoNrlU2BI4EPlQuEd4JrNxUBAgEBAQEBAQKGOAEnBFIbDQEKAgI?=
 =?us-ascii?q?mAl8NBgIBAYR+qA1tgWkzGoQ+g2yCRYEJhGSDMIEHgTKCOi6BQQGCeoM3glQCm?=
 =?us-ascii?q?AkHAY5Ch2eEdJFgMoF0MxoIKAiCfpBgXY5ugkYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DTAADRfOJa/zXSMGcNThoBAQEBAQIBAQEBCAEBAQGFRoN?=
 =?us-ascii?q?rlU2BI4EPlQuEd4JrNxUBAgEBAQEBAQKGOAEnBFIbDQEKAgImAl8NBgIBAYR+q?=
 =?us-ascii?q?A1tgWkzGoQ+g2yCRYEJhGSDMIEHgTKCOi6BQQGCeoM3glQCmAkHAY5Ch2eEdJF?=
 =?us-ascii?q?gMoF0MxoIKAiCfpBgXY5ugkYBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,333,1520870400";
   d="scan'208";a="69097786"
Subject: Re: [PATCH] m68k: Fix calendar month regression on M68328
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <d59432ee-15a3-495b-29db-2d2eb51be97d@linux-m68k.org>
Date: Fri, 27 Apr 2018 11:33:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 27/04/18 11:12, Finn Thain wrote:
> My earlier fix for read_persistent_clock() neglected to cover
> m68328_hwclk(). Correct this oversight.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> Greg, the read_persistent_clock() change has already been queued
> by Geert. Should this patch be pushed together with that one
> (presuming your ack)? Sorry for the inconvenience.

If Geert is happy to add it to his tree that would seem to make sense.
Otherwise I can take it via the m68knommu tree. Either way:

  Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>  arch/m68k/68000/timers.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
> index 252455bce144..71ddb4c98726 100644
> --- a/arch/m68k/68000/timers.c
> +++ b/arch/m68k/68000/timers.c
> @@ -125,7 +125,9 @@ int m68328_hwclk(int set, struct rtc_time *t)
>  {
>  	if (!set) {
>  		long now = RTCTIME;
> -		t->tm_year = t->tm_mon = t->tm_mday = 1;
> +		t->tm_year = 1;
> +		t->tm_mon = 0;
> +		t->tm_mday = 1;
>  		t->tm_hour = (now >> 24) % 24;
>  		t->tm_min = (now >> 16) % 60;
>  		t->tm_sec = now % 60;
> 
