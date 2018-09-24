Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E174C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392FE2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392FE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIXPc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:32:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:36074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbeIXPc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:32:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DD4BAEFD;
        Mon, 24 Sep 2018 09:31:46 +0000 (UTC)
Date:   Mon, 24 Sep 2018 11:31:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: logitech: fix a used uninitialized GCC warning
In-Reply-To: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <nycvar.YFH.7.76.1809241131230.15880@cbobk.fhfr.pm>
References: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, zhong jiang wrote:

> Fix the following compile warning:
> 
> drivers/hid/hid-logitech-hidpp.c: In function 'hi_res_scroll_enable':
> drivers/hid/hid-logitech-hidpp.c:2714:54: warning: 'multiplier' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2:
>      According to Benjamin's suggestion, To initialize the value
> and remove the duplicated assignement. 

Applied to for-4.20/logitech-highres. Thanks,

-- 
Jiri Kosina
SUSE Labs

