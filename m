Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966077AbeCAFfP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:35:15 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:46051 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965994AbeCAFfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:35:10 -0500
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
To: Alex Lemberg <Alex.Lemberg@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <14AC9066-4BA9-478D-9F67-2A29D69E6011@wdc.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <7e4ff9cf-f2f3-68b0-c903-fc6f2fc0c7c7@mentor.com>
Date: Thu, 1 Mar 2018 11:04:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <14AC9066-4BA9-478D-9F67-2A29D69E6011@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 27 February 2018 08:28 PM, Alex Lemberg wrote:
> Hi Andrew,
>
> While RPMB partition requires special IOCTL, the boot partition is only requires "switch partition", which is not unusual operation in eMMC.
> Why to prevent users access boot partition?
>
> Thanks,
> Alex 

The main intention of the patch was to not have RPMB device in /proc/partitions. Boot partitions are also unlikely to have any partitioning, so it made sense to treat them the same way as RPMB and not list in /proc/partitions.
Now I see that RPMB is converted to a character device and this change may not be required for RPMB.

Correct me if I am wrong. Also any comments are welcome.

Thanks,
Harish Jenny K N
