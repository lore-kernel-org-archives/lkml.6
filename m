Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E939C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53DD20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53DD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeIHRqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:46:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:43092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbeIHRqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:46:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94EFCAE3E;
        Sat,  8 Sep 2018 13:00:58 +0000 (UTC)
Date:   Sat, 8 Sep 2018 15:00:55 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        <jwi@linux.ibm.com>, <ubraun@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] s390: vmlogrdr: Use ARRAY_SIZE instead of
 reimplementing its function
Message-ID: <20180908150055.1842ce99@endymion>
In-Reply-To: <1536402388-23872-2-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
        <1536402388-23872-2-git-send-email-zhongjiang@huawei.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2018 18:26:27 +0800, zhong jiang wrote:
> ARRAY_SIZE has implemented its function. we prefer to use the function
> rather than the open code.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/s390/char/vmlogrdr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
> index 069b9ef..58333cb 100644
> --- a/drivers/s390/char/vmlogrdr.c
> +++ b/drivers/s390/char/vmlogrdr.c
> @@ -153,7 +153,7 @@ static void vmlogrdr_iucv_message_pending(struct iucv_path *,
>  	}
>  };
>  
> -#define MAXMINOR  (sizeof(sys_ser)/sizeof(struct vmlogrdr_priv_t))
> +#define MAXMINOR  ARRAY_SIZE(sys_ser)
>  
>  static char FENCE[] = {"EOR"};
>  static int vmlogrdr_major = 0;

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
