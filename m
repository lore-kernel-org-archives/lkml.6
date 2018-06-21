Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ABCC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D5522466
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="hH2b0m5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D5522466
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933825AbeFUWKO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:10:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41329 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFUWKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:10:13 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so2024125pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=877CZ8MHeGbqHti2eTHktGSNjoh76kaXC96/v1gJVvw=;
        b=hH2b0m5Fdj04GdB0d+2wPHhlkIBNXERqoVUEGnXkrTlVtUk9tnlykcoEi/9JK5lk4i
         +UneWcTyQ1KfHjFOGLdrDgnfdUq0l8kRD39hZH+ea+5lBfFU4Bl1cd4aAIovi8XWlO+/
         rPm7g5hsydyxqwpJGXnTMhMcLbsu94RHwZwwI7wlrCLr3cYkGNh7p+KxxKm3X5M5w2VL
         UuLFXQV8j5jPVKP4UvuzmMKHy82ypsj93UA2uKjir7U33/7IPvcwTbK4xUM6Nl9KSjCQ
         PbGWGexvYzmcDJL3DeblahqHA6tsyKAfY26occiawdMNvUPfahocHStCYyw+j0P/K8Y0
         RafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=877CZ8MHeGbqHti2eTHktGSNjoh76kaXC96/v1gJVvw=;
        b=C61tItI0ezxp8evKmNy/ZP72iKUOxunFYCXbmWLnYZtHTH53A191DZ8YwkbFYd/4e4
         yQg0/NV49mcoFbK5Z8bLuBtbEO2N7klrkMHcVR5jSj7PcTUJkOyzhTxOq18IswGHB92U
         qty2ZtYnl4HEtclzu+vI0dXYXIUqmyuCmlocbqx3AYS6OBfypjtKBnmE9p9MBVWRUw6W
         +f6xyhnu7LjTb7bMVSN2cP7bEmAbfoXm9cfpE6NDo8SouAKqWhA/6ej8sCXMYAPWJibt
         1Kso71yDjH/SLd3007VT91MzsEyu8XFV7I9ixaKQ6FMn9e9HQZglogh8gXlWQ6Yn5Shn
         e2kA==
X-Gm-Message-State: APt69E0c6815ji8GlTt42SAbdAgT6jrJVKG/xE1ZPU97/z9ERkC5wUL4
        drTeWgZbScQHdx/2RAlx2CuxRw==
X-Google-Smtp-Source: ADUXVKIG4SoHl0OLeV6jieh1z2M9h0W4u+nRzQ980DTcZKCvvA8vWa99BGkItppqTZXMJHxe7S9hhg==
X-Received: by 2002:a63:2b88:: with SMTP id r130-v6mr23538002pgr.170.1529619012634;
        Thu, 21 Jun 2018 15:10:12 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id y2-v6sm10620369pfk.82.2018.06.21.15.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:10:11 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4FEB6300610; Fri, 22 Jun 2018 01:10:08 +0300 (+03)
Date:   Fri, 22 Jun 2018 01:10:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: register mm for khugepaged when merging vma for
 shmem
Message-ID: <20180621221008.r33hpd223kx2gv3a@kshutemo-mobl1>
References: <1529617247-126312-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529617247-126312-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 05:40:47AM +0800, Yang Shi wrote:
> When merging anonymous page vma, if the size of vam can fit in at least

s/vam/vma/

> one hugepage, the mm will be registered for khugepaged for collapsing
> THP in the future.
> 
> But, it skips shmem vma. Doing so for shmem too when merging vma in
> order to increase the odd to collapse hugepage by khugepaged.

Good catch. Thanks.

I think the fix incomplete. We shouldn't require vma->anon_vma for shmem,
only for anonymous mappings. We don't support file-private THPs.

> Also increase the count of shmem THP collapse. It looks missed before.

Separate patch, please.

-- 
 Kirill A. Shutemov
