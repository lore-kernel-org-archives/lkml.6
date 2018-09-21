Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9268BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524A92087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524A92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbeIUItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbeIUItA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:49:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9254308403C;
        Fri, 21 Sep 2018 03:02:17 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B3854D5;
        Fri, 21 Sep 2018 03:02:16 +0000 (UTC)
Date:   Fri, 21 Sep 2018 11:02:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     zhong jiang <zhongjiang@huawei.com>, akpm@linux-foundation.org
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] kernel: kexec_file: remove some duplicated include file
Message-ID: <20180921030213.GR2555@MiWiFi-R3L-srv>
References: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Sep 2018 03:02:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/18 at 10:48am, zhong jiang wrote:
> We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
> hence just remove them.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>


ACK

> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index c6a3b68..35cf0ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,8 +25,6 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
> -#include <linux/kexec.h>
> -#include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> -- 
> 1.7.12.4
> 
