Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91541C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AEF223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AEF223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeKNRLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:11:25 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:48820 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeKNRLY (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 14 Nov 2018 12:11:24 -0500
Received: from [10.160.4.48] (nat.nue.novell.com [195.135.221.2])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 14 Nov 2018 08:09:24 +0100
Subject: Re: [PATCH] zram: close udev startup race condition as default groups
To:     Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Howard Chen <howardsoc@google.com>
References: <20181114055223.66476-1-minchan@kernel.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <5e9e9db6-1373-484f-2461-096fbcb83414@suse.com>
Date:   Wed, 14 Nov 2018 08:09:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114055223.66476-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 6:52 AM, Minchan Kim wrote:
> commit fef912bf860e upstream.
> commit 98af4d4df889 upstream.
> 
> I got a report from Howard Chen that he saw zram and sysfs race(ie,
> zram block device file is created but sysfs for it isn't yet)
> when he tried to create new zram devices via hotadd knob.
> 
> v4.20 kernel fixes it by [1, 2] but it's too large size to merge
> into -stable so this patch fixes the problem by registering defualt
> group by Greg KH's approach[3].
> 
> This patch should be applied to every stable tree [3.16+] currently
> existing from kernel.org because the problem was introduced at 2.6.37
> by [4].
> 
> [1] fef912bf860e, block: genhd: add 'groups' argument to device_add_disk
> [2] 98af4d4df889, zram: register default groups with device_add_disk()
> [3] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> [4] 33863c21e69e9, Staging: zram: Replace ioctls with sysfs interface
> 
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Tested-by: Howard Chen <howardsoc@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   drivers/block/zram/zram_drv.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
Actually, I have a similar patch for NVMe in older revisions, so maybe I 
should push it to -stable, too.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
