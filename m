Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeC0AtS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:49:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37700 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeC0AtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:49:16 -0400
X-Google-Smtp-Source: AIpwx49zYqY8nJqibupxcSrzIRLX38JwuO88j2Mj4yY1/iHmBIcPGthHlmlnTECI6F2E2sPHVS13Gw==
Date: Tue, 27 Mar 2018 09:49:11 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zram: idle memory tracking
Message-ID: <20180327004911.GA467@jagdpanzerIV>
References: <20180326064951.123940-1-minchan@kernel.org>
 <20180326064951.123940-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326064951.123940-2-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/26/18 15:49), Minchan Kim wrote:
> zRam as swap is useful for small memory device. However, swap means
> those pages on zram are mostly cold pages due to VM's LRU algorithm.
> Especially, once init data for application are touched for launching,
> they tend to be not accessed any more and finally swapped out.
> zRAM can store such cold pages as compressed form but it's pointless
> to keep in memory. Better idea is app developers free them directly
> rather than remaining them on heap.
> 
> This patch tell us last accesss time of each block of zram via
> "cat /sys/kernel/debug/zram/zram0/access_time".
> 
> The output is as follows,
> 
> 276 1250
> 277 1800
> ..  ..
> ..  ..

So can we just use CONFIG_IDLE_PAGE_TRACKING + CONFIG_PAGE_OWNER?

	-ss
