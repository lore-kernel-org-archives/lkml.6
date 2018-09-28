Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E107C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177B206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="uuBZjw89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeI2FCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:02:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45062 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeI2FCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:02:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id d63-v6so6720777oic.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWzR/p3p5OqCUB5+F8FIBR7qdl+zO0eppQWz7JomGWw=;
        b=uuBZjw89MnBCokj39L/zVrn0FQvlfcgkWi48MhZY1OP0I9NkRcdSiBYqNCpDU2DPRi
         2JlVe21wDwQzmlfrqvqTnha6eAYK9KS8aLlun2KBIYdF8yeac8pSbFaN1Ha1RItAAcK9
         BRweexXepdycnj01nlzEXV1s3zW/50Eb8+ug7gu+jsvZT5UozWK2R7ypKeoixza3nmcv
         QHIzObpEBo1/KjXPm/XQMhwkLXSz5eHSwHHwf1BaqVsprDOEDZTlIpag8t9ueIwOVvbR
         EW6bxAOoiS8pDse5F7qQTu/b1WLEtfwBU7ajuxMBry1i37rzbf7vbPciV4ZwEmdDIzyq
         C0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWzR/p3p5OqCUB5+F8FIBR7qdl+zO0eppQWz7JomGWw=;
        b=bgTIVx56/i+Xfo/paXfucTL/f4EaCkNmhfrG1eUEXauzwhi2mO7Zfp7R5lDCFMzyO4
         q88A8SSnvgVFyGngam4vBMr++uTEfbbyyQRYW81lSZUg0unWAuzOa37k9ZwcmcnPQ3uv
         XqFIjaZfsG98qxBGs/SKadNXphLmLHHndpCFu17L5pp5qO7XeNV2R3R1Qexr1tyHf+di
         N0TAPHk7rM9rZRs1m/Bq6fsg0+jGtPDb/NMBPFYqkMx8xxdZteVu+68qD+meRlxVZbxH
         TuwcoXuu+tKZBr1YFBkIwSkf0dv6hF4VT1dWdCfczx4pXRHg2REQLZEvHTKxckQQfRyq
         XahA==
X-Gm-Message-State: ABuFfohdIW3L785xmR+DspO4ENalQNGE9TNCeXzs1ymbhJvUmjn87HLt
        VcDhn9bPG0Vg9zB4XEddfK9YOgQRxVWuCq/ZW6P1UwR8eC4=
X-Google-Smtp-Source: ACcGV60d6Plr/8WUWU2E1UFNxqZmorib2royjkNdH+Tr2eMdJwf1SaREnqpkbdvTqb7hJmo6H/GikOfGmJweewktQ5s=
X-Received: by 2002:aca:b02:: with SMTP id 2-v6mr321748oil.305.1538174221294;
 Fri, 28 Sep 2018 15:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <1538173916-95849-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1538173916-95849-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Sep 2018 15:36:49 -0700
Message-ID: <CAPcyv4jdTWoJMSPuxso=8fu8nGOrmbBPYxkJvsuEDfJSYvsDWg@mail.gmail.com>
Subject: Re: [PATCH] mm: enforce THP for VM_NOHUGEPAGE dax mappings
To:     yang.shi@linux.alibaba.com
Cc:     Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:34 PM <yang.shi@linux.alibaba.com> wrote:
>
> commit baabda261424517110ea98c6651f632ebf2561e3 ("mm: always enable thp
> for dax mappings") says madvise hguepage policy makes less sense for
> dax, and force enabling thp for dax mappings in all cases, even though
> THP is set to "never".
>
> However, transparent_hugepage_enabled() may return false if
> VM_NOHUGEPAGE is set even though the mapping is dax.
>
> So, move is_vma_dax() check to the very beginning to enforce THP for dax
> mappings in all cases.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> I didn't find anyone mention the check should be before VM_NOHUGEPAGE in
> the review for Dan's original patch. And, that patch commit log states
> clearly that THP for dax mapping for all cases even though THP is never.
> So, I'm supposed it should behave in this way.

No, if someone explicitly does MADV_NOHUGEPAGE then the kernel should
honor that, even if the mapping is DAX.
