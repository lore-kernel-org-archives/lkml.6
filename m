Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C5FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qM511Bc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F23E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeGLPSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:18:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43451 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGLPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:18:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so3988579pgr.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yfliBzhE/DKOmBStkuyHNdzJqMAIL6jrpSB1nIhslYs=;
        b=qM511Bc0n3iA2fgNLwFd/5MPIhAQG84Aes1VNmCjrrppBlqCcKMas19zZaFHIGwjGu
         EGb38dbxYdekGJ8pnrqS6z1RJBCQ2+X6riZpfCbh60LShQvZSN3Lk2R9SsVS06+gvg7y
         zTgX+eSQADrByBBM65pzOtnWYo3YF2vjEE6pCi0q7Cm0ClChkwKisw4DGPHIMzFq9MLT
         J4+GSYyDXH/XJiCpN9t4D0IgeaWAVaD1xWwU6hHC/vdf20Zczs1TOpbq8atJAln1NKE7
         ZSAkGpehNRSMVg5uoOxjOVyyugpHl5QFcvEeBPU9/v7AO4O6P51ZvfMMzA+Yen/oTGh4
         Vv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfliBzhE/DKOmBStkuyHNdzJqMAIL6jrpSB1nIhslYs=;
        b=QE1bg3FOPRHQENMHWfRdoLxq4O78+xmnz6mhkgQ4cyv0FR1isuCvNIxbItW+0VDcb2
         tWmcrBHoATLCXr5QG8UFfxLyGKLmbdvFF/3TgbNOv0au5+lOJgf3W1KdWHrNsWZ2f2zD
         EmW6j9pc+qzaCLilzSy7l5q9slO6pVQ/j5V9MQjc/BVz/TPMHKW48tnkBk247iViNqiI
         wgXq4gZaRWlobLukABlbsYPiXOQV3bf/3CGiQdk77aLVTGmFNuDl3LPwb19JnaayvrXq
         tCcIhc1r9KCKXt4RDpw3qcooXu/FbWAUVNHnQbfspdlUZOoJQzUgXUz+T64k4VKO1Bxn
         Inqg==
X-Gm-Message-State: AOUpUlHkLktGeSVZigAgNjlUqvKJifP3ICQeXHXdndrF9kIs5Zwg2EX2
        kkmEfbGcdXHHjF5SlwuUPjDFjg==
X-Google-Smtp-Source: AAOMgpd6XRqnwFqfqDYmUOi84RqkT5faOfNXYjUDlMeYnjkt8+ZFdHBKiSNHoxoGCsgw7xVoQjDu6w==
X-Received: by 2002:a62:5d55:: with SMTP id r82-v6mr2858670pfb.150.1531408085767;
        Thu, 12 Jul 2018 08:08:05 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id y4-v6sm38146030pgy.18.2018.07.12.08.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 08:08:05 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4F92030029E; Thu, 12 Jul 2018 18:08:00 +0300 (+03)
Date:   Thu, 12 Jul 2018 18:08:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/2] Fix crash due to vma_is_anonymous() false-positives
Message-ID: <20180712150759.acjj4jdw4ykwvzwg@kshutemo-mobl1>
References: <20180712145626.41665-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712145626.41665-1-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:56:24PM +0300, Kirill A. Shutemov wrote:
> 
> Fix crash found by syzkaller.
> 
> The fix allows to remove ->vm_ops checks.
> 
> v2:
>  - Catch few more cases where we need to initialize ->vm_ops:
>    + nommu;
>    + ia64;
>  - Make sure that we initialize ->vm_ops even if ->mmap failed.
>    We need ->vm_ops in error path too.

Just to be clear: it *should* help found issues, but I don't have setup to
test nommu changes.

And ion-related bug was actually caused by fault injection that failed
page allocation and ->mmap not setting ->vm_ops. It should be fine now.
But again I wasn't able to trigger the exact situation.

-- 
 Kirill A. Shutemov
