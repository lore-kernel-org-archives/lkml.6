Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1907279-1527589378-2-317178269963881877
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527589378; b=Or/7+LHRm5ej2mfIwOWPbP/ZHzEDxAoEWpiTXjlSAUh/JLvL0/
    lW+Uf9WxbLcqVs8yjH6xwkZ6utFICFQMGNUE+1TvzUd6l/WhtIYWmUvSacmEFV8s
    XLf92Yc+eKS+Je0h5WjaS4R6vRq4n+vcJW5E93/yEMVff2wy4jGUXPGpml1vSD7O
    YA5JLCN+sI2DBejdGOaoUAbXo6i5/BUbg7WeLhR2/gclJFRKv43wlKL5UD5ix1sV
    RoZXOG60If0+qGJUAhf/lfaHoO4Gm8JX1qTlYgxxnSCkKDHZaaGIP5whUzuTXfdR
    lkCmy0pl1G7lOf+cwpMq+OAv5Dq0lvpSiyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527589378; bh=Wb582MidCFQLEGRlRz5tZmDTuRIWE/
    rmDPGOa9jv1Ek=; b=KmdUf+JgeUJcEzmJejJDR4UO1E1CFLWxq2Hs5wu9Cp2HHA
    Fv2kTUS+CIn0rto0xYPdTSjSM3HD1sGtA2DnxSe3yO/Yn5C3FZNpmTGkVbppTeCg
    ih5wpxUytvCRvB76YyHO54ZqLTdvXdqAgurzMbognUu6T2E54psVI6MhPNRJysBZ
    AS4opyxHdCtwXC3OVarfGfANLn4Ef/YsKpFMCkbTqhCB9pdPkjQOYjM0PIAslSUQ
    dwH5zYqHMRYbSo/Aqeqk/Q+KFke5YgWqAe69LaUNl1A8xgP3ThRhoG316oFCYEOE
    D3FYhrh8DcScBfZv0mDQiX0H1mIICIyDhorYYVnQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=fromorbit.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=fromorbit.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNCzBoNtaBi0kiBV5sKd0C+Na/DsBhyI3V11Mr51U9LYl9wSdU4P+shhRnCQLjAx6coP71GBugEK3naQoeH1Lrfp+wzGeZWQy7I/BcKM69UKT40qYH2J
    ZkyYVQN9V89iVtC++AbStFG4iIprN02mNDNOA5DLxa7yYzfC1KjxJQxGPiS6jtMtwDgmHE2BkD+amwrtHonnnX/u1D/dJyBKq5NEJx2xGVNFu+6qTHLZ2SsR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=6slmQGIbPVgDHH9m3fUA:9
    a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbeE2KWz (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 06:22:55 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:61807 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932476AbeE2KWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 06:22:19 -0400
Date: Tue, 29 May 2018 20:22:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] doc: document scope NOFS, NOIO APIs
Message-ID: <20180529102215.GL23861@dastard>
References: <20180524114341.1101-1-mhocko@kernel.org>
 <20180529082644.26192-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529082644.26192-1-mhocko@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 10:26:44AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Although the api is documented in the source code Ted has pointed out
> that there is no mention in the core-api Documentation and there are
> people looking there to find answers how to use a specific API.
> 
> Changes since v1
> - add kerneldoc for the api - suggested by Johnatan
> - review feedback from Dave and Johnatan
> - feedback from Dave about more general critical context rather than
>   locking
> - feedback from Mike
> - typo fixed - Randy, Dave
> 
> Requested-by: "Theodore Y. Ts'o" <tytso@mit.edu>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

We could bikeshed forever about the exact wording, but it covers
everything I think needs to be documented.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
