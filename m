Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7801223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0c1be03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7801223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbeKPDx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeKPDx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:53:56 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CC821780;
        Thu, 15 Nov 2018 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542303909;
        bh=RDzebsoglcjSA6jz06hC6i8s2tVLCMsDKrMeNBhlFt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0c1be03yFqYR8qB/e5E9TmHh4Ig+/PE/x/mcKqMuIat+vNlJrfX215rqnZkM2wL7
         I5BwtqaDv6Ke2pbhNLi78slDPDASAz+AqmQQpx1D+KPS4h2CKILLwASV+4p+/602lU
         mfN2orLjyMo62qlz/LG7UTHcO94KdwMkYOHJcHRU=
Date:   Thu, 15 Nov 2018 12:45:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Howard Chen <howardsoc@google.com>
Subject: Re: [PATCH] zram: close udev startup race condition as default groups
Message-ID: <20181115174504.GJ95254@sasha-vm>
References: <20181114055223.66476-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181114055223.66476-1-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 02:52:23PM +0900, Minchan Kim wrote:
>commit fef912bf860e upstream.
>commit 98af4d4df889 upstream.
>
>I got a report from Howard Chen that he saw zram and sysfs race(ie,
>zram block device file is created but sysfs for it isn't yet)
>when he tried to create new zram devices via hotadd knob.
>
>v4.20 kernel fixes it by [1, 2] but it's too large size to merge
>into -stable so this patch fixes the problem by registering defualt
>group by Greg KH's approach[3].
>
>This patch should be applied to every stable tree [3.16+] currently
>existing from kernel.org because the problem was introduced at 2.6.37
>by [4].
>
>[1] fef912bf860e, block: genhd: add 'groups' argument to device_add_disk
>[2] 98af4d4df889, zram: register default groups with device_add_disk()
>[3] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
>[4] 33863c21e69e9, Staging: zram: Replace ioctls with sysfs interface
>
>Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>Cc: Hannes Reinecke <hare@suse.com>
>Tested-by: Howard Chen <howardsoc@google.com>
>Signed-off-by: Minchan Kim <minchan@kernel.org>

I've queued this for 4.19 and 4.18, but it doesn't apply to anything
older than that.

--
Thanks,
Sasha
