Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C382C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6C20989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="edA1ac7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeLMJ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:59:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeLMJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:59:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so836095plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StY9UoDCFG8zhjwZLxYYNU8yZ08AN+ukRIO/5DBAz74=;
        b=edA1ac7JuDNexgPdC3wZoVcvjzN66CwS+HyQaNEc+gi3CNBv76AuQHu4H5H4nTp1Ml
         hb6sUx9fo5i7Jxk91nrFLcXCa1XxC7idQGINiTYxbmpyyM15msD3dWRn5Hcbf7QRXVjO
         wxd8EqtPRX7iE0x9paoyNv55rrQzgJttrB9kCe9c6ALc6NF8f6/O4US+iWjgHqT0NzUk
         l3TEeJ+VcsnEp4KqryfS5TNT6xOubWvnkyEB2J9zwW6qhZvyrYkOtFDAfLl8D9RseVsF
         RD7w+YNF5yQfg59rEktidBsIcDgRmBkMN+pLoHOjWfW9mRlG75mMBqqxtZrN7JVfbZqa
         pyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=StY9UoDCFG8zhjwZLxYYNU8yZ08AN+ukRIO/5DBAz74=;
        b=p1lIH64L+mx0dzQqfh2arjkkm2aH1RUFI1QZQlsCG5DKdW8aa2BIGBcZkxZJlNt9rp
         6qG7RylXQLm/32yu8VtuSOm184SctjHZG1+Dj8grgFZeWfNXbx0NspjaUA94oucQGWy6
         5gSe1tZyWiPhSBmHldv/NwGA5Zvr8nMjOFmzWaL9RMO4KjXfYt2qErrsY0Ci2/yz18qZ
         TOa44w0WFY+6ylws5r9vHiiyE48Fqcx83zsEqo9rfK8hBrg/Z+Y662sda0cYJY+YGrrb
         Yn9Bbr2mfSHtNAzC6kQejiD+0PEQuzdQcm/dyNx4CQq1Qm0C8po0miXuyA4E9E4iSR6e
         SRNw==
X-Gm-Message-State: AA+aEWa7t+jNQwEg1pz0XRzRHwSAXtcBptuhLVEesvS2/mn7X2o68n8I
        eaAdt8NWz79RkJWmunHOW2d1ug==
X-Google-Smtp-Source: AFSGD/XCes4KZANELoltG8bytGvGpxYeukd1nInCURTgufVJDHDIP1mcfzkGf0wCnyKS8KbjjZNKQA==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr23464371pla.66.1544695188151;
        Thu, 13 Dec 2018 01:59:48 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id d21sm2315350pgv.37.2018.12.13.01.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 01:59:47 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id CD55A300258; Thu, 13 Dec 2018 12:59:42 +0300 (+03)
Date:   Thu, 13 Dec 2018 12:59:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: thp: fix flags for pmd migration when split
Message-ID: <20181213095942.3y7lfdwndek6sja4@kshutemo-mobl1>
References: <20181213051510.20306-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213051510.20306-1-peterx@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 01:15:10PM +0800, Peter Xu wrote:
> When splitting a huge migrating PMD, we'll transfer all the existing
> PMD bits and apply them again onto the small PTEs.  However we are
> fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> or pmd_yound() while actually they don't make sense at all when it's
> a migration entry.  Fix them up.  Since at it, drop the ifdef together
> as not needed.
> 
> Note that if my understanding is correct about the problem then if
> without the patch there is chance to lose some of the dirty bits in
> the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> of swap offset instead of bit 2) and it could potentially corrupt the
> memory of an userspace program which depends on the dirty bit.
> 
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Michal Hocko <mhocko@suse.com>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> CC: Souptick Joarder <jrdr.linux@gmail.com>
> CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> CC: Zi Yan <zi.yan@cs.rutgers.edu>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Stable?

-- 
 Kirill A. Shutemov
