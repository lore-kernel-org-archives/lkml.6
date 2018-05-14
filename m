Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526315554-2-17730577830711190774
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526315554; b=Dgkg4Y3MkukQwXFQDSABZLV9LZ/bXbU7l8peyi9uoY7cD4NJqC
    5hOZiQg42908b1cqrspwwZop09VZGY8LS8slqwscDz563mzfrHeFnL5Qn+hulp+k
    mWsqQgZpBbx4ff7QpYCewWwTLYF0nBjr7/XklA7E4Axkt0wViqcTxRyRDbAkWmIY
    9enMvf7Nw2W/euwI1g3n2090g17m5/5ZEg3xm2FS6mcu9xe4BFUl2p6aDq5iq34o
    fhB+VjX4Tx+1b+5nBViNd97yohYsM865NOOiNTKrSELCjmZ4dQHE+AxMu06cCxV+
    SmwmhYuxhD3q4tcImvkG8X2vF7cYTOVeRIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526315554;
    bh=8ROEALpk5Dk8mfcJEUOC5v86KfllJ/+Fkr3Rt0WYtTY=; b=MaBU1ENRLA93
    b/9DJ52g/czCOkyRwVz0ecPZqg/kgzg22osY3VeVzmorP+Safcvdzj0A+DT3TrOF
    nXaNpqcLJD35UQ4N21OrA9OQ9celxOhCEz8BYo5v0jx+/lUECrcPP4bz3amA1pqm
    Q3puEp9SSFk8z76w8qADvwBgHouPXa67yssptOhpySy9heZNatxNQzYoM4KBgqtv
    /Lf4djUN+nfgG+gyja0MMKM6BW+xfKeGIVpRtLEquCb2FRxb+iu5O5a31ukgpxBp
    0aSp4lk7rfc6yZWxXYvSugfM2A6WFqxKh1jjudb6Y7SxFm2Q9NU1HvHFgPbWzOD8
    ORMz0GyeWA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=kInrvMcs x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=kInrvMcs x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCsbB+BDH9ogYFhCqLKIhfqpNIMmt8jQHslYWLm10TKxN7f3400kwT85IZYrOek72yIH7HV0sE2vvW3WsjPnYDakhxoUV+QlgFX8+6WBQPGNIEvqYT9X
    r/feGwXCou6+Hs12Ac69nuXiUMgJ1UVHveKr3geUKpvkfx4f/uOH1w1UO7uIYClYrh8yOSAio2uBZWTQEAwM3VTrkcDgSrVfE44WElaaqLThZSPK8LLcLCAr
    W8rWHbsXTrwD4EVASX+3Rg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=TcBhvl8sDuQA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=ki4VXbPKjkYnCEwXNzkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeENQcc (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 12:32:32 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:34598
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753676AbeENQcb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 12:32:31 -0400
X-YMail-OSG: N59QDU8VM1kcYFj0HASCEGEf.3Zem.N0jahV9d6qxAaA8k_jeRkdMBKGWk7zexV
 MZnyiQ8aYE9nV2jU1zmYFdOL1OLa3NfFa.nheKf1GJBPPfZr5cyBFqiJlrqOTLVUK2tCn0WPGFMP
 cDYmSG.QBqQg.2Lt4huOexJImKQKOZ2OCoLh90eC8fKadTBTujACg1wbCgKQVvRMuGBjKF9pMISu
 QMOpzoTKswCxFG8t6zTWbeSy_DlCKEYoJh9F4KIy4fAfbuJ3Cg7WipQlE3iNK47RqdzeigKHe00o
 .LRdm6Z6yI5.T_x2g7lG8YsAOnexCxAiPgOR82oFqn5wIayGrLVT_XZEAUYGJ6EH3.tkl4BPwOg.
 cc2QO7KR0IqNdFrif2i1Q_i1pHss119uvnPw8n_F55knRv8rwZMpT0Ve505xTZ6Szh1cf_P6KBNv
 yBuXaES5luqDj2q85GPPGHHoIrnUHHzzZevtoFP96xQzZAzlE79cK4SRQEYTZqWSf8Uv4S0yQrB0
 O1j2Pyma_sPWb7Y1oCjpiDdpWujk9wkeSbIhO_NSLkBE9T8dZd1NOKsUnRJMgsjpLdH4eBOl.NHg
 N5c4epDRQn18Tfw78Hy.7yhZzha3nux0KfiMjBzNIBUKFAIWLGDio5O19Qq740bNQlUwfcFTl9gd
 oDyc-
Subject: Re: [PATCH 10/23] LSM: Infrastructure management of the inode
 security
To: Stephen Smalley <sds@tycho.nsa.gov>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <fd3c36e4-6e75-4eec-afdf-a493889c696f@schaufler-ca.com>
 <a38fb118-8c72-e18d-e55a-48fdc40e21f4@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <906d5338-0021-740d-36dc-0f32b2c36f55@schaufler-ca.com>
Date: Mon, 14 May 2018 09:32:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a38fb118-8c72-e18d-e55a-48fdc40e21f4@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/14/2018 8:04 AM, Stephen Smalley wrote:
> On 05/10/2018 08:53 PM, Casey Schaufler wrote:
>> From: Casey Schaufler <casey@schaufler-ca.com>
>> Date: Thu, 10 May 2018 14:23:27 -0700
>> Subject: [PATCH 10/23] LSM: Infrastructure management of the inode security
>>  blob
>>
>> Move management of the inode->i_security blob out
>> of the individual security modules and into the security
>> infrastructure. Instead of allocating the blobs from within
>> the modules the modules tell the infrastructure how much
>> space is required, and the space is allocated there.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h         |  3 ++
>>  security/security.c               | 85 +++++++++++++++++++++++++++++++++++++--
>>  security/selinux/hooks.c          | 32 +--------------
>>  security/selinux/include/objsec.h |  5 +--
>>  security/smack/smack_lsm.c        | 70 +++++---------------------------
>>  5 files changed, 99 insertions(+), 96 deletions(-)
>> <SNIP>
>> diff --git a/security/security.c b/security/security.c
>> index b414186ad45f..02df9b608b7e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -41,6 +41,7 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>>  
>>  static struct kmem_cache *lsm_file_cache;
>> +static struct kmem_cache *lsm_inode_cache;
>>  
>>  char *lsm_names;
>>  static struct lsm_blob_sizes blob_sizes;
>> @@ -98,6 +99,10 @@ int __init security_init(void)
>>  		lsm_file_cache = kmem_cache_create("lsm_file_cache",
>>  						   blob_sizes.lbs_file, 0,
>>  						   SLAB_PANIC, NULL);
>> +	if (blob_sizes.lbs_inode)
>> +		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
>> +						    blob_sizes.lbs_inode, 0,
>> +						    SLAB_PANIC, NULL);
>>  	/*
>>  	 * The second call to a module specific init function
>>  	 * adds hooks to the hook lists and does any other early
>> @@ -108,8 +113,9 @@ int __init security_init(void)
>>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>>  	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>>  	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
>> +	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
>>  	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
>> -#endif
>> +#endif /* CONFIG_SECURITY_LSM_DEBUG */
>>  
>>  	return 0;
>>  }
>> @@ -285,6 +291,13 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>>  	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
>>  	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
>>  	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
>> +	/*
>> +	 * The inode blob gets an rcu_head in addition to
>> +	 * what the modules might need.
>> +	 */
>> +	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
>> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>> +	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>>  }
>>  
>>  /**
>> @@ -348,6 +361,46 @@ void lsm_early_task(struct task_struct *task)
>>  		panic("%s: Early task alloc failed.\n", __func__);
>>  }
>>  
>> +/**
>> + * lsm_inode_alloc - allocate a composite inode blob
>> + * @inode: the inode that needs a blob
>> + *
>> + * Allocate the inode blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +int lsm_inode_alloc(struct inode *inode)
>> +{
>> +	if (!lsm_inode_cache) {
>> +		inode->i_security = NULL;
>> +		return 0;
>> +	}
>> +
>> +	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_KERNEL);
> Should be GFP_NOFS (and was that way in SELinux and Smack).

Yes, you're correct. I'll make the change.

