Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeFEB1O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:27:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44974 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeFEB1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:27:12 -0400
Subject: Re: [PATCH] Use an IDR to allocate apparmor secids
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org
References: <20180522093259.GA30182@bombadil.infradead.org>
 <20180528170108.GA5448@bombadil.infradead.org>
From: John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <862d03b6-ba2f-3ec0-d45e-d8fcf16f9edf@canonical.com>
Date: Mon, 4 Jun 2018 18:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528170108.GA5448@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 10:01 AM, Matthew Wilcox wrote:
> 
> ping?
> 
> I have this queued up in my XArray tree.  If I don't hear from you before
> -rc1, I'll be submitting it as part of the XArray conversion.
> 
hey Mathew,

I've pulled this into apparmor-next and done the retuning of
AA_SECID_INVALID a follow on patch. The reworking of the api to
return the specific error type can wait for another cycle.


> On Tue, May 22, 2018 at 02:32:59AM -0700, Matthew Wilcox wrote:
>> Replace the custom usage of the radix tree to store a list of free IDs
>> with the IDR.
>>
>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>>
>>  security/apparmor/secid.c |  114 ++++------------------------------------------
>>  1 file changed, 11 insertions(+), 103 deletions(-)
>>
>> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
>> index c2f0c1571156..3ad94b2ffbb2 100644
>> --- a/security/apparmor/secid.c
>> +++ b/security/apparmor/secid.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/err.h>
>>  #include <linux/gfp.h>
>> +#include <linux/idr.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>  
>> @@ -30,18 +31,10 @@
>>  /*
>>   * secids - do not pin labels with a refcount. They rely on the label
>>   * properly updating/freeing them
>> - *
>> - * A singly linked free list is used to track secids that have been
>> - * freed and reuse them before allocating new ones
>>   */
>>  
>> -#define FREE_LIST_HEAD 1
>> -
>> -static RADIX_TREE(aa_secids_map, GFP_ATOMIC);
>> +static DEFINE_IDR(aa_secids);
>>  static DEFINE_SPINLOCK(secid_lock);
>> -static u32 alloced_secid = FREE_LIST_HEAD;
>> -static u32 free_list = FREE_LIST_HEAD;
>> -static unsigned long free_count;
>>  
>>  /*
>>   * TODO: allow policy to reserve a secid range?
>> @@ -49,65 +42,6 @@ static unsigned long free_count;
>>   * TODO: use secid_update in label replace
>>   */
>>  
>> -#define SECID_MAX U32_MAX
>> -
>> -/* TODO: mark free list as exceptional */
>> -static void *to_ptr(u32 secid)
>> -{
>> -	return (void *)
>> -		((((unsigned long) secid) << RADIX_TREE_EXCEPTIONAL_SHIFT));
>> -}
>> -
>> -static u32 to_secid(void *ptr)
>> -{
>> -	return (u32) (((unsigned long) ptr) >> RADIX_TREE_EXCEPTIONAL_SHIFT);
>> -}
>> -
>> -
>> -/* TODO: tag free_list entries to mark them as different */
>> -static u32 __pop(struct aa_label *label)
>> -{
>> -	u32 secid = free_list;
>> -	void __rcu **slot;
>> -	void *entry;
>> -
>> -	if (free_list == FREE_LIST_HEAD)
>> -		return AA_SECID_INVALID;
>> -
>> -	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
>> -	AA_BUG(!slot);
>> -	entry = radix_tree_deref_slot_protected(slot, &secid_lock);
>> -	free_list = to_secid(entry);
>> -	radix_tree_replace_slot(&aa_secids_map, slot, label);
>> -	free_count--;
>> -
>> -	return secid;
>> -}
>> -
>> -static void __push(u32 secid)
>> -{
>> -	void __rcu **slot;
>> -
>> -	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
>> -	AA_BUG(!slot);
>> -	radix_tree_replace_slot(&aa_secids_map, slot, to_ptr(free_list));
>> -	free_list = secid;
>> -	free_count++;
>> -}
>> -
>> -static struct aa_label * __secid_update(u32 secid, struct aa_label *label)
>> -{
>> -	struct aa_label *old;
>> -	void __rcu **slot;
>> -
>> -	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
>> -	AA_BUG(!slot);
>> -	old = radix_tree_deref_slot_protected(slot, &secid_lock);
>> -	radix_tree_replace_slot(&aa_secids_map, slot, label);
>> -
>> -	return old;
>> -}
>> -
>>  /**
>>   * aa_secid_update - update a secid mapping to a new label
>>   * @secid: secid to update
>> @@ -115,11 +49,10 @@ static struct aa_label * __secid_update(u32 secid, struct aa_label *label)
>>   */
>>  void aa_secid_update(u32 secid, struct aa_label *label)
>>  {
>> -	struct aa_label *old;
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&secid_lock, flags);
>> -	old = __secid_update(secid, label);
>> +	idr_replace(&aa_secids, label, secid);
>>  	spin_unlock_irqrestore(&secid_lock, flags);
>>  }
>>  
>> @@ -132,7 +65,7 @@ struct aa_label *aa_secid_to_label(u32 secid)
>>  	struct aa_label *label;
>>  
>>  	rcu_read_lock();
>> -	label = radix_tree_lookup(&aa_secids_map, secid);
>> +	label = idr_find(&aa_secids, secid);
>>  	rcu_read_unlock();
>>  
>>  	return label;
>> @@ -167,7 +100,6 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  	return 0;
>>  }
>>  
>> -
>>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>>  {
>>  	struct aa_label *label;
>> @@ -186,7 +118,6 @@ void apparmor_release_secctx(char *secdata, u32 seclen)
>>  	kfree(secdata);
>>  }
>>  
>> -
>>  /**
>>   * aa_alloc_secid - allocate a new secid for a profile
>>   */
>> @@ -195,35 +126,12 @@ u32 aa_alloc_secid(struct aa_label *label, gfp_t gfp)
>>  	unsigned long flags;
>>  	u32 secid;
>>  
>> -	/* racey, but at worst causes new allocation instead of reuse */
>> -	if (free_list == FREE_LIST_HEAD) {
>> -		bool preload = 0;
>> -		int res;
>> -
>> -retry:
>> -		if (gfpflags_allow_blocking(gfp) && !radix_tree_preload(gfp))
>> -			preload = 1;
>> -		spin_lock_irqsave(&secid_lock, flags);
>> -		if (alloced_secid != SECID_MAX) {
>> -			secid = ++alloced_secid;
>> -			res = radix_tree_insert(&aa_secids_map, secid, label);
>> -			AA_BUG(res == -EEXIST);
>> -		} else {
>> -			secid = AA_SECID_INVALID;
>> -		}
>> -		spin_unlock_irqrestore(&secid_lock, flags);
>> -		if (preload)
>> -			radix_tree_preload_end();
>> -	} else {
>> -		spin_lock_irqsave(&secid_lock, flags);
>> -		/* remove entry from free list */
>> -		secid = __pop(label);
>> -		if (secid == AA_SECID_INVALID) {
>> -			spin_unlock_irqrestore(&secid_lock, flags);
>> -			goto retry;
>> -		}
>> -		spin_unlock_irqrestore(&secid_lock, flags);
>> -	}
>> +	idr_preload(gfp);
>> +	spin_lock_irqsave(&secid_lock, flags);
>> +	secid = idr_alloc(&aa_secids, label, 0, 0, GFP_ATOMIC);
>> +	/* XXX: Can return -ENOMEM */
>> +	spin_unlock_irqrestore(&secid_lock, flags);
>> +	idr_preload_end();
>>  
>>  	return secid;
>>  }
>> @@ -237,6 +145,6 @@ void aa_free_secid(u32 secid)
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&secid_lock, flags);
>> -	__push(secid);
>> +	idr_remove(&aa_secids, secid);
>>  	spin_unlock_irqrestore(&secid_lock, flags);
>>  }
>>
