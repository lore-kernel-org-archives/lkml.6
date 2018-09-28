Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDE6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FEF206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eSuf2HTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FEF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeI2F3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:29:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37140 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2F3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:29:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id o13-v6so7603463otl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soVQvfcXnS0hexYriytwYO0dP4RbNy78loW6q6rLpTI=;
        b=eSuf2HTMsxtwVZ8rkJ6Ejg1LQFwXd1yoGHJIhiCRfxUv+7Rs2XjFuFYtQUL+KStxDq
         IYovkDbQc86JcXrRsbXhjM5113XwYXjuKRsUsQZPoy5hewUYzKFSSn8n02ipu85vvDML
         cuQWVBAWrB8YYBPlIKIxlrufDyWMxgyzoW8A9KWojro2dwGnAu+yh5ttaKKWHC/hdcim
         ajg7OZlIgyeqYqI15L8tZKCgbKH0Zl9L0GzDDTesKfQMNsMJhgXY+KVmwhnRtTNnOCYv
         WoCnu0S8WFgaZ2ndYaWlOf/AbXhsxXjObcv0a3QTVig3dWQAf08YItjEcgu+WQqkm15O
         kuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soVQvfcXnS0hexYriytwYO0dP4RbNy78loW6q6rLpTI=;
        b=Pu59jk0keGsPX8LotvvOPbo6D8aO2CSfndNvXAZ5hgE7uVagLIjKMoFRRkjhL2NuW5
         TZumYAD4NMkjMfJ7qGmjK+8E+8khrO3YoXwLV5sc3YBlMj+etE/St6G0Xn0yAJvqgDol
         U0ZOiNY3VSTyXn5JOJJVu3WttUQzXdH5Ejnxb1XmlzPZ/now0iDmiLRj3Tmt93FwYtfw
         lO71Fg+rCM3yBmn0kmB4qfJgzywpRLztx0U/5SBsKwzNou975Z45DsWEDMx40s5l//eF
         6FSy1J1DYoMuIe1Tfm5fODvEsJN+YpRTRVL/c9xb9Vzbvsqs2eWmln6zAUr+1zvnolcM
         lvsA==
X-Gm-Message-State: ABuFfohEtAOitVaDQiQ2RSCwOVvndebcA4B2X8I706Dd2iqw6GC9vBah
        8gEbb1EFKqMgAnQO2HffZERsLcwFa8nDNyM2sgBbFblD
X-Google-Smtp-Source: ACcGV62SCVeDg0GpMmjDnqbWYbAsjEulVXzooLe9TwvJMpZbUfGhZt1iFlucDxxcBLQEio7vEtq5ygJb/vfYnv30QM4=
X-Received: by 2002:a9d:5170:: with SMTP id u45-v6mr260317oti.214.1538175824716;
 Fri, 28 Sep 2018 16:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <153816098159.2233877.8382846671636531035.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3cf89dd3-a024-dbab-36ed-923f9466669c@linux.intel.com>
In-Reply-To: <3cf89dd3-a024-dbab-36ed-923f9466669c@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Sep 2018 16:03:33 -0700
Message-ID: <CAPcyv4hi7XLAswcoWEKOcQq_0FCTybxTUd_4H+mJj0S7BkTCjg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm, dimm: Maximize label transfer size
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:44 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 9/28/2018 11:56 AM, Dan Williams wrote:
> > Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
> > operations. Given the expense of calling into firmware, maximize the
> > amount of label data we transfer per call to be up to the total label
> > space if allowed by the firmware.
> >
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> This looks mostly fine to me.
>
> The only thing I am not certain about is if we want to use the raw
> max_cmd_size value or not since there is no guarantee it is aligned to
> any sort of boundary. It might be beneficial to either cache line align
> it or align it to 256B if it is larger than that since that way we at
> least would be getting full labels instead of partial ones.

If we leave any portion of the max transfer size unused it just means
we're that much more likely to need an additional call into the ASL
interpreter. That said It might be worthwhile capping the max transfer
size in case the BIOS specifies something extreme (> 1MB) in the
future.
