Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3349C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A820866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VG7R2/6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeILDDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:03:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40894 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeILDDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:03:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so12923843pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUCwlipNH6jpAiwMw98CZTcPDwJ18v87fAZjPliKZQM=;
        b=VG7R2/6YIeI7SmVi0WaymMPDT/UgmFAwUacJNlKHn/YFw44OKV/okXEMBTAyA8XHgs
         GbFdx/W43u+jsZLN3B+T9GG0SNKgsd116Kxz+vc4QsQyQtn6BqfKciQAu142XZhXmXAf
         sb+MYUeokGM2ui4vqi8Zp3l8HKujH9ijVK8xgfPmAzRkovJaHnxWa52ePSZ2UgvXOZ3s
         tDFa1deC4R1xkq2pYEHZbRfxccYy1P5VgquMqkZGx2kH5HYlXmP3htZAOE9KZMpwkWW7
         fHm7/9rupjLlqnMzWmlD4VdQbbAzszEY+fh6+fo8rwUJtaPW2Skk+c8/86wJHQG5bi6f
         QG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUCwlipNH6jpAiwMw98CZTcPDwJ18v87fAZjPliKZQM=;
        b=d88FAJVZ5rZAXoTd1WfDqkuYyRLxZq4R1fRMRTKpR7ZnGnp2ZHb2dYUouwIaldlNKV
         wQ/IpBFXJ3r9VyUdX6VAcaIi+o8zc8y5kGxNNz2sGxCBXx8/1/fPiUeplHl6hJbXbTxf
         BsOcFQYxIiXMEdKYJ4bg8cg05oImRaKH6AFls+ymG/XVhsNta9kN9xTZ8mL7Xy+XyWyX
         3K/WtkXIq367YjFeSB71BVLN2waV9dX7KjeBpQfKBl4hHRJqas3laabwjmxIVnMahagA
         PLPmvfJ2/VppScTuHn8fwprgIyPT29MB3oS5BDvHklxEZq5BexwkzMTmwzmpZIEV1OO6
         yAIQ==
X-Gm-Message-State: APzg51CqFG+FK1b0MQQFjHJonTHXf0Fa21Ajpncevg8J6H4DTKaxVL8e
        xC2XSeS8Y6vIFIaheqZZYY7V7A==
X-Google-Smtp-Source: ANB0Vda5MU+Ifoahno7fBtY8e37jillIItlPAyoTC+h+nJjRY2sIyKxuxdtjxYNq//ahOFcDQMEsvQ==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr30900939pgu.259.1536703347394;
        Tue, 11 Sep 2018 15:02:27 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id r23-v6sm40307024pfj.5.2018.09.11.15.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 15:02:24 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 08553300DB6; Wed, 12 Sep 2018 01:02:20 +0300 (+03)
Date:   Wed, 12 Sep 2018 01:02:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, thp: Fix mlocking THP page with migration enabled
Message-ID: <20180911220219.y6qahrzgkf3ut23d@kshutemo-mobl1>
References: <20180911103403.38086-1-kirill.shutemov@linux.intel.com>
 <5E196C27-3D56-4D76-B361-0665CB3790BF@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E196C27-3D56-4D76-B361-0665CB3790BF@cs.rutgers.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:30:02PM -0400, Zi Yan wrote:
> I want to understand the Anon THP part of the problem more clearly. For Anon THPs,
> you said, PTEs for the page will always come after mlocked PMD. I just wonder that if
> a process forks a child1 which forks its own child2 and the child1 mlocks a subpage causing
> split_pmd_page() and migrates its PTE-mapped THP, will the kernel see the sequence of PMD-mapped THP,
> PTE-mapped THP, and PMD-mapped THP while walking VMAs? Will the second PMD-mapped THP
> reset the mlock on the page?

VM_LOCKED is not inheritable. child2 will not have the VMA mlocked and
will not try to mlock the page. If child2 will do mlock() manually it will
cause CoW and the process will ge new pages in the new VMA.

> In addition, I also discover that PageDoubleMap is not set for double mapped Anon THPs after migration,
> the following patch fixes it. Do you want me to send it separately or you can merge it
> with your patch?

I think we can live without DoubleMap for anon-THP: rmap walking order
semantics and the fact that page can be shared only over fork() should be
enough to get it under control. DoubleMap comes with overhead and I would
like to avoid it where possible.

-- 
 Kirill A. Shutemov
