Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeEGCn5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:43:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751852AbeEGCnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:43:55 -0400
From: Caizhiyong <caizhiyong@hisilicon.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        axboe <axboe@kernel.dk>
CC: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jiangheng <jiangheng@hisilicon.com>
Subject: RE: [PATCH] Documentation: block: cmdline-partition.txt fixes and
 additions
Thread-Topic: [PATCH] Documentation: block: cmdline-partition.txt fixes and
 additions
Thread-Index: AQHT5Wsmk+zbgmPRgU6xzKM5CECa56QjjefQ
Date: Mon, 7 May 2018 02:43:24 +0000
Message-ID: <C3050A4DBA34F345975765E43127F10F8B7720F8@dggemm511-mbs.china.huawei.com>
References: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
In-Reply-To: <dba389fc-2745-34b1-e33e-fc83f53eaf42@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.217.112]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w472i4mh011795

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: Monday, May 07, 2018 2:50 AM
> To: linux-block@vger.kernel.org; axboe <axboe@kernel.dk>
> Cc: LKML <linux-kernel@vger.kernel.org>; Caizhiyong
> <caizhiyong@hisilicon.com>; Andrew Morton <akpm@linux-foundation.org>;
> linux-doc@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>
> Subject: [PATCH] Documentation: block: cmdline-partition.txt fixes and
> additions
> 
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make the description of the kernel command line option "blkdevparts"
> a bit more flowing and readable.
> 
> Fix a few typos.
> Add the optional <size> and <offset> suffixes.
> Note that size can be "-" to indicate all of the remaining space.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Cai Zhiyong <caizhiyong@huawei.com>
> ---
> Should the "ro" and "lk" flags options be described?

thank you for fix typos.
The "ro" and "lk" feature are not implemented in block devices. could you implement them?

>  Documentation/block/cmdline-partition.txt |   21 +++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> --- linux-next-20180504.orig/Documentation/block/cmdline-partition.txt
> +++ linux-next-20180504/Documentation/block/cmdline-partition.txt
> @@ -1,7 +1,9 @@
>  Embedded device command line partition parsing
> 
> ==========================================================
> ===========
> 
> -Support for reading the block device partition table from the command line.
> +The "blkdevparts" command line option adds support for reading the
> +block device partition table from the kernel command line.
> +
>  It is typically used for fixed block (eMMC) embedded devices.
>  It has no MBR, so saves storage space. Bootloader can be easily accessed
>  by absolute address of data on the block device.
> @@ -14,22 +16,27 @@ blkdevparts=<blkdev-def>[;<blkdev-def>]
>      <partdef> := <size>[@<offset>](part-name)
> 
>  <blkdev-id>
> -    block device disk name, embedded device used fixed block device,
> -    it's disk name also fixed. such as: mmcblk0, mmcblk1, mmcblk0boot0.
> +    block device disk name. Embedded device uses fixed block device.
> +    Its disk name is also fixed, such as: mmcblk0, mmcblk1, mmcblk0boot0.
> 
>  <size>
>      partition size, in bytes, such as: 512, 1m, 1G.
> +    size may contain an optional suffix of (upper or lower case):
> +      K, M, G, T, P, E.
> +    "-" is used to denote all remaining space.
> 
>  <offset>
>      partition start address, in bytes.
> +    offset may contain an optional suffix of (upper or lower case):
> +      K, M, G, T, P, E.
> 
>  (part-name)
> -    partition name, kernel send uevent with "PARTNAME". application can
> create
> -    a link to block device partition with the name "PARTNAME".
> -    user space application can access partition by partition name.
> +    partition name. Kernel sends uevent with "PARTNAME". Application can
> +    create a link to block device partition with the name "PARTNAME".
> +    User space application can access partition by partition name.
> 
>  Example:
> -    eMMC disk name is "mmcblk0" and "mmcblk0boot0"
> +    eMMC disk names are "mmcblk0" and "mmcblk0boot0".
> 
>    bootargs:
>      'blkdevparts=mmcblk0:1G(data0),1G(data1),-;mmcblk0boot0:1m(boot),-
> (kernel)'
