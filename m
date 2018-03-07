Return-Path: <SRS0=4hsI=F5=intel.com=dennis.dalessandro@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3579708-1520437206-2-13759388745177659364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=4hsI=F5=intel.com=dennis.dalessandro@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520437206; b=JnFKZTDS4OeBFrehG1VyGzygZMK3Cv8Or6enM/pCqoucihk
    aJT2hsBNU/Pr+SQQ2VCSdrh3syYy8LNSsftt3IiCCYEUQef7o7nPjCVNAfoNf14D
    Iioy61CNAhJf4ZBta4vp08kIjqH3e4AOFqraTtIU4pTkgK3E2tV2+ef2S2ZHtTw5
    GqO42vHqfsXdgM9APeWs1h9tlCJ4zqajAx40erUSEvsQiGkfIlhvuT7EAMKM7DBe
    GPRW2omO1KIgAbeQAJ/F9iFLDkArnLBVCAeCmLvm5K0ORAfaOJpxDabEVpccDq4v
    yvh/+c8j3IrCuKGUfeEz3KLM1e2EGCUrkuTxxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1520437206; bh=HV7vJtXs
    temuhejwrWoiycckpgvppgG1tlJMfyHD4pI=; b=G4+oA3hUGZojeJ7Bl5wOE4JH
    q3bFiyxt0M105BnpbyvwFPl72kvybpWSattQ9Amb9GjOgehs7g2VkwyLc9bdHgMj
    zFaqJV7R5LxVm5d6gdCUI0xG3T2oxv1p92y0OFsPMYiMhhlwbtNFmP39JZKG9A4u
    akBe3G2LVuQxMALKElJMhvcMu8c98b/LrlF68ISlspzqKSSG2PPW3OsqcxI+XTPb
    Cr5SUFfR+soO2FwJX/dcl8YJXHLE9PfG9QlCgab9BhAZUCjYDhDo16lkZOX+dozS
    kCBXDqHe3CVnjtLEuD9xa0qtIEOD7AGI0HGqwyJVMdNjpspMbtfPF0M293uwOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=intel.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=4hsI=F5=intel.com=dennis.dalessandro@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=intel.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=4hsI=F5=intel.com=dennis.dalessandro@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB862172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=dennis.dalessandro@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="209610434"
Subject: Re: [PATCH 3/7] RDMAVT: Fix synchronization around percpu_ref
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
 jannh@google.com, paulmck@linux.vnet.ibm.com, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, kent.overstreet@gmail.com
Cc: security@kernel.org, linux-kernel@vger.kernel.org, kernel-team@fb.com,
 Mike Marciniszyn <mike.marciniszyn@intel.com>, linux-rdma@vger.kernel.org
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-3-tj@kernel.org>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5288ee8a-179a-8e45-0300-6a3c382a1cf9@intel.com>
Date: Wed, 7 Mar 2018 10:39:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306173316.3088458-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/6/2018 12:33 PM, Tejun Heo wrote:
> rvt_mregion uses percpu_ref for reference counting and RCU to protect
> accesses from lkey_table.  When a rvt_mregion needs to be freed, it
> first gets unregistered from lkey_table and then rvt_check_refs() is
> called to wait for in-flight usages before the rvt_mregion is freed.
> 
> rvt_check_refs() seems to have a couple issues.
> 
> * It has a fast exit path which tests percpu_ref_is_zero().  However,
>    a percpu_ref reading zero doesn't mean that the object can be
>    released.  In fact, the ->release() callback might not even have
>    started executing yet.  Proceeding with freeing can lead to
>    use-after-free.
> 
> * lkey_table is RCU protected but there is no RCU grace period in the
>    free path.  percpu_ref uses RCU internally but it's sched-RCU whose
>    grace periods are different from regular RCU.  Also, it generally
>    isn't a good idea to depend on internal behaviors like this.
> 
> To address the above issues, this patch removes the the fast exit and

Typo above too many "the".

> adds an explicit synchronize_rcu().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> Hello, Dennis, Mike.
> 
> I don't know RDMA at all and this patch is only compile tested.  Can
> you please take a careful look?

Looks good to me, passes my basic sanity tests. Thanks!

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
