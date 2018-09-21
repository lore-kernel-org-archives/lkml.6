Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1EEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E3221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E3221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbeIULJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:09:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38332 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIULJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:09:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id z186-v6so10385305lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 22:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c0TDchje/syqfRtebHaI3EvmqKT532k1o/d7yAmvdw0=;
        b=OgCgHSdwuE0zNRBmNqwx0IspgD0DmEdVGFl7p1v36+4uKivaQ5w/yvZH9citwSFm98
         GUtT5PJzASUB/ZpT8xWjIWfxcR7GCrPit+h6Q5ifILpjSNnZmSToNaHyJ0el7A4sHf0z
         nruACvuX+bhWQpe0dMDMeHtJgPAiG/6eKn3eqGJj4cHSNmuJbFMybxWj0BKIjs/xi4j4
         kEadCJvRFCTekYtU7hmsX8+wCty19WuEoGPkZ9a7TKZAZ6kNNPmjp/P7juLUTbUBN9UB
         phVumedWrBt2uwiH3uPK1wlykJvCltmq3PnCyE4HmBUZgbUEMJNTFNsC9WZpMcMi9c0j
         5bbQ==
X-Gm-Message-State: APzg51DnWqeETc6AH3p9GcjfL5dzW310IYNdPZHtG1hD72N+Spg4wISP
        KuQAbAtlUufGSzFDRARikvb0VhZR6yXXfG1iqBkQQA==
X-Google-Smtp-Source: ANB0Vda0jhcFldMN5QXSRmoibm9tJzcxhPPo5hyDmaVPgjjFqsB2V+S9+ydiC7E4lFqd92SlISXg0TAe6AeI658k1KM=
X-Received: by 2002:a19:5a8f:: with SMTP id y15-v6mr12594984lfk.15.1537507310232;
 Thu, 20 Sep 2018 22:21:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9357:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 22:21:49
 -0700 (PDT)
In-Reply-To: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
References: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 21 Sep 2018 10:51:49 +0530
Message-ID: <CACi5LpMPZiv7zgZLR9SD=2SPPT8W3RuP6=NHD4rzqVnpB4xkaA@mail.gmail.com>
Subject: Re: [PATCHv2] kernel: kexec_file: remove some duplicated include file
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Baoquan He <bhe@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 21, 2018 at 8:18 AM, zhong jiang <zhongjiang@huawei.com> wrote:
> We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
> hence just remove them.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
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

Nice catch.
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

BTW while we are at it, can you also send out a separate patch to list the
include files in this file (i.e. kexec_file.c) alphabetically (similar
to other linux source files - see
<https://patchwork.kernel.org/patch/10258279/> for example). Something
like:

#include <crypto/hash.h>
#include <crypto/sha.h>
#include <linux/capability.h>
#include <linux/elf.h>
#include <linux/elfcore.h>
#include <linux/file.h>
#include <linux/fs.h>
#include <linux/ima.h>
#include <linux/kernel.h>
#include <linux/kexec.h>
#include <linux/list.h>
#include <linux/mm.h>
#include <linux/mutex.h>
#include <linux/slab.h>
#include <linux/syscalls.h>
#include <linux/vmalloc.h>
#include "kexec_internal.h"

This will improve readability and also reduce similar instances of
include files being added twice in this source file in future.

Thanks,
Bhupesh
