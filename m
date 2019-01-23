Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D874DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C8520870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAWJYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:24:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfAWJYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:24:06 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7DCE7CFD2C0853360E9C;
        Wed, 23 Jan 2019 17:24:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 17:23:59 +0800
Subject: Re: [PATCH 0/7] SCSI: cleanup debugfs usage
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <de49a145-cdbe-75a4-da8a-e2d376baad19@huawei.com>
Date:   Wed, 23 Jan 2019 09:23:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190122150906.12470-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2019 15:08, Greg Kroah-Hartman wrote:
> When calling debugfs code, there is no need to ever check the return
> value of the call, as no logic should ever change if a call works
> properly or not.  Fix up a bunch of x86-specific code to not care about
> the results of debugfs.
>
> Greg Kroah-Hartman (7):
>   scsi: bfa: no need to check return value of debugfs_create functions
>   scsi: csiostor: no need to check return value of debugfs_create
>     functions
>   scsi: fnic: no need to check return value of debugfs_create functions
>   scsi: snic: no need to check return value of debugfs_create functions
>   scsi: lpfc: no need to check return value of debugfs_create functions
>   scsi: qlogic: no need to check return value of debugfs_create
>     functions
>   scsi: qla2xxx: no need to check return value of debugfs_create
>     functions
>

JFYI, Martin has some more debugfs usage queued for 5.1 here:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/mkp/scsi/+log/5.1/scsi-queue/drivers/scsi/hisi_sas

I'll send a patch to tidy-up, as above. It would not be x86 specific, 
but I am not sure what above is.

Thanks,
John



>  drivers/scsi/bfa/bfad_debugfs.c   |  17 ---
>  drivers/scsi/csiostor/csio_init.c |   6 +-
>  drivers/scsi/fnic/fnic_debugfs.c  |  88 +---------------
>  drivers/scsi/fnic/fnic_main.c     |   7 +-
>  drivers/scsi/fnic/fnic_stats.h    |   2 +-
>  drivers/scsi/fnic/fnic_trace.c    |  17 +--
>  drivers/scsi/fnic/fnic_trace.h    |   4 +-
>  drivers/scsi/lpfc/lpfc_debugfs.c  | 170 ------------------------------
>  drivers/scsi/qedf/qedf_debugfs.c  |  18 +---
>  drivers/scsi/qedi/qedi_debugfs.c  |  17 +--
>  drivers/scsi/qla2xxx/qla_dfs.c    |  43 +-------
>  drivers/scsi/snic/snic_debugfs.c  | 133 +++++------------------
>  drivers/scsi/snic/snic_main.c     |  14 +--
>  drivers/scsi/snic/snic_stats.h    |   2 +-
>  drivers/scsi/snic/snic_trc.c      |  12 +--
>  drivers/scsi/snic/snic_trc.h      |   4 +-
>  16 files changed, 48 insertions(+), 506 deletions(-)
>


