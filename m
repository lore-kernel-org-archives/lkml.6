Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA84C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72175223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72175223EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeHJLJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:09:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10655 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeHJLJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:09:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8F455265CF87;
        Fri, 10 Aug 2018 16:40:56 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 10 Aug 2018
 16:40:55 +0800
Subject: Re: [PATCH v3] f2fs: checkpoint disabling
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kernel-team@android.com>
References: <20180807234843.129387-1-drosen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b156678d-56e6-a46b-c7a6-00f4bc2c4b3d@huawei.com>
Date:   Fri, 10 Aug 2018 16:40:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807234843.129387-1-drosen@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2018/8/8 7:48, Daniel Rosenberg wrote:
> This adds a lightweight non-persistent snapshotting scheme to f2fs.
> 
> To use, mount with the option checkpoint=disable, and to return to
> normal operation, remount with checkpoint=enable. If the filesystem
> is shut down before remounting with checkpoint=enable, it will revert
> back to its apparent state when it was first mounted with
> checkpoint=disable. This is useful for situations where you wish to be
> able to roll back the state of the disk in case of some critical
> failure.

When filesystem is full, statfs shown abnormally as below:

/dev/zram0       2095104 -17177769548 17179864652    - /mnt/f2fs

I guess it's related to this patch, could you have a look at this?

Thanks,

