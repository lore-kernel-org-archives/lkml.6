Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CCDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ABB2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ABB2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIFCdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:33:14 -0400
Received: from nautica.notk.org ([91.121.71.147]:56633 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:33:14 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 6E5F4C009; Thu,  6 Sep 2018 00:01:03 +0200 (CEST)
Date:   Thu, 6 Sep 2018 00:00:48 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v3] proc/kcore: fix invalid memory access in multi-page
 read optimization
Message-ID: <20180905220048.GC13782@nautica>
References: <1536100545-26905-1-git-send-email-asmadeus@codewreck.org>
 <1536100702-28706-1-git-send-email-asmadeus@codewreck.org>
 <20180905135717.ff763b34c4a3f1ca500d715b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905135717.ff763b34c4a3f1ca500d715b@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wed, Sep 05, 2018:
> lgtm.  Let's add a nice little why-were-doing-this?

Sure, thank you.

> --- a/fs/proc/kcore.c~proc-kcore-fix-invalid-memory-access-in-multi-page-read-optimization-v3-fix
> +++ a/fs/proc/kcore.c
> @@ -464,7 +464,7 @@ read_kcore(struct file *file, char __use
>  				ret = -EFAULT;
>  				goto out;
>  			}
> -			m = NULL;
> +			m = NULL;	/* skip the list anchor */
>  		} else if (m->type == KCORE_VMALLOC) {
>  			vread(buf, (char *)start, tsz);
>  			/* we have to zero-fill user buffer even if no read */

-- 
Dominique
