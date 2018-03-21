Return-Path: <SRS0=x95D=GL=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521650408-2-7737090987273345211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES enroaf, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=x95D=GL=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521650407; b=rEf+YP4ZRLuLrszpsRAIbDOdypGdNpT40iC6foSHJxsfYl8
    hizUgKzi11nUDNDaJ21HJdYhe2IKTgCfAes02mMDu4NzK1CRmj4Hvgc+Ira5NIS2
    sxno1/EGFUmdeZi7z3Ahf8nrQJgY7bqu3bDv03tZ7izhHryZAzPOv7KGgkFZgY4e
    +5wTXpYniNfKrUGbsZzUqTOy+MqjTgS14u0u7PsEjtpPYkb/CawAlagj8bR160cU
    3uxW06/YTRpDCILPodrxfQ/aQOCCQhyGuD57G/AzDR120DcmpRIqedkvikdmxWir
    S/2LFyfu5QAj+DCrXDQH+khFe2/wwGXYIKMOFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521650407; bh=xYJgaS3cN6r2RtiwSDEF1CrVvL6RHq78gv+tMKIYbHI=; b=u
    g/Hf+mL95xrPgNL1dWGt+Vb4OxfpJfs5drgLQGuIcYLRb0ud0h3VaoFJ7dL1dIuK
    2cULUIbBmOfd+MSor774pWK+IRcDA8RjC0hIKh+dupehEgcwFnlNZBLFdXTBFn0Y
    bE5L2VZ9adzzuvdF51sSUtvzLWA6Xw+/4DWogrUPo5RZSTFbE2sG5WUQ+vi1Unhg
    CIZfT+dAyekqXJUetfmodRHEyXHblshyVEg/YnWAXfV7QjH83aymRM7c/OVEUN8q
    +G83TnB/kn8/S9XQ4JbSNB5lqQIABj4PAEkPOZxfh9npnp0WvoAK94mMdAbh9aoD
    wAePKuC9qcdIxrTwMIcWA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FjSIZm8f x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=x95D=GL=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gwyefMku;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FjSIZm8f x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=x95D=GL=gmail.com=htejun@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass (Domain match);
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gwyefMku;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF11217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELsLSigFnRgzQrEg7i3t5zOS7Y42yIqs/gmKszaXUayy13li48GYzE8NqwRoV1sQJAM9RWKGFw==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Mar 2018 09:40:00 -0700
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180321164000.GC2149215@devbig577.frc2.facebook.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321155812.GA9382@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey, Oleg.

On Wed, Mar 21, 2018 at 04:58:13PM +0100, Oleg Nesterov wrote:
> > -	struct rcu_head		free_rcu;
> > -	struct work_struct	free_work;	/* see free_ioctx() */
> > +	struct rcu_work		free_rwork;	/* see free_ioctx() */
> 
> IIUC, you can't easily share rcu_work's, thus every kioctx needs its own
> ->free_rwork and this looks sub-optimal.
>
> What do you think about the (untested) patch below?
> 
> Oleg.
> 
> 
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -115,8 +115,10 @@ struct kioctx {
>  	struct page		**ring_pages;
>  	long			nr_pages;
>  
> -	struct rcu_head		free_rcu;
> -	struct work_struct	free_work;	/* see free_ioctx() */
> +	union {
> +		struct rcu_head		free_rcu;
> +		struct llist_node	free_llist;
> +	};

It really depends on how much we want to optimize.  Do you think it
matters enough?

Thanks.

-- 
tejun
