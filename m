Return-Path: <SRS0=C9he=GQ=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1197340-1522076080-2-16271515356625771943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=C9he=GQ=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522076078; b=omo+tz1D0SYwqj3mYdIBqKrJeCR+/L67BFXhL4KBjSsK2N/
    ctjV7z07N5ytNWrn4CRoIWew07LSyMNbvTcmi+IBfGKssM6fqBvR7R6Ezx2uoKOL
    dNoi8PLK+bYCc9kjBEfMx6UQcsmVGXG+bODYtN1mmE0sJZzwqNrofOA2ycSXB0B0
    Tfx1CQcCY+JIUQZ/Wwx3y6Yp6867PaotXn6jGdT55+Sjuns8NZweZU/lTTQBRKku
    zt2noJz0xuNXKhv2PHFgdiZPQLKEmEufSwfmcfDdkvttdkIePk5wGHD90Kpb2guH
    VhnVErAFtulU2ItRynltNGG2cFVGVYqPg/iIV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to; s=arctest; t=1522076078; bh=NeN2mveXF1xaw+egQQJQ5z
    XEszmSrfg62BJqCRagDAo=; b=Mai0M7AxgWUYRvdsaYx/LRT5gMpBwA14Xq4Wo2
    GDizoDlOCequLwWBHh5W4K8NQ+b2ztSOgPHs7n71y6XphSQtpB3BrC3uteHnO4hp
    oWmQKVsKhZV5uS6Nf6tX8zRVpxQY2slspj2FvXB43RhXzeG1zypsqLIn+0COvhTD
    uLxZITynNyWICj+z21VOlHepmIpR4zdR012cDoQStMnbRdIjlWwbrE3qZLkbBATc
    G/uCMl6k/JOxTyYOmBAuvB6UDbcJyvlMM3fBu9x5COqTd/y1GkUAEYS5EROZeh79
    4mD/r6wkPPhlFP7vH/asWmAGjYZPWvZRrz9Y91k7YgWW+hXw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qYXcgFm0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=C9he=GQ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dtYW7K96;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qYXcgFm0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=C9he=GQ=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dtYW7K96;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfClhTnrRqiDaKN/y+MmSs0ERS6D9FZ9vicSYLCfrR4HWcxkKJzGo4dh9UqEscrHZ3zVZ5XFvzpEMk5iBoLF6O9z9ZPt8L92dmU9YAKUc/9oyte7+rQWY
    YmUYWa30EXDaCdX8UDP/C5yrnLEnqXbur3Za2DbuppOqUvyag/2cSpOgjnSh8mXDr7AwhhHga9ai8kEcvgI5TTLX5TqSZUjQBJ0=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=v2DPQv5-lfwA:10 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=37rDS-QxAAAA:8 a=Z4Rwk6OoAAAA:8 a=IInXYfxJI062FFzA82IA:9 a=wPNLvfGTeEIA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=k1Nq6YrhK2t884LQW06G:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F672175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELvZFYOyGxnFtJgQulKl/ZWJxXzFSf4FP9A1K279EtX1FR3niHh0+Hrx7FAopMvA3KWmPO/gkg==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Mar 2018 07:54:31 -0700
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: security@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com,
	linux-mm@kvack.org, torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Subject: Re: [PATCH 4/8] HMM: Remove superflous RCU protection around radix
 tree lookup
Message-ID: <20180326145431.GC1840639@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180314194515.1661824-4-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Andrew.

Do you mind picking up the following patch?  I can't find a good tree
to route this through.  The raw patch can be found at

  https://marc.info/?l=linux-mm&m=152105674112496&q=raw

Thank you very much.

On Wed, Mar 14, 2018 at 12:45:11PM -0700, Tejun Heo wrote:
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
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> Hello,
> 
> Jérôme, how do you want to route this patch?  If you prefer, I can
> route it together with other patches.
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

-- 
tejun
