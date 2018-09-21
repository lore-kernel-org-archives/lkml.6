Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9895ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF12146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDF12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbeIUIWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbeIUIWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44A10308624E;
        Fri, 21 Sep 2018 02:35:33 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97E78DAA82;
        Fri, 21 Sep 2018 02:35:32 +0000 (UTC)
Date:   Fri, 21 Sep 2018 10:35:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: kexec_file: remove some duplicated include file
Message-ID: <20180921023529.GQ2555@MiWiFi-R3L-srv>
References: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com>
 <20180921021524.GP2555@MiWiFi-R3L-srv>
 <5BA4570F.6050700@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BA4570F.6050700@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 21 Sep 2018 02:35:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/18 at 10:27am, zhong jiang wrote:
> On 2018/9/21 10:15, Baoquan He wrote:
> > On 09/20/18 at 01:12pm, zhong jiang wrote:
> >> kexec.h and slab.h have duplicated include. hence just remove
> >> redundant file.
> > They have duplicated include, why do you remove both of them?
> because we include the kexec.h and slab.h twice in kexec_file.c. It's unnecessary.

OK, Could you rewrite the log with this? The old log makes me think
kexec.h and slab.h themselves have duplicated include.

> 
> Thanks,
> zhong jiang
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >> ---
> >>  kernel/kexec_file.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> >> index c6a3b68..35cf0ad 100644
> >> --- a/kernel/kexec_file.c
> >> +++ b/kernel/kexec_file.c
> >> @@ -25,8 +25,6 @@
> >>  #include <linux/elf.h>
> >>  #include <linux/elfcore.h>
> >>  #include <linux/kernel.h>
> >> -#include <linux/kexec.h>
> >> -#include <linux/slab.h>
> >>  #include <linux/syscalls.h>
> >>  #include <linux/vmalloc.h>
> >>  #include "kexec_internal.h"
> >> -- 
> >> 1.7.12.4
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> > .
> >
> 
> 
