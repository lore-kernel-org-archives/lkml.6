Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9158C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878DA20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878DA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLDU1F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:27:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDU1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:27:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 036B93DBE5;
        Tue,  4 Dec 2018 20:27:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 327EB7F1B8;
        Tue,  4 Dec 2018 20:27:03 +0000 (UTC)
Subject: Re: [PATCH v2 17/24] locking/lockdep: Free lock classes that are no
 longer in use
To:     Bart Van Assche <bvanassche@acm.org>, mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
References: <20181204002833.55452-1-bvanassche@acm.org>
 <20181204002833.55452-18-bvanassche@acm.org>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <46b0ff3c-aa6e-7183-3554-19ed112536aa@redhat.com>
Date:   Tue, 4 Dec 2018 15:27:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181204002833.55452-18-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 04 Dec 2018 20:27:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2018 07:28 PM, Bart Van Assche wrote:
> Instead of leaving lock classes that are no longer in use in the
> lock_classes array, reuse entries from that array that are no longer
> in use. Maintain a linked list of free lock classes with list head
> 'free_lock_class'. Initialize that list from inside register_lock_class()
> instead of from inside lockdep_init() because register_lock_class() can
> be called before lockdep_init() has been called. Only add freed lock
> classes to the free_lock_classes list after a grace period to avoid that
> a lock_classes[] element would be reused while an RCU reader is
> accessing it.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/lockdep.h  |   9 +-
>  kernel/locking/lockdep.c | 237 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 205 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 9421f028c26c..02a1469c46e1 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> ...
>  
> +/* Must be called with the graph lock held. */
> +static void remove_class_from_lock_chain(struct lock_chain *chain,
> +					 struct lock_class *class)
> +{
> +	u64 chain_key;
> +	int i;
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +	for (i = chain->base; i < chain->base + chain->depth; i++) {
> +		if (chain_hlocks[i] != class - lock_classes)
> +			continue;
> +		if (--chain->depth == 0)
> +			break;
> +		memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
> +			(chain->base + chain->depth - i) *
> +			sizeof(chain_hlocks[0]));
> +		/*
> +		 * Each lock class occurs at most once in a
> +		 * lock chain so once we found a match we can
> +		 * break out of this loop.
> +		 */
> +		break;
> +	}
> +	/*
> +	 * Note: calling hlist_del_rcu() from inside a
> +	 * hlist_for_each_entry_rcu() loop is safe.
> +	 */
> +	if (chain->depth == 0) {
> +		/* To do: decrease chain count. See also inc_chains(). */
> +		hlist_del_rcu(&chain->entry);
> +		return;
> +	}
> +	chain_key = 0;
> +	for (i = chain->base; i < chain->base + chain->depth; i++)
> +		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);

Do you need to recompute the chain_key if no entry in the chain is removed?

>  
> @@ -4141,14 +4253,31 @@ static void zap_class(struct lock_class *class)
>  	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
>  		if (entry->class != class && entry->links_to != class)
>  			continue;
> +		links_to = entry->links_to;
> +		WARN_ON_ONCE(entry->class == links_to);
>  		list_del_rcu(&entry->entry);
> +		check_free_class(class);

Is the check_free_class() call redundant? You are going to call it near
the end below.
>  	}
> -	/*
> -	 * Unhash the class and remove it from the all_lock_classes list:
> -	 */
> -	hlist_del_rcu(&class->hash_entry);
> -	class->hash_entry.pprev = NULL;
> -	list_del(&class->lock_entry);
> +	check_free_class(class);
> +	WARN_ONCE(class->hash_entry.pprev,
> +		  KERN_INFO "%s() failed for class %s\n", __func__,
> +		  class->name);
> +
> +	remove_class_from_lock_chains(class);
> +}

