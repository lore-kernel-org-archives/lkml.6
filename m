Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EFAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725FE20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uGndb9Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392099AbfBMN2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:28:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33895 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbfBMN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:28:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so1150103pgd.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmiH+RHVhxB+obP/+7+ZvQfxCISotDUjH4WduRSJgp4=;
        b=uGndb9PrlFKPp128sjUuhzeQyXtHaBhX0QhQf99IU33dON5iEdRbB9ViezpinCL2VJ
         /6I8J7auazuseYQKJDf/qCA0DkL9uvW6RQB2p/y7iTJw2GpVRL3UsPfsY4IrHrjBo9Yn
         4XoqHSEWtPOUgMSi1Suvq3pVQGfzdHFogA3paVkc23twhG1Rq9X0CrsUlN7pyL401YpT
         v+x9n6HfqPifh2XCOGm3ZFtr/9g3voB3r62Czp+eS5UN/RZFwkFtWA3pl5YAXiJU8GUf
         rS2OQJVLVNmHVrUzFiNZerpcAHKMFMyu9NivttsJDqxFkVes58+YmzHUgEaPP5WOIVk5
         DMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmiH+RHVhxB+obP/+7+ZvQfxCISotDUjH4WduRSJgp4=;
        b=CTE5gMBF8LJD8bPGn/v+7R5ay/dzCJmt378Abk0UEBp3ZJBnqCax9R4Jy+4Vb24Nge
         vZEpgClyZ5UwarLEkRZkF/b6HS0OBu5l8sBEnPOgVpVn0BCVndfrigT8jOiJIGV3LDwu
         I/lt+aChl0Mm3YM8w9+P+v9lL9df8zlpqaM0ADcOukHk0DF9gD6muGwa9YP8RqdYH+WB
         zpDFOloNBOaxSuMfP47u98kgil47/ssTmtJgl+TNwqdmdKeqFbbzgVBQII5CiRRBpUAR
         K7Xx6G2+p25gm2lL3JL/E4yPMKibQIiPRn62DmeR9YssSeA3yk7KG+G+pcKYysWlVlOQ
         HuUQ==
X-Gm-Message-State: AHQUAuYR5TiKBe4Brgtj6oHNgsrOSBZ5wjLEFzT6xIDSASw2/l4ExQGY
        EeMtcd8OKVPQuaXVKSSesvA2OA==
X-Google-Smtp-Source: AHgI3IYYNPzlTxNjPzRht3OcT4ya72upkHab0DSJv1opzlibqWdDm5S4f71312mBCIr9J+FN5YDErQ==
X-Received: by 2002:a62:5003:: with SMTP id e3mr536528pfb.23.1550064484753;
        Wed, 13 Feb 2019 05:28:04 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id 10sm32945751pfq.146.2019.02.13.05.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:28:03 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4790B3002B2; Wed, 13 Feb 2019 16:28:00 +0300 (+03)
Date:   Wed, 13 Feb 2019 16:28:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LSF/MM TOPIC] Non standard size THP
Message-ID: <20190213132800.dekg525rhrjn3cmj@kshutemo-mobl1>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
 <20190213130647.GQ12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213130647.GQ12668@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:06:47AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 12, 2019 at 11:33:31AM +0300, Kirill A. Shutemov wrote:
> > To consider it seriously we need to understand what it means for
> > split_huge_p?d()/split_huge_page()? How khugepaged will deal with this?
> > 
> > In particular, I'm worry to expose (to user or CPU) page table state in
> > the middle of conversion (huge->small or small->huge). Handling this on
> > page table level provides a level atomicity that you will not have.
> 
> We could do an RCU-style trick where (eg) for merging 16 consecutive
> entries together, we allocate a new PTE leaf, take the mmap_sem for write,
> copy the page table over, update the new entries, then put the new leaf
> into the PMD level.  Then iterate over the old PTE leaf again, and set
> any dirty bits in the new leaf which were set during the race window.
> 
> Does that cover all the problems?

Probably, but it will kill scalability. Taking mmap_sem for write to
handle page fault or MADV_DONTNEED will not make anybody happy.

-- 
 Kirill A. Shutemov
