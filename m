Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7556E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7556E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeINOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:09:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbeINOJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:09:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0185AF75;
        Fri, 14 Sep 2018 08:56:23 +0000 (UTC)
Subject: Re: [PATCH 2/6] xenbus: implement the xenwatch multithreading
 framework
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, paul.durrant@citrix.com,
        wei.liu2@citrix.com, konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-3-git-send-email-dongli.zhang@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2084a3de-29bc-f255-5134-879f1aeb1329@suse.com>
Date:   Fri, 14 Sep 2018 10:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536910456-13337-3-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/18 09:34, Dongli Zhang wrote:
> This is the 2nd patch of a (6-patch) patch set.
> 
> This patch implements the xenwatch multithreading framework to create or
> destroy the per-domU xenwatch thread. The xenwatch thread is created or
> destroyed during xenbus device probing or removing (that is,
> xenbus_dev_probe() or xenbus_dev_remove()) if the corresponding pv driver
> has xenwatch multithreading feature enabled. As there is only one single
> per-domU xenwatch thread for each domid, probing the xenbus device for the
> same domid again would not create the thread for the same domid again, but
> only increment the reference count of the thread's mtwatch domain. When a
> xenbus device is removed, the reference count is decremented. The per-domU
> xenwatch thread is destroyed when the reference count of its mtwatch domain
> is zero, that is, al xenbus devices (whose mtwatch feature is enabled) of
> such mtwatch domain are removed.
> 
> Therefore, a domid has its own per-domU xenwatch thread only when it is
> attached with dom0 backend xenbus device whose pv driver has the feature
> enabled. The domid would not have its own xenwatch thread when it is not
> running any mtwatch-enabled xenbus device.
> 
> When a watch (with xenwatch multithreading enabled) is unregistered, we
> will generally traverse all mtwatch domains to remove all inflight pending
> events fired by such watch. However, one optimization in this patch is we
> only need to remove pending events from a specific mtwatch domain when the
> watch is registered for a specific domid, that is, when its owner_id field
> is non-zero.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/xen/xenbus/xenbus_probe.c |   6 +
>  drivers/xen/xenbus/xenbus_xs.c    | 273 ++++++++++++++++++++++++++++++++++++++
>  include/xen/xenbus.h              |   3 +
>  3 files changed, 282 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 5b47188..5755596 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -236,6 +236,9 @@ int xenbus_dev_probe(struct device *_dev)
>  	if (err)
>  		goto fail;
>  
> +	if (xen_mtwatch && drv->use_mtwatch)
> +		mtwatch_create_domain(dev->otherend_id);
> +
>  	err = watch_otherend(dev);
>  	if (err) {
>  		dev_warn(&dev->dev, "watch_otherend on %s failed.\n",
> @@ -263,6 +266,9 @@ int xenbus_dev_remove(struct device *_dev)
>  	if (drv->remove)
>  		drv->remove(dev);
>  
> +	if (xen_mtwatch && drv->use_mtwatch)
> +		mtwatch_put_domain(dev->otherend_id);
> +
>  	free_otherend_details(dev);
>  
>  	xenbus_switch_state(dev, XenbusStateClosed);
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 3f137d2..741dc54 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -108,6 +108,201 @@ static __init int xen_parse_mtwatch(char *arg)
>  }
>  early_param("xen_mtwatch", xen_parse_mtwatch);
>  
> +struct mtwatch_domain *mtwatch_find_domain(domid_t domid)
> +{
> +	struct mtwatch_domain *domain;
> +	int hash = MTWATCH_HASH(domid);
> +	struct hlist_head *hash_head = &mtwatch_info->domain_hash[hash];
> +
> +	hlist_for_each_entry_rcu(domain, hash_head, hash_node) {
> +		if (domain->domid == domid)
> +			return domain;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* per-domU thread for xenwatch multithreading. */
> +static int mtwatch_thread(void *arg)
> +{
> +	struct mtwatch_domain *domain = (struct mtwatch_domain *) arg;
> +	struct list_head *ent;
> +	struct xs_watch_event *event;
> +
> +	domain->pid = current->pid;
> +
> +	for (;;) {
> +		wait_event_interruptible(domain->events_wq,
> +					 !list_empty(&domain->events) ||
> +					 domain->state == MTWATCH_DOMAIN_DOWN);
> +
> +		if (domain->state == MTWATCH_DOMAIN_DOWN &&
> +		    list_empty(&domain->events))
> +			break;
> +
> +		mutex_lock(&domain->domain_mutex);
> +
> +		spin_lock(&domain->events_lock);
> +		ent = domain->events.next;
> +		if (ent != &domain->events)
> +			list_del(ent);
> +		spin_unlock(&domain->events_lock);
> +
> +		if (ent != &domain->events) {
> +			event = list_entry(ent, struct xs_watch_event, list);
> +			event->handle->callback(event->handle, event->path,
> +						event->token);
> +			kfree(event);
> +		}
> +
> +		mutex_unlock(&domain->domain_mutex);
> +	}

This is nearly the same coding as xenwatch_thread(). Why don't you
define a new (sub-)structure containing the needed elements and move
xenwatch_pid, watch_events_waitq, watch_events, xenwatch_mutex,
watch_events_lock into such a structure? Then you could a common
function for both purposes (you'd need to set state for
xenwatch_thread() to DOMAIN_UP and add a callback for testing the
thread end condition).

> +
> +	/*
> +	 * domain->state is already set to MTWATCH_DOMAIN_DOWN (to avoid
> +	 * new event to domain->events) when above for loop breaks, so
> +	 * that there is no requirement to cleanup domain->events again.
> +	 */
> +
> +	spin_lock(&mtwatch_info->domain_lock);
> +	list_del_rcu(&domain->list_node);
> +	spin_unlock(&mtwatch_info->domain_lock);
> +
> +	spin_lock(&mtwatch_info->purge_lock);
> +	list_add(&domain->purge_node, &mtwatch_info->purge_list);
> +	spin_unlock(&mtwatch_info->purge_lock);
> +
> +	schedule_work(&mtwatch_info->purge_work);
> +
> +	return 0;
> +}
> +
> +static void delayed_destroy_domain(struct rcu_head *head)
> +{
> +	struct mtwatch_domain *domain;
> +
> +	domain = container_of(head, struct mtwatch_domain, rcu);
> +	kfree(domain);
> +}
> +
> +static void xen_mtwatch_purge_domain(struct work_struct *work)
> +{
> +	struct mtwatch_domain *domain;
> +	struct list_head *node;
> +
> +	while (!list_empty(&mtwatch_info->purge_list)) {
> +
> +		spin_lock(&mtwatch_info->purge_lock);
> +		node = mtwatch_info->purge_list.next;
> +		if (node != &mtwatch_info->purge_list)
> +			list_del(node);
> +		spin_unlock(&mtwatch_info->purge_lock);
> +
> +		if (node != &mtwatch_info->purge_list) {
> +			domain = list_entry(node, struct mtwatch_domain,
> +					    purge_node);
> +			kthread_stop(domain->task);
> +
> +			call_rcu(&domain->rcu, delayed_destroy_domain);
> +		}
> +	}
> +}
> +
> +/* Running in the context of default xenwatch kthread. */
> +void mtwatch_create_domain(domid_t domid)
> +{
> +	struct mtwatch_domain *domain;
> +
> +	if (!domid) {
> +		pr_err("Default xenwatch thread is for dom0\n");

Should we really exclude dom0? What if a driver domain wants to support
a dom0 based frontend?

> +		return;
> +	}
> +
> +	spin_lock(&mtwatch_info->domain_lock);
> +
> +	domain = mtwatch_find_domain(domid);
> +	if (domain) {
> +		atomic_inc(&domain->refcnt);
> +		spin_unlock(&mtwatch_info->domain_lock);
> +		return;
> +	}
> +
> +	domain = kzalloc(sizeof(*domain), GFP_ATOMIC);
> +	if (!domain) {
> +		spin_unlock(&mtwatch_info->domain_lock);
> +		pr_err("Failed to allocate memory for mtwatch thread %d\n",
> +		       domid);

No alloc error messages, please!

> +		return;
> +	}
> +
> +	domain->domid = domid;
> +	atomic_set(&domain->refcnt, 1);
> +	mutex_init(&domain->domain_mutex);
> +	INIT_LIST_HEAD(&domain->purge_node);
> +
> +	init_waitqueue_head(&domain->events_wq);
> +	spin_lock_init(&domain->events_lock);
> +	INIT_LIST_HEAD(&domain->events);
> +
> +	list_add_tail_rcu(&domain->list_node, &mtwatch_info->domain_list);
> +
> +	hlist_add_head_rcu(&domain->hash_node,
> +			   &mtwatch_info->domain_hash[MTWATCH_HASH(domid)]);
> +
> +	spin_unlock(&mtwatch_info->domain_lock);
> +
> +	domain->task = kthread_run(mtwatch_thread, domain,
> +				   "xen-mtwatch-%d", domid);
> +
> +	if (!domain->task) {
> +		pr_err("mtwatch kthread creation is failed\n");
> +		domain->state = MTWATCH_DOMAIN_DOWN;
> +
> +		return;
> +	}
> +
> +	domain->state = MTWATCH_DOMAIN_UP;
> +}
> +
> +/* Running in the context of default xenwatch kthread. */
> +void mtwatch_put_domain(domid_t domid)
> +{
> +	struct mtwatch_domain *domain;
> +
> +	spin_lock(&mtwatch_info->domain_lock);
> +
> +	domain = mtwatch_find_domain(domid);
> +	if (!domain) {
> +		spin_unlock(&mtwatch_info->domain_lock);
> +		pr_err("mtwatch kthread for domid=%d does not exist\n",
> +		       domid);
> +		return;
> +	}
> +
> +	if (atomic_dec_and_test(&domain->refcnt)) {
> +
> +		hlist_del_rcu(&domain->hash_node);
> +
> +		if (!domain->task) {
> +			/*
> +			 * As the task is failed to initialize during
> +			 * mtwatch_create_domain(), we do not need to wait
> +			 * for the kernel thread to complete.
> +			 */
> +			list_del_rcu(&domain->list_node);
> +			call_rcu(&domain->rcu, delayed_destroy_domain);
> +		} else {
> +			spin_lock(&domain->events_lock);
> +			domain->state = MTWATCH_DOMAIN_DOWN;
> +			spin_unlock(&domain->events_lock);
> +
> +			wake_up(&domain->events_wq);
> +		}
> +	}
> +
> +	spin_unlock(&mtwatch_info->domain_lock);
> +}
> +
>  static void xs_suspend_enter(void)
>  {
>  	spin_lock(&xs_state_lock);
> @@ -793,6 +988,80 @@ int register_xenbus_watch(struct xenbus_watch *watch)
>  }
>  EXPORT_SYMBOL_GPL(register_xenbus_watch);
>  
> +static void __unregister_single_mtwatch(struct xenbus_watch *watch,
> +					struct mtwatch_domain *domain)
> +{
> +	struct xs_watch_event *event, *tmp;
> +
> +	if (current->pid != domain->pid)
> +		mutex_lock(&domain->domain_mutex);
> +
> +	spin_lock(&domain->events_lock);
> +	list_for_each_entry_safe(event, tmp,
> +				 &domain->events, list) {
> +		if (event->handle != watch)
> +			continue;
> +		list_del(&event->list);
> +		kfree(event);
> +	}
> +	spin_unlock(&domain->events_lock);
> +
> +	if (current->pid != domain->pid)
> +		mutex_unlock(&domain->domain_mutex);
> +}
> +
> +static void unregister_single_mtwatch(struct xenbus_watch *watch,
> +				      domid_t domid)
> +{
> +	struct mtwatch_domain *domain;
> +	bool found = false;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(domain, &mtwatch_info->domain_list,
> +				list_node) {
> +		if (domain->domid == domid) {
> +			found = true;
> +			__unregister_single_mtwatch(watch, domain);
> +		}
> +	}
> +
> +	WARN_ON_ONCE(unlikely(!found));
> +
> +	rcu_read_unlock();
> +}
> +
> +static void unregister_all_mtwatch(struct xenbus_watch *watch)
> +{
> +	struct mtwatch_domain *domain;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(domain, &mtwatch_info->domain_list,
> +				list_node) {
> +		__unregister_single_mtwatch(watch, domain);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
> +static void unregister_mtwatch(struct xenbus_watch *watch)
> +{
> +	/*
> +	 * Generally, to unregister a watch. we need to traverse all
> +	 * mtwatch domains to remove all inflight pending watch events for
> +	 * such watch.
> +	 *
> +	 * One exception is we only need to remove pending watch events
> +	 * from a single mtwatch domain when the watch is registered for a
> +	 * specific domid.
> +	 */
> +	if (watch->owner_id)

Again: 0 as a special value isn't a good idea. Maybe use one of the
reserved DOMIDs, like DOMID_SELF?


Juergen
