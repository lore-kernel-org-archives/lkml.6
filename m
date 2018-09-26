Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E3BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826E52089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBUqN5FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826E52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeIZHGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:06:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeIZHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:06:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id s5-v6so4617514pfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wQgNdP7B6WSeRuLb4cQpF6XsMLo+BL4PUzaYN9SkaNE=;
        b=KBUqN5FUmi63jKq4DZdcaQ5q/z0aEhvL9Q5pJvVJj2jkNihcNMOpiBG4HzjX2Yezn5
         yYmSU0v+9o0Yxo8sa0Hk3q7RYeYVxl3JKdN9BUKNnTclHGHm02QZv0zbev3HxPGiOoCP
         RBvQuzTZdit9L8p8Z7Nu0WdY82KcyjfirZevFvo9DtVhoBpBhhlHTcoeosUltMUKdwAx
         EqvzMttyF1MvNH8nhldOOscL310vnj9QsmkznBePYpjhYApKIdS2sutUFU9zX90vCCPf
         z88j4qix/FDTrrF4BOtdzotNDn8ladX05Cye4ZGjI96Y7oQrfHSjy1q2hBhZ3u+DPp7I
         PvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wQgNdP7B6WSeRuLb4cQpF6XsMLo+BL4PUzaYN9SkaNE=;
        b=byqFIE7vOgmAdY7/fG2rJPhulP0yTi0RAqhPKqSa8oYDMGHsmkbqzYP59IfuftL5rs
         fIofbhoAXcXu/AF+ztUDcXQPl/m2YRv6cW+tKBLYuzKi0P2S1wzhCVw70Gygdnm6nSJT
         5MwRV4uUj90GVkFsvTFckVNV+jXaf60lVmGajY+KAR/XVGzTkqyCegPKNATDMr87RA6h
         q3fJIrs5vTrl/AXN/mx/+B2wVDpFjDJ8cVtvhyNsiYUaNjDNdt8BIBcMmP84u/IRqPp3
         v9S8Ju8K66yFjEaZQOgZgvSx1k+CDulJDslpqPcN9Ym/oszt3FS6KT400NpLdD8eRKQ2
         ijGQ==
X-Gm-Message-State: ABuFfogD5+YfDeTzrtkOIkwvCOFh4QEMbUte73AsjQtfl1mjt8InhN6i
        jDO6qhUhQDHUb1Jz+TFSU9F0ow==
X-Google-Smtp-Source: ACcGV62az4SZBa+10xfue37T/WkEDarH25c/L3JxNnD5way7zh0ePL8SXhedUkYuvkOKpiWra6IwHQ==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr3418572plb.99.1537923355070;
        Tue, 25 Sep 2018 17:55:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 203-v6sm4459647pgb.14.2018.09.25.17.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 17:55:53 -0700 (PDT)
Date:   Tue, 25 Sep 2018 17:55:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in
 smaps
In-Reply-To: <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1809251750300.28960@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com> <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz> <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com> <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz> <20180924200258.GK18685@dhcp22.suse.cz> <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz> <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com> <20180925202959.GY18685@dhcp22.suse.cz>
 <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com> <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Andrew Morton wrote:

> > > > It is also used in 
> > > > automated testing to ensure that vmas get disabled for thp appropriately 
> > > > and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> > > > this, and those tests now break.
> > > 
> > > This sounds like a bit of an abuse to me. It shows how an internal
> > > implementation detail leaks out to the userspace which is something we
> > > should try to avoid.
> > > 
> > 
> > Well, it's already how this has worked for years before commit 
> > 1860033237d4 broke it.  Changing the implementation in the kernel is fine 
> > as long as you don't break userspace who relies on what is exported to it 
> > and is the only way to determine if MADV_NOHUGEPAGE is preventing it from 
> > being backed by hugepages.
> 
> 1860033237d4 was over a year ago so perhaps we don't need to be
> too worried about restoring the old interface.  In which case
> we have an opportunity to make improvements such as that suggested
> by Michal?
> 

The only way to determine if a vma was thp disabled prior to this commit 
was parsing VmFlags from /proc/pid/smaps.  That was possible either 
through MADV_NOHUGEPAGE or PR_SET_THP_DISABLE.  It is perfectly legitimate 
for a test case to check if either are being set correctly through 
userspace libraries or through the kernel itself in the manner in which 
the kernel exports this information.  It is also perfectly legitimate for 
userspace to cull through information in the only way it is exported by 
the kernel to identify reasons for why applications are not having their 
heap backed by transparent hugepages: the mapping is disabled, the 
application is hitting the limit for its mem cgroup, we are low on memory, 
or there are fragmentation issues.  Differentiating between those is 
something our userspace does, and was broken by 1860033237d4.
