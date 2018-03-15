Return-Path: <SRS0=AiLk=GF=ziepe.ca=jgg@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1277664-1521152677-2-4305110405242297371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='ca',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=AiLk=GF=ziepe.ca=jgg@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521152677; b=LsLTL5lsOh5a4mB12zs3561wBt5Em71/URHZHUXqUZO8HsZ
    0TGFkovBSlUdH5NDCI0uDTf2FZ3xG+LTMMgndjd0frwQihoI0yFrruSesxFei8Aj
    Q6WPBv4CkVbsxCjtrxsACjtUd6pvKOOZrdsFznYMSnpDRYbo6Jk+r5jY5YfZek3B
    wjpChzc9eYO55Ir7VwfGYM5ag2iHd5q4EWRPDolh2nHPAfCBek454y3eecxZf2Xx
    iwJBbIrEmqnY4gJM3vyip7oHJ8NT4OMdCK7sYgHynHBEDB8/Hul8nxt6MqdklXCj
    ymq5XOy3kHI8NBhXUFDTgyGGpMtKx/9rcIezxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521152677; bh=TF29Y+kwZvakAklMQqWw5mBlM4lqbvV5ORAZlfTVAxQ=; b=H
    DH0CE/TsbdBQvHCUgZbpffsMA7cFu+zPbdJtSNhWluNsArgkxPzrSU2oBPrmf1mO
    2Ek+Px0moFOtEjF9Df99skRn8qjd+FHY4D84Fo6Sh6IKgrEeCzZB3U9pOHVy5yxl
    lP3FxdqQWyZKdVYasMLJRO+ThwsNPQ24pNKbu5PiySi5tncaim6PdUMlWqW0xIMA
    ciRocwwNBpWul8vsSOOJYgQ0VxEu7+AnqegDE7gMsPqqj6Kx570CefWnIYDIzcEr
    PKa5SCMazatw9m/yF1OLBkf6vfzsUOYjowEze54qsKEYZWfUJhJhS/uzmHasXmB3
    xBw9p4dCXp+3A0Zwu/iNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=ziepe.ca header.i=@ziepe.ca header.b=V2ZIGCmy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,d=none) header.from=ziepe.ca;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=AiLk=GF=ziepe.ca=jgg@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m+EVv0cN;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=ziepe.ca header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=ziepe.ca header.i=@ziepe.ca header.b=V2ZIGCmy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,d=none) header.from=ziepe.ca;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=AiLk=GF=ziepe.ca=jgg@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m+EVv0cN;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=ziepe.ca header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B570421742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jgg@ziepe.ca
X-Google-Smtp-Source: AG47ELv8A/eq2HZBycAjMrdRrya5J0knguYmWTAsW6IBT9/pjCP1BYX4MDxxVySCjQiClpy0fdJi0g==
Date: Thu, 15 Mar 2018 16:24:28 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 3/8] RDMAVT: Fix synchronization around percpu_ref
Message-ID: <20180315222428.GE27537@ziepe.ca>
References: <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314194515.1661824-3-tj@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:45:10PM -0700, Tejun Heo wrote:
> rvt_mregion uses percpu_ref for reference counting and RCU to protect
> accesses from lkey_table.  When a rvt_mregion needs to be freed, it
> first gets unregistered from lkey_table and then rvt_check_refs() is
> called to wait for in-flight usages before the rvt_mregion is freed.
> 
> rvt_check_refs() seems to have a couple issues.
> 
> * It has a fast exit path which tests percpu_ref_is_zero().  However,
>   a percpu_ref reading zero doesn't mean that the object can be
>   released.  In fact, the ->release() callback might not even have
>   started executing yet.  Proceeding with freeing can lead to
>   use-after-free.
> 
> * lkey_table is RCU protected but there is no RCU grace period in the
>   free path.  percpu_ref uses RCU internally but it's sched-RCU whose
>   grace periods are different from regular RCU.  Also, it generally
>   isn't a good idea to depend on internal behaviors like this.
> 
> To address the above issues, this patch removes the fast exit and adds
> an explicit synchronize_rcu().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>  drivers/infiniband/sw/rdmavt/mr.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied to rdma for-next

Thanks,
Jason
