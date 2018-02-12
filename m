Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeBLRAw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:00:52 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36318 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeBLRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:00:49 -0500
X-Google-Smtp-Source: AH8x227z9Ec/A58LyRvVhrqM8lSJiUsIbnkWtz+JuheqONckel5vxqH9a+hYr1yQdq1+dlOUCbNN3A==
Date: Mon, 12 Feb 2018 09:00:46 -0800
From: Tejun Heo <tj@kernel.org>
To: "dongbo (E)" <dongbo4@huawei.com>
Cc: linux-ide@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] Fix compile warning with ATA_DEBUG enabled
Message-ID: <20180212170046.GV695913@devbig577.frc2.facebook.com>
References: <1516936551-20986-1-git-send-email-zhangshaokun@hisilicon.com>
 <5be87d13-f9a0-5b12-ced4-cec5d6394da1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be87d13-f9a0-5b12-ced4-cec5d6394da1@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 11:21:49AM +0800, dongbo (E) wrote:
> From: Dong Bo <dongbo4@huawei.com>
> 
> This fixs the following comile warnings with ATA_DEBUG enabled,
> which detected by Linaro GCC 5.2-2015.11:
> 
> In file included from ./include/linux/printk.h:7:0,
>                  from ./include/linux/kernel.h:14,
>                  from ./include/asm-generic/bug.h:16,
>                  from ./arch/arm64/include/asm/bug.h:37,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/gfp.h:5,
>                  from ./include/linux/slab.h:15,
>                  from drivers/ata/libata-scsi.c:36:
> drivers/ata/libata-scsi.c: In function 'ata_scsi_dump_cdb':
> ./include/linux/kern_levels.h:5:18: warning: format '%d' expects
> argument of type 'int', but argument 6 has type 'u64 {aka long
>  long unsigned int}' [-Wformat=]
>  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>                   ^
> ./include/linux/kern_levels.h:11:18: note: in expansion of macro
> 'KERN_SOH'
>  #define KERN_ERR KERN_SOH "3" /* error conditions */
>                   ^
> ./include/linux/libata.h:65:38: note: in expansion of macro 'KERN_ERR'
>  #define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt,
> 				__func__, ## args)
>                                       ^
> drivers/ata/libata-scsi.c:4284:2: note: in expansion of macro 'DPRINTK'
>   DPRINTK("CDB (%u:%d,%d,%d) %9ph\n",
>   ^
> 
> Signed-off-by: Dong Bo <dongbo4@huawei.com>

Path didn't apply, probalby because of the tailing part.  Hand-applied
to libata/for-4.16-fixes and trimmed the description a bit.

Thanks.

-- 
tejun
