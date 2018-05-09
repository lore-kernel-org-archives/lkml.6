Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-358780-1525869977-2-2021984855951133689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525869976; b=evi7pYaXhDTxTlnH6Wkd2Dtt4KFH7gM/zctAQGaQ418/qkk8RV
    e2VU8kx5HOt/VZmRE+kHUL/b+fAsZOG0jI+43znmQQut+pocHqA9IyboxKjJ++ph
    nvGovNTbHqYrJD7BHl92vwQIbZNhMj/7HNltJczCfjJ5dvcEeyqou1r/LoFibj9H
    FqJeZJ/3T7GUeKy0vsqvbKY1RLh2tqWfwWt4OnPBo6Cln3nlt5IG1+e1KpaG81W2
    3mABpjk5dYV26n+vAVV7D/x31mKcUw8XWMt6wCyz8soV+tpobd6igoavOHck2Xoy
    b1mt5FIsoSzTy8I9otKb2LF2vxVNzW/XLYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525869976; bh=w5Jotk5PlcV944kAipG7RaKY75/R5I
    upQQOf9/jc3dU=; b=aOqu5Q2GKs8U61tuhjXVRyZWfyPTdY1DYgKbnJmRCn5O9q
    4uvGGNIcIWQCv05v0Al74Zzqahp0nAivymzMo3cKaAYEJ4nQtXzfEPmMOWIlaH/y
    IjAgweW3mrZIdIsHXUImHlZ10E9UXaqxIGiO9ytZa0j0Bb2dDrZ2+hUetlnbYcZL
    g7mApGSujFbyTAXriX35PDMjEkWfLu8s40+fRxxEKIuiMBxH3Ss+cf0eU6pAwY+4
    LPa/yujdjNSe/vtF9smwb+gr8a7C9T2/JfR99GDq7FfqKzqJsvx2xmsS5h/mhY6Z
    nfEf/qt95w2t5AMhn14P439X8F4ajEK+NXNhbTuQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOwEuGRf/cBAMHDyj9RxgTpPh1kHteJPkMeZ6XuoX3p/0tVsNVmz2onCGrJ4v/nFP7MOdX7pPIeAiZU7iIVSM0i3RWAud61pTjcEd6FZj9ZJ0IG6nMrT
    KtMWfBuxe1g6ID51SeQsyxQI1AnxL62FIuAp9voUBemJpuc9SXFLRvuXsclAQpfPUpBKM0eV2rGDbOr1Rl77QEpdYVE/O05DU/xNayvGUDxeO+cUb+B9AQLE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=vDH_-Z0_yZCfKFbyiP8A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934328AbeEIMqO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 08:46:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934297AbeEIMqN (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 9 May 2018 08:46:13 -0400
Date: Wed, 9 May 2018 14:46:11 +0200
From: Jan Kara <jack@suse.cz>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/5] radix tree: fix multi-order iteration race
Message-ID: <20180509124611.6hoa743z4qrx6bgc@quack2.suse.cz>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-6-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503192430.7582-6-ross.zwisler@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 03-05-18 13:24:30, Ross Zwisler wrote:
> Fix a race in the multi-order iteration code which causes the kernel to hit
> a GP fault.  This was first seen with a production v4.15 based kernel
> (4.15.6-300.fc27.x86_64) utilizing a DAX workload which used order 9 PMD
> DAX entries.
> 
> The race has to do with how we tear down multi-order sibling entries when
> we are removing an item from the tree.  Remember for example that an order
> 2 entry looks like this:
> 
> struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]
> 
> where 'entry' is in some slot in the struct radix_tree_node, and the three
> slots following 'entry' contain sibling pointers which point back to
> 'entry.'
> 
> When we delete 'entry' from the tree, we call :
>   radix_tree_delete()
>     radix_tree_delete_item()
>       __radix_tree_delete()
>         replace_slot()
> 
> replace_slot() first removes the siblings in order from the first to the
> last, then at then replaces 'entry' with NULL.  This means that for a brief
> period of time we end up with one or more of the siblings removed, so:
> 
> struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]
> 
> This causes an issue if you have a reader iterating over the slots in the
> tree via radix_tree_for_each_slot() while only under
> rcu_read_lock()/rcu_read_unlock() protection.  This is a common case in
> mm/filemap.c.
> 
> The issue is that when __radix_tree_next_slot() => skip_siblings() tries to
> skip over the sibling entries in the slots, it currently does so with an
> exact match on the slot directly preceding our current slot.  Normally this
> works:
>                                     V preceding slot
> struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]
>                                             ^ current slot
> 
> This lets you find the first sibling, and you skip them all in order.
> 
> But in the case where one of the siblings is NULL, that slot is skipped and
> then our sibling detection is interrupted:
> 
>                                            V preceding slot
> struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]
>                                                   ^ current slot
> 
> This means that the sibling pointers aren't recognized since they point all
> the way back to 'entry', so we think that they are normal internal radix
> tree pointers.  This causes us to think we need to walk down to a struct
> radix_tree_node starting at the address of 'entry'.
> 
> In a real running kernel this will crash the thread with a GP fault when
> you try and dereference the slots in your broken node starting at 'entry'.
> 
> We fix this race by fixing the way that skip_siblings() detects sibling
> nodes.  Instead of testing against the preceding slot we instead look for
> siblings via is_sibling_entry() which compares against the position of the
> struct radix_tree_node.slots[] array.  This ensures that sibling entries
> are properly identified, even if they are no longer contiguous with the
> 'entry' they point to.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Reported-by: CR, Sapthagirish <sapthagirish.cr@intel.com>
> Fixes: commit 148deab223b2 ("radix-tree: improve multiorder iterators")
> Cc: <stable@vger.kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  lib/radix-tree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index da9e10c827df..43e0cbedc3a0 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -1612,11 +1612,9 @@ static void set_iter_tags(struct radix_tree_iter *iter,
>  static void __rcu **skip_siblings(struct radix_tree_node **nodep,
>  			void __rcu **slot, struct radix_tree_iter *iter)
>  {
> -	void *sib = node_to_entry(slot - 1);
> -
>  	while (iter->index < iter->next_index) {
>  		*nodep = rcu_dereference_raw(*slot);
> -		if (*nodep && *nodep != sib)
> +		if (*nodep && !is_sibling_entry(iter->node, *nodep))
>  			return slot;
>  		slot++;
>  		iter->index = __radix_tree_iter_add(iter, 1);
> @@ -1631,7 +1629,7 @@ void __rcu **__radix_tree_next_slot(void __rcu **slot,
>  				struct radix_tree_iter *iter, unsigned flags)
>  {
>  	unsigned tag = flags & RADIX_TREE_ITER_TAG_MASK;
> -	struct radix_tree_node *node = rcu_dereference_raw(*slot);
> +	struct radix_tree_node *node;
>  
>  	slot = skip_siblings(&node, slot, iter);
>  
> -- 
> 2.14.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