> +
> +static void reinit_class(struct lock_class *class)
> +{
> +	void *const p = class;
> +	const unsigned int offset = offsetof(struct lock_class, key);
> +
> +	WARN_ON_ONCE(!class->lock_entry.next);
> +	WARN_ON_ONCE(!list_empty(&class->locks_after));
> +	WARN_ON_ONCE(!list_empty(&class->locks_before));
> +	memset(p + offset, 0, sizeof(*class) - offset);
> +	WARN_ON_ONCE(!class->lock_entry.next);
> +	WARN_ON_ONCE(!list_empty(&class->locks_after));
> +	WARN_ON_ONCE(!list_empty(&class->locks_before));
>  }

Is it safer to just reinit those fields before "key" instead of using
memset()? Lockdep is slow anyway, doing that individually won't
introduce any noticeable slowdown.

>  
>  static inline int within(const void *addr, void *start, unsigned long size)
> @@ -4156,6 +4285,38 @@ static inline int within(const void *addr, void *start, unsigned long size)
>  	return addr >= start && addr < start + size;
>  }
>  
> +/*
> + * Free all lock classes that are on the zapped_classes list. Called as an
> + * RCU callback function.
> + */
> +static void free_zapped_classes(struct callback_head *ch)
> +{
> +	struct lock_class *class;
> +	unsigned long flags;
> +	int locked;
> +
> +	raw_local_irq_save(flags);
> +	locked = graph_lock();
> +	rcu_callback_scheduled = false;
> +	list_for_each_entry(class, &zapped_classes, lock_entry) {
> +		reinit_class(class);
> +		nr_lock_classes--;
> +	}
> +	list_splice_init(&zapped_classes, &free_lock_classes);
> +	if (locked)
> +		graph_unlock();
> +	raw_local_irq_restore(flags);
> +}
> +
> +/* Must be called with the graph lock held. */
> +static void schedule_free_zapped_classes(void)
> +{
> +	if (rcu_callback_scheduled)
> +		return;
> +	rcu_callback_scheduled = true;
> +	call_rcu(&free_zapped_classes_rcu_head, free_zapped_classes);
> +}
> +
>  /*
>   * Used in module.c to remove lock classes from memory that is going to be
>   * freed; and possibly re-used by other modules.
> @@ -4181,10 +4342,11 @@ void lockdep_free_key_range(void *start, unsigned long size)
>  	for (i = 0; i < CLASSHASH_SIZE; i++) {
>  		head = classhash_table + i;
>  		hlist_for_each_entry_rcu(class, head, hash_entry) {
> -			if (within(class->key, start, size))
> -				zap_class(class);
> -			else if (within(class->name, start, size))
> -				zap_class(class);
> +			if (!class->hash_entry.pprev ||
> +			    (!within(class->key, start, size) &&
> +			     !within(class->name, start, size)))
> +				continue;
> +			zap_class(class);
>  		}
>  	}
>  
> @@ -4193,18 +4355,14 @@ void lockdep_free_key_range(void *start, unsigned long size)
>  	raw_local_irq_restore(flags);
>  
>  	/*
> -	 * Wait for any possible iterators from look_up_lock_class() to pass
> -	 * before continuing to free the memory they refer to.
> -	 *
> -	 * sync_sched() is sufficient because the read-side is IRQ disable.
> +	 * Do not wait for concurrent look_up_lock_class() calls. If any such
> +	 * concurrent call would return a pointer to one of the lock classes
> +	 * freed by this function then that means that there is a race in the
> +	 * code that calls look_up_lock_class(), namely concurrently accessing
> +	 * and freeing a synchronization object.
>  	 */
> -	synchronize_sched();
>  
> -	/*
> -	 * XXX at this point we could return the resources to the pool;
> -	 * instead we leak them. We would need to change to bitmap allocators
> -	 * instead of the linear allocators we have now.
> -	 */
> +	schedule_free_zapped_classes();

Should you move the graph_unlock() and raw_lock_irq_restore() down to
after this? The schedule_free_zapped_classes must be called with
graph_lock held. Right?

Cheers,
Longman

