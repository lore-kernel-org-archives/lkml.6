Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10709C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43A7206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392071AbfAPKfg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:35:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388688AbfAPKff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:35:35 -0500
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 635CD230294ACFE2C9E3;
        Wed, 16 Jan 2019 18:35:02 +0800 (CST)
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.96]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0415.000;
 Wed, 16 Jan 2019 18:34:57 +0800
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "maco@android.com" <maco@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "christian@brauner.io" <christian@brauner.io>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v3] binderfs: fix error return code in
 binderfs_fill_super()
Thread-Topic: [PATCH v3] binderfs: fix error return code in
 binderfs_fill_super()
Thread-Index: AQHUrYbn54EgeHEzFkqK06OlmmZcEKWxstZg
Date:   Wed, 16 Jan 2019 10:34:57 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB402067D91@dggeml512-mbx.china.huawei.com>
References: <1547627642-96450-1-git-send-email-weiyongjun1@huawei.com>
 <1547635161-62311-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1547635161-62311-1-git-send-email-weiyongjun1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.30.138]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,  please ignore this patch, missing reviewed-by line, I will send a new version.

> -----Original Message-----
> From: weiyongjun (A)
> Sent: Wednesday, January 16, 2019 6:39 PM
> To: gregkh@linuxfoundation.org; arve@android.com; tkjos@android.com;
> maco@android.com; joel@joelfernandes.org; christian@brauner.io
> Cc: weiyongjun (A) <weiyongjun1@huawei.com>;
> devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH v3] binderfs: fix error return code in binderfs_fill_super()
> 
> Fix to return a negative error code -ENOMEM from the new_inode() and
> d_make_root() error handling cases instead of 0, as done elsewhere in
> this function.
> 
> Fixes: 849d540ddfcd ("binderfs: implement "max" mount option")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: move 'ret = -ENOMEM' out of if
> v2 -> v3: use correct fixes commit
> ---
>  drivers/android/binderfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 9518e2e..e4ff4c3 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -518,6 +518,7 @@ static int binderfs_fill_super(struct super_block *sb,
> void *data, int silent)
> 
>  	sb->s_fs_info = info;
> 
> +	ret = -ENOMEM;
>  	inode = new_inode(sb);
>  	if (!inode)
>  		goto err_without_dentry;
> 
> 

