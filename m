Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D64C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C10520867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="I/agJYJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C10520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeIDMZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:25:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:25:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so1308994pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EdKVQ6S8ZH5sycgN24fFDUD/w/OwJLCbuwi4ICBnL6U=;
        b=I/agJYJ1zgSAVOIalC3LUUMu/vDLNy7/j9/nZydtrvWi7vHQ4MUXMTsEV34trxS8lA
         3Ad/qna//z4sEtZfoJDPXgKthdgOCf2nOt2qpFvj7wJODfoRr3Lk0tL5CyURcWPRn7jp
         Tz4B15CVMXcRdzmvK2A76DEBMjAMLMFboNVCQYgzfS5T6cA0TcuuJ7Dg/XB0j79U0Ea4
         03gAEXMaEk4ETC4SluzrvKxAzLqUL+w4g365twSyh0/+QSezmpWSzBHgdYAV7WGSmCUj
         aSDEIXEj5Wuvcvf+R/zadLRfe+HyZtW4yUJF3IJfNuHn1tuZvRWQaxdBYRGGhRlb5boi
         gM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EdKVQ6S8ZH5sycgN24fFDUD/w/OwJLCbuwi4ICBnL6U=;
        b=naKb1BbNt0wKF/bpQ7TrSJq0jWHEcd1S+a+wX1eINDRHc70aYPM/rUC4+kjA1KoJP7
         YuPcgikEJojJkxft5ANLBMWnt2lwSB6vrsBhYflxxT3YUfsdHpEI/dREEh7fcZsP2aPT
         KRYQpZWXAVktp4sanKGHXdX/inJMnW+vNNeTOSKd+KorDrCD8Zr7glG/AwujWaB6R2TR
         /8FBisXmud0sahOnOokQbrPb7pU/CFCQsgysu3rKsZ8ZC2OG7Z2uvp87OfQUHz845r6T
         RFj9EYjAgVVCEj3gMn4fH1CKroty3WfiwNquY9OdGIJL2ltxFcbtJ+DGfvYE7EwwBRLy
         dfWg==
X-Gm-Message-State: APzg51D4esj1Rjc7+OIdfpV08c1EJ8l3qb+cn2ogs5wGkVa/QdM1K9gy
        PpaGrmP+7YsoMnn1cacuPIYfXQ==
X-Google-Smtp-Source: ANB0Vdb5JTX4mz/NSZAUEYwF7663ex3aImAizSW7ATXGTM+uvzhUf1JuP6LIynwCgfZFZE9TbsJG7w==
X-Received: by 2002:a63:6501:: with SMTP id z1-v6mr15189508pgb.419.1536048082543;
        Tue, 04 Sep 2018 01:01:22 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id t12-v6sm35157253pgg.72.2018.09.04.01.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:01:21 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 67455300D89; Tue,  4 Sep 2018 11:01:16 +0300 (+03)
Date:   Tue, 4 Sep 2018 11:01:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugepage: mark splitted page dirty when needed
Message-ID: <20180904080115.o2zj4mlo7yzjdqfl@kshutemo-mobl1>
References: <20180904075510.22338-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904075510.22338-1-peterx@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:55:10PM +0800, Peter Xu wrote:
> When splitting a huge page, we should set all small pages as dirty if
> the original huge page has the dirty bit set before.  Otherwise we'll
> lose the original dirty bit.

We don't lose it. It got transfered to struct page flag:

	if (pmd_dirty(old_pmd))
		SetPageDirty(page);

-- 
 Kirill A. Shutemov
