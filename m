Return-Path: <SRS0=mX/F=F4=redhat.com=jglisse@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-961214-1520359195-2-10887068363962192998
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=mX/F=F4=redhat.com=jglisse@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520359194; b=i6uAYqg/Y+hRzUN+JhbEEdKzmeF/0D4HyhOgkuDWoPpAgX5
    LnFTNUnFPjKV71j2oa+S+P/ECeLEXH608zFvmm6cBb87dJOZIHc03PXm9S6JshxC
    EkVsR/mPgM3yAFOW+fWrMIrn6yD3lVQKdH5BSN8+iT3qRwv+6QiccY418ea79jfc
    HwdwiDvRVM7jLwTXxY01FkH+0aUthke5FK7de0DdtzbPV6qBRXYgSXkgn+jApsfK
    UaQygxFjv1Zr3ba7c4069/lV77ZUNdi3mkn1+sTaOTMBCVB+4Hz9oEjJuq6XVfCp
    yTTzcgpQgvtC7TuJGTpEEJVti4dOcx6jLLgoIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to; s=arctest; t=1520359194; bh=66+c/J2hyZsgCVcaPwZvos
    C7BYopPFsw9vVhK11Vysw=; b=dLG1T5yFCIkysg7XjoIcVfhq/fg+JuxWuMOqEQ
    SmIxmezcj8d0whfevxF9AQL9PkiUsG9/bUjGcIzDo2oJTVDM9wU8ORpPGzOrxKjX
    NqUhTnFbhl2QaAqr8FSDEF1fF78/V4u0Vms7ADa0zGOa7QTXvVaSejob9I6QSmIf
    ynTLMxgYF0Ja9P6CufyBoChF+ncFPFuIdZ/SbP/xdR2GNbYh7nM/+R6zbebTZM1R
    ZNIkmuLfl32zSNFBCNCLR+N0Czp2sdh9j9i3XCWJUeFNh2k8kZfdjPrbO8ZSuNpa
    aHnRHqz9n0vWo4jZSjIx5/Hm64MoWXgz7yQcITi5dZov6kLA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mX/F=F4=redhat.com=jglisse@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=mX/F=F4=redhat.com=jglisse@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148CD21777
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=jglisse@redhat.com
Date: Tue, 6 Mar 2018 12:59:48 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/7] HMM: Remove superflous RCU protection around radix
 tree lookup
Message-ID: <20180306175948.GA4791@redhat.com>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180306173316.3088458-4-tj@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 09:33:13AM -0800, Tejun Heo wrote:
> hmm_devmem_find() requires rcu_read_lock_held() but there's nothing
> which actually uses the RCU protection.  The only caller is
> hmm_devmem_pages_create() which already grabs the mutex and does
> superflous rcu_read_lock/unlock() around the function.
> 
> This doesn't add anything and just adds to confusion.  Remove the RCU
> protection and open-code the radix tree lookup.  If this needs to
> become more sophisticated in the future, let's add them back when
> necessary.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> Cc: linux-mm@kvack.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

> ---
> Hello, Jérôme.
> 
> This came up while auditing percpu_ref users for missing explicit RCU
> grace periods.  HMM doesn't seem to depend on RCU protection at all,
> so I thought it'd be better to remove it for now.  It's only compile
> tested.

Good catch some left over of old logic. I have more cleanup queued up
now that i am about to post nouveau patches to use all this. Thanks for
fixing this.

> 
> Thanks.
> 
>  mm/hmm.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 320545b98..d4627c5 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -845,13 +845,6 @@ static void hmm_devmem_release(struct device *dev, void *data)
>  	hmm_devmem_radix_release(resource);
>  }
>  
> -static struct hmm_devmem *hmm_devmem_find(resource_size_t phys)
> -{
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> -
> -	return radix_tree_lookup(&hmm_devmem_radix, phys >> PA_SECTION_SHIFT);
> -}
> -
>  static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
>  {
>  	resource_size_t key, align_start, align_size, align_end;
> @@ -892,9 +885,8 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
>  	for (key = align_start; key <= align_end; key += PA_SECTION_SIZE) {
>  		struct hmm_devmem *dup;
>  
> -		rcu_read_lock();
> -		dup = hmm_devmem_find(key);
> -		rcu_read_unlock();
> +		dup = radix_tree_lookup(&hmm_devmem_radix,
> +					key >> PA_SECTION_SHIFT);
>  		if (dup) {
>  			dev_err(device, "%s: collides with mapping for %s\n",
>  				__func__, dev_name(dup->device));
> -- 
> 2.9.5
> 
