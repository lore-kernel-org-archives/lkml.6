Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E277ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE172087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE172087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeGMJzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:55:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbeGMJzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:55:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 734E4B149DBBC;
        Fri, 13 Jul 2018 17:41:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:41:31 +0800
Subject: Re: [PATCH] video: fbdev: via: hide unused procfs helpers
To:     <FlorianSchandinat@gmx.de>, <b.zolnierkie@samsung.com>
References: <20180713075625.11252-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <8ec19785-5b1d-09e8-07b2-6ace8c45348e@huawei.com>
Date:   Fri, 13 Jul 2018 17:41:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180713075625.11252-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this.there has a fix:

[PATCH] fbdev/via: fix defined but not used warning

On 2018/7/13 15:56, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/video/fbdev/via/viafbdev.c:1471:12: warning: ‘viafb_sup_odev_proc_show’ defined but not used [-Wunused-function]
>  static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
>             ^
> fix this by adding #ifdef around it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/video/fbdev/via/viafbdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
> index d2f7850..edca3e0 100644
> --- a/drivers/video/fbdev/via/viafbdev.c
> +++ b/drivers/video/fbdev/via/viafbdev.c
> @@ -1468,12 +1468,14 @@ static const struct file_operations viafb_vt1636_proc_fops = {
>  
>  #endif /* CONFIG_FB_VIA_DIRECT_PROCFS */
>  
> +#ifdef CONFIG_PROC_FS
>  static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
>  {
>  	via_odev_to_seq(m, supported_odev_map[
>  		viaparinfo->shared->chip_info.gfx_chip_name]);
>  	return 0;
>  }
> +#endif
>  
>  static ssize_t odev_update(const char __user *buffer, size_t count, u32 *odev)
>  {
> 

