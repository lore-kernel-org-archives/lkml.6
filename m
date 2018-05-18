Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-35557-1526662819-5-7642031917127365744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526662819; b=SoeF3EwlgUJ8VP+PgOugw8shNYtsTg7WUunOxiEm5vVaATzHH4
    OLtqLuxD2uvsuZdcu1gyg0DF2yMUvW07AsbJV0G/awgjl3oiWjXApLX3y5JqMFPB
    0w9sBD1lbUQGeaO+snfh1rQoH31nfkVEXZapaF668MR4K8Ie0lE3jNwfdlO7w98A
    CTfIymaC1Ywz4s8io8JSKpNQjUEEYxuS0KIroJRm3j9HwfdU6Jgbzmf73dVS6+JV
    Y3XubYP4baFDqq03MMKXCKyHg9/umivazgkpQXC+PMyOMY7ihHmtEl2jpB5cjdUd
    SdaGt+MLSwO+acB6x/yzHBi6ydCVJzMVRDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526662819;
    bh=4/7IIFAuMzh5nKRY4S/yW5HBnNxsF2nJpz4f+XX/PDo=; b=nd41hbDw5/XV
    eL+isoNoZWpliNtQTdWCkRyFmiryF4qC8Vs8XvZ594ci8dO3PqXb3m1uhoa46B01
    tUnANhC1xLBb2Qe8zW5EOPPTp83ZKa+9j+SWw0wCf4uskFaQr2gRarR5HQHAKVFo
    eekfo3A3r0DOwMdbMXMF8VZacJ7h8Kb0G7c0DhE413ER6obqg0RVcjvpDKwlmaVG
    zxncTuItBuaT85y0WGgw/tDT7q5ybRXKSZLBisVNytmRQMnpKlkfV2yYRShrGjXj
    HvWb8RaPTHeHfTqipeaHqTqd12bhEly9JLPK9RX9OlyhMqPMFuraO75qd69cZtha
    klhDd+QbCw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyorLTRkfL8RpHZ/xEsjqkoNfGQC/Fjg+GmaMYOpwNW43Vg4Nv2bYy1+trhaepyjsaJGwgfP0Rk6+YsnT1EkpQCtTtbr+Gr2H/DRsACYlzVkh9DYCpq
    UDTTX9dAoNQsDCeA2Nqhwx1RKrZOGmn0qYqUnryct8JxdGb7OOF/jFAkuAQATI3fr97N24u/IdJ1OXA5C3VRRFYmwc5j8YEVmM0M5Zqa+IHzDeG0uVM0gYNr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=CkAG0TsrSNbMCQj8eOYA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeERRAQ (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:00:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751488AbeERRAN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 13:00:13 -0400
Subject: Re: [PATCH] locking/rwsem: simplify the is-owner-spinnable checks
To: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516121947.GE20670@bombadil.infradead.org>
 <20180518070258.GA20971@gmail.com> <20180518084122.GA14307@redhat.com>
 <20180518094052.GA26150@gmail.com> <20180518165534.GA22348@redhat.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eedd968a-3ebf-4f71-6b02-81ce45fdff15@redhat.com>
Date: Fri, 18 May 2018 13:00:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180518165534.GA22348@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 12:55 PM, Oleg Nesterov wrote:
> Add the trivial owner_on_cpu() helper for rwsem_can_spin_on_owner() and
> rwsem_spin_on_owner(), it also allows to make rwsem_can_spin_on_owner()
> a bit more clear.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/locking/rwsem-xadd.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index a903367..3064c50 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -347,6 +347,15 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
>  	}
>  }
>  
> +static inline bool owner_on_cpu(struct task_struct *owner)
> +{
> +	/*
> +	 * As lock holder preemption issue, we both skip spinning if
> +	 * task is not on cpu or its cpu is preempted
> +	 */
> +	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
> +}
> +
>  static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  {
>  	struct task_struct *owner;
> @@ -359,17 +368,10 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  
>  	rcu_read_lock();
>  	owner = READ_ONCE(sem->owner);
> -	if (!owner || !is_rwsem_owner_spinnable(owner)) {
> -		ret = !owner;	/* !owner is spinnable */
> -		goto done;
> +	if (owner) {
> +		ret = is_rwsem_owner_spinnable(owner) &&
> +		      owner_on_cpu(owner);
>  	}
> -
> -	/*
> -	 * As lock holder preemption issue, we both skip spinning if task is not
> -	 * on cpu or its cpu is preempted
> -	 */
> -	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
> -done:
>  	rcu_read_unlock();
>  	return ret;
>  }
> @@ -398,8 +400,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
>  		 * abort spinning when need_resched or owner is not running or
>  		 * owner's cpu is preempted.
>  		 */
> -		if (!owner->on_cpu || need_resched() ||
> -				vcpu_is_preempted(task_cpu(owner))) {
> +		if (need_resched() || !owner_on_cpu(owner)) {
>  			rcu_read_unlock();
>  			return false;
>  		}

Acked-by: Waiman Long <longman@redhat.com>
